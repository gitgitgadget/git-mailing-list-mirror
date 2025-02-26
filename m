Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6999121D3FC
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583362; cv=none; b=UXidTG1Vi1Lig6v67Qo/owXp59rsC4di3rCkqruwJDZaghQbcPj+KG3GkAudBLllaHIGsFI42FIfEBhiBVYXHkzjJu0sVgEPX9nnI3LFsxzHIyCKG11BQbJhVSarg/fZStvwl05N6e8D/qaBNLeAzR9d6S7GqgHahflkzOx6pU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583362; c=relaxed/simple;
	bh=05LbtfSgWMdj7c+3kKoyBloepcA2gaD7FxYTivWrdNQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bz2HOwr9YtGlBxaB2u5IFuOLznpjaWI/nqAPpfxiI2plnc+I7UNiz9zkf8OWzWqb/94wj6QqxNeydW+1isAC4blfTFppHxP48uSm8gUXZPHtkwWu936j4/1nzlGxiYPCK5B6kE4rZQBVkz4Uoh7Wn7tct1ci5ailSp/DuBgc1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=o/MFvY76; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="o/MFvY76"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1740583357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G0+fgWyUUn8alGeT8R44fiYTFTm7I7+RpGzO/s6gabE=;
	b=o/MFvY76e03+Wecm68BDl4Bmfc5VTNFWPLzhPU/lZJlInSjlFwxSfhRBXP9TTOTmA+E6h2
	l5sE8+cKa+H8fsKQCRXUIhAnHqR6jSqeFHA3EMY7p82KjrRA7Bg74m1UKBkJqu4jQhcPTp
	EmF10x5u530RdPuyOzUPQrHCUdvHCm0=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 3/9] builtin/cat-file: support "blob:none" objects filter
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-3-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-3-0852530888e2@pks.im>
Date: Wed, 26 Feb 2025 16:22:25 +0100
Message-ID: <8734g0rary.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Implement support for the "blob:none" filter in git-cat-file(1), which
> causes us to omit all blobs.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-cat-file.adoc |  2 ++
>  builtin/cat-file.c              | 11 ++++++++++-
>  t/t1006-cat-file.sh             | 33 +++++++++++++++++++++++++++++++--
>  3 files changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
> index 7c1c888079a..c11952d9eca 100644
> --- a/Documentation/git-cat-file.adoc
> +++ b/Documentation/git-cat-file.adoc
> @@ -86,6 +86,8 @@ OPTIONS
>  	Omit objects from the list of printed objects. This can only be used in
>  	combination with one of the batched modes. The '<filter-spec>' may be
>  	one of the following:
> ++
> +The form '--filter=blob:none' omits all blobs.

If we chose to use `--object-filter`, we need to use it here as well.
And same for the following commits.


-- 
Toon
