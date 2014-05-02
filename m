From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Detect endianness on more platforms that don't use BYTE_ORDER
Date: Fri, 02 May 2014 12:43:32 -0700
Message-ID: <xmqq38gsarvf.fsf@gitster.dls.corp.google.com>
References: <20140502074917.GA25198@hashpling.org>
	<1399017329-25645-1-git-send-email-cbailey32@bloomberg.net>
	<xmqqwqe4azyd.fsf@gitster.dls.corp.google.com>
	<20140502165830.GA29339@hashpling.org>
	<xmqq7g64asae.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <cbailey32@bloomberg.net>
X-From: git-owner@vger.kernel.org Fri May 02 21:43:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgJN0-0002dE-8g
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbaEBTni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 15:43:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53497 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485AbaEBTnh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 15:43:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD33A126B7;
	Fri,  2 May 2014 15:43:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fFsL9jtJgmNTDKco5obxLX/R+MQ=; b=YQlkvt
	UyEzeNniXTOp+k5kUIEFwWEYY4bOU4pgdNu3oSUnzDMWUkm5Pcm5L4zOvurrcntz
	mjtR+iSNV2cXR2YHv5QnNzOPG4/akinYq5kb6BqpFV92ijE8YvZB3cZ2eomRJ9Xd
	8DgAAN1s8oZu/9NouyKA8suyYId5Tpc7eTzQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QUueQbPrW3n3ycHSoPzaWdHljUBIZKRF
	2NJX84uTCtzeFqDVkM7a4rb9NzADcdv04ZIKJoD6/28h6UWxs/ynCzR3oQXiBFNu
	9UZkys8krQjOh0ldwo5DKaI9siTpzMOrN+3wZeu/z/g61zEvFd/fmG3ccbw0Kum1
	UjzkKiOymuw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9FD1F126B6;
	Fri,  2 May 2014 15:43:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 36884126B5;
	Fri,  2 May 2014 15:43:34 -0400 (EDT)
In-Reply-To: <xmqq7g64asae.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 02 May 2014 12:34:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0BF9D02C-D232-11E3-9F8E-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247962>

Junio C Hamano <gitster@pobox.com> writes:

> Charles Bailey <cbailey32@bloomberg.net> writes:
>
>> I claim that any
>> platform which provides both but with differing senses is somewhat
>> broken so I cannot see the precedence mattering much.
>
> I agree with that, and that is the reason why we shouldn't change
> the order all of a sudden.  If it shouldn't matter, then there is
> only downside of a possiblity to break such an insane set-up that
> has been happily working by accident, without helping anybody if we
> change it, no?

So,... I am inclined to queue this on top of your patch at least for
now, before I go into incommunicado-mode to finish preparing -rc2.

-- >8 --
Subject: [PATCH] compat/bswap.h: restore preference __BIG_ENDIAN over BIG_ENDIAN

The previous commit swaps the order we check the macros defined by
the compiler and the system headers from the original.  Since the
order of check should not matter (i.e. it is insane to define both
__BIG_ENDIAN and friends and BIG_ENDIAN and friends and in a
conflicting way), it is the most conservative thing to do not to
change it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/bswap.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index f08a9fe..c4293db 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -101,18 +101,18 @@ static inline uint64_t git_bswap64(uint64_t x)
 #undef ntohll
 #undef htonll
 
-#if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
-
-# define GIT_BYTE_ORDER BYTE_ORDER
-# define GIT_LITTLE_ENDIAN LITTLE_ENDIAN
-# define GIT_BIG_ENDIAN BIG_ENDIAN
-
-#elif defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && defined(__BIG_ENDIAN)
+#if defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && defined(__BIG_ENDIAN)
 
 # define GIT_BYTE_ORDER __BYTE_ORDER
 # define GIT_LITTLE_ENDIAN __LITTLE_ENDIAN
 # define GIT_BIG_ENDIAN __BIG_ENDIAN
 
+#elif defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
+
+# define GIT_BYTE_ORDER BYTE_ORDER
+# define GIT_LITTLE_ENDIAN LITTLE_ENDIAN
+# define GIT_BIG_ENDIAN BIG_ENDIAN
+
 #else
 
 # define GIT_BIG_ENDIAN 4321
-- 
2.0.0-rc1-355-gd6d6511
