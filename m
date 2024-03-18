Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3DB59B55
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799144; cv=none; b=UxMUhgvGzJBCcATZpb7uz4tyDNQZj//+BkkfqZaXIq+SfaQb47yOdlNCdYqQSDov/C+3CobLpMvI8mb/WXDo4S2KHbK/tALKpf7w5QN6DLcsnml3DJaAFDK9V0ZMNrSv+Vk2yFYiDN74cefFiR585EN0bdFlTDL0qCYVuGlRztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799144; c=relaxed/simple;
	bh=93phwFspBBxOMqOokuNs7NgFuwU23TZjCGBnTrkFnhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DlGCs7oP/ogeW+LDqc/vRY/QMBGbRX2Z1b6rtJ/KnrvT9XtRLtSAMZcFaovqgnTocGOZoxSggWtK3LVW6D8b8qEAr7YaaPaxK3s+Acu7naA2ucUnY5Fg6YxIn5YOGT+jymfrpqM+GAvNA4W2fmZmPP+bbE03uAvH78alfELUnOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=H6MuhPA9; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H6MuhPA9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F043623952;
	Mon, 18 Mar 2024 17:59:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=93phwFspBBxOMqOokuNs7NgFuwU23TZjCGBnTr
	kFnhg=; b=H6MuhPA9PB1o7zZv551eDoDVMYwEOcLAZo+Tlrt3Baf9eu+WnbXduA
	kLbeWNCezmidvmImmsYyfn9jwYR2KEgDPxvvDraebxa3lt4vEb+Z770/mXmNYZqm
	k4L8YqXwMxCs0Fnvzsk68Wd7O0XSNXF1PpxWj5JRDnVSt68EERszU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E84D123951;
	Mon, 18 Mar 2024 17:59:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2AC5E2394D;
	Mon, 18 Mar 2024 17:58:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Mohit Marathe <mohitmarathe@proton.me>
Subject: Re: [PATCH 2/2] test-lib: replace repeated code logic with an
 existing helper
In-Reply-To: <8a730b6ebba4111aaad4e8fc938c52f6e7e54480.1710766062.git.gitgitgadget@gmail.com>
	(Mohit Marathe via GitGitGadget's message of "Mon, 18 Mar 2024
	12:47:42 +0000")
References: <pull.1699.git.1710766062.gitgitgadget@gmail.com>
	<8a730b6ebba4111aaad4e8fc938c52f6e7e54480.1710766062.git.gitgitgadget@gmail.com>
Date: Mon, 18 Mar 2024 14:58:57 -0700
Message-ID: <xmqq7chzdwwu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B93D553E-E572-11EE-A4D4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Mohit Marathe <mohitmarathe@proton.me>
>
> This patch replaces the code, that changes the path separators,
> with the already existing function `change_path_separators()`

Aside from that the name change_path_separators() needs to be
updated, using it here means that the helper cannot become a NO-OP
on platforms where we do not have to change backslashes we read from
the system to forward slashes.  So if we really wanted to use it
here, and update the other existing callers in the main code to help
them lose the ugly "#if WINDOWS" conditional compilation, we would
need two helper functions, perhaps one that is used here that is
identical to the current convert_slashes(), and the other one used
to clean-up the callsites in [1/2] to also remove the conditional
compilation.

Even if we were to make it public, I am not sure if compat-util is
the right place, though.  It is not a kitchen sink.

In any case, perhaps we want to do something like this in a header,
...

	static inline void bs_to_forward_slash_in_place(char *path)
	{
		...
	}
	#ifdef GIT_WINDOWS_NATIVE
	#define normalize_slashes_in_place(path) bs_to_forward_slash_in_place(path)
	#else
	#define normalize_slashes_in_place(path) do { ; /* nothing */ } while (0)
	#endif

... and then use the "normalize" one to lose "#ifdef" in the callers
[1/2] touches, while "bs_to_forward_slash" one here.

I am not convinced if it is worth doing only for this single test,
though.

> @@ -88,9 +86,8 @@ static const char *make_relative(const char *location)
>  
>  	/* convert backslashes to forward slashes */
>  	strlcpy(buf, location + prefix_len, sizeof(buf));
> -	for (p = buf; *p; p++)
> -		if (*p == '\\')
> -			*p = '/';
> +	p = buf;
> +	change_path_separators(p);
>  	return buf;
>  }
