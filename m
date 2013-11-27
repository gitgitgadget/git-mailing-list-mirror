From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 18/24] update-index.c: rewrite index when index-version is given
Date: Wed, 27 Nov 2013 13:00:53 +0100
Message-ID: <1385553659-9928-19-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldpA-00029c-Rq
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631Ab3K0MCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:02:30 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54203 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab3K0MC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:02:27 -0500
Received: by mail-lb0-f174.google.com with SMTP id c11so5376687lbj.33
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hUukXhZGbtIWql8xxffOo2ub87wKcoCY8fJt1vMvmms=;
        b=cUFBhjo1QMzJGntBiWEP40Ca6I7xnid2rkV1A1rCKJmYW+eM0uumyzV9O6afyikBun
         v83M+6I3734Q5dndh9IVN/qJI/HUyh4jkDGEuipfgP3HuKrNLG15JSTk4D5Gse3DrxjO
         L0dffI5QYldkCLHJjb/t0dUo5WO8iA32UYJO06+BpIv0lWgMBp3kllqTcaHjgY4zWAeG
         iSefT0rg7Kb67Q33+bpyH9IucDN16apFFdwZk8rbV5UoSCk4KhbSsyy31NySGL8JjgON
         YivNDyA9+iSUQYxYro27a2iec6+glRtlwQHrnIzco0bni7ejdo6WcPoArj9AG/RdHmvN
         Mxvg==
X-Received: by 10.112.126.164 with SMTP id mz4mr12191lbb.52.1385553746430;
        Wed, 27 Nov 2013 04:02:26 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id i8sm14941127lbh.2.2013.11.27.04.02.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:02:25 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238431>

Make update-index always rewrite the index when a index-version
is given, even if the index already has the right version.
This option is used for performance testing the writer and
reader.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index c5bb889..8b3f7a0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "quote.h"
 #include "cache-tree.h"
+#include "read-cache.h"
 #include "tree-walk.h"
 #include "builtin.h"
 #include "refs.h"
@@ -861,8 +862,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    preferred_index_format,
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
 
-		if (the_index.version != preferred_index_format)
-			active_cache_changed = 1;
+		active_cache_changed = 1;
 		change_cache_version(preferred_index_format);
 	}
 
-- 
1.8.4.2
