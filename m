Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306DB3126CC
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124477; cv=none; b=Gt+Fo9r8JIEoD6gBGSEOEME+/MxMfIGRWWa0HSXkrSDbexOjYbndIbWFUJMvULishKcPjuZVOKJ4ZfZ8vG5Rip5Zy/xuNhSxB20KzmVl9qBuUI3+gQNVoxKy8o32Cn6RlLUa15WH+7JqGjv97UpKzBTjLo4tBO4aui5xgeYx+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124477; c=relaxed/simple;
	bh=MR9akD6gg00yZNDbGAB6Y7j2FL3BDKeAkKO2TdE5kNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+KDunMJc4NJeHY2dFInZABQx9uvAKi4tVXN5u+xma7ygNBwSe9MPreNwDB7IgcJAJkslN1HJDLlJ8P3+PgOAnKoWwUSbXlhmv/zgrN9kbr2Qlj3bDdmjfCjAuhOaecZti3eF/HT8eah8LWxWh5w9fkNt/c0VpUxN8RER/vrOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ImJZk1iA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ImJZk1iA"
Received: (qmail 303093 invoked by uid 109); 22 Oct 2025 09:14:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MR9akD6gg00yZNDbGAB6Y7j2FL3BDKeAkKO2TdE5kNg=; b=ImJZk1iAHp63/KEAHsd80I4RlZ+1AZUbwMm26TSKX9EDC0O/J5YykzmnFNH/8qb8RhXmbTQB+ndTP3V/MspzBXvVbWud6If3910lBfcmGz22dVJNfY1NGP+VEAngj/y4EyYe1qBCVxiQwPVVWG+6Cpw6hx2XZ11AcDFMNwJOxKuWuGfrCWNBhOcXDMp7cVkqBQ1Ay2Ne8Nlgs+cogjeNyRX2Q+yGqu0/N6sYyL2h8AW94dA7ay6TsSleuy1x1xyHVYeml/fKPxiPsEFMxXUnnZj1ZtZ2yVnOQOrtYvue3Aj0Lp+UNuh1ztTVcUVQRMaCjbva7BENmge7sAkLS0w71w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Oct 2025 09:14:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 472242 invoked by uid 111); 22 Oct 2025 09:14:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Oct 2025 05:14:33 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 22 Oct 2025 05:14:33 -0400
From: Jeff King <peff@peff.net>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jake Zimmerman <jake@zimmerman.io>,
	git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
Message-ID: <20251022091433.GC853931@coredump.intra.peff.net>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
 <xmqq7bwt1kyf.fsf@gitster.g>
 <20251018094037.GA1060824@coredump.intra.peff.net>
 <xmqqh5vww7xa.fsf@gitster.g>
 <20251021073640.GB259661@coredump.intra.peff.net>
 <xmqqy0p4wcac.fsf@gitster.g>
 <E76C71D8-103E-4C37-B05C-86DC180BD519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E76C71D8-103E-4C37-B05C-86DC180BD519@gmail.com>

On Wed, Oct 22, 2025 at 12:46:55PM +0800, Lidong Yan wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> > 
> > /* return 1 if any change is found; otherwise, return 0 */
> > static int diff_flush_patch_quietly(struct diff_filepair *p, struct diff_options *o)
> > {
> > @@ -6179,6 +6181,15 @@ static int diff_flush_patch_quietly(struct diff_filepair *p, struct diff_options
> > int saved_found_changes = o->found_changes;
> > int ret;
> > 
> > + /*
> > + * run diff_flush_patch for the exit status. setting
> > + * options->file to /dev/null should be safe, because we
> > + * aren't supposed to produce any output anyway.
> > + */
> > + diff_free_file(o);
> > + o->file = xfopen("/dev/null", "w");
> > + o->close_file = 1;
> > + o->color_moved = 0;
> > o->dry_run = 1;
> > o->found_changes = 0;
> > diff_flush_patch(p, o);
> > 
> 
> This would make everything going to "/dev/null" after the flush_quietly() call.
> I think we need to restore o->file.

We probably also need to restore o->color_moved, too.

In the long run (and this is the kind of cleanup I was hoping you'd work
on for 'master'), we probably could drop that line entirely and just
skip running the moved-line detection when dry_run is set. Assuming it
even runs at all. From a quick look at the code, it looks like we only
do color-moved handling via diff_flush_patch_all_file_pairs(), so it
wouldn't trigger at all for the cases that do individual calls to
diff_flush_patch_quietly()?

-Peff
