Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08982C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 10:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiGVKzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 06:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGVKzo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 06:55:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AD69F072
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 03:55:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ss3so7863347ejc.11
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=U14MV/qbyAT3RWD1dgsfLe1N7HUn2D3PV0vrmYQEO40=;
        b=Tv8w/HhUttdORorE1TW9JYNNQccSUFYi0LshzW78XgeuJtabL8hnMdXOHoGdQrHRFz
         D5HnbRIzWjoZD6sKQSjPGT6YdfzdNWlplxNQKgPLKpQGLUMHlnxLyK7WE0xGBfSHz7S2
         k97oF53UoUbrBJqOzKydi2EjKkm6jo06q2NtG2RHfnEU7Jh08xqKkWTLaw3dZ1AAP9Ip
         DrQIWgeVyyr90evHsK4w7P0Akx8Zf4Ol42Y8LqZenJkRheXOSaYoJzuGuJ313KICm8J0
         yITRk2zjp5/8eOumlnirQL6BwNpVgjth+VWOFBCg/xjJHMDhDcxryg7uvbi0/LXyj6O5
         ztxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=U14MV/qbyAT3RWD1dgsfLe1N7HUn2D3PV0vrmYQEO40=;
        b=399bHIFdUNhr1yFsAdMbeQrp7IUiHCXrntHrm1eIpHbTCzUPGbJqohMwTg8HQj+Udx
         ds27uF1eTCoC1HdPKVBgQlddlgejpdskXjUZGC9eRExeTJbzpOnQXua7+yZBSkfFCUY7
         Uhk33bCLei16KuX0aRr2cWlPPsSi/CNY0Gox+N6IjE3wEIXloyXcH/gKbqkJQNYZWtgk
         Trx77amIeBgrAmi3Mx4zO04c9V/1APegoABcN7ZfoZTgbvgpAggovNOq2I3e3sTIQdrz
         3ufp8oeTFQUS+gF7YTf7PhhrP41FDMyRnGr4xtAhVKXvjSrJSfcmT98PpC+rpTSREzP4
         DkTQ==
X-Gm-Message-State: AJIora9sneAwbzzfBI5TbaV8QGD63GQFeWKexhAH3SrZ5aPdUiBoXDGZ
        1enfQScyk+1bYduRbIlOVnlseD4zkWQsvA==
X-Google-Smtp-Source: AGRyM1v8Unz+jd1WVLZDkUquUEZY/UmK/llZQKHmxOjuH1Znm61eQsGPgYNoaJX55yE+cMmdMvmyhw==
X-Received: by 2002:a17:906:9b86:b0:6f8:24e7:af7d with SMTP id dd6-20020a1709069b8600b006f824e7af7dmr2682151ejc.295.1658487341952;
        Fri, 22 Jul 2022 03:55:41 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id la16-20020a170907781000b0072b92daef1csm1898646ejc.146.2022.07.22.03.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 03:55:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEqJo-005HdY-7x;
        Fri, 22 Jul 2022 12:55:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 5/7] merge: make restore_state() restore staged state
 too
Date:   Fri, 22 Jul 2022 12:53:10 +0200
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
 <f401bd5ad0dd7564412e72d19a4193ad3f64e638.1658466942.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <f401bd5ad0dd7564412e72d19a4193ad3f64e638.1658466942.git.gitgitgadget@gmail.com>
Message-ID: <220722.86k085s9g3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 22 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> There are multiple issues at play here:
>
>   1) If `git merge` is invoked with staged changes, it should abort
>      without doing any merging, and the user's working tree and index
>      should be the same as before merge was invoked.
>   2) Merge strategies are responsible for enforcing the index == HEAD
>      requirement. (See 9822175d2b ("Ensure index matches head before
>      invoking merge machinery, round N", 2019-08-17) for some history
>      around this.)
>   3) Merge strategies can bail saying they are not an appropriate
>      handler for the merge in question (possibly allowing other
>      strategies to be used instead).
>   4) Merge strategies can make changes to the index and working tree,
>      and have no expectation to clean up after themselves, *even* if
>      they bail out and say they are not an appropriate handler for
>      the merge in question.  (The `octopus` merge strategy does this,
>      for example.)
>   5) Because of (3) and (4), builtin/merge.c stashes state before
>      trying merge strategies and restores it afterward.
>
> Unfortunately, if users had staged changes before calling `git merge`,
> builtin/merge.c could do the following:
>
>    * stash the changes, in order to clean up after the strategies
>    * try all the merge strategies in turn, each of which report they
>      cannot function due to the index not matching HEAD
>    * restore the changes via "git stash apply"
>
> But that last step would have the net effect of unstaging the user's
> changes.  Fix this by adding the "--index" option to "git stash apply".
> While at it, also squelch the stash apply output; we already report
> "Rewinding the tree to pristine..." and don't need a detailed `git
> status` report afterwards.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge.c                          | 5 +++--
>  t/t6424-merge-unrelated-index-changes.sh | 7 ++++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 4170c30317e..f807bf335bd 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -383,14 +383,15 @@ static void reset_hard(const struct object_id *oid, int verbose)
>  static void restore_state(const struct object_id *head,
>  			  const struct object_id *stash)
>  {
> -	const char *args[] = { "stash", "apply", NULL, NULL };
> +	const char *args[] = { "stash", "apply", "--index", "--quiet",
> +			       NULL, NULL };
>  
>  	if (is_null_oid(stash))
>  		return;
>  
>  	reset_hard(head, 1);
>  
> -	args[2] = oid_to_hex(stash);
> +	args[4] = oid_to_hex(stash);
>  
>  	/*
>  	 * It is OK to ignore error here, for example when there was

Just a nit/side comment: This is one of these older-style arg
constructions that we've replaced with strvec in most other places.

Let's leave this alone for now (especially in a v4), but FWIW I wouldn't
mind if these sort of changes were strvec converted while at it:
	
	diff --git a/builtin/merge.c b/builtin/merge.c
	index 64def49734a..c3a3a1fde50 100644
	--- a/builtin/merge.c
	+++ b/builtin/merge.c
	@@ -383,21 +383,23 @@ static void reset_hard(const struct object_id *oid, int verbose)
	 static void restore_state(const struct object_id *head,
	 			  const struct object_id *stash)
	 {
	-	const char *args[] = { "stash", "apply", "--index", "--quiet",
	-			       NULL, NULL };
	+	struct strvec args = STRVEC_INIT;
	+
	+	strvec_pushl(&args, "stash", "apply", "--index", "--quiet", NULL);
	 
	 	reset_hard(head, 1);
	 
	 	if (is_null_oid(stash))
	 		goto refresh_cache;
	 
	-	args[4] = oid_to_hex(stash);
	+	strvec_push(&args, oid_to_hex(stash));
	 
	 	/*
	 	 * It is OK to ignore error here, for example when there was
	 	 * nothing to restore.
	 	 */
	-	run_command_v_opt(args, RUN_GIT_CMD);
	+	run_command_v_opt(args.v, RUN_GIT_CMD);
	+	strvec_clear(&args);
	 
	 refresh_cache:
	 	if (discard_cache() < 0 || read_cache() < 0)

I.e. it takes about as much mental energy to review that as counting the
args elements and seeing that 2 to 4 is correct :)
