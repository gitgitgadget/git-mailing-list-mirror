From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] branch: reject -D/-d without branch name
Date: Fri, 25 Jan 2013 19:50:23 +0700
Message-ID: <1359118225-14356-1-git-send-email-pclouds@gmail.com>
References: <1359102416-1240-1-git-send-email-pclouds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 13:50:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyijk-00032M-2Z
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 13:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204Ab3AYMuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 07:50:06 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:44831 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab3AYMuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 07:50:04 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so199674pbb.15
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 04:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=HpUR0h46QGlG/X6FEpaKjdycrrONpYAfF6nSD+b3PeE=;
        b=k5ThSmc+ontS99lB/Bka6nJUkSx4nDoJS+CNUD4pmMQLTEAaXQca/pvSwmJxQIXdIJ
         hbuTfbD1TyZQ+ZGcnYVswZsuEv1n0hAo52+6emgCaFRXAT/vUUvZTGBrGAVe7FwOd48Z
         Ym5+cirT9UskA9cOFGisE7K+FoRVx8aesRKHRFMKHWGNYsFwARdT7g09EtQecjrBJIqg
         eIz4LzJKeDDWkGagl6KGqMjpEyOy136ITjT5QcnlKQ+jbNc+3AWKJCewTFFz/u3l2Is2
         9wUGHCTs4WVdvIDF2krNjRnTOKER0Id34L1YTCQIB9zInSQElmb+nXxCPgOncQEFbzIC
         4OYA==
X-Received: by 10.68.213.233 with SMTP id nv9mr13744725pbc.155.1359118203860;
        Fri, 25 Jan 2013 04:50:03 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id rq7sm623124pbc.69.2013.01.25.04.50.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 04:50:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 25 Jan 2013 19:50:26 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1359102416-1240-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214547>

---
 builtin/branch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 873f624..50fcacc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -837,9 +837,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		colopts = 0;
 	}
 
-	if (delete)
+	if (delete) {
+		if (!argc)
+			die(_("branch name required"));
 		return delete_branches(argc, argv, delete > 1, kinds, quiet);
-	else if (list) {
+	} else if (list) {
 		int ret = print_ref_list(kinds, detached, verbose, abbrev,
 					 with_commit, argv);
 		print_columns(&output, colopts, NULL);
-- 
1.8.0.rc2.23.g1fb49df
