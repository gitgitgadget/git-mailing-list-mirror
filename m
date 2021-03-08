Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50EBC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 13:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7453C64FE3
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 13:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhCHND7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 08:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhCHNDf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 08:03:35 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B013C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 05:03:34 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id h10so14646515edl.6
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 05:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=q5cD6ZtkcW5RluvrvUqEcbR5IsR1wmDU1VDpe/1pmkA=;
        b=evHwILg4y0+vSqjNVdvGxTBdZJwNETjOhWzdOB2AJUBPWS7esF9f5maKytqilGQGoU
         pChCA+i/U9uWsK36zvWxGpnm7g59hQ1O0Z+1xKguTruu+BmLi+zAjCS92QASGp8eYeFP
         2v/+Uc608dnezpVLK4F+g113v33xhQgMWL5FW2DuLL/yoX04TykgXx5KuYr1vOynJHFu
         neF+5owcgngBLBXSW5MMeNzcJU1yRTM8EzQnJBnGcvVL8nqps+RTFR3lv4XRpQYO083J
         44GF9kdROiQurztEYwe5gLamfjtf7Awwqru0QXB7djiRgI1SD33Nig+lefDDSw76c9sF
         QpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=q5cD6ZtkcW5RluvrvUqEcbR5IsR1wmDU1VDpe/1pmkA=;
        b=laFdd/jHgdvzwjpApuc5H97Uupp5hiyXvS1HFZXOfFiWdEbISe1+wNtVKz7VcaoIOq
         eEU8nah7RFGL8pewJHCMKGXRRsOkxRIcDWcQHhDKGFAKKbXRKUY8fFc+hQfV0niBjGPg
         vwQtMX8IrZOhZyI28iRiW/dRmJKatQfcIj9+hyVC8T/Vdl6t1oGRG/Wkzlv6rRbgqm4Q
         f8N7z+pZdvOcw73vVJkdnZLzXuKvTLzKsRtSrOxdvxLRyU8/cNmQQFBH8aVqFGPcrpHm
         2CLzx8sb6A9x9CNoO3TnwBGxkdrF/l5uovMGA0Z7dUnfx6hJh2ZEAJRVrriv5H2Wax8h
         T5VQ==
X-Gm-Message-State: AOAM532yPmYcxP5qCHyO6OeBjjrvVp2DCAW8Ux+wdmoPVMP5u2/Vb/wX
        zde6BCLb9MugACoFPFf3+oVXrCMmIdIOBQ==
X-Google-Smtp-Source: ABdhPJyGJe54HRw37XvATckMIcYVgRu+sRllNsBg+o0XjEXaydeVDBng6QgDDGenGtU5X9z/bMWEHg==
X-Received: by 2002:a05:6402:1d1a:: with SMTP id dg26mr21511166edb.266.1615208613034;
        Mon, 08 Mar 2021 05:03:33 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t15sm7525620edc.34.2021.03.08.05.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:03:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 07/11] t6428: new test for SKIP_WORKTREE handling and
 conflicts
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <6ccb24b557fc9c9d8e3d307d3e142d8393920414.1614905738.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <6ccb24b557fc9c9d8e3d307d3e142d8393920414.1614905738.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 14:03:31 +0100
Message-ID: <874khlkdb0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> If there is a conflict during a merge for a SKIP_WORKTREE entry, we
> expect that file to be written to the working copy and have the
> SKIP_WORKTREE bit cleared in the index.  If the user had manually
> created a file in the working tree despite SKIP_WORKTREE being set, we
> do not want to clobber their changes to that file, but want to move it
> out of the way.  Add tests that check for these behaviors.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6428-merge-conflicts-sparse.sh | 158 ++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100755 t/t6428-merge-conflicts-sparse.sh
>
> diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
> new file mode 100755
> index 000000000000..1bb52ff6f38c
> --- /dev/null
> +++ b/t/t6428-merge-conflicts-sparse.sh
> @@ -0,0 +1,158 @@
> +#!/bin/sh
> +
> +test_description="merge cases"
> +
> +# The setup for all of them, pictorially, is:
> +#
> +#      A
> +#      o
> +#     / \
> +#  O o   ?
> +#     \ /
> +#      o
> +#      B
> +#
> +# To help make it easier to follow the flow of tests, they have been
> +# divided into sections and each test will start with a quick explanation
> +# of what commits O, A, and B contain.
> +#
> +# Notation:
> +#    z/{b,c}   means  files z/b and z/c both exist
> +#    x/d_1     means  file x/d exists with content d1.  (Purpose of the
> +#                     underscore notation is to differentiate different
> +#                     files that might be renamed into each other's paths.)
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-merge.sh
> +
> +
> +# Testcase basic, conflicting changes in 'numerals'
> +
> +test_setup_numerals () {
> +	test_create_repo numerals_$1 &&
> +	(
> +		cd numerals_$1 &&
> +
> +		>README &&
> +		test_write_lines I II III >numerals &&
> +		git add README numerals &&
> +		test_tick &&
> +		git commit -m "O" &&

As an aside this could use the --printf option to test_commit I've got
in next, but that's also a bit painful to use since you can't use
test_write_lines.

I've wanted to just support something like this for this use-case of
using an existing file:

    test_write_lines A B C D >lines &&
    test_commit --add O lines &&


> +
> +		git branch O &&
> +		git branch A &&
> +		git branch B &&
> +
> +		git checkout A &&
> +		test_write_lines I II III IIII >numerals &&
> +		git add numerals &&
> +		test_tick &&
> +		git commit -m "A" &&
> +
> +		git checkout B &&
> +		test_write_lines I II III IV >numerals &&
> +		git add numerals &&
> +		test_tick &&
> +		git commit -m "B" &&
> +
> +		cat <<-EOF >expected-index &&
> +		H README
> +		M numerals
> +		M numerals
> +		M numerals
> +		EOF
> +
> +		cat <<-EOF >expected-merge
> +		I
> +		II
> +		III
> +		<<<<<<< HEAD
> +		IIII
> +		=======
> +		IV
> +		>>>>>>> B^0
> +		EOF
> +
> +	)
> +}
> +
> +test_expect_merge_algorithm success failure 'conflicting entries written to worktree even if sparse' '
> +	test_setup_numerals plain &&

A small nit, but makes it easier to debug things: I think having what
you have in "test_setup_numerals" above in a test_expect_success is a
better pattern, then if it fails we can see where exactly.

Then instead of calling "test_setup_numerals" here you'd do:

    cp -R template plain &&

To just copy over that existing setup template, or re-use it and have
have the tests call a small helper to "test_when_finish" reset --hard
back as appropriate.
