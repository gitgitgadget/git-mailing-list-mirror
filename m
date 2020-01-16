Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A8AC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384292073A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ycBNW6vN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgAPVqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:46:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62802 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbgAPVqP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:46:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B867A9F589;
        Thu, 16 Jan 2020 16:46:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0RfmB9IgrNxFPO+1an0cVc8QfuE=; b=ycBNW6
        vN05DqVWzSxdYUi+jyXFxHO4vNNGVLPj1LXD+fxmmp9O5+pQL0SNDprc1HtMdzzv
        ErYhcc8Gbm8fqEggZWw6Q/sGxX8tYYMq58jkfEVyVi/pqWwNZUX9gjegZrE/vxgj
        WvqWPLXL/3Qbm5XjcuVdmqSdPLxtW9yat+eaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iXCB4qNavuldgpHEC3CBr301/MDzl8DR
        mNam17SPlYlSVobzpNkX0+ZWozg+1FcWzV75LPdN8oq2vFjrcfjDKuST2/HaaSIg
        nlvO6Y0+qyDdRI5B0ZKN2YiQlr5DSYt4zF9ong8dEm+gHJ5C4fV18CYR8aiXLDu5
        ZYT5kGgSXc8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AFFED9F588;
        Thu, 16 Jan 2020 16:46:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7829A9F587;
        Thu, 16 Jan 2020 16:46:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/8] sparse-checkout: create leading directories
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
        <53a266f9aab5f4331c35b3ff15fb0628e2131c56.1579029963.git.gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 13:46:08 -0800
In-Reply-To: <53a266f9aab5f4331c35b3ff15fb0628e2131c56.1579029963.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 14 Jan 2020
        19:25:56 +0000")
Message-ID: <xmqq4kwvgjmn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BF0A7F8-38A9-11EA-9185-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The 'git init' command creates the ".git/info" directory and fills it
> with some default files. However, 'git worktree add' does not create
> the info directory for that worktree. This causes a problem when running
> "git sparse-checkout init" inside a worktree. While care was taken to
> allow the sparse-checkout config to be specific to a worktree, this
> initialization was untested.
>
> Safely create the leading directories for the sparse-checkout file. This
> is the safest thing to do even without worktrees, as a user could delete
> their ".git/info" directory and expect Git to recover safely.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c          |  4 ++++
>  t/t1091-sparse-checkout-builtin.sh | 10 ++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index b3bed891cb..3cee8ab46e 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -199,6 +199,10 @@ static int write_patterns_and_update(struct pattern_list *pl)
>  	int result;
>  
>  	sparse_filename = get_sparse_checkout_filename();
> +
> +	if (safe_create_leading_directories(sparse_filename))
> +		die(_("failed to create directory for sparse-checkout file"));
> +

The use of safe_create_leading_directories() here, which uses
adjust_shared_perm(), is the right thing to do.

Looks good.

> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 20caefe155..37365dc668 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -295,4 +295,14 @@ test_expect_success 'interaction with submodules' '
>  	check_files super/modules/child "a deep folder1 folder2"
>  '
>  
> +test_expect_success 'different sparse-checkouts with worktrees' '
> +	git -C repo worktree add --detach ../worktree &&
> +	check_files worktree "a deep folder1 folder2" &&
> +	git -C worktree sparse-checkout init --cone &&
> +	git -C repo sparse-checkout set folder1 &&
> +	git -C worktree sparse-checkout set deep/deeper1 &&
> +	check_files repo "a folder1" &&
> +	check_files worktree "a deep"
> +'
> +
>  test_done
