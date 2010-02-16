From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 16/26] mailinfo: move up gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:05:07 +0700
Message-ID: <1266336317-607-17-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:15:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ5X-0005oF-Mu
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173Ab0BPQPp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:15:45 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:36915 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab0BPQPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:15:43 -0500
Received: by mail-gx0-f227.google.com with SMTP id 27so89623gxk.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=E4MZYzO8vCmWAHe2E5TfxeLzsflasn/pEtGNBLHz3SA=;
        b=qPD30byA6hbqIBgFj6NKiSLd6cVQnd6FDwN/4SmAK89KUsS8Lw7xpweWrV/URbFRpc
         gdgFFDQhnudV/FbmWFgpkI5UJhlZoTUTqke5Z8wvRsDhM0TklP/YDWpNUbFr+mnfvHY1
         5vkUT3+Zf0MuuNUJDch4tIAg4ASidR0MzM3rY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jq8tKLfD7a3FNT/l0YZQXOOub+TJjMB1oXnCav/MD/yOIKsC00rmMGwoXM3BbxNX+O
         unerpNuhrwY1DAzKRyEv5PeCFmG/R6mWVSMPGugAfpLPZfJzAVDfVbSCAw0jD8tSjtGs
         VE8eh+6kF4aq3hDP/ystrKgPULeeV5BaIeoNU=
Received: by 10.150.252.8 with SMTP id z8mr3891299ybh.232.1266336583393;
        Tue, 16 Feb 2010 08:09:43 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 6sm2835106ywc.23.2010.02.16.08.09.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:09:42 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:07:00 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140120>

mailinfo may use repo config, so setup gitdir first.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-mailinfo.c |    3 ---
 git.c              |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index a50ac22..af72151 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -1027,9 +1027,6 @@ int cmd_mailinfo(int argc, const char **argv, con=
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
index 24fc0fc..8386a3a 100644
--- a/git.c
+++ b/git.c
@@ -352,7 +352,7 @@ static void handle_internal_command(int argc, const=
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
