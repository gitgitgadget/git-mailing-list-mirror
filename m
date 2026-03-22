Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19882BA45
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774212473; cv=none; b=TUarMFDwNPXDwlE1USjO4jF1+CBfTz8HgVceonlNmbnIjqpsUFCcl/SAwCljw9tf+ak5y1MwpmUH2uTIWaoR0c8gBfUBKHezdLJIkVDyBYt3wfU4+u7NzVwj+la35tJ8gDuKYJQpJiiTBil0QeqCYP7DP0+8N5jyQo3/5zueVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774212473; c=relaxed/simple;
	bh=8YYjKpsdiSc76qduWfBZpw4D3hLXyNhNCYbUH7gWJco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTkqMGZoBPpyTCc4VCxqVo5ytNVW7Vwe5f7yc6VnPNmBrQSuzOtj/vWS5lTsR8jSzYfHRZoGr2I9aWc6fZHKmr9sAXFm97uHYHzpM0b9BkO+NEXGflXurOkwsp/mk/WqaHMteNDNoNUFhupVYtFHlLQ+hIgrPwwrefspeEyenbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KBd2zk80; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KBd2zk80"
Received: (qmail 106219 invoked by uid 106); 22 Mar 2026 20:47:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=8YYjKpsdiSc76qduWfBZpw4D3hLXyNhNCYbUH7gWJco=; b=KBd2zk80MRTGeocahjBIWaVTVS1mhCWqECoF/Ofv5+tAVE2voqHdFhku7YbB+U1UozEXb+m55lKRMDeLKcATPnqH7sw08OJ/3vOsmcuaf+rt5GIIKFCaGKiOwJ93TUV8w+JSq10Bry9WUXxRy5LZJczJugb9RVqSPe7VvxyFgWEQvR3Lb2F/ZItdXbTu6savQv/EfDkiB+07EqgKppHPPxPB7YxvaVy7C77ah+5jRjXaoC4k68/g7kOSJRNoDPBYoulwgqtyhHOitKBgIkSgOEl0577a2KZpQfbBZuD97F8GV/ZgEvVzgJwQIK//Unnmd7/lP0mSeW/87+cOPIvDJA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Mar 2026 20:47:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 139809 invoked by uid 111); 22 Mar 2026 20:47:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2026 16:47:50 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 22 Mar 2026 16:47:50 -0400
From: Jeff King <peff@peff.net>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org, Scott Baker <scott@perturb.org>
Subject: Re: [PATCH 5/8] diff-highlight: use test_decode_color in tests
Message-ID: <20260322204750.GB2047044@coredump.intra.peff.net>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
 <20260320004436.GE3654226@coredump.intra.peff.net>
 <b992e118-f948-4145-8d77-96f00b497f99@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b992e118-f948-4145-8d77-96f00b497f99@gmail.com>

On Mon, Mar 23, 2026 at 01:24:00AM +0800, Tian Yuchen wrote:

> > @@ -42,9 +39,9 @@ dh_test () {
> >   	} >/dev/null &&
> >   	"$DIFF_HIGHLIGHT" <diff.raw >diff.hi &&
> > -	test_strip_patch_header <diff.hi >diff.act
> > +	test_strip_patch_header <diff.hi | test_decode_color >diff.act
> 
> Although this is just simple text filtering and leaving it as is wouldn’t
> cause any problems IMO, why not go ahead and add the && while you’re at it?

The bug is in an earlier commit (patch 3), which breaks apart the pipe
but doesn't add the necessary &&. And it's more than just text
filtering; it breaks the &&-chain, so we miss the exit code of
$DIFF_HIGHLIGHT (which was the whole point of patch 3).

chainlint doesn't find it because we're in a helper function, not
directinly in a test snippet.

I'll send a revised series to fix it, but...

> I've noticed that there are several missing &&.

Where else do you see?

Or do you mean that we should not pipe text filtering commands? There
I'd disagree. We are not likely to see a failure from 'sed', and if we
do, the fact that the output does not match would catch it. And the cost
of breaking every command down without pipes means having to manage lots
of intermediate files.

-Peff
