Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612CCC13C
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721671010; cv=none; b=kvuC1c4Ov2yAmUqNods/aePAsZOPTE0hmo+xVrG7ft7mtaAV6URHycj+2YlS6AuXFb62pGFW5feGwaUfcuAoquaZGuarj9PDNpNrZnOZrb4Ii43Q5Bl45rtJAHC/ZSYUW3FThAbS/EvMhC/FcYEocFc+LVVbkja6APdbToIyBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721671010; c=relaxed/simple;
	bh=17lS9X+cGUjW3OlnGikkoK8KBNAhcYgFSwOizTZSEZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nijc4kyUH0UsqW8fLP1+HVE6wl9SmnWrTTGHRDs74XyR0DR5TdQ0NlKQwV1xJr53GcaXYeUdeqR739b2ARXdbwBgopfEj2KJEEfePg2u+IVt+hgeqwts+mK8Vu+M7jxn4S4/vDWm7BQjkYcR/lCJqDz+6KFTLvigHMkTKbU0Kks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HpC4mb8I; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HpC4mb8I"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D47013B6D4;
	Mon, 22 Jul 2024 13:56:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=17lS9X+cGUjW3OlnGikkoK8KBNAhcYgFSwOizT
	ZSEZk=; b=HpC4mb8IFLRYNU3A8qiyapDUZ1l1XJTTsWwe+39JkyF+dmLAyBOjyV
	7yKDQfmWY5Gp1XU4TPWxjrxRf8JRqSoaK3w4Oo9OSbbKeUpCrSZtGmTDhMZoqDaC
	3byeMByuWoKJpoAv5EQhGq7OLk4VQlVOAHgOBy36+yjsB95DuDfq4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BF1AE3B6D3;
	Mon, 22 Jul 2024 13:56:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E7EF3B6D2;
	Mon, 22 Jul 2024 13:56:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  karthik188@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH v5 2/5] t: move reftable/tree_test.c to the unit testing
 framework
In-Reply-To: <xmqqcyn5co04.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	22 Jul 2024 10:52:59 -0700")
References: <20240716075641.4264-1-chandrapratap3519@gmail.com>
	<20240722061836.4176-1-chandrapratap3519@gmail.com>
	<20240722061836.4176-3-chandrapratap3519@gmail.com>
	<xmqqcyn5co04.fsf@gitster.g>
Date: Mon, 22 Jul 2024 10:56:37 -0700
Message-ID: <xmqq8qxtcnu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BED211C6-4853-11EF-ADCB-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
>> +	/* pseudo-randomly insert the pointers for elements between
>> +	 * values[1] and values[10] (included) in the tree.
>> +	 */
>
> Style?

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index d7d530f2f7..e7d774d774 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -32,8 +32,9 @@ static void t_tree_search(void)
 	struct tree_node *nodes[11] = { 0 };
 	size_t i = 1;
 
-	/* pseudo-randomly insert the pointers for elements between
-	 * values[1] and values[10] (included) in the tree.
+	/*
+	 * Pseudo-randomly insert the pointers for elements between
+	 * values[1] and values[10] (inclusive) in the tree.
 	 */
 	do {
 		nodes[i] = tree_search(&values[i], &root, &t_compare, 1);
-- 
2.46.0-rc1-48-g0900f1888e

