From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 07/10] clone: --branch=<branch> always means refs/heads/<branch>
Date: Tue, 10 Jan 2012 16:57:04 +0700
Message-ID: <1326189427-20800-8-git-send-email-pclouds@gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 10:58:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYTM-0005WL-An
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878Ab2AJJ6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 04:58:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48718 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672Ab2AJJ6X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 04:58:23 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so664914iab.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 01:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wyVWD9Qb+20UpqPF/GeVaGga+sYTAJmTTF3Zp6jlIH0=;
        b=awr1uu0XrNKTFCfa3tKuNVjZI5/KoNKP7llv6QWZLMi9v3ZC1hmoy/52ipzh8c2XNW
         Th0k354UFM1/CoREG3/GsjBjBbImKXNZ8vh/VSldnHYTv+aR/8mtZANW128dBKJK+72O
         hSCA0Aicns+0atnHO9MEu0c1OQTEG8tYkkB/0=
Received: by 10.50.168.4 with SMTP id zs4mr1775389igb.28.1326189502784;
        Tue, 10 Jan 2012 01:58:22 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id l28sm261454956ibc.3.2012.01.10.01.58.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 01:58:21 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Jan 2012 16:58:13 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188239>

It does not make sense to look outside refs/heads for HEAD's target
(src_ref_prefix can be set to "refs/" if --mirror is used) because ref
code only allows symref in form refs/heads/...

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 05224d7..960242f 100644
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
@@ -760,7 +760,7 @@ int cmd_clone(int argc, const char **argv, const ch=
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
