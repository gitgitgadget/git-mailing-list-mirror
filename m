Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F913B2A6
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710446; cv=none; b=qffP4Rg86NKcblxt0lMKG4VGkGJd2HoPH25PDJbhAVv/qlUWjPBSoS2K2yc0cRTZ8AbvAyqnACkKI9U7vxDrGkqIOFYTBYx1l5wPoFOoMoB/vL8cHZTKKb3Z8tEib35rP6lSEaIPF9giTsmtM1OYDGT1NawSPkM+R9+xOUMVRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710446; c=relaxed/simple;
	bh=qMIVkpNjjykTMiqxAgrnTZR4APffBjiqs9L/GORE7No=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q8cJQFsacrehXYO9qKrkzoxP6v/+NrZiHnfOVge7tKQtRNeE+E7o8NggDwziPfVQGtR/+19mJmU8adQMBbnw7Jl+EJahPeOAu5B6CL+nK7YNNaDZB1W014qcIRGHl2zGsCPWcohFM6ux7vZZRCFIXd5I+aVRJfzonbj/1v4hqYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WhPE4C7p; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WhPE4C7p"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E9C8B1DFF0D;
	Fri, 23 Feb 2024 12:47:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qMIVkpNjjykTMiqxAgrnTZR4APffBjiqs9L/GO
	RE7No=; b=WhPE4C7pRncAtey5lh2TI6RYRTPS89vuLrEe5QCoipWkUPubUUFdB4
	taT91J0vEDx5vqHUn3xJ1kom9Rtik4rmuKkAMsvGaMONvs5cLwOF8JGLMEHvVnuM
	rETIv8OuZRMUpxWAS1/if98WPwjI4M7nwtsKkJQS6N7axnFxIVO0M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0A5E1DFF0C;
	Fri, 23 Feb 2024 12:47:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51D891DFF0B;
	Fri, 23 Feb 2024 12:47:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <git@jeffhostetler.com>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 11/16] fsmonitor: remove custom loop from
 non-directory path handler
In-Reply-To: <1853f77d3331f7736139f686ac2efee6d68f9207.1708658300.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Fri, 23 Feb 2024
	03:18:15 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<1853f77d3331f7736139f686ac2efee6d68f9207.1708658300.git.gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 09:47:21 -0800
Message-ID: <xmqqfrxjul7a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 98E8F944-D273-11EE-B0BE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  static void handle_path_without_trailing_slash(
>  	struct index_state *istate, const char *name, int pos)
>  {
> -	int i;
> -
>  	/*
>  	 * Mark the untracked cache dirty for this path (regardless of
>  	 * whether or not we find an exact match for it in the index).
> @@ -200,33 +212,28 @@ static void handle_path_without_trailing_slash(
>  
>  	if (pos >= 0) {
>  		/*
> -		 * We have an exact match for this path and can just
> -		 * invalidate it.
> +		 * An exact match on a tracked file. We assume that we
> +		 * do not need to scan forward for a sparse-directory
> +		 * cache-entry with the same pathname, nor for a cone
> +		 * at that directory. (That is, assume no D/F conflicts.)
>  		 */
>  		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
>  	} else {
> +		struct strbuf work_path = STRBUF_INIT;
> +
>  		/*
> +		strbuf_add(&work_path, name, strlen(name));
> +		strbuf_addch(&work_path, '/');
> +		pos = index_name_pos(istate, work_path.buf, work_path.len);
> +		handle_path_with_trailing_slash(istate, work_path.buf, pos);
> +		strbuf_release(&work_path);
>  	}
>  }

The "with trailing slash" variant is returning a useful value to
this caller that ignores it, but we do not yet return a value from
this function, so that is OK.  The name being a name that may be in
different case from what we know in the index is not yet handled in
this step (we have "Assume it is case-correct" in the comment) and
that applies for both the main array of cache entries as well as the
untracked cache.

It will be exciting to see how these are lifted.  The main array has
some helper functions that uses name-hash features to help icase
matches, but I do not offhand recall what we have for the untracked
cache side.
