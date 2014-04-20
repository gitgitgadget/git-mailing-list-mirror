From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/8] fast-export: improve argument parsing
Date: Sun, 20 Apr 2014 13:59:23 -0500
Message-ID: <1398020370-11406-2-git-send-email-felipe.contreras@gmail.com>
References: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:10:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbx8D-0005Yz-64
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbaDTTJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:09:57 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:62086 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbaDTTJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:09:54 -0400
Received: by mail-yk0-f169.google.com with SMTP id 142so2828253ykq.14
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sa7eFTdAYJa6UDvMxmD0uiL04eKqpj6XksOBy/xykcU=;
        b=nzZbv5tVjrtuWY7/tyNkjp5BvnGax8WiwuhXjF4ntTjIKd9WN/MAXajwq0u+H83YSH
         bUJyh+wuHgC+Lc60rN5ntJNGKELosc3htKVmeoDoYrtpGClxAUWEhXyGeY5BbEhgUJzU
         c4si1x/L3XTyRVTPkahyUXaT8Igr74jIJiLtBmWcpeHA++B+TYvPPAhoZEVcfoFlrKnk
         hBnfMi3EVFaLVCPf4m6OCLHKo7faW7ibbwShyZwLf/vIi6l6jRfO0JoRDC0SSvxI/xP8
         PY5jp2Z/mIrsaVJVzaEW7tUM+Xz/CkFmA0qvsPNqU3h8mu5BZB+rvDrRcA+UZBZhR+af
         DdIw==
X-Received: by 10.236.30.230 with SMTP id k66mr46875486yha.57.1398020994342;
        Sun, 20 Apr 2014 12:09:54 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r46sm65404173yhd.29.2014.04.20.12.09.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:09:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246559>

We don't want to pass arguments specific to fast-export to
setup_revisions.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fast-export.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b8d8a3a..bc3490c 100644
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
1.9.1+fc3.9.gc73078e
