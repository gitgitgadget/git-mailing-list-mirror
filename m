From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] fast-export: improve argument parsing
Date: Wed,  8 May 2013 20:31:33 -0500
Message-ID: <1368063095-22861-2-git-send-email-felipe.contreras@gmail.com>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:33:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFjJ-0006x9-E8
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345Ab3EIBdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:33:05 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:37720 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab3EIBdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:33:04 -0400
Received: by mail-ob0-f182.google.com with SMTP id eh20so2393314obb.27
        for <git@vger.kernel.org>; Wed, 08 May 2013 18:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1xdLX5z56jNViOWKH0+E2RCDs+MX77W2Yt7xgt9Syzo=;
        b=uTCQw6ZHulYl57uwxzCoUrnQNr//vaVNQorweqFKTqenech6qIzot9BrcmwxvmDtQi
         nmxFRiU8e4CCpaJjTM64t+Z/RAVxgno68TnQ5Er32LCV43eKkwWlo9l2QElHGrzuIkse
         wiDcd70/Mu1pw7UABLigK2CrogXuC6RFTxCidLv+aWLRA8/hBh3St3+aybkvikuyGVCI
         GqpoJnNe1vJs38Q89JVTND3D46J7zwClYgqRM/RTxFTNloqeTB/kGpyuyJpatZ016qwE
         QCbLsvtUvge39tUDLwcCi7yvg7qp6DjZ36CZoalmpDnHLi9P/y5kiiXAzXa/bI7g4hCT
         0BEg==
X-Received: by 10.60.123.10 with SMTP id lw10mr3232470oeb.39.1368063184010;
        Wed, 08 May 2013 18:33:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm1185365oez.4.2013.05.08.18.33.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 18:33:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
In-Reply-To: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223707>

We don't want to pass arguments specific to fast-export to
setup_revisions.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d60d675..6e46057 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -686,8 +686,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
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
1.8.3.rc1.553.gac13664
