Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340E0C433E0
	for <git@archiver.kernel.org>; Sun, 24 May 2020 21:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C502204EF
	for <git@archiver.kernel.org>; Sun, 24 May 2020 21:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="SURYrXMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388250AbgEXViT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 17:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387879AbgEXViS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 17:38:18 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9AAC061A0E
        for <git@vger.kernel.org>; Sun, 24 May 2020 14:38:17 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id r3so7350927qve.1
        for <git@vger.kernel.org>; Sun, 24 May 2020 14:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bLxpOOdY24IAC0R6OIFGDXLsAKo7p6mjUe3fCBOUW1U=;
        b=SURYrXMw/69wZfVP4YoQ4oX+FLzk103DO7tZO3BclyH0beIGZ/GEt1OhRzG3CIyNAa
         ljkblaPcNlj+D8y425bG2D+H+4ojgIfkXbpvzPTqZbs8rzRePaFYLPihCydYKFNoLTnC
         7GBigANGgqN5zpbJ3a009wygb/LMiEGUMLKKwNvF6NN9WTCMTlFyEZXGiC9jiSseEVYm
         jB3bn9LGfgWRDky4vCftRacRFgaABnnjv3C/fHOky9VOLnyxJmd3tNf7YWgcBe0Osn4L
         4vYrkpQI1+RLA7hfofKoVSdLtFBsoqyc4u9katcT4Ddcma94dq4tWrOpBvL9FybMdj0W
         09mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bLxpOOdY24IAC0R6OIFGDXLsAKo7p6mjUe3fCBOUW1U=;
        b=H3MxZu26rh7XRwjEsVSpTs9I+xn5OUWXL8hORksE2BL/gsXhXwaw7Ki4E1ojc7RYkb
         kb3tSNvGYep2ce7Z1z5qOGz47X+jonPIzkIBQEIhIH3PzAGbr3CFbfhu0fEbhzDrnsZ8
         j174Txo6kfyQpwwa0YNFx5rXbXyvN0j/YwU20Hpr5HjJ/BbMouwD1fNS9UWcCzvsXcPe
         y74WblGwCyISCjR8+7pkFtWcSl+4/e5JPK3qvCwlBaaKMC5etQRHd2o+lumhdHbyacvL
         w4Y3uh5OEoeJxrIhq7884QI5XQOvCOq1Ivi3qpkyzhtzC1dVkNRjfnl0H0d25B4sC48T
         ae/A==
X-Gm-Message-State: AOAM533rpBcZP/XjxbzX1npeF30NlQPJ9J+3MyyTsARmbWrwXDDzW22Z
        vm/6bviF/bo9/ftBD816r6Dkrw==
X-Google-Smtp-Source: ABdhPJwddzyl801ZuN8+okBdC124bBPM6KDup7Z0z4AzgIbHUApocTtGSnPzV03wpvOJCgHCudSEkw==
X-Received: by 2002:a0c:b5a4:: with SMTP id g36mr13606566qve.86.1590356296001;
        Sun, 24 May 2020 14:38:16 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id g3sm12708213qtu.90.2020.05.24.14.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 14:38:15 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     asottile@umich.edu
Cc:     git@vger.kernel.org
Subject: Re: git git<tab> completes non-existent command `git gitk`
Date:   Sun, 24 May 2020 18:38:08 -0300
Message-Id: <20200524213808.24849-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CA+dzEBnpheB-ZT5+bajKphux-+7gYFx1Msws7mXM=LOJO7pukw@mail.gmail.com>
References: <CA+dzEBnpheB-ZT5+bajKphux-+7gYFx1Msws7mXM=LOJO7pukw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Anthony

On Sat, May 23, 2020 at 7:25 PM Anthony Sottile <asottile@umich.edu> wrote:
>
> easiest to reproduce is with docker
>
> ```dockerfile
> FROM ubuntu:focal
> RUN : \
>     && apt-get update \
>     && DEBIAN_FRONTEND=noninteractive apt-get install -y
> --no-install-recommends \
>         bash-completion \
>         git \
>     && apt-get clean \
>     && rm -rf /var/lib/apt/lists/*
> ```
>
> ```console
> $ docker run --rm -ti test bash
> root@23e691ecc7ba:/# [ -f /etc/bash_completion ] && . /etc/bash_completion
> root@23e691ecc7ba:/# git gitk
> ```
>
> (I typed git git<tab>)
>
> ```console
> $ git gitk
> git: 'gitk' is not a git command. See 'git --help'.
> ```
> this is a bit annoying because I have some aliases/commands for git-github-*
>
> the git version I have is 2.25.1:

Thanks for the report. This is also reproducible in Git 2.27.0-rc1. To complete
subcommands, git-completion.bash uses[1] the output of:

	git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config

And the list returned by the line above contains "gitk", because this
command is in the "mainporcelain" category (in command-list.txt).

One possible solution to the invalid completion you mentioned, without having
to re-categorize "gitk", is to explicitly exclude it in git-completion.bash:

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b1d6e5ebed..f07394584f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3214,7 +3214,10 @@ __git_main ()
 			then
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
-				__gitcomp "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
+				local cmds="$(__git --list-cmds=list-mainporcelain,others,nohelpers,list-complete,config | \
+						sed -e '/^gitk$/d')"
+				local aliases="$(__git --list-cmds=alias,config)"
+				__gitcomp "$cmds $aliases"
 			fi
 			;;
 		esac

(I had to split the list into "cmds" and "aliases" so that we could still give
completion for a valid "git gitk" alias, if present.)

This should solve the problem, althought it's admittedly not very elegant...
Nevertheless, I'd be happy to send a complete patch if folks are happy with the
workaround.

In the meantime, you could use:

	git config completion.commands -gitk

To locally remove the completion for "gitk".

Thanks,
Matheus

[1]: See contrib/completion/git-completion.bash +3218
     (https://github.com/git/git/blob/master/contrib/completion/git-completion.bash#L3218)
