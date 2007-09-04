From: Pierre Habouzit <madcoder@debian.org>
Subject: strbuf new semantics, let's give it a try
Date: Tue,  4 Sep 2007 10:47:58 +0200
Message-ID: <11888956803429-git-send-email-madcoder@debian.org>
References: <buobqcjrycl.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 10:48:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISU4z-00087Y-K5
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 10:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbXIDIsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 04:48:04 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbXIDIsE
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 04:48:04 -0400
Received: from pan.madism.org ([88.191.52.104]:44241 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263AbXIDIsD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 04:48:03 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 32A3F1AA1E
	for <git@vger.kernel.org>; Tue,  4 Sep 2007 10:48:01 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1B933145D73; Tue,  4 Sep 2007 10:48:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.3
In-Reply-To: <buobqcjrycl.fsf@dhapc248.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57540>

  Allright, here is a proposal for a new strbuf semantics like the one =
I
proposed before. Like said, with this proposal, strbuf's always have a
'\0' at the end of the buffer, not accounted in its length, so that any
C str* function can still be used.

  The second patch demonstrate that strbufs makes the code smaller,
simpler to read, while keeping the exact same efficiency (as may
mallocs, memcpys, and fread's in that case).


  I've tried to keep the amount of inlines low. Though, I wonder if
strbuf_add shouldn't be inlined (so that memcpys could be even more
inlined/optmized by gcc). And strbuf_addstr is inlined so that the
strlen call is optimized when the argument is an immediate string.
Meaning that calling strbuf_addstr(sb, "foo") is not sloppy at all.

  I don't really like the buffer growth scheme right now, I just stick
with the one that was used in git before. Though I really belive it's
inelegant as is, and should be simplified (strbuf_extend).

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
