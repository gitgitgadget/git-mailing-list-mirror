From: =?UTF-8?q?Pawe=C5=82=20Wawruch?= <pawlo@aleg.pl>
Subject: [PATCH v4] install_branch_config: simplify verbose messages logic
Date: Wed, 12 Mar 2014 01:33:32 +0100
Message-ID: <1394584412-7735-1-git-send-email-pawlo@aleg.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 01:33:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNX7D-0002jM-PS
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 01:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbaCLAdn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 20:33:43 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:41135 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657AbaCLAdm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 20:33:42 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so4049592eek.29
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 17:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=rABWW3v4krYcn9wq3P2vmh+uFdjfx/MN5/qTStDTiD8=;
        b=CEJIEQT8kO/RHQTtRchx+V128+x/Hfk6hSi2VL6YiXyYm1oZKRT1cAFQADHs6sS9aY
         g47azdbgV6WmJwDtwqxrthJeu71rON/zUAEmIhTYX/1m4F2FRk/Dvjl81Qtga5FpGTSp
         VjR5HjeDXosPbdxgN0z4cFl6sBJEb6itbbNvmwihT7NHG8MbhjOeEJhPMVYGjrNDlQwl
         wOpXWbiGJJ3GY5xVGJMBKOfpxo6NLzz1R3UjTmFR2uwNolbWxz73NWsQwKkx0UP+mOtl
         9x/+vCPRDNMh4X/Jvf7SpLXhbfybkYY/5PJvFNDw/OpJ1BYIzp0xp61lF1wj/nU4W6dv
         7aUg==
X-Received: by 10.14.177.135 with SMTP id d7mr44530289eem.33.1394584420860;
        Tue, 11 Mar 2014 17:33:40 -0700 (PDT)
Received: from endymion.chello.pl (89-74-49-157.dynamic.chello.pl. [89.74.49.157])
        by mx.google.com with ESMTPSA id m1sm63474718een.7.2014.03.11.17.33.39
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Mar 2014 17:33:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243914>

Replace the chain of if statements with table of strings.

Signed-off-by: Pawe=C5=82 Wawruch <pawlo@aleg.pl>
---
The changes proposed by Junio C Hamano:
Improvement of indentations. Removed an unused variable.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243502
[2]: http://thread.gmane.org/gmane.comp.version-control.git/243849
[3]: http://thread.gmane.org/gmane.comp.version-control.git/243865

 branch.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..2a4b911 100644
--- a/branch.c
+++ b/branch.c
@@ -53,6 +53,20 @@ void install_branch_config(int flag, const char *loc=
al, const char *origin, cons
 	int remote_is_branch =3D starts_with(remote, "refs/heads/");
 	struct strbuf key =3D STRBUF_INIT;
 	int rebasing =3D should_setup_rebase(origin);
+	const char *message[][2][2] =3D {{{
+		N_("Branch %s set up to track remote branch %s from %s by rebasing."=
),
+		N_("Branch %s set up to track remote branch %s from %s."),
+		},{
+		N_("Branch %s set up to track local branch %s by rebasing."),
+		N_("Branch %s set up to track local branch %s."),
+		}},{{
+		N_("Branch %s set up to track remote ref %s by rebasing."),
+		N_("Branch %s set up to track remote ref %s."),
+		},{
+		N_("Branch %s set up to track local ref %s by rebasing."),
+		N_("Branch %s set up to track local ref %s.")
+	}}};
+	const char *name =3D remote_is_branch ? remote : shortname;
=20
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
@@ -77,29 +91,12 @@ void install_branch_config(int flag, const char *lo=
cal, const char *origin, cons
 	strbuf_release(&key);
=20
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote branch %s from %s by rebasin=
g.") :
-				  _("Branch %s set up to track remote branch %s from %s."),
-				  local, shortname, origin);
-		else if (remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local branch %s by rebasing.") :
-				  _("Branch %s set up to track local branch %s."),
-				  local, shortname);
-		else if (!remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote ref %s by rebasing.") :
-				  _("Branch %s set up to track remote ref %s."),
-				  local, remote);
-		else if (!remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local ref %s by rebasing.") :
-				  _("Branch %s set up to track local ref %s."),
-				  local, remote);
+		if (origin && remote_is_branch)
+			printf_ln(_(message[!remote_is_branch][!origin][!rebasing]),
+				local, name, origin);
 		else
-			die("BUG: impossible combination of %d and %p",
-			    remote_is_branch, origin);
+			printf_ln(_(message[!remote_is_branch][!origin][!rebasing]),
+				local, name);
 	}
 }
=20
--=20
1.8.3.2
