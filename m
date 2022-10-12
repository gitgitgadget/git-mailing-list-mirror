Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA06C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 23:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJLXLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 19:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJLXLv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 19:11:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2AA125731
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 16:11:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a67so321050edf.12
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 16:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UpN9KeEIh4COUV+ikl73KAintXqtWqPv8QeaJIa/ePg=;
        b=pZsSAI/mFXkoPd42v2wW1POpK8tkrbuH/2Cc4zCswQ59hpMwWusrU2ICu42JUuqZvy
         aHcsY8JoYV+IBBZPD9NNKXVwNuShKB2xsaDjIZuOb/E73ZAMEXSIwzq/VfO/hb0LyhDN
         wW1cY6+KrvPpY0/SUSX55DfbmwP50TW/ca8JMmugCjg0ZyzX9aLXmqZwficGaMymvnNr
         m/rE40UYTtcx/eIYWPL+Udi3D76gp8Bb0yOTMBFuciKoD6YPW7yqE4F6agP6XUSZ/XfQ
         Mb3B8zVU7dmw2yZI+TQdku+Oi9gA1JOkW4y7z4qwabsbwQdJxhAPW9ARH5h96eMtfsUU
         5nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpN9KeEIh4COUV+ikl73KAintXqtWqPv8QeaJIa/ePg=;
        b=YHPZHWpRk79AMpLoh0zhd45m5eYDqI6w3mRA6O+tmd5TenFlXoyRTPd8r7oDYYezaX
         Q8Ij7wGrq08GIbauuJyE0MBk9OzUokDPAnmiEBKukNkaw+6bXSMn1HB6ESgSAS6F5qzK
         djC0duhMm4vbhUJFX5zp9VzjkIrrSoza6f+Sul43zCva53O+BHsfA605Yrd3quUMCi2k
         ACZx38gZvDPpJe9O5yPCWSkCoUtkIDgK8O5+1pfWHRVw7Q4iNRdREwkhTjQj9rxgOnsF
         R1mgkwRInDzFtBi8jR8Mq8fQM5NoHtv+aRqSXf7JRYrsvOSZQVvvkA92g5FGewkIvZt3
         9MZw==
X-Gm-Message-State: ACrzQf3/Y60wGcQLKFuhzfjGLElAhxddPwn5KPdTDFio1n+fMSWEDzxq
        b9Xq7UvSK44BhxyYa/JICUKXAw6pm+75pA==
X-Google-Smtp-Source: AMsMyM6gTQbLWR+bc+vv4N2T+f3dnVe8PO84tKxE9BAeLmJYExrW1JNFMJ0jp+DxfoLTieQmsNjcXw==
X-Received: by 2002:a50:eb8f:0:b0:458:482d:43de with SMTP id y15-20020a50eb8f000000b00458482d43demr29223839edr.205.1665616309349;
        Wed, 12 Oct 2022 16:11:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d41-20020a056402402900b0045bef7cf489sm8373627eda.89.2022.10.12.16.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 16:11:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oikt9-004O1N-21;
        Thu, 13 Oct 2022 01:11:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] git fetch fetches tags matching negative refspec
Date:   Thu, 13 Oct 2022 01:09:36 +0200
References: <CA+JQ7M-CN0UnHQDDDVz0kPcU1AcoL9+WFOeR8eiw_B=Yiyc-CA@mail.gmail.com>
 <221012.86mta1mmli.gmgdl@evledraar.gmail.com>
 <CA+JQ7M-y9d=c3GbpAs+Y4qtimtVs9oQ6BU1YL8nmFmF=rZxKag@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CA+JQ7M-y9d=c3GbpAs+Y4qtimtVs9oQ6BU1YL8nmFmF=rZxKag@mail.gmail.com>
Message-ID: <221013.865ygomybw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 12 2022, Erik Cervin Edin wrote:

> On Wed, Oct 12, 2022 at 11:13 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> I.e. it got stuff you asked for, but also tags pointing at the main
>> history, --no-tags will stop that, at which point you can *also* fetch
>> tags, just with the refspec.
> I tried but
>   git fetch --no-tags
> with negative refspec did not fetch any tags.
>   git fetch --tags
> does.

Because your refspec doesn't include refs/tags/*:, try e.g.:

	git fetch https://github.com/git/git.git 'refs/tags/*:refs/tags/*' --no-ta=
gs --dry-run

That's what "--no-tags", i.e. it's per-se (and confusingly) nothing to
do with whether you get tags or not, it's to do with whether we to tag
following.

> I'm going to set
>   git config remote.origin.tagopt --tags
> and then that's going to do what I want.

Isn't that going to give you also the tags you don't want?
