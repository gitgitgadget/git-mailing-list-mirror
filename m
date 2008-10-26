From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/3] rename_ref(): handle the case when the reflog of a ref does not exist
Date: Sun, 26 Oct 2008 03:33:57 +0100
Message-ID: <b06bf89aeeb844903e16f7c231c6add011a910bf.1224987945.git.vmiklos@frugalware.org>
References: <cover.1224987944.git.vmiklos@frugalware.org>
 <39b6bd01cf753d48a803e1d5908e543b66899c77.1224987944.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 03:34:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtvSl-0001cv-Gl
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 03:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbYJZCdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 22:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbYJZCdS
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 22:33:18 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:53274 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbYJZCdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 22:33:16 -0400
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id D22FA446CD0;
	Sun, 26 Oct 2008 03:33:13 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id CA9B58B388; Sun, 26 Oct 2008 03:33:59 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <39b6bd01cf753d48a803e1d5908e543b66899c77.1224987944.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1224987944.git.vmiklos@frugalware.org>
References: <cover.1224987944.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99136>

We tried to check if a reflog of a ref is a symlink without first
checking if it exists, which is a bug.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 70c0967..3c39a31 100644
--- a/refs.c
+++ b/refs.c
@@ -975,7 +975,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	const char *symref = NULL;
 	int is_symref = 0;
 
-	if (S_ISLNK(loginfo.st_mode))
+	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldref);
 
 	symref = resolve_ref(oldref, orig_sha1, 1, &flag);
-- 
1.6.0.2
