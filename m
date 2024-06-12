Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF2282F7
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158722; cv=none; b=nGJeXk7X7zZcNfCzf+5S0yVtapdoXSG9VyoBTwwbSHRJF/KfC1pysSG4tD7mpeOwoZaOVohXNL8/Mna/7esQLyhXC6KGOGw2KFkPwYKp8OkIrEHTAwWCqxtueiCUb5gsrfrJOQfTUrQfdSe2w/kfGShPOabwLbCIykG/H55StJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158722; c=relaxed/simple;
	bh=LG39I5C6gqOjcYaUjVEV1SzWK6XfAUnQU9+Sb1VaiqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E1IKx2aIPhu+3E98rYR4ZAWd80yYn0Znw2M363+Enp4abOlgcR3IbHqoDTvrs1L0NXehjhnRksKU29suEScqCD0jPLWnnm8acILl6Sl1o5EWdlE3do2ci77S/rYPgObIchzcmnWTSmGwjk81TWrL0pgpywiEC3IPocSUfhXK3n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u190WBEB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u190WBEB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C8F32C5ED;
	Tue, 11 Jun 2024 22:18:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LG39I5C6gqOjcYaUjVEV1SzWK6XfAUnQU9+Sb1
	VaiqY=; b=u190WBEBhYoi9OqlFhSkr7cBoau5S1oOGpmKnBzvjNEikK4ezoRGj7
	ybSBY66s2fLhdmy2MXdLFaboCbDYd8UFnyLt2mimqHIHjd5hLQM4fi5APiGSY9hY
	Mw5DH4S3sdPnsL5+5CRTitaEwRnSmlTk5mg4fQ4s56TPJ1jTgy/MI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 454582C5EC;
	Tue, 11 Jun 2024 22:18:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1B5F2C5EB;
	Tue, 11 Jun 2024 22:18:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 08/16] mktree: add a --literally option
In-Reply-To: <b497dc90687a7c77a4d21c3a12fe5fa3bfdabc16.1718130288.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Tue, 11 Jun 2024 18:24:40
	+0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<b497dc90687a7c77a4d21c3a12fe5fa3bfdabc16.1718130288.git.gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 19:18:37 -0700
Message-ID: <xmqqh6dyrjia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1473C3DE-2862-11EF-A8E3-965B910A682E-77302942!pb-smtp2.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Add the '--literally' option to 'git mktree' to allow constructing a tree
> with invalid contents. For now, the only change this represents compared to
> the normal 'git mktree' behavior is no longer sorting the inputs; in later
> commits, deduplicaton and path validation will be added to the command and
> '--literally' will skip those as well.

Hmph, the end state of the the series as a whole may be good, but
the above makes me wonder if we broke bisectability with the
previous step 07/16 where we introduced type checks without touching
any existing tests?

> Certain tests use 'git mktree' to intentionally generate corrupt trees.
> Update these tests to use '--literally' so that they continue functioning
> properly when additional input cleanup & validation is added to the base
> command. Note that, because 'mktree --literally' does not sort entries, some
> of the tests are updated to provide their inputs in tree order; otherwise,
> the test would fail with an "incorrect order" error instead of the error the
> test expects.

Makes sense.

> diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
> index 507682ed23e..fb07e40cef0 100644
> --- a/Documentation/git-mktree.txt
> +++ b/Documentation/git-mktree.txt
> @@ -9,7 +9,7 @@ git-mktree - Build a tree-object from formatted tree entries
>  SYNOPSIS
>  --------
>  [verse]
> -'git mktree' [-z] [--missing] [--batch]
> +'git mktree' [-z] [--missing] [--literally] [--batch]
>  
>  DESCRIPTION
>  -----------
> @@ -27,6 +27,13 @@ OPTIONS
>  	object.  This option has no effect on the treatment of gitlink entries
>  	(aka "submodules") which are always allowed to be missing.
>  
> +--literally::
> +	Create the tree from the tree entries provided to stdin in the order
> +	they are provided without performing additional sorting, deduplication,
> +	or path validation on them. This option is primarily useful for creating
> +	invalid tree objects to use in tests of how Git deals with various forms
> +	of tree corruption.
> +

OK.

> diff --git a/builtin/mktree.c b/builtin/mktree.c
> index 5530257252d..48019448c1f 100644
> --- a/builtin/mktree.c
> +++ b/builtin/mktree.c
> @@ -45,11 +45,11 @@ static void release_tree_entry_array(struct tree_entry_array *arr)
>  }
>  
>  static void append_to_tree(unsigned mode, struct object_id *oid, const char *path,
> -			   struct tree_entry_array *arr)
> +			   struct tree_entry_array *arr, int literally)
>  {
>  	struct tree_entry *ent;
>  	size_t len = strlen(path);
> -	if (strchr(path, '/'))
> +	if (!literally && strchr(path, '/'))
>  		die("path %s contains slash", path);

;-).

A tree_entry with a slash in it.  Our fsck should be catching them
already, but this will allow constructing a test case more easily.

