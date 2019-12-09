Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B14C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B82205C9
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9R3EL91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLIVFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:05:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39913 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfLIVFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 16:05:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so7845127pfx.6
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 13:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ISHDwHufZ6NzJ60H0t76lLUIMLAOywUQtXQ3SKosud0=;
        b=i9R3EL91fHiBpwSPee+8HR453JszeuA/F17jZvVOFkt8k6xyhn0/wvLWeUE3Vj2HYp
         Cr6pslqKVDPn+o0fkHMYLY7Y6+9s+tzapXoTpiMhSYLM+v2CBimz6gt4f2riSDpoOGhV
         y0savx0GRTd9WIHzFMmqByi2XDYuC8xbhLaN9SG2Xajc54mi7E0ww3buYngLdgTXtzI8
         QdqnRVBWHSgvIVP8fj7EIFPHUQvNayBcc7pJcYqWH92AEHfVwYruDFEHWDZcN5V1WWcE
         vm56EcqqlW0N/Q+Hf2b4pzklwKX0fnABxd8hLEVsRna4KUvRK+Z0vv6+y917lS9MgnFc
         LXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ISHDwHufZ6NzJ60H0t76lLUIMLAOywUQtXQ3SKosud0=;
        b=fGmIcvCiCXiK6kxZH14+9QuzTjXnUCtgy9anAFpd4T1Wunad10t36Ux7zOHKh8F90t
         NksUnXB9KkbvvPN+HD2Gvlt2EpSeOmUtD+S0tRujlwWyfCigZWNlwpT2hz+nWRIAGOA8
         tZa2X3GZZrE/xA2amjBqlhwrmylxGxffek1UQ6UryKxL5DBUV7+cDwljNNR2Wm5MyxoT
         kXqRanO+xK8P3J4upkpZX4MqkzZjzsTnyDBeo2YVyoJNyqjUkRxGEDCtUcBfG87W2GUE
         rq2fA6oabrPFe1A4LyAdWeRxavZP5Pj9U8eNAErXs/pjGAV31EhWpJYA25hp41dvfEAf
         TjtQ==
X-Gm-Message-State: APjAAAVma5k9g3EO+J5kXyD9NSVc83/nhAuNQiokKPXHZHhXdsxEuEQI
        GCXBvEcp3q9IePzlL3uyy9k=
X-Google-Smtp-Source: APXvYqxXVGVdteQXNuomqsTg6nIx9yRUBcJMUY0XA6kB1CD6Q2BWDf8YIAcQvqcn8wQ2RhEJYED0xg==
X-Received: by 2002:a63:2ad8:: with SMTP id q207mr20875860pgq.45.1575925544318;
        Mon, 09 Dec 2019 13:05:44 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id z29sm450029pge.21.2019.12.09.13.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:05:43 -0800 (PST)
Date:   Mon, 9 Dec 2019 13:06:08 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/8] t3011: demonstrate directory traversal failures
Message-ID: <20191209210608.GA39599@generichostname>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
 <4b24ba9966d41558cc2382d81e6e76b4375b555c.1575924465.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b24ba9966d41558cc2382d81e6e76b4375b555c.1575924465.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, Dec 09, 2019 at 08:47:38PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Add several tests demonstrating directory traversal failures of various
> sorts in dir.c (and one similar looking test that turns out to be a
> git_fnmatch bug).  A lot of these tests look like near duplicates of
> each other, but an optimization path in dir.c to pre-descend into a
> common prefix and the specialized treatment of trailing slashes in dir.c
> mean the tiny differences are sometimes important and potentially cause
> different codepaths to be explored.
> 
> Of the 7 failing tests, 2 are new to git-2.24.0 (tweaked by side effects
> of the en/clean-nested-with-ignored-topic); the other 5 also failed
> under git-2.23.0 and earlier.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  ...common-prefixes-and-directory-traversal.sh | 193 ++++++++++++++++++
>  1 file changed, 193 insertions(+)
>  create mode 100755 t/t3011-common-prefixes-and-directory-traversal.sh
> 
> diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
> new file mode 100755
> index 0000000000..773d6038d1
> --- /dev/null
> +++ b/t/t3011-common-prefixes-and-directory-traversal.sh
> @@ -0,0 +1,193 @@
> +#!/bin/sh
> +
> +test_description='directory traversal handling, especially with common prefixes'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit hello &&
> +
> +	>empty &&
> +	mkdir untracked_dir &&
> +	>untracked_dir/empty &&
> +	git init untracked_repo &&
> +	>untracked_repo/empty &&
> +
> +	echo ignored >.gitignore &&
> +	echo an_ignored_dir/ >>.gitignore &&

Could we just do

	cat <<-EOF >expect
	ignored
	an_ignored_dir/
	EOF

instead? Alternatively, we can use test_write_lines() but since we have
here-doc usages below already, let's keep using here-docs here to be
consistent. Same comment applies to anywhere in this patch where we have
a >>.

> +	mkdir an_ignored_dir &&
> +	mkdir an_untracked_dir &&
> +	>an_ignored_dir/ignored &&
> +	>an_ignored_dir/untracked &&
> +	>an_untracked_dir/ignored &&
> +	>an_untracked_dir/untracked
> +'
> +
> +test_expect_success 'git ls-files -o shows the right entries' '
> +	cat <<-EOF >expect &&
> +	.gitignore
> +	actual
> +	an_ignored_dir/ignored
> +	an_ignored_dir/untracked
> +	an_untracked_dir/ignored
> +	an_untracked_dir/untracked
> +	empty
> +	expect
> +	untracked_dir/empty
> +	untracked_repo/
> +	EOF
> +	git ls-files -o >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files -o --exclude-standard shows the right entries' '
> +	cat <<-EOF >expect &&
> +	.gitignore
> +	actual
> +	an_untracked_dir/untracked
> +	empty
> +	expect
> +	untracked_dir/empty
> +	untracked_repo/
> +	EOF
> +	git ls-files -o --exclude-standard >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files -o untracked_dir recurses' '
> +	echo untracked_dir/empty >expect &&
> +	git ls-files -o untracked_dir >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files -o untracked_dir/ recurses' '
> +	echo untracked_dir/empty >expect &&
> +	git ls-files -o untracked_dir/ >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files -o --directory untracked_dir does not recurse' '
> +	echo untracked_dir/ >expect &&
> +	git ls-files -o --directory untracked_dir >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'git ls-files -o --directory untracked_dir/ does not recurse' '
> +	echo untracked_dir/ >expect &&
> +	git ls-files -o --directory untracked_dir/ >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files -o untracked_repo does not recurse' '
> +	echo untracked_repo/ >expect &&
> +	git ls-files -o untracked_repo >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'git ls-files -o untracked_repo/ does not recurse' '
> +	echo untracked_repo/ >expect &&
> +	git ls-files -o untracked_repo/ >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
> +	echo untracked_dir/empty >expect &&
> +	echo untracked_repo/ >>expect &&
> +	git ls-files -o untracked_dir untracked_repo >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files -o untracked_dir/ untracked_repo/ recurses into untracked_dir only' '
> +	echo untracked_dir/empty >expect &&
> +	echo untracked_repo/ >>expect &&
> +	git ls-files -o untracked_dir/ untracked_repo/ >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
> +	echo untracked_dir/ >expect &&
> +	echo untracked_repo/ >>expect &&
> +	git ls-files -o --directory untracked_dir untracked_repo >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files -o --directory untracked_dir/ untracked_repo/ does not recurse' '
> +	echo untracked_dir/ >expect &&
> +	echo untracked_repo/ >>expect &&
> +	git ls-files -o --directory untracked_dir/ untracked_repo/ >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files -o .git shows nothing' '
> +	>expect &&
> +	git ls-files -o .git >actual &&
> +	test_cmp expect actual
> +'

Could we use test_must_be_empty here instead?

> +
> +test_expect_failure 'git ls-files -o .git/ shows nothing' '
> +	>expect &&
> +	git ls-files -o .git/ >actual &&
> +	test_cmp expect actual
> +'

test_must_be_empty?

Thanks,

Denton

> +
> +test_expect_success FUNNYNAMES 'git ls-files -o untracked_* recurses appropriately' '
> +	mkdir "untracked_*" &&
> +	>"untracked_*/empty" &&
> +
> +	echo "untracked_*/empty" >expect &&
> +	echo untracked_dir/empty >>expect &&
> +	echo untracked_repo/ >>expect &&
> +	git ls-files -o "untracked_*" >actual &&
> +	test_cmp expect actual
> +'
> +
> +# It turns out fill_directory returns the right paths, but ls-files' post-call
> +# filtering in show_dir_entry() via calling dir_path_match() which ends up
> +# in git_fnmatch() has logic for PATHSPEC_ONESTAR that assumes the pathspec
> +# must match the full path; it doesn't check it for matching a leading
> +# directory.
> +test_expect_failure FUNNYNAMES 'git ls-files -o untracked_*/ recurses appropriately' '
> +	echo "untracked_*/empty" >expect &&
> +	echo untracked_dir/empty >>expect &&
> +	echo untracked_repo/ >>expect &&
> +	git ls-files -o "untracked_*/" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success FUNNYNAMES 'git ls-files -o --directory untracked_* does not recurse' '
> +	echo "untracked_*/" >expect &&
> +	echo untracked_dir/ >>expect &&
> +	echo untracked_repo/ >>expect &&
> +	git ls-files -o --directory "untracked_*" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success FUNNYNAMES 'git ls-files -o --directory untracked_*/ does not recurse' '
> +	echo "untracked_*/" >expect &&
> +	echo untracked_dir/ >>expect &&
> +	echo untracked_repo/ >>expect &&
> +	git ls-files -o --directory "untracked_*/" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files -o consistent between one or two dirs' '
> +	git ls-files -o --exclude-standard an_ignored_dir/ an_untracked_dir/ >tmp &&
> +	! grep ^an_ignored_dir/ tmp >expect &&
> +	git ls-files -o --exclude-standard an_ignored_dir/ >actual &&
> +	test_cmp expect actual
> +'
> +
> +# ls-files doesn't have a way to request showing both untracked and ignored
> +# files at the same time, so use `git status --ignored`
> +test_expect_failure 'git status --ignored shows same files under dir with or without pathspec' '
> +	cat <<-EOF >expect &&
> +	?? an_untracked_dir/
> +	!! an_untracked_dir/ignored
> +	EOF
> +	git status --porcelain --ignored >output &&
> +	grep an_untracked_dir output >expect &&
> +	git status --porcelain --ignored an_untracked_dir/ >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> -- 
> gitgitgadget
> 
