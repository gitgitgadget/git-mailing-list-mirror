Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D43C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJLJNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLJNB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590EE140F0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:13:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s30so23642650eds.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kFfoOqC5whRR45O5YnId44VOwjqzv8G+DAOjtawFXOg=;
        b=baWq2h32CPIs9iXTYOTfRa1NFiA+SazEEl231O9efOfQpKXLGkM+eEmPHiyOJBsarh
         Jm4ua+NjngEUsPvjZIXB3wnLlhYM8h2EnbJpH7Rh6Ypg5gwz/6JGLKYrM3FfR2y1nZMT
         5pQgnf9dIs9M9m9OMqJli4lw6U4sl9SvagJ+LvUUzeAGZYAKTZtEjuNU2anDOAR9M14c
         wtwskd+kLzvBxXyU+7yWAA2XUbFdkpXHBV5zC3hSBZXflHvBQW7eDIY+NL3d79rwTMc/
         rLe+q5i8N/HKwxR4XqKaIiKHwOfPbuZPWYHrXyVIKiCwU1jmY2OatO11D/Nx7xaWAUw8
         n6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kFfoOqC5whRR45O5YnId44VOwjqzv8G+DAOjtawFXOg=;
        b=N1tmPfj7Cadxuyt6ndnhb57iyko++MLr2LvsW7Vllj1ZnQJd+5abmrWzwgMMEj+7ek
         K2E1kGSK4u81E8hHblSIibIK/6ZWVl6XAKAJGQw9VZ0SPo2N9Yp2ZGgSAyIjxrWpNJGY
         rWYy5X7YarppVPUkzJkORjU8I4e2y5YvdJs4WHDuGq6YHEsx0CoSi+7+gu+s6X2PONvJ
         4R5RL0DnRmHy808ugnlVQw5+ISC5x3DsH3IhoPyOc/XDgEhV2SZHF+Rnl8YYhphG55AW
         IWJhEMWpa6kAb7EPNFz5/GAvUnniq9d8xGDOozRVg/d83h9XjxpMHgjP0XEiHziZK2DZ
         ct0Q==
X-Gm-Message-State: ACrzQf02P3d3kRr48vKDpgf25nuBhp34eCIjSjORtrO8H6ybtFxtVaag
        M8ulx7ECgkaIoiq4Chb//a2R3UNiBqNrPQ==
X-Google-Smtp-Source: AMsMyM7S6rj+NpCAsIXimdBbvKcfFpc55KLOEaAfQPUTabm4VJpFAUaUwL8oR9ghpCGH/xDM6Y7d8w==
X-Received: by 2002:a05:6402:1941:b0:457:13a:cce9 with SMTP id f1-20020a056402194100b00457013acce9mr27176973edz.265.1665565978813;
        Wed, 12 Oct 2022 02:12:58 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709067d0200b00730bfe6adc4sm932530ejo.37.2022.10.12.02.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:12:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiXnN-004GJd-1S;
        Wed, 12 Oct 2022 11:12:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] git fetch fetches tags matching negative refspec
Date:   Wed, 12 Oct 2022 11:11:47 +0200
References: <CA+JQ7M-CN0UnHQDDDVz0kPcU1AcoL9+WFOeR8eiw_B=Yiyc-CA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CA+JQ7M-CN0UnHQDDDVz0kPcU1AcoL9+WFOeR8eiw_B=Yiyc-CA@mail.gmail.com>
Message-ID: <221012.86mta1mmli.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 12 2022, Erik Cervin Edin wrote:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> Delete all v2.9.* tags
>   git tag | grep ^v2.9.* | xargs git tag -d
>
> Change standard the standard fetch configuration
> [remote "origin"]
>     url =3D git@github.com:git/git.git
>     fetch =3D +refs/heads/*:refs/remotes/origin/*
>
> By adding a negative respec for tags matching v2.9.*
> [remote "origin"]
>     url =3D git@github.com:git/git.git
>     fetch =3D +refs/heads/*:refs/remotes/origin/*
>     fetch =3D ^refs/tags/v2.9.*
>
> run
>   git fetch
>
> What did you expect to happen? (Expected behavior)
>
> To exclude tags matchings v2.9*, just like when running git fetch --tags
>
> What happened instead? (Actual behavior)
>
> Without specifying git fetch --tags, tags matching the negative
> refspec are still fetched
>
> What's different between what you expected and what actually happened?
>
> The negative refspec appears to be ignored or overruled when running
> git fetch without the --tags flag
>
> Anything else you want to add:
> I love git, thank you! =E2=99=A5
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.

I haven't had time to try this, but I believe this isn't a bug, it's
just that you didn't supply --no-tags.

"But I want some tags!", yes, that's not what --no-tags does, see the
2nd paragraph of the DESCRIPTION section of "git-fetch".

I.e. it got stuff you asked for, but also tags pointing at the main
history, --no-tags will stop that, at which point you can *also* fetch
tags, just with the refspec.

