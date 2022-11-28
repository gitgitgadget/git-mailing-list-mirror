Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8F6C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 13:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiK1N2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiK1N2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 08:28:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96761145C
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:28:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so25692782ejb.13
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iGT+Cvl2af94ynJ/ainRbYUf2VuhcLcNpyjV8WwGWrw=;
        b=CqPSaSX/sKCSjWpOwraDzhVZtCMC7W5e/LtXwmFobOn78SBxNMVbqgklFxulveLjEG
         5ICJ27DU+s/vCjKDSj2RgsySXZ3masBDg9Yozl1Ttn8rvCaUFqNECQ5LvEFc8NMlooxC
         W2XQjEtdva1kfSeHGWGxWqBWQDJxE28Zo/iZ/DCna1m79q7UK+Wpc01kM7ugH696X4dz
         EYCo05UoU1XtupHiSkc4OIBMr7ECCl9QHBqPMPfhjopFpt425CzsqeOyl9xcp84dKF/3
         jp4AASvoMqcNVr2/ER+VfRGfd4Y7hZmyBCF81lV9R6IL+rMj+nD2PEbjl1E2XtrAJFZf
         n9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGT+Cvl2af94ynJ/ainRbYUf2VuhcLcNpyjV8WwGWrw=;
        b=4ikh+SViSpDNomOChyF33wzY1iFo97kkP+A7jthziF+Bd1RUm6fleXqAgVd5OE8rW8
         ghRGKY6KPIM5ogVtBJL59nK8t6vgLie77vbRYePxSg8XoY+UC5w+SMakVWEO3/V9h6y/
         dLA9QUXolhf1zKrNBs+b8lyUP09HtB4hiiTl8pdcC7o8R6WNFKdpuyk3KaHbAPCzOiw0
         cZ3YHdDFG/JQ6b0UQN7zIS28r9Rzy+rMaqzaiL64jhsyU8VvQQMRerIzHo6ewklWmifE
         x0Uz/QEqNEQPfdNkFDrccToNHmH1VS3OpbYNgnYmLyq/1nsxNl+Up/UYwBJbBIOd4WC1
         URDg==
X-Gm-Message-State: ANoB5pnN0QyLvVMZ/drfzcqfCjFe52U4mUIrlsOhMxdwViHJP+9HjEU5
        2F10K+GS6KDii+v00ThuqLjaJo0dZ7ee7g==
X-Google-Smtp-Source: AA0mqf5RSqBokMTLdiez1Ln39fa42XVvS10WF+9yDmMxnY5kWybzxDL51FXQmP09dFyIcqPtptIkCw==
X-Received: by 2002:a17:906:6dd5:b0:78d:a633:b55 with SMTP id j21-20020a1709066dd500b0078da6330b55mr45112653ejt.106.1669642091279;
        Mon, 28 Nov 2022 05:28:11 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906300b00b007aee947ce9esm4966946ejz.138.2022.11.28.05.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:28:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozeB8-0013jv-0h;
        Mon, 28 Nov 2022 14:28:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 1/3] t1301: fix wrong template dir for git-init
Date:   Mon, 28 Nov 2022 14:24:33 +0100
References: <20221127145130.16155-1-worldhello.net@gmail.com>
 <20221128130323.8914-2-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221128130323.8914-2-worldhello.net@gmail.com>
Message-ID: <221128.86edtnky39.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> The template dir prepared in test case "forced modes" is not used as
> expected because a wrong template dir is provided to "git init". This is
> because the $CWD for "git-init" command is a sibling directory alongside
> the template directory. Change it to the right template directory and
> add a protection test using "test_path_is_file".
>
> The wrong template directory was introduced by mistake in commit
> e1df7fe43f (init: make --template path relative to $CWD, 2019-05-10).
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  t/t1301-shared-repo.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index 93a2f91f8a..7578e75d77 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -140,7 +140,8 @@ test_expect_success POSIXPERM 'forced modes' '
>  	(
>  		cd new &&
>  		umask 002 &&
> -		git init --shared=0660 --template=templates &&
> +		git init --shared=0660 --template=../templates &&
> +		test_path_is_file .git/hooks/post-update &&
>  		>frotz &&
>  		git add frotz &&
>  		git commit -a -m initial &&

This fix looks fishy to me. The code you're changing looks like it was
buggy, but this looks like it's sweeping under the rug the fact that
"templates" never did anything at this point.

So I'm not saying you should squash this in, but if you do so you'll see
that we only ever used this later.
	
	diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
	index d4315b5ef5a..106ccc5704e 100755
	--- a/t/t1301-shared-repo.sh
	+++ b/t/t1301-shared-repo.sh
	@@ -129,15 +129,12 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
	 '
	 
	 test_expect_success POSIXPERM 'forced modes' '
	-	mkdir -p templates/hooks &&
	-	echo update-server-info >templates/hooks/post-update &&
	-	chmod +x templates/hooks/post-update &&
	 	echo : >random-file &&
	 	mkdir new &&
	 	(
	 		cd new &&
	 		umask 002 &&
	-		git init --shared=0660 --template=templates &&
	+		git init --shared=0660 &&
	 		>frotz &&
	 		git add frotz &&
	 		git commit -a -m initial &&
	@@ -181,6 +178,10 @@ test_expect_success POSIXPERM 'remote init does not use config from cwd' '
	 test_expect_success POSIXPERM 're-init respects core.sharedrepository (local)' '
	 	git config core.sharedrepository 0666 &&
	 	umask 0022 &&
	+	mkdir -p templates/hooks &&
	+	echo update-server-info >templates/hooks/post-update &&
	+	chmod +x templates/hooks/post-update &&
	+
	 	echo whatever >templates/foo &&
	 	git init --template=templates &&
	 	echo "-rw-rw-rw-" >expect &&

From a glance isn't the real fix here to adjust the "post-update hook
must be 0770" case? I.e. it's conflating "I saw the right permissions"
with "I didn't see this line at all", isn't it?

Thus if we take this squash above we're not setting up the post-update
hook at all, so it's "not broken", but if we ever screw up our test
setup again it'll be broken again...

No?
