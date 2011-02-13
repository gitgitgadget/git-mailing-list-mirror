From: Jeff King <peff@peff.net>
Subject: Re: a bug about format-patch of multibyte characters comment
Date: Sun, 13 Feb 2011 05:23:08 -0500
Message-ID: <20110213102307.GA7735@sigill.intra.peff.net>
References: <4D565D3B.7060808@gmail.com>
 <20110213075337.GA12112@sigill.intra.peff.net>
 <20110213083137.GB12112@sigill.intra.peff.net>
 <4D579A35.1000007@gmail.com>
 <20110213085236.GA2251@sigill.intra.peff.net>
 <4D57AEFC.10608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: xiaozhu <xiaozhu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 11:23:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoZ6q-0006rO-1R
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 11:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438Ab1BMKXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 05:23:12 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57427 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754367Ab1BMKXK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 05:23:10 -0500
Received: (qmail 13047 invoked by uid 111); 13 Feb 2011 10:23:09 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 13 Feb 2011 10:23:09 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Feb 2011 05:23:08 -0500
Content-Disposition: inline
In-Reply-To: <4D57AEFC.10608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166658>

On Sun, Feb 13, 2011 at 07:14:20PM +0900, xiaozhu wrote:

> I am not similar with mail format. I read the rfc2047 again, but I didn't
> see any description about line separator encoding. Perhaps a base64 encoded-word
> will contain the line separator involuntarily? I also found a sample in
> rfc2047 it show us a line broken subject mail, but it didn't say any thing
> about line separator encoding.

If the encoded-word contains the line separator, wouldn't it be a
literal character in the header value then? I.e., using rfc2047 you can
embed a literal newline into your subject (or possibly, a 0x0a byte may
be part of a multi-byte character; that can't happen in utf8, but I
believe it can in utf16).

> A sample of rfc2047 show us a legal line broken subject mail, like following:
> ------------------------------------------------------------------
>  Subject: =?ISO-8859-1?B?SWYgeW91IGNhbiByZWFkIHRoaXMgeW8=?=
>     =?ISO-8859-2?B?dSB1bmRlcnN0YW5kIHRoZSBleGFtcGxlLg==?=
> ------------------------------------------------------------------
> 
> I understand that the current format-patch is not not valid to rfc2822/rfc2047,
> but even a valid one just like above, most of the mail client will can not show it
> correctly, they show the first line only, I think that's a problem of user
> friendliness.

Then those mail clients are broken. That should first be unfolded to put
both encoded-words on the same line (separated by whitespace, I think,
though it doesn't matter for encoded words), and then each encoded word
should be decoded (the resulting text is "If you can read this you
understand the example.").

Mutt and other MUAs do this just fine. If you have a MUA that doesn't,
complain to the author.

-Peff
