Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E44119CC20
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133657; cv=none; b=QN8z1zDcOQTQUGjnv0eBrl+SoFZ872aDGiAyUTEX61Oem/DuD+zqhLgt5mdpMoyeGgFYNpzUxT8RLPcJPEXzi7u6WwVIr1qI0DWBKTjaAydZgK63dMLTQNDRYzDU/l0QfUFlBPerdWP9gYRCggqX2LfiWWfxRUmeceHvDfWJN64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133657; c=relaxed/simple;
	bh=KXIG4QzlwJsT4uCQmDSzgyRnhXo9fafNcisVJ1j/DHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCoo/6qgDsuOy3R69uphVAu9zLkeGeuCcCl3fnmZjwClebziFE9mc3zMcU8QVjCQDa/aDdjBPzIdjwPxMD0haKt8wzc+RgW+QJPfXxfHQB6fRQZTmJoZD0TRvetn8W+zQBBovTpzDJ5hXlQa6Fkvfh2r3S9+5jxz0MA9d9iDfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=IHD+imaf; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="IHD+imaf"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id AB782428135
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 11:17:51 +0100 (CET)
Received: from [192.168.3.191] (unknown [141.255.129.53])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id DB5CA780375;
	Fri, 21 Feb 2025 11:17:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1740133064;
	bh=KXIG4QzlwJsT4uCQmDSzgyRnhXo9fafNcisVJ1j/DHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IHD+imaf/o1Bs3/qp5v65WlvmBWQ2NvXBMYGQRbx8P8CeG9SrWx7x3zkKbvmGLZZe
	 wbArcKw9LKL+c368mtJH3s0eGD9L/tyn6gGThVGz1/T0s4TSjJ1ifR5GgsTlM0eAq6
	 5X8A2GiMT2HkWmy9U8ChpC/D0JEKIrcwLzgTdFxh4Y/ox0BIGXqnML/d3T1gavtlRP
	 hlreGIO8V4+qZ2h7XF1wOA/v9sPiVlPNQXTXn5hruVkHlER00PeSp2UFAAl1eZ/nUB
	 CRA6/31liPq4GF0y8Qo9ghK0FqTsZHEcd4kjbk9mL/Zfw3eWq1OweJfsB19ADzcFdm
	 b3GSzNnYqXDVQ==
Message-ID: <70b76a89-00a4-4ba6-92f2-4fb46981317d@free.fr>
Date: Fri, 21 Feb 2025 11:17:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][PATCH v2] merge-strategies.adoc: detail submodule merge
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <20250220151207.3248-1-lucasseikioshiro@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <20250220151207.3248-1-lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 20/02/2025 à 16:12, Lucas Seiki Oshiro a écrit :
> Submodule merges are, in general, similar to other merges based on oid
> three-way-merge. When a conflict happens, however, Git has two special
> cases (introduced in 68d03e4a6e44) on handling the conflict before
> yielding it to the user. From the merge-ort and merge-recursive sources:
> 
> - "Case #1: a is contained in b or vice versa": both strategies try to
> perform a fast-forward in the submodules if the commit referred by the
> conflicted submodule is descendant of another;
> 
> - "Case #2: There are one or more merges that contain a and b in the
> submodule.  If there is only one, then present it as a suggestion to the
> user, but leave it marked unmerged so the user needs to confirm the
> resolution."
> 
> Add a small paragraph on merge-strategies.adoc describing this behavior.
> 
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> 
> This v2 changes the documentation text to a clearer explanation (as
> suggested in the v1 review), and changes its location to
> merge-strategies.adoc instead of git-merge.adoc.
> 
> This content is duplicated as this works for both `ort` and `recursive`
> strategies.
> 
>  Documentation/merge-strategies.adoc | 15 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/merge-strategies.adoc b/Documentation/merge-strategies.adoc
> index 5fc54ec060..a7fca249e2 100644
> --- a/Documentation/merge-strategies.adoc
> +++ b/Documentation/merge-strategies.adoc
> @@ -21,6 +21,13 @@ ort::
>  	("Ostensibly Recursive's Twin") and came from the fact that it
>  	was written as a replacement for the previous default
>  	algorithm, `recursive`.
> +
> +        In the case where the path is a submodule, if the submodule commit
> +        used on one side of the merge is a descendant of the submodule
> +        commit used on the other side of the merge, Git attempts to
> +        fast-forward to the descendant. Otherwise, Git will treat this case
> +        as a conflict, suggesting as a resolution a submodule commit that
> +        is descendant of the conflicting ones, if one exists.
>  +
>  The 'ort' strategy can take the following options:
>  
> @@ -95,6 +102,13 @@ recursive::
>  	renames.  It does not make use of detected copies.  This was
>  	the default strategy for resolving two heads from Git v0.99.9k
>  	until v2.33.0.
> +
> +        In the case where the path is a submodule, if the submodule commit
> +        used on one side of the merge is a descendant of the submodule
> +        commit used on the other side of the merge, Git attempts to
> +        fast-forward to the descendant. Otherwise, Git will treat this case
> +        as a conflict, suggesting as a resolution a submodule commit that
> +        is descendant of the conflicting ones, if one exists.
>  +
>  The 'recursive' strategy takes the same options as 'ort'.  However,
>  there are three additional options that 'ort' ignores (not documented


If both chunks are meant to be kept identical, I would recommend to
define an attribute (see
https://docs.asciidoctor.org/asciidoc/latest/attributes/custom-attributes/)
and use it at both sites.

Thanks.

