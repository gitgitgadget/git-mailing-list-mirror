Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65C26295
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710667; cv=none; b=WI4pga9WGU2MokzfJQOe8hTWj5Y3sKHdSst2DuGZLUZypNTu3j2694QOslEhaoLnTThBMAvqqt+vPuXRjbOsl+yWI5v32eB0guK5ILhpDf3dbAtqxzmCMZxMPbFROO4U3cJ3cc4VjAAyOqHYTUKGp1W7UozMjnNYCNTfgoQjl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710667; c=relaxed/simple;
	bh=FnN/TIcAnOnEZFopJh1nmDZmi2D2gyczSdTLqFn5qLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DzVTDlvGmWMotq96QGHZAmCiWBD67bxb5EmBXAKgScNqYZG6GNipypVGKlRVTlN4/R6j4ym34PNJwlodfxYCDTEG5BZWJvD9HUcti5ocdYd3aXU8LNJbv4J1rVxyYpBu2JDGhdJNJ+S8ZWWH1V0aGdW5IHm8kYP/T39IERcMblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pgktAB1B; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pgktAB1B"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B71BF1DFF8F;
	Fri, 23 Feb 2024 12:51:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FnN/TIcAnOnEZFopJh1nmDZmi2D2gyczSdTLqF
	n5qLc=; b=pgktAB1BrtGBM4fv9A/XV70bNXB5TGPCr7rSV7LaV50OsmHLldo5l9
	RURxHTvhmVaHaO9EJxaAp+8XHuFSAlBRRY+zHGln573u58XPGiJPfyYujVwhfPNk
	JGqDWFyLMi0yxeSfV2iPTAtwFEkFKbHe9KtfAP2MYi2DOvmhStZiE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A771A1DFF8E;
	Fri, 23 Feb 2024 12:51:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E66041DFF8D;
	Fri, 23 Feb 2024 12:51:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <git@jeffhostetler.com>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 12/16] fsmonitor: return invalided cache-entry count
 on non-directory event
In-Reply-To: <f77d68c78ada02bfb4b96759f6ad82ebff00b35b.1708658300.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Fri, 23 Feb 2024
	03:18:16 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<f77d68c78ada02bfb4b96759f6ad82ebff00b35b.1708658300.git.gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 09:51:02 -0800
Message-ID: <xmqqbk87ul15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1CFFEEAE-D274-11EE-B702-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Teah the refresh callback helper function for unqualified FSEvents

Teach?

> (pathnames without a trailing slash) to return the number of
> cache-entries that were invalided in response to the event.
>
> This will be used in a later commit to help determine if the observed
> pathname was (possibly) case-incorrect when (on a case-insensitive
> file system).
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

I do not see anything unexpected in the change to the code below.
Looking good.

Thanks.

> diff --git a/fsmonitor.c b/fsmonitor.c
> index a51c17cda70..c16ed5d8758 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -196,8 +196,10 @@ static size_t handle_path_with_trailing_slash(
>   * do not know it is case-correct or -incorrect.
>   *
>   * Assume it is case-correct and try an exact match.
> + *
> + * Return the number of cache-entries that we invalidated.
>   */
> -static void handle_path_without_trailing_slash(
> +static size_t handle_path_without_trailing_slash(
>  	struct index_state *istate, const char *name, int pos)
>  {
>  	/*
> @@ -218,7 +220,9 @@ static void handle_path_without_trailing_slash(
>  		 * at that directory. (That is, assume no D/F conflicts.)
>  		 */
>  		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
> +		return 1;
>  	} else {
> +		size_t nr_in_cone;
>  		struct strbuf work_path = STRBUF_INIT;
>  
>  		/*
> @@ -232,8 +236,10 @@ static void handle_path_without_trailing_slash(
>  		strbuf_add(&work_path, name, strlen(name));
>  		strbuf_addch(&work_path, '/');
>  		pos = index_name_pos(istate, work_path.buf, work_path.len);
> -		handle_path_with_trailing_slash(istate, work_path.buf, pos);
> +		nr_in_cone = handle_path_with_trailing_slash(
> +			istate, work_path.buf, pos);
>  		strbuf_release(&work_path);
> +		return nr_in_cone;
>  	}
>  }
