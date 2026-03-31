Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2D3A962E
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774999043; cv=none; b=OQKiL7h4YgDQA7OG2LSvWnJxny5eVN7Lisct+Y6AvUBgh8bNZPNckod0MXG4qYtS00rBHs1EK3f+clP+yPrEidAjxVnnrhEASpQpZ00K5kCserH91Zw+nKyqF3fj9g85mWPd5ZJa/lT9SOQ3liiKmaJ9UsOugtVahOyaDtzJiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774999043; c=relaxed/simple;
	bh=hBtB0og2klAZR1Xlql/ldluPMqi4agZJMZBy565Zr/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFxpbPZO/LrsxR6m1qd6U7o62+FDvnmEBcPTwFr/QJeyiem99sqTAhjRWtvReDduZ3IfG1LupgKkiXeUKgzw0RHHN2w4FbHZEMB57ndGwU8XA7eQRhbzBYsWx0Zq1WYufr+84g8nabw2g+WS81xC3nIwpU08iIOedHiqMdcHt2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=P1s5NWk9; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="P1s5NWk9"
Received: (qmail 206488 invoked by uid 106); 31 Mar 2026 23:17:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hBtB0og2klAZR1Xlql/ldluPMqi4agZJMZBy565Zr/4=; b=P1s5NWk9sZBcMO3eQhvljDS04Gf5cCSFNuzOvBbxz7XMMjgp0NFJ/+MA4m0rxkvR2G+QYRgLQa6bN7BWvZv/J6YH63rljclVnUvFNyIzBjvC6GQ41YTO84qqQPdQeMRNqqXlp5sqmmLdK8wH7gAMnpjFnuV+RSRQqVTDrPFkQooop1z/JHIsfrvI4Nd5qBN9JDr9LtM12wJ5EQKJ9Wk45YUo9PZM8WsH+PKGZhID6oDnznRlBOXAO/jY1T+kN3gth/bgvWqtKinkX+K22/i8Nbsf/3wMa8gDX4ErY0cTAiGXJosUuosCxJ2/8JXVoIrw+nO2qa41wCnsDmStiij6FQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:17:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326096 invoked by uid 111); 31 Mar 2026 23:17:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:17:13 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:17:13 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 04/16] midx: use `strvec` for `keep_hashes`
Message-ID: <20260331231713.GA2325145@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <5fc72d5049a602ae5ede6bb243f44546f02d995d.1774820449.git.me@ttaylorr.com>
 <20260330230130.GD41843@coredump.intra.peff.net>
 <acxJ/NfLNloCv3o+@nand.local>
 <acxPyXnV8HtxtEHl@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acxPyXnV8HtxtEHl@nand.local>

On Tue, Mar 31, 2026 at 06:50:49PM -0400, Taylor Blau wrote:

> If we move to strset, we obviously still need to ensure that
> constructing .keep doesn't leak strings. The strset API has a
> strdup_strings option (via the strmap underneath), but does not
> explicitly free keys on clear.
> 
> As far as I can tell, the strset API is not designed to take ownership
> of the strings themselves, so to avoid leaks we would have to do
> something like:

It's based on strmap, which handles ownership. If you use STRMAP_INIT or
strmap_init(), then strdup_strings is set to 1.

Or do you mean that you can't transfer ownership into the strset from an
existing string? I think that is true, and if you are generating the
strings with xstrfmt() then yeah, you have two copies in the loop and
have to free one.

That is probably actually fine for the sizes we are talking about, but
if you want to care you can either do the reusable-strbuf thing, or
we can add a strset_add_nodup().

> @@ -815,6 +817,9 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
>  	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
>  				     clear_midx_file_ext, &data);
> 
> +	hashmap_for_each_entry((struct hashmap*)&data.keep.map, &iter, e, ent) {
> +		free((void *)e->key);
> +	}
>  	strset_clear(&data.keep);
>  }
> --- >8 ---
> 
> which is... pretty gross. I think we may be better off sticking with a
> string_list for 'keep' here internally.

Yeah, this is horrible, and this kind of "we own it, but only kind of
and strdup_strings is not set" game has been the cause of many bugs on
the string-list side.

Having a "nodup" variant is less awful, but still error prone and leads
to complications. For example, if strset_add_nodup() sees a duplicate,
what does it do with the input?

So I would probably just either do:

  for (...) {
	item = xstrfmt(...);
	strset_add(&set, item);
	free(item);
  }

or if you care about the extra allocation, then:

  struct strbuf item = STRBUF_INIT;
  for (...) {
	strbuf_reset(&item);
	strbuf_addf(&item, ...);
	strset_add(&set, item.buf);
  }
  strbuf_release(&item);

-Peff
