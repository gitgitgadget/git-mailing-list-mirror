From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 07/10] clone: --branch=<branch> always means refs/heads/<branch>
Date: Fri, 13 Jan 2012 14:21:59 +0700
Message-ID: <1326439322-15648-8-git-send-email-pclouds@gmail.com>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 08:23:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlbTu-00087O-Jv
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 08:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab2AMHXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 02:23:18 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:47911 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752984Ab2AMHXR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2012 02:23:17 -0500
Received: by obcva7 with SMTP id va7so1809394obc.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 23:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MUn3KIrNUkWtFY8DvQ2j78/z3mQbl8R3xDiSTrKIGR0=;
        b=qL/Nw1u3mb7wC0/8MjY3u1sonY/cnWxEXEXB4IkUDPfGRGdyu/VH2L8MlCnHZjAq82
         X9GqHHepHsEfv7UW4d8s55Hn95DY1SyjnnOHrVHqJYpLWDV5tK9XlVBBQEXeKUCHIuZp
         zjGMmcP8S6NSgBU8v/5ozPf89zDwLrjgVtuIc=
Received: by 10.50.77.226 with SMTP id v2mr4907978igw.12.1326439396925;
        Thu, 12 Jan 2012 23:23:16 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id rc7sm5349001igb.0.2012.01.12.23.23.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 23:23:15 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Jan 2012 14:23:07 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188504>

It does not make sense to look outside refs/heads for HEAD's target
(src_ref_prefix can be set to "refs/" if --mirror is used) because ref
code only allows symref in form refs/heads/...

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a9d06a4..89ba6f0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -463,7 +463,7 @@ static void update_remote_refs(const struct ref *re=
fs,
 static void update_head(const struct ref *our, const struct ref *remot=
e,
 			const char *msg)
 {
-	if (our) {
+	if (our && !prefixcmp(our->name, "refs/heads/")) {
 		/* Local default branch link */
 		create_symref("HEAD", our->name, NULL);
 		if (!option_bare) {
@@ -765,7 +765,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 		if (option_branch) {
 			struct strbuf head =3D STRBUF_INIT;
-			strbuf_addstr(&head, src_ref_prefix);
+			strbuf_addstr(&head, "refs/heads/");
 			strbuf_addstr(&head, option_branch);
 			our_head_points_at =3D
 				find_ref_by_name(mapped_refs, head.buf);
--=20
1.7.3.1.256.g2539c.dirty
