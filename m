Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64017BB5
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724342; cv=none; b=fC+JwOjMPHZNB4OKBrYyZoHT36S3YT+4hH/JcPz8/SBXhpeWILwGmo/cgHvOLHgClhu/Gf7CXk06G5keTe7RE1KYPQIRUKqEALTfa39ruYy4Dkhk5tPMrLUh23GgjxqoU1MOLTOoTQjbEEjTojq3a926bzzEbl7DADlweSoUI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724342; c=relaxed/simple;
	bh=IaIu2m6KxWTkP7VP6g8MFU0p0xj1/oeRknyEJTbuEj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uDON9Y4GHhxWLzOPfrE4pYM0JQnMpn7mwfmS5iim/d3nDzpEO11Xub6bq+rR3s8A+5DHW3A+SSuGt5A9gev5zc04YwmfZD+NNI0ul2CqKv8X0cIz3KQusJSNje+WVlwIAwKR3pCzD7435gDlgd9ZCM95KawkYlLvpYpSPPs8GNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i4kyF2Q/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i4kyF2Q/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CC5A2973A;
	Tue, 18 Jun 2024 11:25:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IaIu2m6KxWTkP7VP6g8MFU0p0xj1/oeRknyEJT
	buEj4=; b=i4kyF2Q/bWq3iJcT7z+hP3/OESrhfJrPBdEbJugwTilcP978yYWSk9
	QUTsIXRlB7ITCbXVLAsSXosm0T76gANRACCtOqvPLPZs99fR3uJmOfGukzS5X+5k
	3N/W+Q2LC09r3w76ckOm3ZCzA5hO5ffxGkTgupO6iyTiT5YKBkQ+Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 651A829739;
	Tue, 18 Jun 2024 11:25:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B8E029737;
	Tue, 18 Jun 2024 11:25:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v3 1/7] fsck: add refs check interfaces to
 interface with fsck error levels
In-Reply-To: <ZnFJTdHQcHVagflt@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 18 Jun 2024 16:46:05 +0800")
References: <ZnFCEYypdAyXMMlg@ArchLinux>
	<CAOLa=ZS57EsZk+7xOW9imbA4oWANKf0b+HxBZ8hGFaQQkCsvcQ@mail.gmail.com>
	<ZnFJTdHQcHVagflt@ArchLinux>
Date: Tue, 18 Jun 2024 08:25:34 -0700
Message-ID: <xmqqfrta2ryp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 02F5289E-2D87-11EF-A456-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> On Tue, Jun 18, 2024 at 04:38:07AM -0400, Karthik Nayak wrote:
>> shejialuo <shejialuo@gmail.com> writes:
>> 
>> [snip]
>> 
>> >  struct fsck_options {
>> > +	/*
>> > +	 * Reorder the fields to allow `fsck_ref_options` to use
>> > +	 * the interfaces using `struct fsck_options`.
>> > +	 */
>> 
>> Why is this added? It makes sense to have it in the commit message
>> because it talks about the change, but why make it persistent in the
>> code?
>> 
>
> I explicitly add this comments due to the following reasons:
>
> 1. If someone needs to change the `fsck_options`, without this comment,
> he might be just add some new fields at top. Although the change will
> fail the tests here, I think we should mention this in code.

Do you mean you plan to take advantage of the fact that early
members of two structures are the same?  IOW, if there is a function
that takes a pointer to smaller fsck_refs_options, you plan to pass
a pointer to fsck_options from some callers, e.g.

    extern void func(struct fsck_refs_options *);
    void a_caller(struct fsck_options *o)
    {
	func((struct fsck_options *)o);
	...

If that is the case, then ...

Do not do that.

Your data structure design is broken.  Instead you would do this:

	struct fsck_options {
		struct fsck_refs_options refs;
		... other members ...
	};
	void a_caller(struct fsck_options *o)
	{
		func(&o->refs);
		...

