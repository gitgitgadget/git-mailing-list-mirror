Received: from mta1.migadu.com (out-29.mta1.migadu.com [95.215.58.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F1480345
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871063; cv=none; b=uwiAwOMFSazdnSF764Z/JD9ba7gFfJB6/DnVPJNESB1hy/6YD14DVScOKnQ75WdVF5ldQ5o783lkszlcqquZraXFGclPc5pEgu/nd6LqYPog0iF/THvgn0subnRSA1m+f2wRlxRVwfPf3gmb8BUp9uN9dyg22zousllA1PXVykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871063; c=relaxed/simple;
	bh=IhEOclPAIS5OvhX3chlndeyFe3ExiuysNJgqWJ6gS4c=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PAtMo5HpHlDL04hmuSe7a5uw9j1y+TRGVjrAFoe8oFdyLXABnsW8mYvshAJ1yEOqd3PUKtJUrsoSJo1rfoauBPQy8D/ae6/vrQHHY324/Oo2PeUo8AvLNbldl+2GX5hXvVrjXAZ40sSiSI9YZI2E8oqiNud59Nv8T72xrefX+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=OYtQqvJT; arc=none smtp.client-ip=95.215.58.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="OYtQqvJT"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IhEOclPAIS5OvhX3chlndeyFe3ExiuysNJgqWJ6gS4c=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791871057; v=1; x=1792475857;
 b=OYtQqvJTjML5HSZEJfuWm2cI+3ot0hbG00ltswBMC05EoFMYH7dACZ95XTSGvEUv4Q2hqXs/
 VJnxvQZNxXTw71IISNDRv4IDFzMYWJ7ID0VPMJFyXRJq4wg2c4mpIvQtgah+JC9R93xkJAX9xUH
 GLMTXNGSw8t7jsEg1tOMLBag=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 5a34caa7e6fcbe0a;
	Tue, 13 Oct 2026 05:57:35 +0000
X-Mizu-Trace-ID: 5a34caa7e6fcbe0a
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: David Yang <mmyangfl@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] git diff go mad compared to diffutils
In-Reply-To: <CAAXyoMPJ1P6RCRQgPpZwZjFZJW8Y07paXJD3=8LXtD3KuVnWnQ@mail.gmail.com>
References: <CAAXyoMPJ1P6RCRQgPpZwZjFZJW8Y07paXJD3=8LXtD3KuVnWnQ@mail.gmail.com>
Date: Tue, 13 Oct 2026 07:57:29 +0200
Message-ID: <87cxtedtx2.fsf@dev.null.iotcl.com.invalid>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Yang <mmyangfl@gmail.com> writes:

> Hello Git community,
>
> I'm using git 2.53.0 on Debian testing. During preparing a new version
> for https://lore.kernel.org/all/20261001204851.2576101-3-mmyangfl@gmail.com/
> , I've noticed git generated unusual distorted patch
> https://github.com/yangfl/linux/commit/01e2de4664f60528dd9b4f15b5995fc5cb0e7b4f
> . As you may see, GitHub diff is distorted as well.
>
> With diffutils 3.12 (diff -u old new) I can get nice diff file with
> delection only, just like the v2 patch.

I think this depends on the used diff algorithm. By default git uses
'myers', this isn't really great. If you run:

   git diff --diff-algorithm=histogram \
     9142c2f8f84bf4eafe23e9d68b6ba016a60300c0 \
     01e2de4664f60528dd9b4f15b5995fc5cb0e7b4f \
     -- drivers/net/dsa/motorcomm/chip.c

The diff is cleaner.

> Should this be considered a bug?

So I don't consider this a bug. Git is just stuck at an ancient default
algorithm. 

-- 
Laters,
Toon
