Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14D148FF8
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938164; cv=none; b=uG5Uynw+dKD2hFr6scyMNPwG3Zq7VFw/g1DVZn7YQv0qz/v6gtHMaTk/ccvUJkuyzQmP/q8xfUnYU8SpWsRSyDBy8O/84HhaBaXwBgmrUfWAvNunJ1+zVrK5CARJ9eUfDMeCFT+QpoUYOErg8eHe/x9Xp4+qoVVbDMeMoslfu6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938164; c=relaxed/simple;
	bh=ApLkBIMXn1AUWgU56J+ERiJ4jek9aNMZmG57NKYxwmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vy0CIdXFNTNv+/xpOIV6Voh7kvbMZk7MgKJrnCG9xM0SX+XN66Jl2uLp3fTODZrzsb0hYNYVnws0GJJSn2ZRIyg9uD/pZHTaNAy4IIwk05/vEFRZxtbRascesKy63R7jXD/MhzbV9aG/UdEutKfmsRcBsoUGFdF8WT5CVoaRvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FHHYdzc7; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FHHYdzc7"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 332551E0C24;
	Fri, 12 Apr 2024 12:09:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ApLkBIMXn1AUWgU56J+ERiJ4jek9aNMZmG57NK
	YxwmI=; b=FHHYdzc7m7ybwzBK1SV9iP5fh/1v2uYvzkHBQw6Wr46UD1C2Y5Sp+s
	Xh0dCmn1A7FsA2jAFuJ5xAqORs+tMAm9SzSyhKLCcC/zsJR2jnN7Wb7Gmw6qdkmk
	RR6cphyYLs3u/xFr8WhwloG8Untv5unU/dNUgQjGM8yFuAhnHEoj4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A6361E0C21;
	Fri, 12 Apr 2024 12:09:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AB901E0C20;
	Fri, 12 Apr 2024 12:09:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] merge-tree: fix argument type of the `--merge-base` option
In-Reply-To: <pull.1717.git.1712923841235.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 12 Apr 2024 12:10:40
	+0000")
References: <pull.1717.git.1712923841235.gitgitgadget@gmail.com>
Date: Fri, 12 Apr 2024 09:09:20 -0700
Message-ID: <xmqq7ch2pnpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 05DC98C8-F8E7-11EE-BE98-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 5f43cf5b2e4 (merge-tree: accept 3 trees as arguments, 2024-01-28), I
> taught `git merge-tree` to perform three-way merges on trees. This
> commit even changed the manual page to state that the `--merge-base`
> option takes a tree-ish rather than requiring a commit.
>
> But I forgot to adjust the in-program help text. This patch fixes that.

Thanks for being careful---better late than never ;-)

Will queue and fast-track, as I do not see much chance of regression
coming from here.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     merge-tree: adjust argument type of the --merge-base option
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1717%2Fdscho%2Fmerge-tree-document-merge-base-treeish-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1717/dscho/merge-tree-document-merge-base-treeish-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1717
>
>  builtin/merge-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 3492a575a6c..60eaf0ca9f1 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -563,7 +563,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  			   PARSE_OPT_NONEG),
>  		OPT_STRING(0, "merge-base",
>  			   &merge_base,
> -			   N_("commit"),
> +			   N_("tree-ish"),
>  			   N_("specify a merge-base for the merge")),
>  		OPT_STRVEC('X', "strategy-option", &xopts, N_("option=value"),
>  			N_("option for selected merge strategy")),
>
> base-commit: 342990c7aaef5ac645e89101cb84569caf64baf4
