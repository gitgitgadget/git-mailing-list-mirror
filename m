Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9392C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 17:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B33320781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 17:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKybgYgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgKJRJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 12:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJRJu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 12:09:50 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0D7C0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 09:09:49 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id e7so11975248pfn.12
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 09:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IeaCMBOXfRfXtS3Tsli2rP4pksX/QkttIYSUdE5Inm0=;
        b=QKybgYgmYCA+vdXeIjK9sjZYpndRWOR9x2iRXrej+gaNJaQ6d4aJKKMKjhFjtnH2wg
         8ROOGywBYzlVoNxdfxRUHwDuuqteSuR9/OXe9U+83ye66LMZdqwhRxfeR8azOrcES0AS
         4sM1nLgj8bp9KtBseGfrOG8yVd4SZqBtKnN4vdFEZ95aYZekOPtUAPwxof83OWzR3OKC
         mywKYGelv+cMLR1QeKG1F4GEhPaoDjW+sDvjXsgKhC60EA5LyQ6gReMW5SnjfA2Lm4wu
         Bo38iRmKHP/qnbh+2YiEBJ4gj4zXt0xVxKNAJ35G2w9h59KngOKyKGaD5hZ0QCadMDle
         xbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IeaCMBOXfRfXtS3Tsli2rP4pksX/QkttIYSUdE5Inm0=;
        b=n3MqhjO6NYKgMyiy4eprEZkOKArh7OJ8JgaGyzrYAWqAHEVkGknBGPJnVRpbXne/p4
         vb7puDWnWHXco+2b9jsCNoWRntdukn0fq5R69n+CgGib2ZYTe6a2SMP5v661JSj7d1jQ
         QgaB2JJWBQW027LOuMDmHevYZemTC8UBDKFY2gxf+poPL5/4D7l6G4tErhYDK36NPNpR
         NxQpo8JAOqSShrKzCmZb7/z1oXj58y3SvSBUbeUQbambah6cnl35blyA5FJni2R54ngX
         8sImM//z4SCpq0SxdGVFY1KXHHZw6gf46sRaDYMCn3KYysKLxTj/z0xUG5NwGImSdTHK
         AEAw==
X-Gm-Message-State: AOAM530x8wOGhHOTEnKxFWOlYYo2IkX4bHgKzYlhV7dfnvKk44y/C4YO
        ECn9INIcINCPJ5HPGqfYLCg=
X-Google-Smtp-Source: ABdhPJzxr1pwkRaCAItiYaucA6o9ZkFmZxqYD73kvyk177UIZdaGbHYIht4igrz44L8ruNyEfmUbVw==
X-Received: by 2002:a65:404b:: with SMTP id h11mr17205004pgp.379.1605028189448;
        Tue, 10 Nov 2020 09:09:49 -0800 (PST)
Received: from localhost ([2402:800:63a8:b485:e36e:8de6:8e0a:7fe3])
        by smtp.gmail.com with ESMTPSA id y23sm3096425pje.41.2020.11.10.09.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 09:09:48 -0800 (PST)
Date:   Wed, 11 Nov 2020 00:09:46 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Sangeeta Jain <sangunb09@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com,
        sunshine@sunshineco.com
Subject: Re: [Outreachy][PATCH v7] diff: do not show submodule with untracked
 files as "-dirty"
Message-ID: <X6rJWpuUHz1qHYZL@danh.dev>
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
 <20201110083900.88161-1-sangunb09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110083900.88161-1-sangunb09@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta,

First, thanks for correcting the test code that I've noticed in the
previous mail (and thanks to Junio, who explained my words in better
terms).

On 2020-11-10 14:09:00+0530, Sangeeta Jain <sangunb09@gmail.com> wrote:
> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
> index c3ae136eba..2d3331f55c 100644
> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -85,6 +85,8 @@ diff.ignoreSubmodules::
>  	and 'git status' when `status.submoduleSummary` is set unless it is
>  	overridden by using the --ignore-submodules command-line option.
>  	The 'git submodule' commands are not affected by this setting.
> +	By default this is set to untracked so that any untracked
> +	submodules are ignored.

This rounds looks better to me.
My only question now is: Should this change applicable to diff-index,
diff-files and other plumbing commands?

As of it's now, we treat the absent of diff.ignoreSubmodules as
"none" but we're changing to "untracked" with this change.

Will someone's scripts break by this change?
I think it's unlikely, but who knows?

To contribute to the chaos, --ignore-submodules implies --ignore-submodules=all 
My first-quick-and-INCORRECT scan to the diff-options, I was puzzled
by its default, and I thought (incorrectly, for a second) the absent of
--ignore-submodules mean --ignore-submodules=all.

-- Danh

>  
>  diff.mnemonicPrefix::
>  	If set, 'git diff' uses a prefix pair that is different from the
> diff --git a/diff.c b/diff.c
> index 2bb2f8f57e..5a80695da8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4585,6 +4585,9 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
>  		DIFF_XDL_SET(options, INDENT_HEURISTIC);
>  
>  	options->orderfile = diff_order_file_cfg;
> +	
> +	if (!options->flags.ignore_submodule_set)
> +		options->flags.ignore_untracked_in_submodules = 1;
>  
>  	if (diff_no_prefix) {
>  		options->a_prefix = options->b_prefix = "";
> diff --git a/diff.h b/diff.h
> index 11de52e9e9..1e18e6b1c3 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -178,6 +178,7 @@ struct diff_flags {
>  	unsigned diff_from_contents;
>  	unsigned dirty_submodules;
>  	unsigned ignore_untracked_in_submodules;
> +	unsigned ignore_submodule_set;
>  	unsigned ignore_dirty_submodules;
>  	unsigned override_submodule_config;
>  	unsigned dirstat_by_line;
> diff --git a/submodule.c b/submodule.c
> index b3bb59f066..8f6227c993 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -420,6 +420,7 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
>  void handle_ignore_submodules_arg(struct diff_options *diffopt,
>  				  const char *arg)
>  {
> +	diffopt->flags.ignore_submodule_set = 1;
>  	diffopt->flags.ignore_submodules = 0;
>  	diffopt->flags.ignore_untracked_in_submodules = 0;
>  	diffopt->flags.ignore_dirty_submodules = 0;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index ca04fac417..9a2489cde0 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -765,6 +765,12 @@ test_expect_success 'setup different kinds of dirty submodules' '
>  	cat >expected <<-\EOF &&
>  	dirty-both-ways
>  	dirty-head
> +	EOF
> +	test_cmp expected actual &&
> +	git -C for-submodules diff-files --name-only --ignore-submodules=none >actual &&
> +	cat >expected <<-\EOF &&
> +	dirty-both-ways
> +	dirty-head
>  	dirty-otherwise
>  	EOF
>  	test_cmp expected actual &&
> diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
> index d7145ccca4..894a11b224 100755
> --- a/t/t4027-diff-submodule.sh
> +++ b/t/t4027-diff-submodule.sh
> @@ -93,6 +93,14 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked)' '
>  	) &&
>  	git diff HEAD >actual &&
>  	sed -e "1,/^@@/d" actual >actual.body &&
> +	expect_from_to >expect.body $subtip $subprev &&
> +	test_cmp expect.body actual.body
> +'
> +
> +test_expect_success 'git diff HEAD with dirty submodule (untracked) (none ignored)' '
> +	test_config diff.ignoreSubmodules none &&
> +	git diff HEAD >actual &&
> +	sed -e "1,/^@@/d" actual >actual.body &&
>  	expect_from_to >expect.body $subtip $subprev-dirty &&
>  	test_cmp expect.body actual.body
>  '
> @@ -168,13 +176,13 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
>  		git clean -qfdx &&
>  		>cruft
>  	) &&
> -	git diff HEAD >actual &&
> +	git diff --ignore-submodules=none HEAD >actual &&
>  	sed -e "1,/^@@/d" actual >actual.body &&
>  	expect_from_to >expect.body $subprev $subprev-dirty &&
>  	test_cmp expect.body actual.body &&
>  	git diff --ignore-submodules=all HEAD >actual2 &&
>  	test_must_be_empty actual2 &&
> -	git diff --ignore-submodules=untracked HEAD >actual3 &&
> +	git diff HEAD >actual3 &&
>  	test_must_be_empty actual3 &&
>  	git diff --ignore-submodules=dirty HEAD >actual4 &&
>  	test_must_be_empty actual4
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index f852136585..b3a7b7acaa 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -262,7 +262,7 @@ test_expect_success 'submodule is up to date' '
>  
>  test_expect_success 'submodule contains untracked content' '
>  	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	EOF
> @@ -270,7 +270,7 @@ test_expect_success 'submodule contains untracked content' '
>  '
>  
>  test_expect_success 'submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&
>  	test_must_be_empty actual
>  '
>  
> @@ -286,7 +286,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
>  
>  test_expect_success 'submodule contains untracked and modified content' '
>  	echo new > sm1/foo6 &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	Submodule sm1 contains modified content
> @@ -296,7 +296,7 @@ test_expect_success 'submodule contains untracked and modified content' '
>  
>  test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
>  	echo new > sm1/foo6 &&
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains modified content
>  	EOF
> @@ -337,7 +337,7 @@ test_expect_success 'submodule is modified' '
>  
>  test_expect_success 'modified submodule contains untracked content' '
>  	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p  --ignore-submodules=none --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	Submodule sm1 $head6..$head8:
> @@ -347,7 +347,7 @@ test_expect_success 'modified submodule contains untracked content' '
>  '
>  
>  test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 $head6..$head8:
>  	  > change
> @@ -371,7 +371,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
>  
>  test_expect_success 'modified submodule contains untracked and modified content' '
>  	echo modification >> sm1/foo6 &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	Submodule sm1 contains modified content
> @@ -383,7 +383,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
>  
>  test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
>  	echo modification >> sm1/foo6 &&
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains modified content
>  	Submodule sm1 $head6..$head8:
> diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
> index fc8229c726..dc7b242697 100755
> --- a/t/t4060-diff-submodule-option-diff-format.sh
> +++ b/t/t4060-diff-submodule-option-diff-format.sh
> @@ -409,7 +409,7 @@ test_expect_success 'submodule is up to date' '
>  
>  test_expect_success 'submodule contains untracked content' '
>  	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=diff HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	EOF
> @@ -417,7 +417,7 @@ test_expect_success 'submodule contains untracked content' '
>  '
>  
>  test_expect_success 'submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +	git diff-index -p --submodule=diff HEAD >actual &&
>  	test_must_be_empty actual
>  '
>  
> @@ -433,7 +433,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
>  
>  test_expect_success 'submodule contains untracked and modified content' '
>  	echo new > sm1/foo6 &&
> -	git diff-index -p --submodule=diff HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	Submodule sm1 contains modified content
> @@ -451,7 +451,7 @@ test_expect_success 'submodule contains untracked and modified content' '
>  # NOT OK
>  test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
>  	echo new > sm1/foo6 &&
> -	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +	git diff-index -p --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains modified content
>  	diff --git a/sm1/foo6 b/sm1/foo6
> @@ -512,7 +512,7 @@ test_expect_success 'submodule is modified' '
>  
>  test_expect_success 'modified submodule contains untracked content' '
>  	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=diff HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	Submodule sm1 $head7..$head8:
> @@ -528,7 +528,7 @@ test_expect_success 'modified submodule contains untracked content' '
>  '
>  
>  test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +	git diff-index -p --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 $head7..$head8:
>  	diff --git a/sm1/foo6 b/sm1/foo6
> @@ -564,7 +564,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
>  
>  test_expect_success 'modified submodule contains untracked and modified content' '
>  	echo modification >> sm1/foo6 &&
> -	git diff-index -p --submodule=diff HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	Submodule sm1 contains modified content
> @@ -583,7 +583,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
>  
>  test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
>  	echo modification >> sm1/foo6 &&
> -	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +	git diff-index -p --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains modified content
>  	Submodule sm1 $head7..$head8:
> diff --git a/wt-status.c b/wt-status.c
> index 7074bbdd53..83d418647d 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -606,7 +606,9 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
>  	if (s->ignore_submodule_arg) {
>  		rev.diffopt.flags.override_submodule_config = 1;
>  		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
> -	}
> +	} else if (!rev.diffopt.flags.ignore_submodule_set && 
> +			s->show_untracked_files != SHOW_NO_UNTRACKED_FILES)
> +		handle_ignore_submodules_arg(&rev.diffopt, "none");
>  	rev.diffopt.format_callback = wt_status_collect_changed_cb;
>  	rev.diffopt.format_callback_data = s;
>  	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
> -- 
> 2.21.1 (Apple Git-122.3)
> 

-- 
Danh
