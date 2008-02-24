From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/6] Protect peel_ref fallback case from NULL parse_object result
Date: Sun, 24 Feb 2008 03:07:19 -0500
Message-ID: <20080224080719.GA22587@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:08:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTBuM-0004Lv-O0
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 09:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbYBXIHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 03:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbYBXIHr
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 03:07:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42950 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbYBXIHX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 03:07:23 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTBtI-0001fB-3s; Sun, 24 Feb 2008 03:07:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CB4BE20FBAE; Sun, 24 Feb 2008 03:07:19 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74905>

If the SHA-1 we are requesting the object for does not exist in
the object database we get a NULL back.  Accessing the type from
that is not likely to succeed on any system.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 67d2a50..fb33da1 100644
--- a/refs.c
+++ b/refs.c
@@ -506,7 +506,7 @@ int peel_ref(const char *ref, unsigned char *sha1)
 
 	/* fallback - callers should not call this for unpacked refs */
 	o = parse_object(base);
-	if (o->type == OBJ_TAG) {
+	if (o && o->type == OBJ_TAG) {
 		o = deref_tag(o, ref, 0);
 		if (o) {
 			hashcpy(sha1, o->sha1);
-- 
1.5.4.3.295.g6b554
