Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14EF47A53
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774330; cv=none; b=JMY0Qagg9uMU6RQvbOGjCd9uuaYY5TU3DwsDeHDIgrrqEHH5VS25/d9YTpSlzctJI/YOFZ0Q9+q/89tJs3sE/N465MSEHoQUzVEeM+z9iECTf9Xz7weMJ4lWS8C8hhJTbsDKZnlx35tR3jhXUP9ecDKAl1xZLvDl9QX4xPnX9xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774330; c=relaxed/simple;
	bh=9XcE0Q8TyOxCSwdIyycJmSDZFMgyjW5lqG5kGtJIYsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UiEPTo54esxW+/KkADMSnkkyhHQiLuM1XgO90tGfKYnvoNGsJZ4YIFskDWLMRk425UvDosKlgPCkOv++DJBm0HNKX+V37lAm/gw9+ryD2YAuRLEtz0Eo0tQ/dPm3/vrjhHaLewA7nzNQl74sQxGOJY/HK9HI0kaVO7t2zhimxn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ITIlr+M8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ITIlr+M8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 915611E06AA;
	Mon, 12 Feb 2024 16:45:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9XcE0Q8TyOxCSwdIyycJmSDZFMgyjW5lqG5kGt
	JIYsk=; b=ITIlr+M85Kpy0eHbzsSHXgVK3ArGXeULvU9GovZc7Ru/UgXnRbJUpW
	WTskFYinTpyuwoPknAZkqNpuf3HsKvnQfKCAewcH0YrG6SQQmaHmKvXqVe3LFgkq
	7nxakU79EIhpK+Bbxef4f0OOQdxCxnKbcgWpZV+FaY9y+q0hi6/S4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 885D01E06A8;
	Mon, 12 Feb 2024 16:45:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6B101E06A7;
	Mon, 12 Feb 2024 16:45:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  sunshine@sunshineco.com,  ps@pks.im
Subject: Re: [PATCH v5 1/2] add-patch: classify '@' as a synonym for 'HEAD'
In-Reply-To: <20240211202035.7196-4-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Mon, 12 Feb 2024 01:50:11 +0530")
References: <20240206225122.1095766-3-shyamthakkar001@gmail.com>
	<20240211202035.7196-4-shyamthakkar001@gmail.com>
Date: Mon, 12 Feb 2024 13:45:25 -0800
Message-ID: <xmqqwmr94aru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08A834F2-C9F0-11EE-BA9F-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

>  add-patch.c                |  8 -------
>  builtin/checkout.c         |  4 +++-
>  builtin/reset.c            |  4 +++-
>  t/t2016-checkout-patch.sh  | 46 +++++++++++++++++++++-----------------
>  t/t2020-checkout-detach.sh | 12 ++++++++++
>  t/t2071-restore-patch.sh   | 18 +++++++++------
>  t/t7105-reset-patch.sh     | 15 ++++++++-----
>  7 files changed, 64 insertions(+), 43 deletions(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 79eda168eb..68f525b35c 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1729,14 +1729,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>  	if (mode == ADD_P_STASH)
>  		s.mode = &patch_mode_stash;
>  	else if (mode == ADD_P_RESET) {
> -		/*
> -		 * NEEDSWORK: Instead of comparing to the literal "HEAD",
> -		 * compare the commit objects instead so that other ways of
> -		 * saying the same thing (such as "@") are also handled
> -		 * appropriately.
> -		 *
> -		 * This applies to the cases below too.
> -		 */
>  		if (!revision || !strcmp(revision, "HEAD"))
>  			s.mode = &patch_mode_reset_head;
>  		else
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index a6e30931b5..067c251933 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1224,7 +1224,9 @@ static void setup_new_branch_info_and_source_tree(
>  	struct tree **source_tree = &opts->source_tree;
>  	struct object_id branch_rev;
>  
> -	new_branch_info->name = xstrdup(arg);
> +	/* treat '@' as a shortcut for 'HEAD' */
> +	new_branch_info->name = !strcmp(arg, "@") ? xstrdup("HEAD") :
> +						    xstrdup(arg);
>  	setup_branch_path(new_branch_info);
>  
>  	if (!check_refname_format(new_branch_info->path, 0) &&
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 8390bfe4c4..f0bf29a478 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -281,7 +281,9 @@ static void parse_args(struct pathspec *pathspec,
>  			verify_filename(prefix, argv[0], 1);
>  		}
>  	}
> -	*rev_ret = rev;
> +
> +	/* treat '@' as a shortcut for 'HEAD' */
> +	*rev_ret = !strcmp("@", rev) ? "HEAD" : rev;
>  
>  	parse_pathspec(pathspec, 0,
>  		       PATHSPEC_PREFER_FULL |

Nice.  Things have become so much simpler, without having to touch
millions of strcmp() with "HEAD" everywhere in the code paths.

Will queue.  Thanks.
