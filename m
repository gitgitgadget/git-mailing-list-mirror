From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 12/15] strbuf_vaddf(): support %*s, too
Date: Fri, 27 Jun 2008 18:22:05 +0200
Message-ID: <3a8521edeb769e0fb85bec434daf064ce29edaa5.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
 <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
 <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org>
 <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
 <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org>
 <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org>
 <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org>
 <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org>
 <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org>
 <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org>
 <7ea320cd49601de0e331777f82528876101fd946.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:24:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGkC-0004E3-74
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598AbYF0QXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761436AbYF0QXP
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:23:15 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45347 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760850AbYF0QWN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:13 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id 654FD1DDC69;
	Fri, 27 Jun 2008 18:22:07 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 730B818E833; Fri, 27 Jun 2008 18:22:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <7ea320cd49601de0e331777f82528876101fd946.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86592>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The recent addition of graph.c broke things with our custom implementation
of strbuf_vaddf(), because "%*s" was not yet supported (because it did not
have any users before).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 strbuf.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 72b3585..bd5dc80 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -154,6 +154,12 @@ void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
 			fill = *p++;
 		if (isdigit(*p))
 			size = (int)strtol(p, &p, 10);
+		else if (*p == '*') {
+			size = va_arg(ap, int);
+			if (!fill)
+				fill = ' ';
+			p++;
+		}
 		else if (!prefixcmp(p, ".*")) {
 			max_size = va_arg(ap, int);
 			p += 2;
-- 
1.5.6
