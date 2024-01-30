Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA3381AA
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706592215; cv=none; b=nmbhfrprSPab30ZnpstnOZrWbt8BW/UW7afkKU6tHsc0KbaljGmGrGA5nTrk7pgYIQTp3Ule0SzblymhP6CmBAiMrnjT/CFyOhD7nsb91A8z+BTORzT+oNbIeNBxyLU5pq0SdmCe/WaqRuU0SxmYtM7QssvMTxyH21zRjKpLG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706592215; c=relaxed/simple;
	bh=6dEylHUVYGcavuJF/B0wKFHJViC6RI8XwMPl8o2CCl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwGonyUkmMBw8DQP6hCFefMagkgcaftOcOsy1Dcz12IyWSbPWK4EBu44XilshFVn0YBhrjPy1kKwj6icaAXYZT/hSB1ww4R1RI8t3hQtpxMQ7UVqtNPhlNVY2Rk6w4kEt6CCpMOGihR/HoXf/imW44X/6PhiqeKJKnZ6vRYp5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8548 invoked by uid 109); 30 Jan 2024 05:23:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jan 2024 05:23:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28958 invoked by uid 111); 30 Jan 2024 05:23:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jan 2024 00:23:33 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jan 2024 00:23:31 -0500
From: Jeff King <peff@peff.net>
To: Adam Dinwoodie <adam@dinwoodie.org>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] t/Makefile: get UNIT_TESTS list from C sources
Message-ID: <20240130052331.GB154684@coredump.intra.peff.net>
References: <20240129031540.GA2433764@coredump.intra.peff.net>
 <20240129031933.GB2433899@coredump.intra.peff.net>
 <ZbeLcrjIYd4d7PaB@tanuki>
 <20240129174918.GA3765717@coredump.intra.peff.net>
 <CA+kUOanDydgCEax9RFu_xVXkx_LeiSPOoWiUpwAg=EVQxSDJRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+kUOanDydgCEax9RFu_xVXkx_LeiSPOoWiUpwAg=EVQxSDJRw@mail.gmail.com>

On Mon, Jan 29, 2024 at 09:31:11PM +0000, Adam Dinwoodie wrote:

> > Hmm, good point. It seems like the answer should obviously be "yes", but
> > Windows CI seemed to pass all the same (and I checked that it indeed ran
> > the unit tests). Do we only get the $X suffix for MSVC builds or
> > something? Looks like maybe cygwin, as well.
> 
> Cygwin will automatically append ".exe" when doing directory listings;
> a check if the file "a" exists will return true on Cygwin if "a" or
> "a.exe" exists; a glob for "a*" in a directory containing files "a1"
> and "a2.exe" will return "a1" and "a2". This causes problems in some
> edge cases, but it means *nix scripts and applications are much more
> likely to work without any Cygwin-specific handling. I *think* this
> logic is carried downstream to MSYS2 and thence to Git for Windows.
> 
> As a result, I'm not surprised this worked without handling $X, but I
> don't think there's any harm in adding it either.

Ah, that makes sense. I do think it will work under the conditions you
laid out, but I don't know if there are platforms where that's not the
case. I'll add the $(X) just to be sure (as that really feels more
consistent with what the top-level Makefile is doing anyway).

Thanks.

-Peff
