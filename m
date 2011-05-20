From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] bisect: refactor sha1_array into a generic sha1 list
Date: Fri, 20 May 2011 03:47:14 -0400
Message-ID: <20110520074714.GC3663@sigill.intra.peff.net>
References: <20110519213231.GA29702@sigill.intra.peff.net>
 <20110519213433.GB29793@sigill.intra.peff.net>
 <BANLkTikYih5hOU=_Q9N_b8VZ_KJeb8zePg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 09:47:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNKQb-0006I7-H9
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 09:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489Ab1ETHrQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2011 03:47:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53309
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932135Ab1ETHrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 03:47:16 -0400
Received: (qmail 26417 invoked by uid 107); 20 May 2011 07:49:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 May 2011 03:49:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 May 2011 03:47:14 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikYih5hOU=_Q9N_b8VZ_KJeb8zePg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174047>

On Thu, May 19, 2011 at 09:17:42PM -0300, Thiago Farina wrote:

> > +struct sha1_array {
> > + =C2=A0 =C2=A0 =C2=A0 unsigned char (*sha1)[20];
> > + =C2=A0 =C2=A0 =C2=A0 int nr;
> > + =C2=A0 =C2=A0 =C2=A0 int alloc;
> Would be worth to change from int to unsigned int? Maybe is fine as i=
s
> though. It's that in some places we use unsigned int (string_list is
> one example).

Yeah, they probably should both be unsigned, and the sorted flag should
be a bit-field (not that it saves any space here, but it makes its purp=
ose
more clear).

Junio, do you mind squashing this into patch 2/3?

diff --git a/sha1-array.h b/sha1-array.h
index 15d3b6b..b602303 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -3,9 +3,9 @@
=20
 struct sha1_array {
 	unsigned char (*sha1)[20];
-	int nr;
-	int alloc;
-	int sorted;
+	unsigned nr;
+	unsigned alloc;
+	unsigned sorted:1;
 };
=20
 #define SHA1_ARRAY_INIT { NULL, 0, 0, 0 }

-Peff
