From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 5/6] fast-import: honor pack.indexversion and
 pack.packsizelimit config vars
Date: Wed, 17 Feb 2010 14:05:55 -0500
Message-ID: <1266433556-1987-6-git-send-email-nico@fluxnic.net>
References: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:06:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhpEP-0005G9-TP
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 20:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab0BQTGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 14:06:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11748 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab0BQTGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 14:06:09 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY000GRF2DZ9K50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Feb 2010 14:06:02 -0500 (EST)
X-Mailer: git-send-email 1.7.0.23.gf5ef4
In-reply-to: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140249>

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 fast-import.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d2f45b1..7fc9862 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2876,6 +2876,17 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		pack_compression_seen = 1;
 		return 0;
 	}
+	if (!strcmp(k, "pack.indexversion")) {
+		pack_idx_default_version = git_config_int(k, v);
+		if (pack_idx_default_version > 2)
+			die("bad pack.indexversion=%"PRIu32,
+			    pack_idx_default_version);
+		return 0;
+	}
+	if (!strcmp(k, "pack.packsizelimit")) {
+		max_packsize = git_config_ulong(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "core.bigfilethreshold")) {
 		long n = git_config_int(k, v);
 		big_file_threshold = 0 < n ? n : 0;
-- 
1.7.0.23.gf5ef4
