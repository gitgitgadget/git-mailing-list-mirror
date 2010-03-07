From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/18] mailinfo: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:55:58 +0700
Message-ID: <1267937767-12504-10-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8bK-0002Hr-Nb
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738Ab0CGFAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:00:08 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab0CGFAC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:00:02 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3156711pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/ftmuwbBtLkPWwNg6UBaq05dC2nzgzIVYlSRHmW2JdE=;
        b=aYoZ3dC2Ha+rlp6g4dDC5hqdoOoNIsddRG/TsvvLdCaTC3qbIuwWRQTSXToxkPVAnO
         LEER5z4BXvohVzF7wMvI+IHd/OesLCFflm6wsDrnaaVBx6dvY77DWDz91jKU4obtkiu+
         /tKYoNbaVmieYW6Zf//g/rnO8kGZqDsl1Evi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nDdm9R5CEUy3Rr6mZK46D3w3MI+tp3jcL4x8Z/mo+OPegrirXsgIqownm6DRyNOmvJ
         gd+eWvTjxeJS6P43lRTvc60lxWFhGFhHZCRIoy+snL4c0U3TcYVg0KMdMohUl45CvetP
         YPsXvEYra3kDAry7ltLLsLuSzEMwNDeXqo6/U=
Received: by 10.141.188.32 with SMTP id q32mr2012738rvp.183.1267938002205;
        Sat, 06 Mar 2010 21:00:02 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 21sm3251477pzk.4.2010.03.06.21.00.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 21:00:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:56:46 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141653>

mailinfo may use repo config, so setup gitdir first.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mailinfo.c |    3 ---
 git.c              |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index ce2ef6b..3d2c650 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -1026,9 +1026,6 @@ int cmd_mailinfo(int argc, const char **argv, con=
st char *prefix)
 {
 	const char *def_charset;
=20
-	/* NEEDSWORK: might want to do the optional .git/ directory
-	 * discovery
-	 */
 	git_config(git_mailinfo_config, NULL);
=20
 	def_charset =3D (git_commit_encoding ? git_commit_encoding : "UTF-8")=
;
diff --git a/git.c b/git.c
index 2b59f06..326f7c7 100644
--- a/git.c
+++ b/git.c
@@ -339,7 +339,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 		{ "ls-remote", cmd_ls_remote },
-		{ "mailinfo", cmd_mailinfo },
+		{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
--=20
1.7.0.195.g637a2
