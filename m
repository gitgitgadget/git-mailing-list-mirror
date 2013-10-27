From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 04/10] fast-export: improve argument parsing
Date: Sun, 27 Oct 2013 01:05:21 -0600
Message-ID: <1382857521-7005-11-git-send-email-felipe.contreras@gmail.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 08:12:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaKWd-0006wv-M8
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 08:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab3J0HM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 03:12:28 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:43995 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab3J0HMY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 03:12:24 -0400
Received: by mail-ob0-f177.google.com with SMTP id vb8so2453505obc.22
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pv1fmFRZjwjteeLCxVnmYZVCbDo/pMV8uRefWJk8irM=;
        b=MSIWX4tKj9yeifvrcPhu5iyDP2HOzMYrSjf+fYANJA1Df8qWKIIiIJJ8E3zwO955vH
         3W5DjIb93X7yboXF9r1Qa3NEVT/M2bIzQUrBaYSqYxpysZ0uddnchq7rsCv5QuZO6ev1
         tch8e4qHp4ZZ8dSNQ/JZy/5SfKG8I/NakYTd/M1jakSzd/gEfkXyRVJT2/TITmtmv598
         p6wxtaFT7zmy+Az2WSbh8MTLHVTeAWm4PftEADmGmliCoBoiTQomhIiytN3G/p/q/hl3
         RgtQ1b1q62dmdNTr2OQXmCf90Px1hz9q+o/hTyVutfA9BindL6FkveNBdjaljTvkZpfX
         qtow==
X-Received: by 10.60.144.230 with SMTP id sp6mr3960452oeb.29.1382857944487;
        Sun, 27 Oct 2013 00:12:24 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm22384224oeb.7.2013.10.27.00.12.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2013 00:12:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236789>

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
1.8.4-fc
