Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953554723
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 05:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094244; cv=none; b=EF9dexXIxYMEzYgEYwHQzsYWGsO3Skd6/wqrqyM+VqmFp7p7s4Gr1YqG8buAvon0wtkAKdbbz9jlN7d1csg2v3NYq+yciih1wo85fiXykFiAP2zd6H7PSYA/Kavmyd8aAhBiI4C1gl69Buxm7c5WRgar3rg6/hFBo2QvD4pfMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094244; c=relaxed/simple;
	bh=4AxDOd8kK3DzpAogrmA7Ud9gaoq/GnRdYtva4tK30JE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XQB3cyz5brpaRr+ZFCGhI+TyPjM25BHBhSdCwU40g7NExlqxQAurmVxNfGrbArJ9xq7V6Focu9sy/6xdaYkm8hDtpF8crtVOXMNLqtmj+0qo/esDL2UK1+X7LqgkUu1Ui1meAoFt+IfELfMO/GpVvf9G0eF/OzClXlJaTGNhQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=DtWC9R7t; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="DtWC9R7t"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784094240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHSyLRlPzAMswwtm7OjVW6Ub6woUqAvdKrzAkT1QaC0=;
	b=DtWC9R7tXVAdL/9TKQxrWfxDQpnMLt6FpXh8M72atNzQ2pyYNg9zfkSQ5qRQhFs8Gziet3
	1W0sQ6y8k3fchucmDZkDSFEtBLEZaKLxgkqfbHcVzjZWmLOfswr1GhJt+oriql3csyYQNk
	vE2H0M2CcAoaU+mdVx5r8gS/8t0ANXw=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/9] odb: introduce object filters to
 `odb_for_each_object()`
In-Reply-To: <alXKzb-GHodV6uGj@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
 <alW0KzSZuZnHmOZD@com-79390> <alXKzb-GHodV6uGj@pks.im>
Date: Wed, 15 Jul 2026 07:43:56 +0200
Message-ID: <87wluwlsdf.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jul 13, 2026 at 08:59:39PM -0700, Taylor Blau wrote:
>> On Mon, Jul 13, 2026 at 04:41:24PM +0200, Patrick Steinhardt wrote:
>> > Range-diff versus v2:
>> >
>> >  1:  baf2adb012 =  1:  7c0dc1be0d odb/source-packed: improve lookup when enumerating objects
>> >  2:  57eecf3031 =  2:  2e5908c9c3 pack-bitmap: mark object filter as `const`
>> >  -:  ---------- >  3:  f4d66ccfc6 pack-objects: drop unused return value from add_object_entry()
>> >  3:  92dd6a6f6e =  4:  af475654b8 pack-bitmap: allow aborting iteration of bitmapped objects
>> >  4:  92fe41577d =  5:  6ca42587c9 pack-bitmap: iterate object sources when opening bitmaps
>> >  5:  e5d59959e3 =  6:  f62c3bbc81 pack-bitmap: drop `_1` suffix from functions that open bitmaps
>> >  6:  ab3547ac2b =  7:  b2d25b6e9b pack-bitmap: introduce function to open bitmap for a single source
>> >  7:  026f21f522 =  8:  a5bf309bec odb: introduce object filters to `odb_for_each_object()`
>> >  8:  534b25c817 =  9:  600b15a907 builtin/cat-file: filter objects via object database
>> 
>> Thanks, this version looks good to me.

I only posted a nit about function name in the commit messages 7 & 8
isn't correct, but other than that I'm happy with these patches too.

-- 
Cheers,
Toon
