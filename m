From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Makefile: Fix APPLE_COMMON_CRYPTO with BLK_SHA1
Date: Mon, 05 Aug 2013 10:52:54 -0700
Message-ID: <7v4nb4kosp.fsf@alter.siamese.dyndns.org>
References: <1375718364-13824-1-git-send-email-brian@gernhardtsoftware.com>
	<1375718364-13824-2-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jeremy Huddleston <jeremyhu@apple.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 19:53:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Oxv-0000Ap-Rd
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 19:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab3HERxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 13:53:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459Ab3HERw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 13:52:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CF33361C7;
	Mon,  5 Aug 2013 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K49kgNPL8suliP6wy4tLBc4B//4=; b=N1j5/T
	mscNDZLP94DgN8AJ+K6efUIlBf4m3GPppNqpHRVRawGPdI8GZPFurWV3TB74IlmX
	wbqI6ffM5wxF+3v0jajXa5dJYyqT9/b2h/gRKKKDwsqJAzdiKY3yx1TXtaJiS6Ky
	MlTTjeys/3YzMsWoto5EABNBILXhke+KDngS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I4Fwxuz08yJkTSs/zdi6wz23oEFtModc
	Xwathc6ktsqe4p6K2Xq/ttxk+GjsQF2HpWYSr2rw2X2naj9CUoMucyLU9SholOqr
	ANVELry9hyk4SCKCluaAL7yV51gosDDrPyRBe7mVwYF6VsSsp+dZ+C3Rp0l3dT1H
	QZ6uqUQSRuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5162361C4;
	Mon,  5 Aug 2013 17:52:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01F97361BF;
	Mon,  5 Aug 2013 17:52:55 +0000 (UTC)
In-Reply-To: <1375718364-13824-2-git-send-email-brian@gernhardtsoftware.com>
	(Brian Gernhardt's message of "Mon, 5 Aug 2013 11:59:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBC26194-FDF7-11E2-B49E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231683>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> It used to be that APPLE_COMMON_CRYPTO did nothing when BLK_SHA1 was
> set.  But APPLE_COMMON_CRYPTO is now used for more than just SHA1 (see
> 3ef2bca) so make sure that the appropriate libraries are always set.
>
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>  Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 82f2e22..7051956 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1182,6 +1182,9 @@ ifdef NEEDS_SSL_WITH_CRYPTO
>  else
>  	LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto
>  endif
> +ifdef APPLE_COMMON_CRYPTO
> +	LIB_4_CRYPTO += -framework Security -framework CoreFoundation
> +endif
>  endif
>  ifdef NEEDS_LIBICONV
>  	ifdef ICONVDIR
> @@ -1413,7 +1416,6 @@ ifdef PPC_SHA1
>  	LIB_H += ppc/sha1.h
>  else
>  ifdef APPLE_COMMON_CRYPTO
> -	LIB_4_CRYPTO += -framework Security -framework CoreFoundation
>  	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
>  	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
>  else

Hmph.

So the people previously tested this must have built imap-send
without blk-sha1, which not just linked with these libs but also
included the <CommonCrypto/CommonDigest.h> header file and defined
the -DCOMMON_DIGEST_FOR_OPENSSL preprocessor macro.  Building with
blk-sha1 would not have worked for them.

Now we always link with these libraries, even when building with
blk-sha1.  Do the COMPAT_CFLAGS and SHA1_HEADER pieces only needed
when using the SHA1 digest implementation from CommonCrypto and
nothing imap-send uses?
