Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138AB191F92
	for <git@vger.kernel.org>; Tue, 13 May 2025 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164525; cv=none; b=obukMSmxK1I4XCx3g9Ipr0Vvj8x0QYdj8iex7k3eECuvLRnJF9O76B2GxqHxeXawvbS7dTzWKry9C30DksdMc0fY6UG5SW3Pl2lpdRoxaXZOe8eSMghNSzWlEEAgCjPTLOl8sc09KkpKMhBu3pKOApRr7qdkDZhXs9hHU9UcFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164525; c=relaxed/simple;
	bh=nAF2J4L6eHJiB42JbEE5nvIEQ8onykYe7zjnDZWUcC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ww5JrtZQ/4obOb5YjnKRT9MI55WKDF0LNSsk3HU7KgdLKZTrpM759jUtFJsQH3P1ZZxgSBQ8Jzch9AQR5ArBKd+loVecs+14UVxTTA7AnQ2yBp5RXU4RtRLSvRjzhJfL/ITNloIbsJEFhmmBcDVgOcrFKzXMfo5LNgm3UawZBLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VT2sDH40; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VT2sDH40"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1747164520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZy3J1X+NH4lfXmv/ABA/zURIEDfeAU7CgRQw9/iwno=;
	b=VT2sDH40Pq0fapfEWEZPD1I/RMLkZT/eN6iFq37QJYDzg1KKizvTFzFbIoTVvf0SPAC2+I
	cAx0/eqX5OwUSdTDuagOA46sddW5LSNswT0QpwyXtqMtppSY2uUe6fGWDzhucyONxRgr2R
	4GoWBi74NKepOzCJX01DnH7UMdUCrcw=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/17] object-store: carve out the object database
 subsystem
In-Reply-To: <aB3mMtoxCcaOFn0W@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <5bea19fe-6616-4f01-a78d-9b7da94db899@gmail.com> <aB3mMtoxCcaOFn0W@pks.im>
Date: Tue, 13 May 2025 21:28:30 +0200
Message-ID: <87a57gjoo1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> ... I have decided to rename this to `odb_alternate`. I don't think
> "shard" works well, as shard is an extremely generic term that doesn't
> really convey much meaning.
>
> On the other hand, I think that `odb_alternate` is quite a good fit. We
> already use it all over the place to mean almost exactly what we are
> after here. And it doesn't seem far-fetched to have an
> `odb_packed_alternate`, `odb_loose_alternate` and `odb_redis_alternate`
> for different backends.

So a database is a collection of alternates? And the alternates are
stored as a linked list?

> The only stretch is that the primary object directory is now the primary
> alternate. I think that this is acceptable though'

This is a very important nuance, and with that knowledge it starts to
click with me. I didn't read this in the commit messages though, so I
think it's worth adding something about that in [PATCH 02/17].

-- 
Toon
