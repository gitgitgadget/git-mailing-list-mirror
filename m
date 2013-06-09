From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 11/15] for-each-ref: introduce %(HEAD) marker
Date: Sun,  9 Jun 2013 23:24:30 +0530
Message-ID: <1370800474-8940-12-git-send-email-artagnon@gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:57:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uljrk-0006hW-3h
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab3FIR5E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:57:04 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:47919 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab3FIR5C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:57:02 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so3057222pdj.3
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wkEcoa1IcmdO3XpwKwsuYUn1v3RMaGwEYxWJX0cb/5A=;
        b=kkrL/oXlwJDi9GZNlGq9t4pSzYJur37w0pSyA0ypia9ge+P0fm9eIDDujW+FA2pP92
         +n0tAvILENKHHb3xT884wzZbv4gopdBxAcobtCQQw0wL9XYMGK71lKmZyGQ6ML0qbGP3
         KxsoQ1o05DEuOV3STnLgPn5QvfVc8UPicssyAmgiEYmvfWSFspJQjWDTGQvAfqmgKS6w
         x/LCuOXbHBs4RHi4RHgBahA1PMgAMdlx5Xa+84jPgPB108+uXf50nzPGugIDMvosGDbV
         ZRE912ZVHr1VKPySFdSioU/IRRpe4hth+QU+dFJXPgmrjs4NQh3KaGcIaRKsIVirJQjS
         BCWQ==
X-Received: by 10.66.2.103 with SMTP id 7mr10765714pat.211.1370800621935;
        Sun, 09 Jun 2013 10:57:01 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.56.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:57:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227067>

'git branch' shows which branch you are currently on with an '*', but
'git for-each-ref' misses this feature.  So, extend the format with
%(HEAD) to do exactly the same thing.

Now you can use the following format in for-each-ref:

  %C(red)%(HEAD)%C(reset) %C(green)%(refname:short)%C(reset)

to display a red asterisk next to the current ref.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-for-each-ref.txt |  4 ++++
 builtin/for-each-ref.c             | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index 8cbc08c..8d982e3 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -121,6 +121,10 @@ upstream::
 	from the displayed ref. Respects `:short` in the same way as
 	`refname` above.
=20
+HEAD::
+	Useful to indicate the currently checked out branch.  Is '*'
+	if HEAD points to the current ref, and ' ' otherwise.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index da479d1..3d357a9 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -76,6 +76,7 @@ static struct {
 	{ "upstream" },
 	{ "symref" },
 	{ "flag" },
+	{ "HEAD" },
 };
=20
 /*
@@ -679,8 +680,16 @@ static void populate_value(struct refinfo *ref)
 				v->s =3D xstrdup(buf + 1);
 			}
 			continue;
-		}
-		else
+		} else if (!strcmp(name, "HEAD")) {
+			const char *head;
+			unsigned char sha1[20];
+			head =3D resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+			if (!strcmp(ref->refname, head))
+				v->s =3D "*";
+			else
+				v->s =3D " ";
+			continue;
+		} else
 			continue;
=20
 		formatp =3D strchr(name, ':');
--=20
1.8.3.247.g485169c
