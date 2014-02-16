From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 5/5] streaming: simplify attaching a filter
Date: Sun, 16 Feb 2014 16:06:06 +0000
Message-ID: <0120f99a7cccc118782cda63f478d7d3f528ee3f.1392565571.git.john@keeping.me.uk>
References: <cover.1392565571.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 17:06:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF4F3-0007zt-I1
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 17:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbaBPQGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 11:06:49 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:35863 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbaBPQGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 11:06:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id AA5D4CDA5B5;
	Sun, 16 Feb 2014 16:06:41 +0000 (GMT)
X-Quarantine-ID: <DML4RIfyiVDC>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DML4RIfyiVDC; Sun, 16 Feb 2014 16:06:41 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 4A793CDA590;
	Sun, 16 Feb 2014 16:06:41 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 43E3C161E4CB;
	Sun, 16 Feb 2014 16:06:41 +0000 (GMT)
X-Quarantine-ID: <xfyTvGRiwhAl>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xfyTvGRiwhAl; Sun, 16 Feb 2014 16:06:41 +0000 (GMT)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 2733E161E4C1;
	Sun, 16 Feb 2014 16:06:36 +0000 (GMT)
X-Mailer: git-send-email 1.9.rc0.187.g6292fff
In-Reply-To: <cover.1392565571.git.john@keeping.me.uk>
In-Reply-To: <cover.1392565571.git.john@keeping.me.uk>
References: <cover.1392565571.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242229>

We are guaranteed that 'nst' is non-null because it is allocated with
xmalloc(), and in fact we rely on this three lines later by
unconditionally dereferencing it.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 streaming.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/streaming.c b/streaming.c
index d7c9f32..8a7135d 100644
--- a/streaming.c
+++ b/streaming.c
@@ -151,10 +151,7 @@ struct git_istream *open_istream(const unsigned char *sha1,
 	}
 	if (filter) {
 		/* Add "&& !is_null_stream_filter(filter)" for performance */
-		struct git_istream *nst = attach_stream_filter(st, filter);
-		if (!nst)
-			close_istream(st);
-		st = nst;
+		st = attach_stream_filter(st, filter);
 	}
 
 	*size = st->size;
-- 
1.9.rc0.187.g6292fff
