Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7378A1BDDC
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942231; cv=none; b=IQrHzlu52yT0jTqV2qgL9J5FuPhU/eifZMvJLYr1vPpk24vL/HSjN12rO4/w6fsnQ/CzTKwBhn/SXymV7TQdItN6h5vrV44ffVTqu5BHSzpSmGyDY/Cg/VFdSyHWwD8d1Ba9VihfKm7SHjgPlr9iccDIRy7oIcqDo93B6sfU0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942231; c=relaxed/simple;
	bh=VQTe2Nqad0lsBlzywMPkVNuw0KxkESf2YRtXYFSohwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyuh4a3WG1gXT99JazAJqrmmKzkESYpWX5zjeDm+8t+akQIDX8y7tt6NWg1Hz4ehGIQqVvvFLMmtDi/IeResKb6g/CGLQXybl+qPC/nqLefJ/F7HTAXuxHR6bY8UHTSCf4WIo6VNDaZR+2WUiHKuAF2hK0NGLiYVJ+ARt4e4RRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22036 invoked by uid 109); 26 Feb 2024 10:10:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Feb 2024 10:10:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15491 invoked by uid 111); 26 Feb 2024 10:10:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Feb 2024 05:10:33 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 26 Feb 2024 05:10:27 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Yasushi SHOJI <yasushi.shoji@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] read_ref_at(): special-case ref@{0} for an empty
 reflog
Message-ID: <20240226101027.GA2685773@coredump.intra.peff.net>
References: <20240226100010.GA1214708@coredump.intra.peff.net>
 <20240226100803.GC2685600@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226100803.GC2685600@coredump.intra.peff.net>

On Mon, Feb 26, 2024 at 05:08:03AM -0500, Jeff King wrote:

> Thus nobody should actually look at the reflog entry info we return. But
> we'll still put in some fake values just to be on the safe side, since
> this is such a subtle and confusing interface. Likewise, we'll document
> what's going on in a comment above the function declaration. If this
> were a function with a lot of callers, the footgun would probably not be
> worth it. But it has only ever had two callers in its 18-year existence,
> and it seems unlikely to grow more. So let's hold our noses and let
> users enjoy the convenience of a simulated ref@{0}.

Obviously I'm sympathetic to Patrick's position that this empty-reflog
special case is kind of gross. ;)

That's one of the reasons I split this out from patch 2; we can see
exactly what must be done to make each case work. And in fact I had
originally started to write a patch that simply changed t1508 to expect
failure. I could still be persuaded to go that way if anybody feels
strongly.

-Peff
