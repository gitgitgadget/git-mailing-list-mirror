From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Cast &cp to eliminate a compile-time warning on
 FreeBSD 8-STABLE.
Date: Sat, 5 Dec 2009 11:14:05 -0500
Message-ID: <20091205161405.GA9272@sigill.intra.peff.net>
References: <1259968322-66072-1-git-send-email-jh@jameshoward.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "James P. Howard, II" <jh@jameshoward.us>
X-From: git-owner@vger.kernel.org Sat Dec 05 17:14:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGxHB-0005WB-BY
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 17:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837AbZLEQOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 11:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756770AbZLEQOG
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 11:14:06 -0500
Received: from peff.net ([208.65.91.99]:46048 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756538AbZLEQOF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 11:14:05 -0500
Received: (qmail 25397 invoked by uid 107); 5 Dec 2009 16:18:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 05 Dec 2009 11:18:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Dec 2009 11:14:06 -0500
Content-Disposition: inline
In-Reply-To: <1259968322-66072-1-git-send-email-jh@jameshoward.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134608>

On Fri, Dec 04, 2009 at 06:12:02PM -0500, James P. Howard, II wrote:

> --- a/utf8.c
> +++ b/utf8.c
> @@ -449,7 +449,7 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
>  	cp = (iconv_ibp)in;
>  
>  	while (1) {
> -		size_t cnt = iconv(conv, &cp, &insz, &outpos, &outsz);
> +		size_t cnt = iconv(conv, (const char **)&cp, &insz, &outpos, &outsz);
>  
>  		if (cnt == -1) {
>  			size_t sofar;

Aren't you now introducing a warning for all of the other platforms
which take a "char **"? Should you instead just be building with
OLD_ICONV=Yes on your platform? See commit fd547a9 for details.

-Peff
