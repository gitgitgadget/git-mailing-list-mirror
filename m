Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F01C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 13:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DEA206B1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 13:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nw+Exp3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCLNUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:20:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55087 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLNUk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 09:20:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id n8so6062562wmc.4
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 06:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rD0k9HuvlZTVyOgCuuT4naY2hDKm0LeW6g7PwFz3YmQ=;
        b=nw+Exp3iJiJiAhrVj+mk7R5Hy6boCc0GQcEc/3cKG4cYhv+UpmC6hp/mcNxrSsxpft
         EBvW56dHJATgS+dVYnyDUj18qCGGMcZg1PAGgUtvMelWhFenNKM+bW1CxB8zBDlVbK53
         nkb2WuNhjO8aAAlTVQzrJ5XVbHYlhE9zSdEfZAA3mim8DmMnyfyFRYKOUsHaH5Ai5ZBo
         /VNBRUpB56WWhAN6q+ISgXvNng5kxLcrDjVKBTX/hD5YCFrtZi1evBGi+oF7Wqp7uIp+
         bGkuL/76SMaAIf4sUubfFfooANCigBs68PnIouQzfIkIYi0FvsGdHFm2Yi1q4Ii5sx3+
         ys1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rD0k9HuvlZTVyOgCuuT4naY2hDKm0LeW6g7PwFz3YmQ=;
        b=BB12ZAgDLrNtehkYFrhxsUDR9lngBv5oWzrmPmbeMnULnUTaOJZKIpNQ5NSTjRY701
         aMwDycfmkL/Zdngxl2lr+WNZSSi2TkqndU2d+k1QO0agBAp5GsZ61ZV/cW/5XAGA1pv/
         /qv/uIxwgd22gKb8S9M7xT7b64WMt30XqVHjMF012oZOICNIY+ThwQbDcYfOYva/NjE1
         VX/VeHVYNnHDEDWgg9RAS32U6TzCV4h6wkaMotEv/nDmkNzRS9Fz1Yo6mWjz6ZKxrlly
         yoS0qJQYg4hjg0cqQB2epZVhLT0J23x4sdhWdW/Yy0IaEe6MMVzrkTv/97S5M/+2DjZY
         hESg==
X-Gm-Message-State: ANhLgQ1RSIxDLftgA0iT8upc99NEXGgIYzBCfN1Ps3C6CqgY4jfH088d
        QyDGcRFfsifUMy59wu0wTec=
X-Google-Smtp-Source: ADFU+vszMxAnd7XwD/1BzKWIhBFsQMJNb8eW+adUclF5oXdoOEAQKcLQfZClck9Uz5ijMqcCx1bSpQ==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr4784309wml.173.1584019237385;
        Thu, 12 Mar 2020 06:20:37 -0700 (PDT)
Received: from szeder.dev (94-21-29-150.pool.digikabel.hu. [94.21.29.150])
        by smtp.gmail.com with ESMTPSA id r9sm5350913wma.47.2020.03.12.06.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:20:35 -0700 (PDT)
Date:   Thu, 12 Mar 2020 14:20:32 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] t6022, t6046: test expected behavior instead of
 testing a proxy for it
Message-ID: <20200312132032.GD3122@szeder.dev>
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
 <26d0c34cd1d4a54dab28d0c9c2242336244e8a3c.1582762465.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26d0c34cd1d4a54dab28d0c9c2242336244e8a3c.1582762465.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 27, 2020 at 12:14:23AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> In t6022, we were testing for file being overwritten (or not) based on
> an output message instead of checking for the file being overwritten.
> Since we can check for the file being overwritten via mtime updates,
> check that instead.
> 
> In t6046, we were largely checking for both the expected behavior and a
> proxy for it, which is unnecessary.  The calls to test-tool also were a
> bit cryptic.  Make them a little clearer.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6022-merge-rename.sh                | 15 ++++-
>  t/t6046-merge-skip-unneeded-updates.sh | 89 +++++++++++++++++---------
>  2 files changed, 70 insertions(+), 34 deletions(-)
> 
> diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
> index 6f196aaf276..d97cf48495b 100755
> --- a/t/t6022-merge-rename.sh
> +++ b/t/t6022-merge-rename.sh
> @@ -242,12 +242,23 @@ test_expect_success 'merge of identical changes in a renamed file' '
>  	rm -f A M N &&
>  	git reset --hard &&
>  	git checkout change+rename &&
> +
> +	test-tool chmtime =31337 B &&
> +	test-tool chmtime --get B >old-mtime &&

Nit: I think it's possible to change the mtime and print it in a
single invocation with:

  test-tool chmtime --get =1234 file

>  	GIT_MERGE_VERBOSITY=3 git merge change >out &&

Nit: The output of 'git merge' is still redirected to a file, but ...

> -	test_i18ngrep "^Skipped B" out &&

... the only command looking at the output is now removed.

> +	test-tool chmtime --get B >new-mtime &&
> +	test_cmp old-mtime new-mtime &&
> +
>  	git reset --hard HEAD^ &&
>  	git checkout change &&
> +
> +	test-tool chmtime =-1 M &&
> +	test-tool chmtime --get M >old-mtime &&
>  	GIT_MERGE_VERBOSITY=3 git merge change+rename >out &&
> -	test_i18ngrep ! "^Skipped B" out

Likewise.

> +	test-tool chmtime --get B >new-mtime &&
> +	test $(cat old-mtime) -lt $(cat new-mtime)

I saw this test fail today in one of my custom CI builds:

  +git checkout change
  Switched to branch 'change'
  +test-tool chmtime =-1 M
  +test-tool chmtime --get M
  +GIT_MERGE_VERBOSITY=3 git merge change+rename
  +test-tool chmtime --get B
  +cat old-mtime
  +cat new-mtime
  +test 1583967731 -lt 1583967731
  error: last command exited with $?=1
  not ok 12 - merge of identical changes in a renamed file

The contents of 'out', i.e. the output of the 'git merge' command
before the failure is:

  Auto-merging B
  Merge made by the 'recursive' strategy.
   A => B | 0
   1 file changed, 0 insertions(+), 0 deletions(-)
   rename A => B (100%)

This is a rare failure, this is the first time I saw it, and to make
things worse, this one time it happened on big-endian and with all the
GIT_TEST_* knobs enabled.

  https://travis-ci.org/github/szeder/git-cooking-topics-for-travis-ci/jobs/661294571#L4020

I've been running './t6022-merge-rename.sh --stress -r 1,12' both with
and without all the GIT_TEST_* knobs for a few hundred repetitions,
but couldn't trigger the failure yet...

I wonder whether comparing the mtimes with '-le' instead of '-lt' is
acceptable in this test case, but don't have enough insight to form an
opinion.  Note that this patch added a few similar mtime comparisons
to t6046 below, and they might be prone to the same issue as well.

>  test_expect_success 'setup for rename + d/f conflicts' '
> diff --git a/t/t6046-merge-skip-unneeded-updates.sh b/t/t6046-merge-skip-unneeded-updates.sh
> index b7e46698321..962030ecdb6 100755
> --- a/t/t6046-merge-skip-unneeded-updates.sh
> +++ b/t/t6046-merge-skip-unneeded-updates.sh
> @@ -71,16 +71,16 @@ test_expect_success '1a-L: Modify(A)/Modify(B), change on B subset of A' '
>  
>  		git checkout A^0 &&
>  
> -		test-tool chmtime =31337 b &&
> -		test-tool chmtime -v +0 b >expected-mtime &&
> +		test-tool chmtime =-1 b &&
> +		test-tool chmtime --get b >old-mtime &&
>  
>  		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
>  
> -		test_i18ngrep "Skipped b" out &&
>  		test_must_be_empty err &&
>  
> -		test-tool chmtime -v +0 b >actual-mtime &&
> -		test_cmp expected-mtime actual-mtime &&
> +		# Make sure b was NOT updated
> +		test-tool chmtime --get b >new-mtime &&
> +		test_cmp old-mtime new-mtime &&
>  
>  		git ls-files -s >index_files &&
>  		test_line_count = 1 index_files &&
> @@ -102,9 +102,14 @@ test_expect_success '1a-R: Modify(A)/Modify(B), change on B subset of A' '
>  
>  		git checkout B^0 &&
>  
> +		test-tool chmtime =-1 b &&
> +		test-tool chmtime --get b >old-mtime &&
>  		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
>  
> -		test_i18ngrep "Auto-merging b" out &&
> +		# Make sure b WAS updated
> +		test-tool chmtime --get b >new-mtime &&
> +		test $(cat old-mtime) -lt $(cat new-mtime) &&
> +
>  		test_must_be_empty err &&
>  
>  		git ls-files -s >index_files &&
> @@ -165,10 +170,10 @@ test_expect_success '2a-L: Modify/rename, merge into modify side' '
>  
>  		git checkout A^0 &&
>  
> +		test_path_is_missing c &&
>  		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
>  
> -		test_i18ngrep ! "Skipped c" out &&
> -		test_must_be_empty err &&
> +		test_path_is_file c &&
>  
>  		git ls-files -s >index_files &&
>  		test_line_count = 1 index_files &&
> @@ -193,9 +198,14 @@ test_expect_success '2a-R: Modify/rename, merge into rename side' '
>  
>  		git checkout B^0 &&
>  
> +		test-tool chmtime =-1 c &&
> +		test-tool chmtime --get c >old-mtime &&
>  		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
>  
> -		test_i18ngrep ! "Skipped c" out &&
> +		# Make sure c WAS updated
> +		test-tool chmtime --get c >new-mtime &&
> +		test $(cat old-mtime) -lt $(cat new-mtime) &&
> +
>  		test_must_be_empty err &&
>  
>  		git ls-files -s >index_files &&
> @@ -256,16 +266,15 @@ test_expect_success '2b-L: Rename+Mod(A)/Mod(B), B mods subset of A' '
>  
>  		git checkout A^0 &&
>  
> -		test-tool chmtime =31337 c &&
> -		test-tool chmtime -v +0 c >expected-mtime &&
> -
> +		test-tool chmtime =-1 c &&
> +		test-tool chmtime --get c >old-mtime &&
>  		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
>  
> -		test_i18ngrep "Skipped c" out &&
>  		test_must_be_empty err &&
>  
> -		test-tool chmtime -v +0 c >actual-mtime &&
> -		test_cmp expected-mtime actual-mtime &&
> +		# Make sure c WAS updated
> +		test-tool chmtime --get c >new-mtime &&
> +		test_cmp old-mtime new-mtime &&
>  
>  		git ls-files -s >index_files &&
>  		test_line_count = 1 index_files &&
> @@ -290,9 +299,12 @@ test_expect_success '2b-R: Rename+Mod(A)/Mod(B), B mods subset of A' '
>  
>  		git checkout B^0 &&
>  
> +		test_path_is_missing c &&
>  		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
>  
> -		test_i18ngrep "Auto-merging c" out &&
> +		# Make sure c now present (and thus was updated)
> +		test_path_is_file c &&
> +
>  		test_must_be_empty err &&
>  
>  		git ls-files -s >index_files &&
> @@ -361,13 +373,18 @@ test_expect_success '2c: Modify b & add c VS rename b->c' '
>  
>  		git checkout A^0 &&
>  
> +		test-tool chmtime =-1 c &&
> +		test-tool chmtime --get c >old-mtime &&
>  		GIT_MERGE_VERBOSITY=3 &&
>  		export GIT_MERGE_VERBOSITY &&
>  		test_must_fail git merge -s recursive B^0 >out 2>err &&
>  
>  		test_i18ngrep "CONFLICT (rename/add): Rename b->c" out &&
> -		test_i18ngrep ! "Skipped c" out &&
> -		test_must_be_empty err
> +		test_must_be_empty err &&
> +
> +		# Make sure c WAS updated
> +		test-tool chmtime --get c >new-mtime &&
> +		test $(cat old-mtime) -lt $(cat new-mtime)
>  
>  		# FIXME: rename/add conflicts are horribly broken right now;
>  		# when I get back to my patch series fixing it and
> @@ -460,11 +477,13 @@ test_expect_success '3a-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
>  
>  		git checkout A^0 &&
>  
> +		test_path_is_missing bar/bq &&
>  		GIT_MERGE_VERBOSITY=3 git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
>  
> -		test_i18ngrep ! "Skipped bar/bq" out &&
>  		test_must_be_empty err &&
>  
> +		test_path_is_file bar/bq &&
> +
>  		git ls-files -s >index_files &&
>  		test_line_count = 2 index_files &&
>  
> @@ -488,11 +507,13 @@ test_expect_success '3a-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
>  
>  		git checkout B^0 &&
>  
> +		test_path_is_missing bar/bq &&
>  		GIT_MERGE_VERBOSITY=3 git -c merge.directoryRenames=true merge -s recursive A^0 >out 2>err &&
>  
> -		test_i18ngrep ! "Skipped bar/bq" out &&
>  		test_must_be_empty err &&
>  
> +		test_path_is_file bar/bq &&
> +
>  		git ls-files -s >index_files &&
>  		test_line_count = 2 index_files &&
>  
> @@ -552,11 +573,13 @@ test_expect_success '3b-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
>  
>  		git checkout A^0 &&
>  
> +		test_path_is_missing bar/bq &&
>  		GIT_MERGE_VERBOSITY=3 git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
>  
> -		test_i18ngrep ! "Skipped bar/bq" out &&
>  		test_must_be_empty err &&
>  
> +		test_path_is_file bar/bq &&
> +
>  		git ls-files -s >index_files &&
>  		test_line_count = 2 index_files &&
>  
> @@ -580,11 +603,13 @@ test_expect_success '3b-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
>  
>  		git checkout B^0 &&
>  
> +		test_path_is_missing bar/bq &&
>  		GIT_MERGE_VERBOSITY=3 git -c merge.directoryRenames=true merge -s recursive A^0 >out 2>err &&
>  
> -		test_i18ngrep ! "Skipped bar/bq" out &&
>  		test_must_be_empty err &&
>  
> +		test_path_is_file bar/bq &&
> +
>  		git ls-files -s >index_files &&
>  		test_line_count = 2 index_files &&
>  
> @@ -654,16 +679,16 @@ test_expect_failure '4a: Change on A, change on B subset of A, dirty mods presen
>  		git checkout A^0 &&
>  		echo "File rewritten" >b &&
>  
> -		test-tool chmtime =31337 b &&
> -		test-tool chmtime -v +0 b >expected-mtime &&
> +		test-tool chmtime =-1 b &&
> +		test-tool chmtime --get b >old-mtime &&
>  
>  		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
>  
> -		test_i18ngrep "Skipped b" out &&
>  		test_must_be_empty err &&
>  
> -		test-tool chmtime -v +0 b >actual-mtime &&
> -		test_cmp expected-mtime actual-mtime &&
> +		# Make sure b was NOT updated
> +		test-tool chmtime --get b >new-mtime &&
> +		test_cmp old-mtime new-mtime &&
>  
>  		git ls-files -s >index_files &&
>  		test_line_count = 1 index_files &&
> @@ -722,16 +747,16 @@ test_expect_success '4b: Rename+Mod(A)/Mod(B), change on B subset of A, dirty mo
>  		git checkout A^0 &&
>  		echo "File rewritten" >c &&
>  
> -		test-tool chmtime =31337 c &&
> -		test-tool chmtime -v +0 c >expected-mtime &&
> +		test-tool chmtime =-1 c &&
> +		test-tool chmtime --get c >old-mtime &&
>  
>  		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
>  
> -		test_i18ngrep "Skipped c" out &&
>  		test_must_be_empty err &&
>  
> -		test-tool chmtime -v +0 c >actual-mtime &&
> -		test_cmp expected-mtime actual-mtime &&
> +		# Make sure c was NOT updated
> +		test-tool chmtime --get c >new-mtime &&
> +		test_cmp old-mtime new-mtime &&
>  
>  		git ls-files -s >index_files &&
>  		test_line_count = 1 index_files &&
> -- 
> gitgitgadget
> 
