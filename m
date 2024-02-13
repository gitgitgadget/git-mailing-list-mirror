Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C862170
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862033; cv=none; b=Q2ySf3+MGpkwOIKgvKje/ORs85tAEvBnNDopHJcIaw4FSiAB/nQsPB96BxREt+vRSCUEA7q5HMUX+WHjiQY5IO7U23j5iu7a1bfV/NcFk949uPUkQ4QMh38Lkofj2deF7pOmqCcI6Sd7RsvkoTsId9pOsmw++TLL9g3nZY27c38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862033; c=relaxed/simple;
	bh=v7bgkY0BLWaLwjrOtkhGTNB3MYUU1xXsvFmsZ2HxRWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XylcA9p2IVYw3GGeGaG3D2jqHkLwftrKFY8VS/1MxNT2nPFPT2PCqn7wBVZDblSXi5NsC8+zjvhg8zlpJlz9Iy+KBQCEP1p89qVr37s3dOpM0t51GOexnzIzPcq+rrZq/bLmPxOE52eXZX0H4KcFYz3ZwmYNbuqYueEiU+AyGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k3Rldw+j; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k3Rldw+j"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F305B1C9D95;
	Tue, 13 Feb 2024 17:07:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=v7bgkY0BLWaLwjrOtkhGTNB3MYUU1xXsvFmsZ2
	HxRWQ=; b=k3Rldw+jXEdmeyrtleAMfyaKClPoIPpc01Pr3zUo3Yekia2lVfTUTb
	F5ZFhbQlTGliV4xdTqX1bcGu8g6MfErzHqIWJkg54q9M4HRVZ4WZWFipHJvGNDGO
	wvHI0mpUIViUXbn1GQppUIqMgc/WlC5VziGk9P1ctV+bz1QpxZplE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EAE381C9D94;
	Tue, 13 Feb 2024 17:07:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B7DC1C9D93;
	Tue, 13 Feb 2024 17:07:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 01/12] sparse-index: pass string length to
 index_file_exists()
In-Reply-To: <6f81e2e30609c70d4dcdbe9d4f11c4f6b5173c77.1707857541.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Tue, 13 Feb 2024
	20:52:10 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<6f81e2e30609c70d4dcdbe9d4f11c4f6b5173c77.1707857541.git.gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 14:07:07 -0800
Message-ID: <xmqqzfw410j8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3B51347C-CABC-11EE-A11A-25B3960A682E-77302942!pb-smtp2.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> The call to index_file_exists() in the loop in expand_to_path() passes
> the wrong string length.  Let's fix that.
>
> The loop in expand_to_path() searches the name-hash for each
> sub-directory prefix in the provided pathname. That is, by searching
> for "dir1/" then "dir1/dir2/" then "dir1/dir2/dir3/" and so on until
> it finds a cache-entry representing a sparse directory.
>
> The code creates "strbuf path_mutable" to contain the working pathname
> and modifies the buffer in-place by temporarily replacing the character
> following each successive "/" with NUL for the duration of the call to
> index_file_exists().
>
> It does not update the strbuf.len during this substitution.
>
> Pass the patched length of the prefix path instead.
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---

This looked familiar, and it turns out that

https://lore.kernel.org/git/pull.1649.git.1706897095273.gitgitgadget@gmail.com/

has already been merged to 'master'.


>  sparse-index.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index 3578feb2837..e48e40cae71 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -579,8 +579,9 @@ void expand_to_path(struct index_state *istate,
>  		replace++;
>  		temp = *replace;
>  		*replace = '\0';
> +		substr_len = replace - path_mutable.buf;
>  		if (index_file_exists(istate, path_mutable.buf,
> -				      path_mutable.len, icase)) {
> +				      substr_len, icase)) {
>  			/*
>  			 * We found a parent directory in the name-hash
>  			 * hashtable, because only sparse directory entries
> @@ -593,7 +594,6 @@ void expand_to_path(struct index_state *istate,
>  		}
>  
>  		*replace = temp;
> -		substr_len = replace - path_mutable.buf;
>  	}
>  
>  cleanup:
