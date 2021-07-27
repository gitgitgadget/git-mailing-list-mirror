Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD7CC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 19:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED3F60C51
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 19:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhG0Tnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 15:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhG0Tnl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 15:43:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A800BC061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 12:43:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l18so8832053wrv.5
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LCle3nbjqsnsO1hCmmBC6d+I0mbY0IuP06NM+3OP6e0=;
        b=nKUYldtUTLmU1En3i41Bn3Fa9DXAAr8ql2C915J6cqTkUwg4ztOtnrIfFWGEcKzAFU
         XEgHRrfJOwfNGd7mxOS/ppfMd+37btd8wd3O9l86DIHDwg6whjYGU9CMexJRylvly1KX
         gdvocDAyxlFZHpTXzJeTAK+7T0PqIXnw1LNAhmaoztxmZge47Z4gIceFwt7/3MDJbJu5
         C2oDwcSWaZIqm26t/O7hzclZbk2ZVDL36VmYT/b5TRQSRe9us7c4jUFHngYPg6T1cqoJ
         NXDJhKN5N558355xoQLeFymORE4JOPk+WFudvLrvjmWMkBw5HT95oW8X24OJJHKqGqBE
         SlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LCle3nbjqsnsO1hCmmBC6d+I0mbY0IuP06NM+3OP6e0=;
        b=EqrXtfpgEFJGDgegzSYweNcoMmhUNOfXjusL0yovSD+7Ve5IW3r6pDQ/4ryNT/4YDn
         vOHLovkXaxV8X3Y4/xab5sIFsOnWSl/j1bfwZh486BZhi8oB3EMDJ7zxz8aw0/jITzQr
         sTeQZggP1d53YsCisyb2kMBsOcEfqOao8g9keAb/X8SyLSDS8so1iX/MATCWA02k6uMH
         msO2ie6VyVxsho41mj3HVcQ5d6Q898/UEsNeXx8fYQnVUvAaohO33/407jdGBTgDBJ+0
         Zhbk2/JQzgBzW3EhklsZE8kcDeT3x4PXlrUSY/kQYDLersUxZYt8qfh1O5YRk8/N3aUB
         ND+Q==
X-Gm-Message-State: AOAM530YOtIh5t3PM8IZgeAh/7jW2aQuwRhpfdDaczJXUqxbXsbafe5d
        cnpjsrgsLj85XxSFMVlhCJA=
X-Google-Smtp-Source: ABdhPJxk7LGjx5meI9pZx4JUll9BQqBXZ6oVXhhNjJSQO3pfCC481IrryMSul4ObiX3z5x0l6S/N1w==
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr26549681wrs.301.1627415018250;
        Tue, 27 Jul 2021 12:43:38 -0700 (PDT)
Received: from [192.168.1.14] (host-2-98-21-22.as13285.net. [2.98.21.22])
        by smtp.gmail.com with ESMTPSA id j1sm4594079wrm.86.2021.07.27.12.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 12:43:37 -0700 (PDT)
Subject: Re: [PATCH v2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
 <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com>
Date:   Tue, 27 Jul 2021 20:43:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/07/2021 15:01, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> If we set the value of the environment variable GIT_CHERRY_PICK_HELP
> when using `git cherry-pick`, CHERRY_PICK_HEAD will be deleted, then
> we will get an error when we try to use `git cherry-pick --continue`
> or other cherr-pick command.
> 
> So unsetenv(GIT_CHERRY_PICK_HELP) in cmd_cherry_pick(), to avoid
> deleting CHERRY_PICK_HEAD when we are truly cherry-picking, which can
> fix this breakage.
> 
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by Hariom Verma <hariom18599@gmail.com>:
> ---
>      [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
>      
>      This patch fixes the bug when git cherry-pick is used with environment
>      variable GIT_CHERRY_PICK_HELP.
>      
>      Change from last version:
>      
>       1. Only unsetenv(GIT_CHERRY_PICK_HELP) without touching anything in
>          sequencer.c. Now git cherry-pick will ignore GIT_CHERRY_PICK_HELP,
>      
>      $ GIT_CHERRY_PICK_HELP="213" git cherry-pick dev~3..dev
>      
>      will only output default advice:
>      
>      hint: after resolving the conflicts, mark the corrected paths hint: with
>      'git add ' or 'git rm ' hint: and commit the result with 'git commit'
>      
>      This may still not be good enough, hope that cherry-pick will not advice
>      anything related to "git commit". Maybe we should make --no-commit as
>      cherry-pick default behavior?
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1001%2Fadlternative%2Fcherry-pick-help-fix-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1001/adlternative/cherry-pick-help-fix-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1001
> 
> Range-diff vs v1:
> 
>   1:  c2a6a625ac8 ! 1:  fbb9c166502 [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
>       @@ Commit message
>            we will get an error when we try to use `git cherry-pick --continue`
>            or other cherr-pick command.
>        
>       -    So add option action check in print_advice(), we will not remove
>       -    CHERRY_PICK_HEAD if we are indeed cherry-picking instead of rebasing.
>       +    So unsetenv(GIT_CHERRY_PICK_HELP) in cmd_cherry_pick(), to avoid
>       +    deleting CHERRY_PICK_HEAD when we are truly cherry-picking, which can
>       +    fix this breakage.
>        
>            Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>       +    Mentored-by: Christian Couder <christian.couder@gmail.com>
>       +    Mentored-by Hariom Verma <hariom18599@gmail.com>:
>        
>       - ## sequencer.c ##
>       -@@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
>       - 		 * (typically rebase --interactive) wants to take care
>       - 		 * of the commit itself so remove CHERRY_PICK_HEAD
>       - 		 */
>       --		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
>       --				NULL, 0);
>       -+		if (opts->action != REPLAY_PICK)
>       -+			refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
>       -+					NULL, 0);
>       - 		return;
>       - 	}
>       + ## builtin/revert.c ##
>       +@@ builtin/revert.c: int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>         
>       + 	opts.action = REPLAY_PICK;
>       + 	sequencer_init_config(&opts);
>       ++	unsetenv("GIT_CHERRY_PICK_HELP");
>       + 	res = run_sequencer(argc, argv, &opts);
>       + 	if (res < 0)
>       + 		die(_("cherry-pick failed"));
>        
>         ## t/t3507-cherry-pick-conflict.sh ##
>       +@@ t/t3507-cherry-pick-conflict.sh: test_expect_success 'advice from failed cherry-pick --no-commit' "
>       + 	test_cmp expected actual
>       + "
>       +
>       ++test_expect_success 'advice from failed cherry-pick with GIT_CHERRY_PICK_HELP' "
>       ++	pristine_detach initial &&
>       ++	(
>       ++		picked=\$(git rev-parse --short picked) &&
>       ++		cat <<-EOF >expected &&
>       ++		error: could not apply \$picked... picked
>       ++		hint: after resolving the conflicts, mark the corrected paths
>       ++		hint: with 'git add <paths>' or 'git rm <paths>'
>       ++		hint: and commit the result with 'git commit'
>       ++		EOF
>       ++		GIT_CHERRY_PICK_HELP='and then do something else' &&
>       ++		export GIT_CHERRY_PICK_HELP &&
>       ++		test_must_fail git cherry-pick picked 2>actual &&
>       ++		test_cmp expected actual
>       ++	)
>       ++"
>       ++
>       + test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
>       + 	pristine_detach initial &&
>       + 	test_must_fail git cherry-pick picked &&
>        @@ t/t3507-cherry-pick-conflict.sh: test_expect_success \
>         	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
>         '
>         
>        -test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
>        -	pristine_detach initial &&
>       -+test_expect_success 'GIT_CHERRY_PICK_HELP respects CHERRY_PICK_HEAD' '
>       -+	git init repo &&
>       - 	(
>       -+		cd repo &&
>       -+		git branch -M main &&
>       -+		echo 1 >file &&
>       -+		git add file &&
>       -+		git commit -m 1 &&
>       -+		echo 2 >file &&
>       -+		git add file &&
>       -+		git commit -m 2 &&
>       -+		git checkout HEAD~ &&
>       -+		echo 3 >file &&
>       -+		git add file &&
>       -+		git commit -m 3 &&
>       - 		GIT_CHERRY_PICK_HELP="and then do something else" &&
>       - 		export GIT_CHERRY_PICK_HELP &&
>       +-	(
>       +-		GIT_CHERRY_PICK_HELP="and then do something else" &&
>       +-		export GIT_CHERRY_PICK_HELP &&
>        -		test_must_fail git cherry-pick picked
>        -	) &&
>        -	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
>       -+		test_must_fail git cherry-pick main &&
>       -+		git rev-parse --verify CHERRY_PICK_HEAD >actual &&
>       -+		git rev-parse --verify main >expect &&
>       -+		test_cmp expect actual &&
>       -+		git cherry-pick --abort
>       -+	)
>       - '
>       -
>       +-'
>       +-
>         test_expect_success 'git reset clears CHERRY_PICK_HEAD' '
>       + 	pristine_detach initial &&
>       +
> 
> 
>   builtin/revert.c                |  1 +
>   t/t3507-cherry-pick-conflict.sh | 27 +++++++++++++++++----------
>   2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 237f2f18d4c..ec0abe7db73 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -245,6 +245,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>   
>   	opts.action = REPLAY_PICK;
>   	sequencer_init_config(&opts);
> +	unsetenv("GIT_CHERRY_PICK_HELP");

This will break git-rebase--preserve-merges.sh which uses 
GIT_CHERRY_PICK_HELP to set the help and ensure CHERRY_PICK_HEAD is 
removed when picking commits. I'm a bit confused as to what the problem 
is - how is 'git cherry-pick' being run with GIT_CHERRY_PICK_HELP set in 
the environment outside of a rebase (your explanation in [1] does not 
mention how GIT_CHERRY_PICK_HELP is set)? As far as I can see 'git 
rebase -i' does not set it so the only case I can think of is 
cherry-picking from an exec command  while running 'git rebase -p'

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/CAOLTT8Ty47fyY7T3d68CYPKh9k+HAHsnCLJ=F0KaLm+0gp3+EQ@mail.gmail.com/

>   	res = run_sequencer(argc, argv, &opts);
>   	if (res < 0)
>   		die(_("cherry-pick failed"));
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 014001b8f32..6f8035399d9 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -76,6 +76,23 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
>   	test_cmp expected actual
>   "
>   
> +test_expect_success 'advice from failed cherry-pick with GIT_CHERRY_PICK_HELP' "
> +	pristine_detach initial &&
> +	(
> +		picked=\$(git rev-parse --short picked) &&
> +		cat <<-EOF >expected &&
> +		error: could not apply \$picked... picked
> +		hint: after resolving the conflicts, mark the corrected paths
> +		hint: with 'git add <paths>' or 'git rm <paths>'
> +		hint: and commit the result with 'git commit'
> +		EOF
> +		GIT_CHERRY_PICK_HELP='and then do something else' &&
> +		export GIT_CHERRY_PICK_HELP &&
> +		test_must_fail git cherry-pick picked 2>actual &&
> +		test_cmp expected actual
> +	)
> +"
> +
>   test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
>   	pristine_detach initial &&
>   	test_must_fail git cherry-pick picked &&
> @@ -109,16 +126,6 @@ test_expect_success \
>   	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
>   '
>   
> -test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
> -	pristine_detach initial &&
> -	(
> -		GIT_CHERRY_PICK_HELP="and then do something else" &&
> -		export GIT_CHERRY_PICK_HELP &&
> -		test_must_fail git cherry-pick picked
> -	) &&
> -	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
> -'
> -
>   test_expect_success 'git reset clears CHERRY_PICK_HEAD' '
>   	pristine_detach initial &&
>   
> 
> base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
> 
