From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 05/10] fast-export: improve argument parsing
Date: Mon, 11 Nov 2013 16:55:01 -0600
Message-ID: <1384210507-26561-5-git-send-email-felipe.contreras@gmail.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 00:02:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg0Ut-0006Gg-W9
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab3KKXCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:02:15 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33663 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab3KKXCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:02:09 -0500
Received: by mail-ob0-f178.google.com with SMTP id va2so5145075obc.9
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GNMeKRkxMWz89BRrhJ/ban7/UTxmEXiUPRoKUKUKxZA=;
        b=G/lgnU7cpmoc1rBPYZxdZI+X867ZgDuXplDaZqfbeg3AFy8KLqzOXgv/fgMSueGfcQ
         UaPSxa/hbZnwLXqSX3m9og0Xs2R3VOZqhdq1OS23K9v31owaNlyu/SPDtiqyrji4Ott9
         ECYVkoFF7xejRt6be8vLmWWYcwbHAuR0107ox6gxM0FIvzmKZ7p6a1ZG25XYT9aycaf1
         eH7Opt4nJIbf4/eRjNxdYjpgpACDdPmF02WEC3yf5rBHyCPsu2wQ+msg0yVJbLv+LxBA
         tLcSs48LolB9ZAd0MHGbxi9k84KAuFHDzJj3TAzndaPe3JtvELSaotEg9fxErPFItJ4f
         p7Fw==
X-Received: by 10.60.51.196 with SMTP id m4mr27285921oeo.1.1384210928882;
        Mon, 11 Nov 2013 15:02:08 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm29420092oeb.7.2013.11.11.15.02.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 15:02:08 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237667>

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
