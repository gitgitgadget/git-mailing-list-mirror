Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1604F208
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574542; cv=none; b=tQuioZMkhnIqnoBZPN4PkMEng8CxwY06An74I7z+X6g0MrWIhPKMEbsAXyOHqR12kL9FBzLuMksXLqdlNhFnVDZq5JPRtozYQbamLeAtSTvqIz1QuyvX7Pti28sg0JP1cBsP9DD3j41h8gzml0Em5vmKjjZfHrCn0xh+OYKI/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574542; c=relaxed/simple;
	bh=3kqNrdO9wrPAD8Js6kyNwb+gV/0PPSGHPOS2DdNHYL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RMKyaj62Rbw9WCRFYDdXaIhdoOhb4YlegnzsspsLsnwLLv2RnYGYoTw8PylzPFX24YWS2nsl/ol5joaiqdc3Q8Alr+NNIXblMQv1OBKz7MfLs+5pcijyBfgpFs+SCKu+SsN+PPQjDHNevDJy70a+CkWaImdx56IrxIoVwLU7Nig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bpPqKota; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bpPqKota"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 11A581E410F;
	Wed, 27 Mar 2024 17:22:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3kqNrdO9wrPAD8Js6kyNwb+gV/0PPSGHPOS2Dd
	NHYL0=; b=bpPqKotaikJeb3Qg56vcJdaTCxfMZm6shlvyiaNuER9SM6khkkiqvT
	wtDdWly1OBb2uGwU8tRUuHexjsRGTQYzZ2xTC4yYxPjtETw6WsqQvao5n8iEZqBL
	58ofZy7DbtZr4IPDqoyJzSryE7NNG3CkVakeZQqBnamQWYqxb9vJ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09A291E410E;
	Wed, 27 Mar 2024 17:22:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 699941E410D;
	Wed, 27 Mar 2024 17:22:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Matthew John Cheetham <mjcheetham@outlook.com>,  M Hickford
 <mirth.hickford@gmail.com>
Subject: Re: [PATCH 12/13] strvec: implement swapping two strvecs
In-Reply-To: <ZgPSpYVSSmQ9Muec@tanuki> (Patrick Steinhardt's message of "Wed,
	27 Mar 2024 09:02:45 +0100")
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
	<20240324011301.1553072-13-sandals@crustytoothpaste.net>
	<ZgPSpYVSSmQ9Muec@tanuki>
Date: Wed, 27 Mar 2024 14:22:17 -0700
Message-ID: <xmqqbk6z1iba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1736B0F4-EC80-11EE-8CB3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +
>> +void strvec_swap(struct strvec *a, struct strvec *b)
>> +{
>> +	struct strvec t = *a;
>> +	*a = *b;
>> +	*b = t;
>> +}
>
> Isn't this equivalent to `SWAP(*a, *b)`?

Yes.  "make coccicheck" does flag this one.

Let's drop this step, and tweak the 13/13 patch to make its sole
caller directly use SWAP() instead, perhaps like so:

 credential.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/credential.c w/credential.c
index 9a08efe113..5ea52ddd68 100644
--- c/credential.c
+++ w/credential.c
@@ -39,7 +39,7 @@ void credential_clear(struct credential *c)
 void credential_next_state(struct credential *c)
 {
 	strvec_clear(&c->state_headers_to_send);
-	strvec_swap(&c->state_headers, &c->state_headers_to_send);
+	SWAP(c->state_headers, c->state_headers_to_send);
 }
 
 void credential_clear_secrets(struct credential *c)


