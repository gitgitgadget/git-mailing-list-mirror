From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fsck failure on OS X with files >= 4 GiB
Date: Thu, 29 Oct 2015 10:19:14 -0700
Message-ID: <xmqqlhalsict.fsf@gitster.mtv.corp.google.com>
References: <CAG3jReJn2Pz6-bXLw6baOZaE1BHYiC+1-zN0eagigfG3umWpJA@mail.gmail.com>
	<CAEDE8505fXAwVXx=EZwxPHvXpMByzpnXJ9LBgfx3U6VUaFbPHw@mail.gmail.com>
	<CAG3jRe+23sy1k9QNdpdn3GF3nbzPMmYO=TM=SufEq83OtwNxbA@mail.gmail.com>
	<CAEDE853n2HR-SK9_sGn8n3j0xoTb3eQa86UvdW0DBrc+Z1sDrg@mail.gmail.com>
	<CA+izobtdwszVrYsnKU=_ytLuNbPGyRe_7kXqyrQO7u5Lo+OdPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Rafael =?utf-8?Q?Esp=C3=ADndola?= <rafael.espindola@gmail.com>,
	Filipe Cabecinhas <filcab@gmail.com>
To: Atousa Duprat <atousa.p@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 18:19:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrqrC-0003Pe-Br
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 18:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759AbbJ2RTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 13:19:18 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751390AbbJ2RTR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 13:19:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2122B22E3C;
	Thu, 29 Oct 2015 13:19:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RJg2Na71YgSqFQbcKR39sX5S2SY=; b=p1Sf8W
	N2CLvubbX0iFVxy/70C0+tBxnt4I5DzV66m4UvQ8L/kehcE/Ji4KhBxWBT5D/d33
	WOyYS7Ys5kUuNi7lk+270uP0AQfbEGyz0zMBUN44p5JfmGF5PmVRImi5Lx3e0YNb
	qqGpE7Qk3wfk16jzs7QXqpg2zSahl/Q3hUUi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R2I3YkEU1NuH5+Hp4yThdoWRVXUFDREj
	PzTltX81ttZ11TPyeRal/AHnaDXNOu8rY78aNfsVItxODyyquYyJ+2EdEKS4JXT/
	T8f8zkZ9JMnTTgWjg4YAdTASqmcBNl4OIx79KWgwfMH0b6MwSrY0GdokJJS5kVZ3
	IotHdfyEkc8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19EBA22E3A;
	Thu, 29 Oct 2015 13:19:16 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 90E7022E38;
	Thu, 29 Oct 2015 13:19:15 -0400 (EDT)
In-Reply-To: <CA+izobtdwszVrYsnKU=_ytLuNbPGyRe_7kXqyrQO7u5Lo+OdPg@mail.gmail.com>
	(Atousa Duprat's message of "Thu, 29 Oct 2015 09:02:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E293AF2-7E61-11E5-8C8B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280446>

Atousa Duprat <atousa.p@gmail.com> writes:

> [PATCH] Limit the size of the data block passed to SHA1_Update()
>
> This avoids issues where OS-specific implementations use
> a 32-bit integer to specify block size.  Limit currently
> set to 1GiB.
> ---
>  cache.h | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/cache.h b/cache.h
> index 79066e5..c305985 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -14,10 +14,28 @@
>  #ifndef git_SHA_CTX
>  #define git_SHA_CTX SHA_CTX
>  #define git_SHA1_Init SHA1_Init
> -#define git_SHA1_Update SHA1_Update
>  #define git_SHA1_Final SHA1_Final
>  #endif
>
> +#define SHA1_MAX_BLOCK_SIZE (1024*1024*1024)
> +
> +static inline int git_SHA1_Update(SHA_CTX *c, const void *data, size_t len)
> +{
> + size_t nr;
> + size_t total = 0;
> + char *cdata = (char*)data;
> + while(len > 0) {
> + nr = len;
> + if(nr > SHA1_MAX_BLOCK_SIZE)
> + nr = SHA1_MAX_BLOCK_SIZE;
> + SHA1_Update(c, cdata, nr);
> + total += nr;
> + cdata += nr;
> + len -= nr;
> + }
> + return total;
> +}
> +

I think the idea illustrated above is a good start, but there are
a few issues:

 * SHA1_Update() is used in fairly many places; it is unclear if it
   is a good idea to inline.

 * There is no need to punish implementations with working
   SHA1_Update by another level of wrapping.

 * What would you do when you find an implementation for which 1G is
   still too big?

Perhaps something like this in the header

#ifdef SHA1_MAX_BLOCK_SIZE
extern int SHA1_Update_Chunked(SHA_CTX *, const void *, size_t);
#define git_SHA1_Update SHA1_Update_Chunked
#endif

with compat/sha1_chunked.c that has

#ifdef SHA1_MAX_BLOCK_SIZE
int SHA1_Update_Chunked(SHA_CTX *c, const void *data, size_t len)
{
	... your looping implementation ...
}
#endif

in it, that is only triggered via a Makefile macro, e.g. 
might be a good workaround.

diff --git a/Makefile b/Makefile
index 8466333..83348b8 100644
--- a/Makefile
+++ b/Makefile
@@ -139,6 +139,10 @@ all::
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
+# Define SHA1_MAX_BLOCK_SIZE if your SSH1_Update() implementation can
+# hash only a limited amount of data in one call (e.g. APPLE_COMMON_CRYPTO
+# may want 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined).
+#
 # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
@@ -1002,6 +1006,7 @@ ifeq ($(uname_S),Darwin)
 	ifndef NO_APPLE_COMMON_CRYPTO
 		APPLE_COMMON_CRYPTO = YesPlease
 		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
+		SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L
 	endif
 	NO_REGEX = YesPlease
 	PTHREAD_LIBS =
@@ -1350,6 +1355,11 @@ endif
 endif
 endif
 
+ifdef SHA1_MAX_BLOCK_SIZE
+LIB_OBJS += compat/sha1_chunked.o
+BASIC_CFLAGS += SHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
+endif
+
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
