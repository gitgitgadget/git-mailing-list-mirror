Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4061C84A0
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775372165; cv=none; b=SI/WsQKaQdYpKIadtqxHFCKCmCy0ulLzY1Zgz8sERFO6N7YFB+ye3wjpYYKSsg25Aplimht4ULXRFHWZfO55u68KMCYjeRCdtdjt12DWo5I7sAJI2MWlEGaImuUehZ1013S4xCcJNo+JRrFZBheEzrPcErj5QNuAdaHkYedgSA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775372165; c=relaxed/simple;
	bh=fsWgr/6z3izCYb2UseZ5/QrcYXRM+FaUfbR8I/fLoOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukQrcFazm6Py2iwlGytU9bdPNLrXcqL8efFUr4WbCO9YK9yD9KMFE5+5QKh9OA5g5yHnKD+G8Z0mVcoIjCwJpbofQFl29hENayZI+OZn7U78fqTAj0PezPnIPjFOmpyLGtrAypFFrBeTGV8Vro7pU7PzrSy3rTRaiSMDdTokSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hBP1YAsB; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hBP1YAsB"
Received: (qmail 251450 invoked by uid 106); 5 Apr 2026 06:56:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fsWgr/6z3izCYb2UseZ5/QrcYXRM+FaUfbR8I/fLoOQ=; b=hBP1YAsBfRoTgRN6v8DIRklmH3GerV12tH8bEsPLI9E3ipd3NIrnjqLOsPOXIXKH4bf9tWkNPe5upFac6NlIjilmpYjAwyYsbNsHQf/0zaa4PFQNfPSsHCiEB8sXqz+7UZDmta9C6lw+Jvu3jmFoiJjjMJHyv0FV/c05LXe758pvIZJbYIfXQYAoW/ARVHoBtPHI/5tY8mstE9jdX8va5bsX4oP3BE/SergP3bo+E6o65bLbAdJd5QCB23kS6+zoF9IVqYkPOYIA7+NxXgzf89LqiiN8NNYmPkCt1ZxFO7T2n4kOxVu6LWjlB6bFtSGzKEroX/dit/APvayGhmY0zg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 05 Apr 2026 06:56:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 403269 invoked by uid 111); 5 Apr 2026 06:56:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Apr 2026 02:56:03 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 5 Apr 2026 02:56:02 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 01/16] object-file: fix -Wsign-compare warnings
Message-ID: <20260405065602.GA1481314@coredump.intra.peff.net>
References: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
 <20250717-pks-object-file-wo-the-repository-v2-1-36d2cd6c700e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717-pks-object-file-wo-the-repository-v2-1-36d2cd6c700e@pks.im>

On Thu, Jul 17, 2025 at 06:56:27AM +0200, Patrick Steinhardt wrote:

> @@ -1268,7 +1265,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
>  		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
>  	else if (!S_ISREG(st->st_mode))
>  		ret = index_pipe(istate, oid, fd, type, path, flags);
> -	else if (st->st_size <= repo_settings_get_big_file_threshold(the_repository) ||
> +	else if ((st->st_size >= 0 && (size_t) st->st_size <= repo_settings_get_big_file_threshold(the_repository)) ||
>  		 type != OBJ_BLOB ||
>  		 (path && would_convert_to_git(istate, path)))
>  		ret = index_core(istate, oid, fd, xsize_t(st->st_size),

This is an old thread, but I happened across this code while looking at
the function for something more recent. This cast seems quite
suspicious. What happens when st->st_size is larger than a size_t (e.g.,
a 4.1GB file on a 32-bit system)? We'll truncate and get a wrong answer.

I think this ought to be comparing in the off_t space instead. Which I
_think_ was happening before the cast due to C's integer promotion rules
(even though off_t is signed, because it's larger than size_t on a
32-bit system and can hold all of size_t's values, then size_t is
promoted).

It's sort of academic, since both sides of the conditional end up
calling xsize_t(), which will then bail. But it _could_ handle off_t
correctly in the "else" clause here, which tries to stream the content.

More interesting to me (and why I responded to this old patch series) is
that inserting a cast to silence -Wsign-compare actually broke the
comparison in this case.

-Peff
