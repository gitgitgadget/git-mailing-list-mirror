Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE599A3D
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NXUm985c"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8574212
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 16:20:10 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B7E0C2B0CE;
	Fri, 10 Nov 2023 19:20:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2Urk3QdtTbGlICqRi+yGdJZsOGZofKOiOd7Zif
	zAP4Q=; b=NXUm985cghrOWqjfnfM1Ic3pctBYDCRTdl8IOekVXVTb9H8H256xLu
	ic6RC/qR8YCzYevLZzmZq7ck1NYjfjRAIPxSEfMPOs0o13WG1Fy36I6Oa7WEz/av
	tW1ThdjoDkHUwviT4ZxS7MacujH8cNw7w5CjOckLzXuK8NJX5p22Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B09432B0CD;
	Fri, 10 Nov 2023 19:20:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3F9CE2B0C4;
	Fri, 10 Nov 2023 19:20:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] global: convert trivial usages of `test <expr>
 -a/-o <expr>`
In-Reply-To: <xmqq34xdtac3.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	11 Nov 2023 09:14:36 +0900")
References: <cover.1699526999.git.ps@pks.im> <cover.1699609940.git.ps@pks.im>
	<2967c8ebb460934eb4aaaaebe5941bff643d4a94.1699609940.git.ps@pks.im>
	<20231110214423.GC2758295@coredump.intra.peff.net>
	<xmqq34xdtac3.fsf@gitster.g>
Date: Sat, 11 Nov 2023 09:20:04 +0900
Message-ID: <xmqqr0kxrvij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 10BA461A-8028-11EE-AAB3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I am not so surprised that this one was missed, though.  I didn't
> point this one out during my review of the previous round, either,
> and not everybody is as careful as you are.

Ah, sorry, thist came out in a way I did not mean to.

I didn't mean "I did not point it out explicitly.  It is not
surprising if a contributor who was not careful did not find it on
their own and took initiative to fix it themselves".

I meant "I failed to spot it myself hence I didn't point it out in
my review---I was not being so careful to aim for thoroughly cover
and find all the similar issues".

In any case, I'll tweak it while queueing.  Thanks for noticing.

diff --git i/t/valgrind/valgrind.sh w/t/valgrind/valgrind.sh
index 9fbf90cee7..3c8ee19975 100755
--- i/t/valgrind/valgrind.sh
+++ w/t/valgrind/valgrind.sh
@@ -23,7 +23,7 @@ memcheck)
 	VALGRIND_MAJOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*\([0-9]*\)')
 	VALGRIND_MINOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*[0-9]*\.\([0-9]*\)')
 	test 3 -gt "$VALGRIND_MAJOR" ||
-	( test 3 -eq "$VALGRIND_MAJOR" && test 4 -gt "$VALGRIND_MINOR" ) ||
+	{ test 3 -eq "$VALGRIND_MAJOR" && test 4 -gt "$VALGRIND_MINOR"; } ||
 	TOOL_OPTIONS="$TOOL_OPTIONS --track-origins=yes"
 	;;
 *)
