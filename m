Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30231F9BE
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854868; cv=none; b=V8+CT3M5+2AHLPKlIm00iY2mCoFOX7ofqIMT8NQyXHJ6AJfPn/DgSVrVQjdF1X3kLdjpt9sSi7DH3Hsl7ZSvXfLw5sSFrakAW160N5Gn5IAnZJvRXJ4j69CC7asi3SfMEQDhHnq24lwH90rOOFhol4eobPnbCayZK4tT+a7hTmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854868; c=relaxed/simple;
	bh=LBlWEL8lxao47tkZ1a8gd1PymcTZe+ZD9jJy6iT3Auc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I9aV2xwfLtoyIxNuEYOvkEY29h/KVLcqPgWtjLiM6aZqJ3YaR3k7Z1GeRGqI6UfFlCneqio1S7E3lJQMBhzySLVcl8mwi3EOrAMph5JOeg36da4p5wnKZDBY+Bkt5+wNXUF1WYWr5trJTIdT/LJ8g+YMPrXEIPTO4ke5s0mhBjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=fhOf53d7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fhOf53d7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781854864; x=1782459664;
	i=johannes.schindelin@gmx.de;
	bh=dAblYR3VqZ7DOM7fQ4E2F8C/VFzgR+0/zxZ4AN9ylTw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fhOf53d7I0ix4ncsNghdBhk0O6jjbco2vvfIj6NdPEX1MjfxmeW/2vN+a2lyiE3c
	 FSuhacsSRzN4QdEQl5YDH7qEnoSV/z5agwcJm6BMVK+Z99E7N8GK0yfY5tiA+SJkT
	 vzahuyPG31Fs9xRZ+mqkWsrmLsNG3dz6HNzZb3AkKSXqXCzoMoSw9iV6w0IxrVmmW
	 RsOmqoxDHUWDy1bXUBYXeHIqPgXU2Dcue+Lo0oZyqWqrmPdmctnXUiROfvBwO10dG
	 YLditnXY5ukWgysM3+NHw0/fr9RNGLOKV1qtmigGZzegMIXz+Brob1Polrr6AGQA0
	 TlDptIbuTpmUDdIZ6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1wUgAN0oI7-00AfOJ; Fri, 19
 Jun 2026 09:41:04 +0200
Date: Fri, 19 Jun 2026 09:41:03 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] zlib: properly clamp to uLong
In-Reply-To: <xmqqzf0rrdbp.fsf@gitster.g>
Message-ID: <ef345cb3-e54b-65ce-9a41-bde56ea7108f@gmx.de>
References: <pull.2153.git.1781790619424.gitgitgadget@gmail.com> <xmqqzf0rrdbp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:PWKFRv8PtfcLx/v+pFnxTP49Vt7YlQOxd/Xv32LP8+PDUwuPOl1
 VKi44aVycYK5xGBYwM/TYBpDuXzrwY3syd2pIVMxVPdga3E6Kb5hYt68hpiMdGGwkdoisT9
 2ogI+JdHer9iiGMi3JTCIkr8hjtkimL8H4fPmfVbwNUrL6MKwMjqRROPMMWs6VUktDXJii4
 vM3EAdBChtavXHqLZZ74Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HVaAQGIUP3M=;p0wxDL89c1+oC7nXcPtfJt/bgCA
 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
 RgAvQiI6o1ZHVPq9WlNhbBgyokk=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 18 Jun 2026, Junio C Hamano wrote:

> [...]
>
> > @@ -60,7 +65,7 @@ static void zlib_post_call(git_zstream *s, int statu=
s)
> >  	 * We track our own totals and verify only the low bits match.
> >  	 */
> >  	if ((s->z.total_out & ULONG_MAX_VALUE) !=3D
> > -	    ((s->total_out + bytes_produced) & ULONG_MAX_VALUE))
> > +	    ((zlib_uLong_cap(s->total_out) + bytes_produced) & ULONG_MAX_VAL=
UE))
> >  		BUG("total_out mismatch");
>=20
> Because we now clamp (not "taking lower bits of") s->total_out to a
> value between 0..4GB and store it in s->z.total_out in pre-call, let
> zlib do its thing that increments s->z.total_out modulo 4GB, and we
> clamp the s->total_out (before incrementing) the same way in post_call
> here, both sides of "!=3D" above even out.

Technically, the range is 0..(4GB-1), but yes, that's exactly the idea.

If we clamped bit-wise, i.e. to the lower bits as is currently done, we
would _also_ stay within that range, but we'd restrict the total size
unnecessarily in most cases (i.e. in all cases where `total_out` isn't one
less than an exact multiple of 4GB). In the worst case, we'd restrict to 0
bytes, in which case we would run into an infinite loop because zlib has
no space to work with and we'd try again and again to whittle away a chunk
of that large input.

> But the comment before this comparison that claims that "we ... verify
> only the low bits match" is a bit off the reality, I suspect.

I am afraid that the comment is still true. The thing is, we're trying to
compare the _real_ `total_out + bytes_produced` to zlib's necessarily
restricted `total_out` (we cannot change the data type of that attribute
of `struct z_stream_s`, it's not ours to change, it'll remain `uLong`
because zlib made the same mistake as Git to choose that imprecise data
type for memory size calculations). The sum `total_out + bytes_produced`
is of type `size_t`, the attribute `s->z.total_out` is of type `uLong`.

Therefore, we still need to clamp bit-wise, as the _real_ `total_out +
bytes_produced` may very well exceed the maximal value of
`s->z.total_out`, and the zlib operation will _still_ have produced the
expected number of bytes, i.e. that sanity check should _pass_.

If anything, we _could_ consider dropping that masking of `s->z.total_out`
to the maximal `unsigned long` value, seeing as `s->z.total_out` _is_ of
that data type and therefore cannot reasonably exceed that. But then,
there might emerge a zlib variant in the future that recapitulates Git's
effort to use `size_t` where `size_t` is due, and compiling/linking
against _that_ zlib variant would need this mask, otherwise the sanity
check could fail for completely bogus reasons.

So: The comment is still correct, even with the adjusted logic.

Ciao,
Johannes

>=20
> > @@ -68,7 +73,7 @@ static void zlib_post_call(git_zstream *s, int statu=
s)
> >  	 */
> >  	if (status !=3D Z_NEED_DICT &&
> >  	    (s->z.total_in & ULONG_MAX_VALUE) !=3D
> > -	    ((s->total_in + bytes_consumed) & ULONG_MAX_VALUE))
> > +	    ((zlib_uLong_cap(s->total_in) + bytes_consumed) & ULONG_MAX_VALU=
E))
> >  		BUG("total_in mismatch");
> > =20
> >  	s->total_out +=3D bytes_produced;
> >
> > base-commit: 7a094d68a27e321a99c8ab6b700909e503904bd9
>=20
