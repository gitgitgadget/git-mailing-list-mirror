Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C76BB3C
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450160; cv=none; b=o3Q9JhHZ1P4sR754thZxs2sWG4VNNdK2WBcfiJqJDrJSBs+axO39KDNDBCS1wd/n9gpNUUVydzOSD5G6JJRuMDVM9GWgcScALPwm7etyoWgDCAb17jrbzWR/KJUyZspAD7MMChkFbsain29V6nDhqX8wBANFKXoMSqHb7pZgxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450160; c=relaxed/simple;
	bh=I4giwaWcXy6l4ZOWsaLRH7fwnCRKEh+8LQI1zpAlbm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ERuOkEovDwHMB3PMRRg5/kUGa10TTtU1JcwVqyZevM39Q5vff8LsE3eIdTSOfhggoWvs82duzKiqUHaRisFg26WOX4zmUQCCVFrqo8a+50beqFdscJeM1qBaoC0ZrS6Y1BiFWUBXn1uES2BTJnqNIkway8YImVa9086gtojOpA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gHjFBIVz; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gHjFBIVz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 001BA2CA6E;
	Tue, 20 Feb 2024 12:29:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=I4giwaWcXy6l4ZOWsaLRH7fwnCRKEh+8LQI1zp
	Albm0=; b=gHjFBIVzjl8Z3nTDcP/NpFzhxyN/5aJHnRDou8Vxu7t8eW5HW2Cw/6
	pZGMF4oFJm07l4Yjc461PdD6W0ZxnnSb4WN2r5XIWFrzxR7/l1YgAdP8DSka91bv
	WvVQu3dPj7I+9YWv8+3VgZfM71i27AA4YX35MkJDkbd6aypQdZ/gw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EC9332CA6D;
	Tue, 20 Feb 2024 12:29:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A1A42CA6C;
	Tue, 20 Feb 2024 12:29:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Harmen Stoppels via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harmen Stoppels <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
In-Reply-To: <pull.1669.git.1708442603395.gitgitgadget@gmail.com> (Harmen
	Stoppels via GitGitGadget's message of "Tue, 20 Feb 2024 15:23:21
	+0000")
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
Date: Tue, 20 Feb 2024 09:29:13 -0800
Message-ID: <xmqqv86jqc2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 91586B34-D015-11EE-9426-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Harmen Stoppels via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harmen Stoppels <me@harmenstoppels.nl>
>
> When you run `git rebase --continue` when no rebase is in progress, git
> outputs `fatal: no rebase in progress?` which is not a question but a
> statement. This commit makes it appear as a statement.

"This commit makes it appear" -> "Make it appear" (see
SubmittingPatches).

>  builtin/rebase.c | 2 +-

This change is very good, but a commit that touches code should not
touch po/ localizations in this project.  They are updated to match
the code change by respective language teams.

>  po/bg.po         | 2 +-
>  po/ca.po         | 2 +-
>  po/de.po         | 2 +-
>  po/el.po         | 2 +-
>  po/es.po         | 2 +-
>  po/fr.po         | 2 +-
>  po/id.po         | 2 +-
>  po/it.po         | 2 +-
>  po/ko.po         | 2 +-
>  po/pl.po         | 2 +-
>  po/pt_PT.po      | 2 +-
>  po/ru.po         | 2 +-
>  po/sv.po         | 2 +-
>  po/tr.po         | 2 +-
>  po/uk.po         | 2 +-
>  po/vi.po         | 2 +-
>  po/zh_CN.po      | 2 +-
>  po/zh_TW.po      | 2 +-
>  19 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 5b086f651a6..415783c4a21 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1254,7 +1254,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		die(_("options '%s' and '%s' cannot be used together"), "--root", "--fork-point");
>  
>  	if (options.action != ACTION_NONE && !in_progress)
> -		die(_("No rebase in progress?"));
> +		die(_("No rebase in progress"));
>  
>  	if (options.action == ACTION_EDIT_TODO && !is_merge(&options))
>  		die(_("The --edit-todo action can only be used during "

Interestingly this change does not break any test in t/ directory,
which means we have a gap in test coverage.  It should not be any
part of this patch, but we may want to add a test to exercise this
codepath (#leftoverbits).

Thanks.
