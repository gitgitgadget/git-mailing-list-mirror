Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857F28376
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654226; cv=none; b=CUEbBZ2cG9HY96u5uWK762jXSvbAGy1QHqL6+88B4w1mI/cBXf/2djyWcF0j+GHvbuBc0EFFXkKlwHeGTJJ49u/b54WeHPYo3TqHsDQ0k+czf+H/U403jmSPxl85+aSf1mXaFXrhNoA2P3hT37Bk8QTUODsnAvk1v61kv1T9ONE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654226; c=relaxed/simple;
	bh=Gjt8M+VZp9joUvjesQ4Iibtw59q6O27xQw6H8dXwzQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhkVW3y94s6RLqQRaxrl8G/uYYEsgA63B+PEVCCAr1Ot+5vWdQjGh6Ad0olUk01SzgC01SQXXoE9gI+/jzm+heiHiLqxXr9/01cXQ0UW1ylzh6UfrxLwX+4yr3UTLWs2OLI8wqSTw/LujBz7ESIUhxkKj3aHsMAD34VJ7wzO4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=w/O1qh18; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w/O1qh18"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EA1AB2A613;
	Thu,  6 Jun 2024 02:10:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Gjt8M+VZp9joUvjesQ4Iibtw59q6O27xQw6H8d
	XwzQw=; b=w/O1qh1848LNVbPjkKhb1NObzop/5DYwqAIs4FD9B1UZrTFyFy30Za
	h1pFi74kKIkO5leeJV3S41W2nMPrdCIEvX7LWaL7BrfL8BUiwGsO/pC1Sku4Pewx
	mtfwypU8KBXvB5sn8+e2Dt4dH0EkPirQvTD8oXmpx7DoOILzhlCTs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E35482A612;
	Thu,  6 Jun 2024 02:10:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0F78E2A611;
	Thu,  6 Jun 2024 02:10:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 12/27] object-file: mark cached object buffers as const
In-Reply-To: <xmqqr0dapq1s.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	05 Jun 2024 23:02:07 -0700")
References: <cover.1716983704.git.ps@pks.im> <cover.1717504517.git.ps@pks.im>
	<ecca8e973df77cfc8233ab63bf7d1f6fa83031a3.1717504517.git.ps@pks.im>
	<xmqqr0dapq1s.fsf@gitster.g>
Date: Wed, 05 Jun 2024 23:10:20 -0700
Message-ID: <xmqqmsnyppo3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 750B7976-23CB-11EF-8C9A-8F8B087618E4-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +	co_buf = xmalloc(len);
>> +	memcpy(co_buf, buf, len);
>>  
>>  	hash_object_file(the_hash_algo, buf, len, type, oid);
>>  	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
>
> There is an early return around here.  Perhaps we are leaking co_buf
> when we hit it?

Indeed, that seems to be the case.  With the attached at the tip of
the branch and rebuilding 'seen' seems to pass these 6130, 7010, 8002
tests with SANTIZE=leak.

From f307bbf7bd317d90db29bd1589b49e84b9e37e88 Mon Sep 17 00:00:00 2001
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 5 Jun 2024 23:03:34 -0700
Subject: [PATCH] fixup! object-file: mark cached object buffers as const

---
 object-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index b5b5a59dc6..2d5bd3a211 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1785,8 +1785,10 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 
 	hash_object_file(the_hash_algo, buf, len, type, oid);
 	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
-	    find_cached_object(oid))
+	    find_cached_object(oid)) {
+		free(co_buf);
 		return 0;
+	}
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
 	co = &cached_objects[cached_object_nr++];
 	co->size = len;
-- 
2.45.2-409-g7b0defb391

