Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBADA47
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347602; cv=none; b=Y5Cry4KdAdsK3CnW+1SF0tF60Irp3faQ5svxfokaluK/XZzgYoUXs3lvHtORRrkJGNG7G/MGALySaLH7i0F0Wo1FZmOqjTUGzlKTjkHxDR416ro2ZYwRDxoBvUv4S1bUJIK5pbQXQFjm2kGVQWALVYCvnKbkh08RhDXkgOpnGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347602; c=relaxed/simple;
	bh=2CLYlwQ+3igeHlBM/lu+sJwlLRs2EgjH++iOVq7tAJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkuYvdy97kVnsNUlRnkXSDGoMVB3YcCPff+2bR0omAKbG4ZuTXmYSCwXRvuSPmJMEEMNHzrDbo10wwSY/COytFrGGiuIG8nwaG049SRE7dlfEktdCGJl/51yA9mt1sbHAEVrQ228keRABD3yir/aaIf8AQe+/nr1WKTOy21zCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=Mkk0Sekp; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="Mkk0Sekp"
Date: Tue, 1 Jul 2025 01:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751347596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rm64j/HR4UAdIm1umyna7on6L3BL098nN7AjHRnrYrY=;
	b=Mkk0SekpmGy3vOaDpsQks0oW31i2qDuGhqhpk9l9KEtb2wIGQWASdTCCkrEoeiMcLAVCVO
	XPiF9PcN5tzvj46M3NQvYmQKUO3X5pTLJp1hEV9lRKwjnAYHkip767I2zzh+Iv9p8JlfXo
	LgS3EzX4Zq/Cm97rsL+oN45n4eP3878=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH 1/5] apply: error on --intent-to-add outside gitdir
Message-ID: <lhhs5j47cnvhp7zcqtcfr725els2dlvoufsp7mexn3isivnpnv@ode3ul6ds3sa>
References: <20250628225819.1294068-2-ray@ameretat.dev>
 <20250628225819.1294068-3-ray@ameretat.dev>
 <xmqqfrfh13k5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrfh13k5.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On 25/06/30 11:34AM, Junio C Hamano wrote:
> "Raymond E. Pasco" <ray@ameretat.dev> writes:
> 
> > It makes no sense to register an intent to add outside a repository. We
> > should error out here.
> 
> I am not so sure, especially if you still keep the original "if we
> are using 'git apply' as a better GNU patch, ignore -N" logic.
> 
> Not that I am suggesting to also error out when -N is given without
> --index or --cached, that is.
> 
> I think the most problematic is the claim "it makes no sense" is not
> linked to the conclusion "we should error out".  The behaviour of
> the original code, and the behaviour of the code with this patch in
> "a better GNU patch" mode is based on "it makes no sense in such a
> context, hence we just ignore (instead of erroring out)", which
> makes perfect sense as well.

Yeah, perhaps that's right. My thought was that "the user said -N,
they must think they're in a repository". On the other hand, however,
it's a lot weaker than saying --index or --cached, which mean the
user definitely wants to manipulate a git repository; the user is
still /mainly/ trying to manipulate files if they use -N.
