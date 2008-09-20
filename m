From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/14] update-index: refactor mark_valid() in preparation for new options
Date: Sat, 20 Sep 2008 17:01:43 +0700
Message-ID: <1221904913-25887-5-git-send-email-pclouds@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
 <1221904913-25887-3-git-send-email-pclouds@gmail.com>
 <1221904913-25887-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzJa-0001Aq-0q
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbYITKCi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 06:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbYITKCi
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:02:38 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:21281 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbYITKCh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:02:37 -0400
Received: by wf-out-1314.google.com with SMTP id 27so880198wfd.4
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oVCYOxm9OPP+Y7NCu7lnV1GbWvNKKailvgb/Fs1IIoA=;
        b=fJKO2WtXhBSKxOOpMkuetfebWxGH0/8LSop6CxM3v88z3y9ZggMHmX14Jj+2UGheim
         98kq6dYfAFH6cys67XeiUm+ody/nSXEXd4ufe2jZCIPBOZR6Ds30uJVGJwo32TuNVM5m
         WjtooxEG+uVGWh2xINQjkl4TV07eoo0NAct+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aNQwTa9FdYDUvky0tRBqVabqRAv6LbNYIIuc1631e9AEwwNksHfBe6zyiLjy27knm0
         +8VQNU5HCjiNLIx43iXGAnwIf5gBrWFgFhxWVxLdoJafk6PTgUVeDHhlQVkrWRjJjNyu
         RE7CecQOvsCG/0LODaWb5L+m00j3KO3l5UNhU=
Received: by 10.142.48.14 with SMTP id v14mr454395wfv.133.1221904957269;
        Sat, 20 Sep 2008 03:02:37 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id 31sm3594219wff.16.2008.09.20.03.02.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:02:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:02:26 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221904913-25887-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96341>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-update-index.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 417f972..ae94739 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -24,8 +24,8 @@ static int info_only;
 static int force_remove;
 static int verbose;
 static int mark_valid_only;
-#define MARK_VALID 1
-#define UNMARK_VALID 2
+#define MARK_FLAG 1
+#define UNMARK_FLAG 2
=20
 static void report(const char *fmt, ...)
 {
@@ -40,19 +40,15 @@ static void report(const char *fmt, ...)
 	va_end(vp);
 }
=20
-static int mark_valid(const char *path)
+static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen =3D strlen(path);
 	int pos =3D cache_name_pos(path, namelen);
 	if (0 <=3D pos) {
-		switch (mark_valid_only) {
-		case MARK_VALID:
-			active_cache[pos]->ce_flags |=3D CE_VALID;
-			break;
-		case UNMARK_VALID:
-			active_cache[pos]->ce_flags &=3D ~CE_VALID;
-			break;
-		}
+		if (mark)
+			active_cache[pos]->ce_flags |=3D flag;
+		else
+			active_cache[pos]->ce_flags &=3D ~flag;
 		cache_tree_invalidate_path(active_cache_tree, path);
 		active_cache_changed =3D 1;
 		return 0;
@@ -276,7 +272,7 @@ static void update_one(const char *path, const char=
 *prefix, int prefix_length)
 		goto free_return;
 	}
 	if (mark_valid_only) {
-		if (mark_valid(p))
+		if (mark_ce_flags(p, CE_VALID, mark_valid_only =3D=3D MARK_FLAG))
 			die("Unable to mark file %s", path);
 		goto free_return;
 	}
@@ -649,11 +645,11 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 				continue;
 			}
 			if (!strcmp(path, "--assume-unchanged")) {
-				mark_valid_only =3D MARK_VALID;
+				mark_valid_only =3D MARK_FLAG;
 				continue;
 			}
 			if (!strcmp(path, "--no-assume-unchanged")) {
-				mark_valid_only =3D UNMARK_VALID;
+				mark_valid_only =3D UNMARK_FLAG;
 				continue;
 			}
 			if (!strcmp(path, "--info-only")) {
--=20
1.6.0.96.g2fad1.dirty
