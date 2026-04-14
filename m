Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465738AC8E
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776208094; cv=none; b=sdGWpcPxblF+TfiiWQcslp28l15n7TXwVnbLuEAMPuvIgocDWar7WkU5jmqxaWxvkt/naMXBzmvIKSglIb8XlK4xo9bgvuUtGpF6zqb70gU8qIqZq2EznuITETeYb3s9EVysfu6NLN5KRr6/qSXYvAawddhRyqq/2giQBDrHo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776208094; c=relaxed/simple;
	bh=U7udbx/VCL2hC3Ix69YuV3z796dpJITxh1qbZgG0THY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvVbxgvXDmcJaR/1mx7OHlwbYtAlK5SZPty89n0iABvoQjZ+l0p2LO5rpsEfqpclgqGzBfYVO8d0QtuBHRIcR/zwcdANdPN9/T+QvIa4s6r4jEwTxQrywYXj2JX0If+Xw80uxOjIOesnXY1QmTiDTDD1Fu4QswwF6vsml/N5Ic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SaV88Oyn; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SaV88Oyn"
Received: (qmail 351028 invoked by uid 106); 14 Apr 2026 23:08:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=U7udbx/VCL2hC3Ix69YuV3z796dpJITxh1qbZgG0THY=; b=SaV88Oyntz7iFw8JilhJTZYiv11GwkBpHlRBHiRo/A/OdmtjM06VwPniXKiW0DSk/t9WvalnB8fPMZxuf/xXeo4TlZMNwt5qXvW9yBsYFsjWH9bN3LqGZB2L1nuOZ+8cTqqcAkOD9jJT69HX/eE1qRZrYPg4KmCS/+p8dRFLNOFcKdAsa3lmOqKWu5QggQRArkDebuBWpjBqOpa7D5Y7/iTRrfXl+/Cbnq0WeIwI/q0czMWrUqqLl+oXhXZWdIjDe3EdIaK8pM+GNJDZVPWLzasf+UEIVokb8vXxWNNRjfJyB3LndQRLteUhZxZgSHVNUNRBkrlAh8Xb2SIGxItCAQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Apr 2026 23:08:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 587691 invoked by uid 111); 14 Apr 2026 23:08:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2026 19:08:11 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Apr 2026 19:08:10 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Message-ID: <20260414230810.GA3528448@coredump.intra.peff.net>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
 <xmqqeckifq59.fsf@gitster.g>
 <xmqq340yfivf.fsf@gitster.g>
 <ad3rgbgadjIZRgaz@pks.im>
 <20260414220347.GA3475127@coredump.intra.peff.net>
 <20260414225206.GA3486072@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260414225206.GA3486072@coredump.intra.peff.net>

On Tue, Apr 14, 2026 at 06:52:07PM -0400, Jeff King wrote:

> Short of requiring a third-party shell, the only workaround I can think
> of is to manually "set +e" before using "command", and then restore it
> with "set -e". Gross.

I guess one other option is to avoid turning on "set -e" at all for
known-buggy shells. We are not relying on it working everywhere, but
rather hoping that if at least one platform uses it, it will find
programming errors in the test script.

Personally, I am still skeptical that all of this is worth it versus
just checking stderr.

-Peff
