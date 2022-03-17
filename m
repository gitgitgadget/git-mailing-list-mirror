Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01E7C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 13:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiCQNjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 09:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiCQNjU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 09:39:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D54B6E7BC
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 06:38:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w25so6572598edi.11
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZDGsQN3K1EfENgA+bh2w29tNxu9Av3Ben/FRmjSJCSI=;
        b=jdrYh+RDgD9knxZOoCVd0w+ehxrONabqMFxu0HwbPZd8yXnBnSvdXJgtqiB63wyt84
         DoNr2dIgctIaCKcKIH0vIVsughW5datDWB1Tf/HkqtadjmXPja9zpxvmEAnx0rzoLc7o
         17twrr3Nule4MTpy0Gcz1vu1YrWllwjnlMAOLCHa5OoB3ngOfNQJEJNykpLFj+45Vr5K
         yPWpdtik0+fsZglF/88gBexfQj1fCRyZRch9hm3pBHdw9n7uPWmLusEVj/tQrIpsZB3q
         tMLR2ybjF9LmxIV6WDSkMD1EmHsjknqUGV12uq8l16osbJuJe/6mNX9+IZyHYWRffLIk
         FJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZDGsQN3K1EfENgA+bh2w29tNxu9Av3Ben/FRmjSJCSI=;
        b=ezAH6bUbVfgqPe9x6g5J0ML6bhKQpxU0Pvfq5CpSWlLdpFfq8/ftL01hQRtr0jU3Z8
         pVFqQ/rYArirJ4H/oWtzyZ94nYu4USt5vnlIFszHRP57JOMdT086O7LcEoFrFDB4HMq+
         tMoEWzxpMinnRg5bOlcPd3fEsxDlJb6Jjoaf/4utxX71xSMtCNCyiJcpdsAfZL9J0Ijm
         8oPtwocFKpoa5wdEL6sz6PtbtiazeiPvjy69VKlghMj69eZYO4lSUCSX2gBoOfyRFJv6
         NO/Sb/JG4/rGIsTEYpz//dgs/7Xqa7ZnisZxWHyyVTPE1hT4d4a34NFyPHZPy446X445
         wkCA==
X-Gm-Message-State: AOAM531J11qakcHWdIduwZFO0rfw4he62aYv9EXStVUqNXGNTSa8/xcM
        ER13zCaLf2x5kzaIAHomINXOYUrP/63/DQ==
X-Google-Smtp-Source: ABdhPJx3ba9gdIB9D4Q5tTIV9FFIA1nn1cg6eLzCt8qpWfzGZ6c8LfPT3wG9kKhxsedF/nB0Kw6wXA==
X-Received: by 2002:a05:6402:1217:b0:419:249:8461 with SMTP id c23-20020a056402121700b0041902498461mr938425edw.10.1647524281425;
        Thu, 17 Mar 2022 06:38:01 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qx13-20020a170906fccd00b006bdeb94f50csm2337155ejb.203.2022.03.17.06.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 06:38:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nUqKF-0022op-Uu;
        Thu, 17 Mar 2022 14:37:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 1/2] rebase: use test_commit helper in setup
Date:   Thu, 17 Mar 2022 14:37:06 +0100
References: <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
 <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
 <f658eb00bcd2429859bc7b0d3b19bfa8a7791ca8.1647487001.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <f658eb00bcd2429859bc7b0d3b19bfa8a7791ca8.1647487001.git.gitgitgadget@gmail.com>
Message-ID: <220317.86v8wcd7ig.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 17 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> To prepare for the next commit that will test rebase with oids instead
> of branch names, update the rebase setup test to add a couple of tags we
> can use. This uses the test_commit helper so we can replace some lines
> that add a commit manually.
>
> Setting logAllRefUpdates is not necessary because it's on by default for
> repositories with a working tree.
>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/t3400-rebase.sh | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 71b1735e1dd..0643d015255 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -18,10 +18,7 @@ GIT_AUTHOR_EMAIL=bogus@email@address
>  export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
>  
>  test_expect_success 'prepare repository with topic branches' '
> -	git config core.logAllRefUpdates true &&
> -	echo First >A &&
> -	git update-index --add A &&
> -	git commit -m "Add A." &&
> +	test_commit "Add A." A First First &&
>  	git checkout -b force-3way &&
>  	echo Dummy >Y &&
>  	git update-index --add Y &&
> @@ -32,9 +29,7 @@ test_expect_success 'prepare repository with topic branches' '
>  	git mv A D/A &&
>  	git commit -m "Move A." &&
>  	git checkout -b my-topic-branch main &&
> -	echo Second >B &&
> -	git update-index --add B &&
> -	git commit -m "Add B." &&
> +	test_commit "Add B." B Second Second &&
>  	git checkout -f main &&
>  	echo Third >>A &&
>  	git update-index A &&

At least these could also be done, and skimming there's a few more "git
commit" that could also be converted:

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 0643d015255..6dc8df8be7e 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -35,9 +35,7 @@ test_expect_success 'prepare repository with topic branches' '
 	git update-index A &&
 	git commit -m "Modify A." &&
 	git checkout -b side my-topic-branch &&
-	echo Side >>C &&
-	git add C &&
-	git commit -m "Add C" &&
+	test_commit --no-tag "Add C" C Side &&
 	git checkout -f my-topic-branch &&
 	git tag topic
 '
@@ -114,10 +112,7 @@ test_expect_success 'rebase off of the previous branch using "-"' '
 test_expect_success 'rebase a single mode change' '
 	git checkout main &&
 	git branch -D topic &&
-	echo 1 >X &&
-	git add X &&
-	test_tick &&
-	git commit -m prepare &&
+	test_commit prepare X 1 &&
 	git checkout -b modechange HEAD^ &&
 	echo 1 >X &&
 	git add X &&

Maybe worthwhile squashing in & doing the rest?

Note that --no-tag and --append allow for converting more than could be
in the past before those (relatively recently added) options.
