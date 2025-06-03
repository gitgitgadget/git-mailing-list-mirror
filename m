Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B694221DBD
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990285; cv=none; b=sFcFE54dZ4EdGZc0KXXRnL4p0rbqmnYPIgUjCxjmRqwcoEJqjXlT9uF4wi7mUsZl2sNyC/T1qVfZsyfJIqmjyF89wdGBYztj3p+58UEnpVvg/xMHhmnEp9J86bDF2988Z+yzGJSsMpcJaWp59nJFygytG9teydG1Kq9r3jjcg2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990285; c=relaxed/simple;
	bh=oGaqd9fv6H6q+0b1i7hab3FCFHs5O2PYvYMKfcgwdCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tC+c83PO8oPi+1F2WNRbl0pPc8/QkidkjDR19wGDPYISk21gzzi2Z/cDglRWtvcCfSnQmW3nN+ww58bxiWwo5l3gdCUkOEUSs2sfpATtSdUX/0u7u6SVSTFSz+5TMelYS8vt4w1fa+/3rmUt/200Cx+Gp0cscLBXYnweIGHA04Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3522184-ipxg00e01tokaisakaetozai.aichi.ocn.ne.jp ([122.27.91.184] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1uMaGa-001D9F-2F;
	Tue, 03 Jun 2025 22:37:56 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1uMaGU-009ceN-1c;
	Wed, 04 Jun 2025 07:37:50 +0900
Date: Wed, 4 Jun 2025 07:37:50 +0900
From: Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	git@vger.kernel.org, ps@pks.im, jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
Message-ID: <20250603223750.sjp5rw56ajehaaqe@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
 <20250307195057.GA3675279@coredump.intra.peff.net>
 <xmqq34foefh8.fsf@gitster.g>
 <20250307225444.GA42758@coredump.intra.peff.net>
 <20250308032309.GA584028@coredump.intra.peff.net>
 <20250603212934.uojo22zjcuf6yfic@glandium.org>
 <xmqqh60wh42f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh60wh42f.fsf@gitster.g>

On Tue, Jun 03, 2025 at 03:07:36PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > There is a similar problem with this code in refs/files-backend.c:
> >
> > 			if (!create_ref_symlink(lock, update->new_target))
> > 				continue;
> >
> > Where create_ref_symlink is defined as such:
> >
> > #ifdef NO_SYMLINK_HEAD
> > #define create_ref_symlink(a, b) (-1)
> > #else
> > static int create_ref_symlink(struct ref_lock *lock, const char *target)
> > {
> > ...
> > #endif
> >
> > And NO_SYMLINK_HEAD is defined on Windows.
> 
> Would the NOT_CONSTANT() trick we ended up using for the original
> "sigfillset" thing solve your issue as well?

   if (NOT_CONSTANT(!create_ref_symlink(lock, update->new_target)))

indeed works around it.

Mike
