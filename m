Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC7EC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 11:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiGOLaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 07:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiGOL33 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 07:29:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B03B383
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 04:28:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so5903726edc.4
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 04:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=p5n+us3eblge/Af7NfHOjIJMudfjOehGdU/mFgtpciI=;
        b=Run5xExUKw7IZKOC14WAklvGFgPQpQ9TiHQlycysKYVeCngE5UcJIjRr9M8k6XzeZs
         oO/zJb3d6IToxKKCLhBHSxJ9Mx8/J94rZjXnr8GwQAiUSga3UzWxyuDzD6VEs9NKLoM0
         4jT3thisW9nSj2OUxfBzRcrsphGoFkzLpdAgLirdqCzJTj/ZwiU6y1bTXaiG9I6L3A58
         /DkO/zdDuevOzoEYyhTgshynV6IVdsLsxYd5HaxwRasCHJmi06onsp29zioInDbu++Ew
         1PNawNx1gq+kmBSOdFK0fC+SOfFjtO3m41/0jkRN/ROmIsFrpvtF+24xRgOxPb+qNQT2
         /GTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=p5n+us3eblge/Af7NfHOjIJMudfjOehGdU/mFgtpciI=;
        b=0DBC6Mt9ZHwWXzwZC0idPl5yen7yN+2WosXFtFTxykd9XdqVqJifGu6RbHD9AfoOb9
         yCwOs1INiW0qNSPoCdvZhS2Y0NYf8LHwjtppnf+0dZpkk2pBo1DSymVIBrTg2oqP5PcR
         lhkYAjaXzrlvdJ853kxkWa7jKpEThfeSsMD/6++Lu4ZS0KBWT26yr5I8eirNL4db6hU5
         qLaw8eudu5CNBs1tuX9t9rVhqlCJaEq+c4R06ijl2bQMKK/ieaMhJgIrfXRbAasD0JA3
         AVeVl8r1R69CQ3M5RRyW3r7tZUorNW/s36FWHJW6hKC8m/q4G0XDQ1PQf5lyz+VLpV1d
         TTZQ==
X-Gm-Message-State: AJIora81TLbkhtYJf6jpyoecgp+bHfpd/0HTiPTotkFlIZ3uNbo3jTXv
        XXp16lbvhzokRfOeKCDJGVs=
X-Google-Smtp-Source: AGRyM1tFMzF0Uio5KjIdOsi8FE0SCxwAl3Ul4pNM3iGJQ6T7gLOi8nA1yG0xwqHmSmeh4PcXfFVdSQ==
X-Received: by 2002:a05:6402:909:b0:435:a8b:5232 with SMTP id g9-20020a056402090900b004350a8b5232mr18314493edz.240.1657884512841;
        Fri, 15 Jul 2022 04:28:32 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906a21400b006fe8a4ec62fsm1937090ejy.4.2022.07.15.04.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 04:28:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oCJUk-002gUh-5u;
        Fri, 15 Jul 2022 13:28:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/3] *: avoid "whitelist"
Date:   Fri, 15 Jul 2022 13:19:58 +0200
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
 <0d862cbbebe1a9f47f72255217faf734b1db4055.1657852722.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <0d862cbbebe1a9f47f72255217faf734b1db4055.1657852722.git.gitgitgadget@gmail.com>
Message-ID: <220715.86k08ezkbl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 15 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> -	logerror("'%s': not in whitelist", path);
> +	logerror("'%s': not in directory list", path);
>  	return NULL;		/* Fallthrough. Deny by default */
>  }
>  	if (strict_paths && (!ok_paths || !*ok_paths))
> -		die("option --strict-paths requires a whitelist");
> +		die("option --strict-paths requires a directory list");
>  
>  	if (base_path && !is_directory(base_path))
>  		die("base-path '%s' does not exist or is not a directory",

The former here is worse than before, which relates to the latter.

Put yourself in the shoes of a user who gets this error message. You
then do "man git-daemon", search for "whitelist", and the only thing
you'll find are references to --strict-paths and --interpolated-path,
which puts you on the right path.

IOW I don't care about the term "whitelist" here, I care that it it has
(goes and counts...) 5 occurances in the manpage, directorty has 16.

And SYNOPSIS of "git-daemon" says "...[<directory...]", so that
hypothehtical user is probably wondering e.g. if the directory they
provided on argv is bad. It's not just 5 v.s. 16, it's that we've
introduced jargon we only used for that feature, but now we use a vague
general term.

So we need to tell the user *what directory*. That's obviously easy, we
should refer back to the option that brought us here.

So per [1] I really welcome any improvements to the docs, but I was also
expecting to find various issues related to the origin of this series
blindly replacing things :( Please look a bit more at the bigger picture
beyond the specific hunks being changed, I might have missed some
similar issues on this read-through...

1. https://lore.kernel.org/git/220715.86sfn2zlkm.gmgdl@evledraar.gmail.com/
