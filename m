From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 05/10] fast-export: improve argument parsing
Date: Thu, 31 Oct 2013 03:36:31 -0600
Message-ID: <1383212197-14259-5-git-send-email-felipe.contreras@gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:43:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vboms-0003nt-VJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab3JaJna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:43:30 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:43914 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab3JaJn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:43:28 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so2787452obc.14
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GNMeKRkxMWz89BRrhJ/ban7/UTxmEXiUPRoKUKUKxZA=;
        b=F4yCHGoXVj72k9ILVOSsJ5DWBvosd0S5EskILfQiaMvQXaraHice3gjATdoDgghHui
         VNkBYiC9ohHEmA52GkeOCJiQP1/5r/VexO0MAUmDhm97fSZPn9+S2gEqKfwjykT7yoXF
         aS2fYyp8wH+vWdrFrdAZgwfESSzam9p4qM03k9AyAlNgF4e7ZzHSPm0pJ8wBsaTkk870
         orAtvsW6FoBp/KVsRaRq9gtznxPN/yr55AZj6xe9x2N2fuH9wS0G1ev8EE3vfC48J/sJ
         rTdQ7qqCdM38Obkod1llAS5MKHClH5J23MQ/t6tQVpkFAl7Kt8Ds8IBjPOjbLdpEjT21
         yfwg==
X-Received: by 10.60.58.71 with SMTP id o7mr1874335oeq.51.1383212608105;
        Thu, 31 Oct 2013 02:43:28 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm4495900obi.14.2013.10.31.02.43.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:43:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237104>

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
