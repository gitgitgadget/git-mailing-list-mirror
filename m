From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 05/10] fast-export: improve argument parsing
Date: Tue, 12 Nov 2013 14:56:58 -0600
Message-ID: <1384289830-5471-6-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:05:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL9Z-0000cy-C2
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235Ab3KLVFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:05:36 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34842 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202Ab3KLVET (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:19 -0500
Received: by mail-ob0-f171.google.com with SMTP id gq1so6691478obb.30
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GNMeKRkxMWz89BRrhJ/ban7/UTxmEXiUPRoKUKUKxZA=;
        b=AOMK37PzTAZ+uRMrJpPQgpKKv+kB6dQ6FyLJzScpmPgh9YPjRpciWGWw8bg4zr7I6g
         SfujcVhF8D54kq8O1/6rGPy0s+8GnSmcgqcf00ftZPcOvpzNTJ7rRdWHefK8UGdM2YKC
         hutfoBUCtG119FPu7n+LVIm7zphhTpyl00uhwQqbbw2LKOw5dg248Os60K+Udqg5EtB+
         PEgUznV4IIIuj2k7GXaz8WaWb1Xn77gsnjfmR9tNbZxgiiu8tz9eQvQ5vLwpLRqk2MqD
         2zrMnEWaF8lBWXJDUmDd5A4AK4+/ISPtGcfUcCJ3y2mQaard90Vs9fGqv+GLHNqy5lYb
         hnqQ==
X-Received: by 10.60.68.135 with SMTP id w7mr33459279oet.9.1384290257792;
        Tue, 12 Nov 2013 13:04:17 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id m7sm35387196obo.7.2013.11.12.13.04.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:16 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237753>

We don't want to pass arguments specific to fast-export to
setup_revisions.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 78250ea..eea5b8c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -701,8 +701,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	revs.topo_order = 1;
 	revs.show_source = 1;
 	revs.rewrite_parents = 1;
+	argc = parse_options(argc, argv, prefix, options, fast_export_usage,
+			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
 	argc = setup_revisions(argc, argv, &revs, NULL);
-	argc = parse_options(argc, argv, prefix, options, fast_export_usage, 0);
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
 
-- 
1.8.4.2+fc1
