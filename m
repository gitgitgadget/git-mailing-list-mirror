Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E552018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbcHEV5J (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:57:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S940127AbcHEV5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2016 17:57:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 27886322CD;
	Fri,  5 Aug 2016 17:57:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FUJ2zJlNK/jf
	UDiUe5C8C1E6FNw=; b=b1QQXsBT/hIpHNtYNgoI1Cqff9hxBYyDo2E1FokDxm18
	tr7z45jsj87z134RGn7QQ/D10bOXYM0cgypbUzmIwt3YIR30pCOrz9z+Xl161Yhu
	l4Fq7ODYp1chugng6xkORcmG80z7pjvBHzGuFZ9fJoMkQ2/3EmX/J/Je+Oa0cyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gHqTow
	jIbfillQk6eN+Yno6YM8QsZY+i0b6QY2bAXYvd/XbbrAORPSJTQIY5t9l3SwVXRg
	uiCNk0bvuRyNpgnqqjnn8yAmexPznhpUuUQ0rOswsEWERBaO7bfoFivgvHlJRd+m
	n+4ApU+06jNQXCI7TJ8D66KFugS5MFu14a3Cg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 20520322CC;
	Fri,  5 Aug 2016 17:57:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9745E322CB;
	Fri,  5 Aug 2016 17:57:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
References: <cover.1470326812.git.johannes.schindelin@gmx.de>
	<57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de>
	<57A3BA26.5080601@web.de>
	<xmqqk2fwyx8h.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608051728380.5786@virtualbox>
Date:	Fri, 05 Aug 2016 14:57:01 -0700
In-Reply-To: <alpine.DEB.2.20.1608051728380.5786@virtualbox> (Johannes
	Schindelin's message of "Fri, 5 Aug 2016 17:34:49 +0200 (CEST)")
Message-ID: <xmqqk2fuvpzm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8B27EDBA-5B57-11E6-8494-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio & René,
>
> On Thu, 4 Aug 2016, Junio C Hamano wrote:
>
>> Let's try it this way.  How about this as a replacement?
>
> I like it (with the if (s2) test intead of if (s1), of course). But please
> record René as author, maybe mentioning myself with a "Diagnosed-by:"
> line.

Hmph.  I cannot do that unilaterally without waiting for René to
respond, though.  In any case, with only header and footer changes,
here is what will appear in 'pu'.

Thanks.

-- >8 --
From: René Scharfe <l.s.r@web.de>
Date: Thu, 4 Aug 2016 23:56:54 +0200
Subject: [PATCH] nedmalloc: work around overzealous GCC 6 warning

With GCC 6, the strdup() function is declared with the "nonnull"
attribute, stating that it is not allowed to pass a NULL value as
parameter.

In nedmalloc()'s reimplementation of strdup(), Postel's Law is heeded
and NULL parameters are handled gracefully. GCC 6 complains about that
now because it thinks that NULL cannot be passed to strdup() anyway.

Because the callers in this project of strdup() must be prepared to
call any implementation of strdup() supplied by the platform, so it
is pointless to pretend that it is OK to call it with NULL.

Remove the conditional based on NULL-ness of the input; this
squelches the warning.

See https://gcc.gnu.org/gcc-6/porting_to.html for details.

Diagnosed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/nedmalloc/nedmalloc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index 677d1b2..2d4ef59 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -955,12 +955,11 @@ void **nedpindependent_comalloc(nedpool *p, size_t elems, size_t *sizes, void **
  */
 char *strdup(const char *s1)
 {
-	char *s2 = 0;
-	if (s1) {
-		size_t len = strlen(s1) + 1;
-		s2 = malloc(len);
+	size_t len = strlen(s1) + 1;
+	char *s2 = malloc(len);
+
+	if (s2)
 		memcpy(s2, s1, len);
-	}
 	return s2;
 }
 #endif
-- 
2.9.2-766-gd7972a8

