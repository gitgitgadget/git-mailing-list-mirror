From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix a crash in ls-remote when refspec expands into nothing
Date: Fri, 12 Oct 2007 22:40:04 +0200
Message-ID: <20071012204004.GA6700@steel.home>
References: <1191919868-4963-1-git-send-email-v@pp.inet.fi> <1191919868-4963-2-git-send-email-v@pp.inet.fi> <81553116-3A4F-4526-A772-9A43C53D3E22@pp.inet.fi> <20071009182043.GA2997@steel.home> <20071010051034.GA30834@coredump.intra.peff.net> <20071010212735.GB16635@steel.home> <20071012040745.GC27899@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?iso-8859-15?B?VuRpbvYgSuRydmVs5A==?= <v@pp.inet.fi>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 12 22:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgRIz-0007xW-H3
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 22:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757127AbXJLUkL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2007 16:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756919AbXJLUkL
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 16:40:11 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:57360 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756884AbXJLUkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 16:40:09 -0400
Received: from tigra.home (Fcb36.f.strato-dslnet.de [195.4.203.54])
	by post.webmailer.de (fruni mo42) (RZmta 13.4)
	with ESMTP id J02deaj9CGkh59 ; Fri, 12 Oct 2007 22:40:04 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A8C92277AE;
	Fri, 12 Oct 2007 22:40:04 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 7C04956D22; Fri, 12 Oct 2007 22:40:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071012040745.GC27899@spearce.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqB/Ong==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60704>

Originally-by: V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 <v@pp.inet.fi>
Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 remote.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

Shawn O. Pearce, Fri, Oct 12, 2007 06:07:45 +0200:
> I think the above patch is the only thing to do here.  Perhaps Alex
> can write up a formal patch and send it to back to the list and CC
> Lars Hjemli <hjemli@gmail.com> so he can put it into the patch queue.

here you go

diff --git a/remote.c b/remote.c
index e7d735b..a25f66d 100644
--- a/remote.c
+++ b/remote.c
@@ -882,7 +882,8 @@ int get_fetch_map(struct ref *remote_refs,
 			    rm->peer_ref->name);
 	}
=20
-	tail_link_ref(ref_map, tail);
+	if (ref_map)
+		tail_link_ref(ref_map, tail);
=20
 	return 0;
 }
--=20
1.5.3.4.232.ga843
