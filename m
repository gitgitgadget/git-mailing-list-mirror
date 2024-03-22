Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8324C601
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120532; cv=none; b=hgu0FlhQcMCb2zSVXI0DRp/WF7OqhZ15W+lv9n4C0kq16LqSd19mxy9SiZrJOHEhtIQQzHjd/Bzt7THtTnwVHs1rGLdgOqgSMPoIzW/t2qFY6mTMxwVhBAery4rwiX30A2dEXx4CMLIFAdc33qpEMr259jIJpxzZmaIBM/YNb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120532; c=relaxed/simple;
	bh=JGUDGPE4hhNxmN7jBYQ45M/WYMEsQIE2W1GGmTd3Cjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HIY8pIz5s+kCF6RWkUoMVQSKhHZzKvN4LNvgXMfQG4bRphcuJFTmbVeSjrQDd24NwYdhEy+h1eHvYx6kcbkkoq15ZnEpLIUKv+XybtAm9pcIhcXHSjE6C1VPT92i3UIYnBxGn0LxWCR3V53ED7G1kjvlBnK65VlW61lMXi5tIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=sKaRPkDZ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="sKaRPkDZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1711120527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JGUDGPE4hhNxmN7jBYQ45M/WYMEsQIE2W1GGmTd3Cjs=;
	b=sKaRPkDZZugChjK5bhNpnoL/K9FPUDwgH9lCPbKRuCnSZHnGqjzmJ86rlipuotFbRaMpan
	ZRNKpnF6OEorS/FlaJMaI9DNl6uZX30BzPQcNHg8keD3TiAsLvIk8rW+VWvpV7jPcyzVpk
	i0HdeabbIQAiToktYwlIsy6tic+49uY=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, rsbecker@nexbridge.com, Jeff King
 <peff@peff.net>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] reftable: fix tests being broken by NFS'
 delete-after-close semantics
In-Reply-To: <8ac5e94a3930cdd2aee9ea86acda3155674b635c.1711035529.git.ps@pks.im>
References: <ZfBwZTL9zqDsac5m@manet.1015granger.net>
 <8ac5e94a3930cdd2aee9ea86acda3155674b635c.1711035529.git.ps@pks.im>
Date: Fri, 22 Mar 2024 16:15:12 +0100
Message-ID: <87frwiuwlb.fsf@to1.studio>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Fix this bug by skipping over any files that start with a leading dot
> when counting files. While we could explicitly check for a prefix of
> ".nfs", other network file systems like SMB for example do the same
> trickery but with a ".smb" prefix. In any case though, this loosening of
> the assertion should be fine given that the reftable library would never
> write files with leading dots by itself.

I'm fully supportive of this, as this will also fix any issues possibly
caused by .DS_Store files created by Finder on macOS, although it's very
unlikely they will be created in these tests.

--
Toon
