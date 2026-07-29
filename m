Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760A2F3621
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327472; cv=none; b=DPrcTt3KO6XWor2YQIJSdPjj7h0hySXqXWzh5RdZag+DyvLHMig9hyVodswbzvXUtuKm0CPkrdy8Ta1GqJR7/3B8acmGucNhd14KKbyFaLZElZqPUtHKqKFoH69hQ26/DEUCN00Jkc8BPENyoCajxITOskj1umTfVC40xTSYBGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327472; c=relaxed/simple;
	bh=B8uD8SDvylu19sq8oYvleA+LQFrKaYStOt62LzQClcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9yXtB91o6E2U3KnaDAtt6/Cdzc5nCnvD8BkxtPtqCIFQJ6B75PNz96k/oOAzF+5tYbPUpZNpalpVkeFDFB8bguaxsowHyDar6+25Z/46uLKT6lRCCgnqrjMXpaS+kPMq8pFwncdit/ioLRWgsQLG3qFlbQwP7GWvL1mzXoqM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=C2TBPzuz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="C2TBPzuz"
Received: (qmail 758 invoked by uid 106); 29 Jul 2026 12:17:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=B8uD8SDvylu19sq8oYvleA+LQFrKaYStOt62LzQClcY=; b=C2TBPzuznCMCkkNXRn1/ZT6d0/SKC0a5vTP3uuxzW5wZIcPm/5bZ6/id6b78jtEHOiHU1A4y+6zB6MPs0FyuwxD/YHVolJhwRubo1sWfmaloqLI4H1dmiMTVrUB8lKefr7uNn6XO1Ch5V+uRhpqfdNqE25TDUmen/kWXwlKk2udyxv/nxclY7E4fkqnAPqWGvXoJFSCKqf3hRVN38R/8Hro+Y8429xrYriiZCMVVmyYY0K0CN057GS1/czOSJfI/eKEFS1ioUdR9INpuXzBuCXGf4JfCXKW0XlQPPpgVxGEK4nPDCsI4e2yGgWOtq5qYQE/6RjgD9qQzzmU7f2Q2ew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2026 12:17:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1677 invoked by uid 111); 29 Jul 2026 12:17:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2026 08:17:48 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Jul 2026 08:17:47 -0400
From: Jeff King <peff@peff.net>
To: Alan Stokes <alan@source.dev>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] cat-file: handle content request for --batch-command
 without type
Message-ID: <20260729121747.GA679014@coredump.intra.peff.net>
References: <CAFZW3h0K6vi15HhMEX30Ab+pjRc3mQr2Myv9KJUH=MWzsvt0FQ@mail.gmail.com>
 <20260727095735.GA1153453@coredump.intra.peff.net>
 <DK9MX0YJ07S0.1TOBLIA6ZNSEN@gmail.com>
 <CAFZW3h3xyeJJwHfVK2mB2k1=e-0he9_gbTetJ1RdB2uUM1rp4A@mail.gmail.com>
 <20260728150031.GA41931@coredump.intra.peff.net>
 <xmqqjyqfdnie.fsf@gitster.g>
 <CAFZW3h2hVMaVy12uO_5k5cwN=N9LDhrxuVSQPNmPWxB4j+kRwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFZW3h2hVMaVy12uO_5k5cwN=N9LDhrxuVSQPNmPWxB4j+kRwQ@mail.gmail.com>

On Wed, Jul 29, 2026 at 11:03:34AM +0100, Alan Stokes wrote:

> Thanks, Peff and Pablo. Sorry I wasn't able to contribute this time.

Reporting the bug is a very important form of contribution. :)

> (Peff: for some reason I'm not receiving emails from you, although
> I've got the other ones on this thread. I'm assuming that's due to
> some over-zealous filter at my end.)

Thanks for letting me know. The problem was on my end, and (shocker) it
turned out to be DNS.

-Peff
