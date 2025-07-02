Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C53B276056
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461237; cv=none; b=eoDjpZTg2p2tGD/TCFJM4lPmurpNH/Bi+3zyYfurjXLOM2tzc32e8f9pdHVVt3oaiNX9V912D33Xn5wRQgiXRMqPZtFLX1ZdprnzfENQJtQp2oTzl+uYnClLifrAzd9ziuuW/K3FT0DWEDzKkcM7iHETKazs8JZB9bYe8+K7uJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461237; c=relaxed/simple;
	bh=uBqR5lMzp0nKXOwxOtTA2p75C8fygn/42GvrlqRkgeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uRVK0JsW7jB2shJa/uHiOhhhKqU7o5qyVOtwCYZ26n24xfGkgoBAvxZXI4azlFRdPeA8/R2itFNJcrXga5T1baaSQTMMX4aInO4CRDgIaMuEZGBkXaR7R5ZXug2ISV8Hx2j4bGqeSOxVxoRm+U1W/FCsHiW3LfZ+wiVO1COYok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=qJkH22I3; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="qJkH22I3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1751461230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zykLEGOe6dEKdpiLBf/gazqWvtQ4rF88Qbzm4xBbJKg=;
	b=qJkH22I3ckp/VIYIv2/8/pRqdaA98WKaYxTfbx41Z07IJyWLqApgpoblssmbPZAN8L7WYl
	2BBpcy/rM/v1A0Ve91qc/EzAveKAm1sLFRzW1sYjFluayfIBgY51Nhxz+yGDfhPegs/gnN
	BKsuACO4xNBJyKvJY/yLcRd/Bdouqbw=
From: Toon Claes <toon@iotcl.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano
 <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Taylor Blau
 <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v2 0/5] Introduce git-last-modified(1) command
In-Reply-To: <d93c9199-80b1-4834-bfbb-8263a80d90d5@app.fastmail.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
 <f0c508cc-5c6b-4c4b-a3f3-0cdd8d1071e5@app.fastmail.com>
 <xmqq5xgbk4d2.fsf@gitster.g>
 <d93c9199-80b1-4834-bfbb-8263a80d90d5@app.fastmail.com>
Date: Wed, 02 Jul 2025 15:00:20 +0200
Message-ID: <8734berbmj.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

>> I do not see anything unexpected.  Have you seen "git ls-tree"
>> output without -r(ecursive) before?
>>
>>     $ git ls-tree HEAD refs.c refs.h Documentation
>>     040000 tree a0f7113f63a19b70dff14bfd9f8f82809f5068e1	Documentation
>>     100644 blob dce5c49ca2ba65fd6a2974e38f67134215bee369	refs.c
>>     100644 blob 46a6008e07f2624239139cd8b2ff712545f07d3f	refs.h

You raise a good point here. Let's compare:

$ git ls-tree HEAD -- refs.c refs.h Documentation/git-last-modified.adoc Documentation/git-config.adoc
100644 blob 936e0c5130fe7d67f645501fbb9e70b94b437f54	Documentation/git-config.adoc
100644 blob 1af38f402ed6437353fb5765f62251966d828df9	Documentation/git-last-modified.adoc
100644 blob dce5c49ca2ba65fd6a2974e38f67134215bee369	refs.c
100644 blob 46a6008e07f2624239139cd8b2ff712545f07d3f	refs.h

$ git last-modified HEAD -- refs.c refs.h Documentation/git-last-modified.adoc Documentation/git-config.adoc
56073a0af90be947cfefbfc3cf762b268e5e20a9	Documentation
062b914c841329a003f74e1340ea5178391274a6	refs.c
47478802daddf3f9916111307f153c6298ffc0bc	refs.h

I have to agree with Kristoffer here, and the latter is not what I
would expect. Thanks for the testing! I will try to address in next
version.

-- 
Cheers,
Toon
