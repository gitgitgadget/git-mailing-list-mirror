From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/6] clone: --branch=<branch> always means refs/heads/<branch>
Date: Sun,  8 Jan 2012 18:46:26 +0700
Message-ID: <1326023188-15559-4-git-send-email-pclouds@gmail.com>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 12:48:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjrEG-0000t7-TC
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 12:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab2AHLrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 06:47:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39267 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab2AHLra (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 06:47:30 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so5239138iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 03:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CfThf+CHyaQnxpQlxXUePtI3gp4K2yreZIBi26RpKeo=;
        b=aIuhdmNbn4T8RtOnRksR5nUa7AJ+T7RBgODknDITkUmUzjkLEcqHGp8JXYAO134TBZ
         D/7VGLTp4DYMB7Gdlbv5ipd8La/Zd5ypPs7PQ0iWnanQQ+2UzDR5ipjJdrxUe7ftgsGl
         qSfU7cYMA7wM2wXQf/SQNr2Ku1Z3fV3Zj7T9o=
Received: by 10.50.34.233 with SMTP id c9mr14630464igj.19.1326023249869;
        Sun, 08 Jan 2012 03:47:29 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.35.243])
        by mx.google.com with ESMTPS id x18sm237729502ibi.2.2012.01.08.03.47.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 03:47:29 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 08 Jan 2012 18:47:01 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188102>

It does not make sense to look outside refs/heads for HEAD's target
(src_ref_prefix can be set to "refs/" if --mirror is used) because ref
code only allows symref in form refs/heads/...

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 100056d..914fd6b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -727,7 +727,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 		if (option_branch) {
 			struct strbuf head =3D STRBUF_INIT;
-			strbuf_addstr(&head, src_ref_prefix);
+			strbuf_addstr(&head, "refs/heads/");
 			strbuf_addstr(&head, option_branch);
 			our_head_points_at =3D
 				find_ref_by_name(mapped_refs, head.buf);
@@ -763,7 +763,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 			      reflog_msg.buf);
 	}
=20
-	if (our_head_points_at) {
+	if (our_head_points_at &&
+	    !prefixcmp(our_head_points_at->name, "refs/heads/")) {
 		/* Local default branch link */
 		create_symref("HEAD", our_head_points_at->name, NULL);
 		if (!option_bare) {
--=20
1.7.8.36.g69ee2
