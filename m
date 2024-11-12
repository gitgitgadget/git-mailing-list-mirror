Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DBA1F7092
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402186; cv=none; b=MJP77t1RwiXkQ6Ss6R1bp01GH8sLCxqipyrkDw2GfsGAXvzietxqdHScI/klRrzwmBAnHetDjnQvB3Nl4Sw1Tt4RBV8jjWQzw2NbcBfZskD8PSWQza5WPyRDtF12W3sUhF3xydk+UBgMSSmH7n4Xg8wLAvshkLvJHBf+oePtwh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402186; c=relaxed/simple;
	bh=rjGpkydGAwKAcDgGtkg4dtTOm7Kmm+3Gm5z5EheSgis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NodEUEVRhjt32Pp0BxWf4Zbr6TK7RnI5/IqXipjnKTYycaPvO9lXWInz4WZvzDaqP0QGDRBD6vdQiqVIYiHXyjhYUwfJiNAX7bTpgviaSqRB8f1GAkvQ0KXfXTYYscUWroxHwPN09tT2TMV7F/pPnhFmowOrbpUIB8J7WpvyVwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GeeHK1fn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GeeHK1fn"
Received: (qmail 30670 invoked by uid 109); 12 Nov 2024 09:03:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rjGpkydGAwKAcDgGtkg4dtTOm7Kmm+3Gm5z5EheSgis=; b=GeeHK1fnUAJmq75w0ywxh0jXuPa1tua3BGKnyhMIFqUh7J712jbTHQqDev8xsfzy3PqWAYxP2pQo1/PbE1Z0ECgIF0CVSgiqpgq3nv5NPt3yq7ag1esfOCAUhKo1y2zKxrF0/8M78bLUSbeC2Feru/IiZzZgYatQHszsyogGyWb640UodM0MEafc/OlzHN8W8p+wQexASrcqQJDVXLAw9kLOe+Gmr2kNbj2YFRZOif2th3sOTmdc9Zo8MT6QQc9NkySDeHEBCpdklUFA14hwg6x1IWFga6+QTJwio1h20adWETXjUvqnGI2GRR+BdZf08a+gtyAP8J4Qwh2Yr4fHYw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Nov 2024 09:03:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27874 invoked by uid 111); 12 Nov 2024 09:03:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2024 04:03:08 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Nov 2024 04:03:03 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 21/27] global: drop `UNLEAK()` annotation
Message-ID: <20241112090303.GA3687943@coredump.intra.peff.net>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-21-6154bf91f0b0@pks.im>
 <20241112082609.GA3166560@coredump.intra.peff.net>
 <ZzMXh-Pcb4SMSno0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzMXh-Pcb4SMSno0@pks.im>

On Tue, Nov 12, 2024 at 09:53:28AM +0100, Patrick Steinhardt wrote:

> On Tue, Nov 12, 2024 at 03:26:09AM -0500, Jeff King wrote:
> > On Mon, Nov 11, 2024 at 11:38:50AM +0100, Patrick Steinhardt wrote:
> > > This neatly demonstrates one of the issues with `UNLEAK()`: it is quite
> > > easy for the annotation to become stale. A second issue is that its
> > > whole intent is to paper over leaks. And while that has been a necessary
> > > evil in the past, because Git was leaking left and right, it isn't
> > > really much of an issue nowadays where our test suite has no known leaks
> > > anymore.
> > 
> > I do agree that stale annotations are a weakness (they do not hurt the
> > leak-checker if they exist, but they are an eye-sore).
> > 
> > I'm not sure I would agree that the intent was to paper over leaks. The
> > point was to avoid noise from the leak-checker about memory that was
> > intentionally held until program exit and released by returning from
> > main(). I think the main thing that made it obsolete is that we decided
> > it was worth it to spend the cycles freeing that memory rather than
> > ignoring it.
> > 
> > But it's possible I'm just splitting hairs. :)
> 
> Yeah, I know that this was also used to mark memory that intentionally
> leaks because we're about to exit anyway. I basically consider that as
> some form of "papering over" it, but I get your comment that this may be
> a bit too strongly worded.
> 
> Do you want me to reformulate this, or do we just go with the current
> description?

Nah, I think it is OK to leave it as-is. The important thing is that it
is gone. :)

(Thanks for all your work on this, btw. I was so happy to see the commit
dropping all of the PASSING_SANITIZE_LEAK infrastructure).

-Peff
