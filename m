Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78851D6DB9
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992108; cv=none; b=m26pjZhDnM6bux2pgmxjbn9gaSUrt8UMjJSEwgQRV/ZulVPsgBDVeMoqpD59Zgf1XCgwnPMEhzhIjj37R1tP0QXsHRYuuqmtmK7a1Pp0qnVA9CsIVzK2J3EoA68gTIZ/PElW9uRW9tf6rTkWv2aeT4Z2oQB8MkxRcnsmWXpeWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992108; c=relaxed/simple;
	bh=e9yZDnn55aFCdmIC88b+o+EchL/G6JH1IAlivboFEeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYVXsbfeRWKo54vtgYuXvLRiV+sYbUeURyNEW0r5sN3zU09JTB6LwhZ1GEpGoLtI4MHZQrBOCGTvAzEUkNjGaHh1cJt+GCDNlqAPwPTezswLghj6BEnRXLfeZIANbNyVtYvHRemO/W4yHe3Ir8cBLFflNCm0kkDpZi9hdP6tY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3522184-ipxg00e01tokaisakaetozai.aichi.ocn.ne.jp ([122.27.91.184] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1uMak4-001FJa-2e;
	Tue, 03 Jun 2025 23:08:25 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1uMak1-009kJI-1x;
	Wed, 04 Jun 2025 08:08:21 +0900
Date: Wed, 4 Jun 2025 08:08:21 +0900
From: Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
Message-ID: <20250603230821.qig7g4zsenunlkbh@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
 <20250307195057.GA3675279@coredump.intra.peff.net>
 <xmqq34foefh8.fsf@gitster.g>
 <20250307225444.GA42758@coredump.intra.peff.net>
 <20250308032309.GA584028@coredump.intra.peff.net>
 <20250603212934.uojo22zjcuf6yfic@glandium.org>
 <xmqqh60wh42f.fsf@gitster.g>
 <20250603223750.sjp5rw56ajehaaqe@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603223750.sjp5rw56ajehaaqe@glandium.org>

On Wed, Jun 04, 2025 at 07:37:50AM +0900, Mike Hommey wrote:
> On Tue, Jun 03, 2025 at 03:07:36PM -0700, Junio C Hamano wrote:
> > Mike Hommey <mh@glandium.org> writes:
> > 
> > > There is a similar problem with this code in refs/files-backend.c:
> > >
> > > 			if (!create_ref_symlink(lock, update->new_target))
> > > 				continue;
> > >
> > > Where create_ref_symlink is defined as such:
> > >
> > > #ifdef NO_SYMLINK_HEAD
> > > #define create_ref_symlink(a, b) (-1)
> > > #else
> > > static int create_ref_symlink(struct ref_lock *lock, const char *target)
> > > {
> > > ...
> > > #endif
> > >
> > > And NO_SYMLINK_HEAD is defined on Windows.
> > 
> > Would the NOT_CONSTANT() trick we ended up using for the original
> > "sigfillset" thing solve your issue as well?
> 
>    if (NOT_CONSTANT(!create_ref_symlink(lock, update->new_target)))
> 
> indeed works around it.

I sent it as a patch along with other warning fixes.

Mike
