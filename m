From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] compat/bswap.h: Detect endianness from XL C compiler
 macros
Date: Sun, 26 Oct 2014 11:38:16 -0700
Message-ID: <20141026183815.GB18144@peff.net>
References: <87k33mag65.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 19:38:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiShs-0001Tk-Py
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 19:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbaJZSiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 14:38:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:33777 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751518AbaJZSiT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 14:38:19 -0400
Received: (qmail 6476 invoked by uid 102); 26 Oct 2014 18:38:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Oct 2014 13:38:19 -0500
Received: (qmail 31253 invoked by uid 107); 26 Oct 2014 18:38:22 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Oct 2014 14:38:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2014 11:38:16 -0700
Content-Disposition: inline
In-Reply-To: <87k33mag65.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 26, 2014 at 01:34:26PM -0400, David Michael wrote:

> diff --git a/compat/bswap.h b/compat/bswap.h
> index f6fd9a6..7fed637 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -122,6 +122,10 @@ static inline uint64_t git_bswap64(uint64_t x)
>  #  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
>  # elif defined(_LITTLE_ENDIAN) && !defined(_BIG_ENDIAN)
>  #  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
> +# elif defined(__THW_BIG_ENDIAN__) && !defined(__THW_LITTLE_ENDIAN__)
> +#  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
> +# elif defined(__THW_LITTLE_ENDIAN__) && !defined(__THW_BIG_ENDIAN__)
> +#  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN

Out of curiosity, is there ever a case where _both_ are defined? That
is, would:

diff --git a/compat/bswap.h b/compat/bswap.h
index f6fd9a6..b78a0bd 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -122,6 +122,10 @@ static inline uint64_t git_bswap64(uint64_t x)
 #  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
 # elif defined(_LITTLE_ENDIAN) && !defined(_BIG_ENDIAN)
 #  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
+# elif defined(__THW_BIG_ENDIAN__)
+#  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
+# elif defined(__THW_LITTLE_ENDIAN__)
+#  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
 # else
 #  error "Cannot determine endianness"
 # endif

be enough, or is that used to mark some other special case? Even if not,
there is not much downside to the more thorough conditions you put
above, but as a reviewer I wondered if there is something else going on.

-Peff
