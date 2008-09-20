From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/14] grep: skip files outside sparse checkout area
Date: Sat, 20 Sep 2008 17:01:48 +0700
Message-ID: <1221904913-25887-10-git-send-email-pclouds@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
 <1221904913-25887-3-git-send-email-pclouds@gmail.com>
 <1221904913-25887-4-git-send-email-pclouds@gmail.com>
 <1221904913-25887-5-git-send-email-pclouds@gmail.com>
 <1221904913-25887-6-git-send-email-pclouds@gmail.com>
 <1221904913-25887-7-git-send-email-pclouds@gmail.com>
 <1221904913-25887-8-git-send-email-pclouds@gmail.com>
 <1221904913-25887-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:04:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzKB-0001Il-DT
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbYITKDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 06:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbYITKDR
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:03:17 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:21281 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbYITKDR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:03:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so880198wfd.4
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=A+QEaJfLJ9zwRnDfgtgIg+pUYXoIDBJ9HdO0tPV+iJY=;
        b=T2zMum2A1qIghGElgmLV7dyvtSt6lY/VrKg1fBCiwJKCoRReLelS95oPJa2/TKWdil
         kZ8+lA31RK8w1txGN/I4tcF5D/EzuyA/82bEC1Sihgw+qh4SB5pLJFHSEfkGXB2XULeK
         iHzHf/L28ch54tPnSvzlKpggY/6oyIGKPo0+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OjsrFhY6+YQUrV7sKzn55cAt1RwdFc1b/0HLSt3/1WwqIId1ecuTcNR/kcxM4B0SZX
         zKJglsDV3g0xx5D6Jqtc9u6MbUZ+871MZuGTIn2Ev3qioV0Dthc6uHygdF4q0fq5Tao/
         SJ/4h8uGdIs92j2bZ/s+ljujVKc8zZYCRTg9E=
Received: by 10.142.139.19 with SMTP id m19mr459524wfd.25.1221904996725;
        Sat, 20 Sep 2008 03:03:16 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id 30sm3610141wfc.5.2008.09.20.03.03.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:03:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:03:06 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221904913-25887-9-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96346>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-grep.txt |    4 +++-
 builtin-grep.c             |    7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index fa4d133..ee359c9 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -24,7 +24,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Look for specified patterns in the working tree files, blobs
-registered in the index file, or given tree objects.
+registered in the index file, or given tree objects. By default
+it will search in the working tree files. When in sparse checkout
+mode, it only searches checked-out files.
=20
=20
 OPTIONS
diff --git a/builtin-grep.c b/builtin-grep.c
index 3a51662..d5507d7 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -343,6 +343,8 @@ static int external_grep(struct grep_opt *opt, cons=
t char **paths, int cached)
 			continue;
 		if (!pathspec_matches(paths, ce->name))
 			continue;
+		if (ce_no_checkout(ce))
+			continue;
 		name =3D ce->name;
 		if (name[0] =3D=3D '-') {
 			int len =3D ce_namelen(ce);
@@ -404,8 +406,11 @@ static int grep_cache(struct grep_opt *opt, const =
char **paths, int cached)
 				continue;
 			hit |=3D grep_sha1(opt, ce->sha1, ce->name, 0);
 		}
-		else
+		else {
+			if (ce_no_checkout(ce))
+				continue;
 			hit |=3D grep_file(opt, ce->name);
+		}
 		if (ce_stage(ce)) {
 			do {
 				nr++;
--=20
1.6.0.96.g2fad1.dirty
