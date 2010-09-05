From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/17] rev-list: do not do commit simplification if simplify_history = 0
Date: Sun,  5 Sep 2010 16:47:28 +1000
Message-ID: <1283669264-15759-2-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:48:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os91i-0007mC-MB
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109Ab0IEGs1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:48:27 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35696 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab0IEGsW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:48:22 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1071512pvg.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=itCyzIqDGYDroqaFejKM4hojIwfCM+N5/xlUcWmfYtw=;
        b=xzY4TnZjHUUK0GrsomrE6D4bUZLbISAUCjyESvBVSCLfXu6SuHqWvZvZE1DTSZ334C
         y1f+pgdbtTFIbg7k2kiMr8FCt1Byw6vnuTPHD5RZJIQnFyAe7/sC3cYQi4t05EIrAIG+
         S/YYqD5XikDb9dlS6uFFAwOB8I2MxzSbGpuTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SWxfNeLEUtRCesq1fm3LWLpgdZXj+FXSBbcL17jEoasj/YjxCXGDrPgM5jq3uhX6e/
         Jwo3oNPX2TtwTLf9JytNNJV/N/Qsbzzlql9+irzhjRcj62cDEYNHYMi/nUULoYtDHTpH
         KWXzaZX3uDqh0jb9ZSvtmvliHk2P4BdPVKkg4=
Received: by 10.114.133.18 with SMTP id g18mr1869567wad.48.1283669302244;
        Sat, 04 Sep 2010 23:48:22 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id d2sm8037080wam.2.2010.09.04.23.48.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:48:21 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:48:14 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155426>

This is just a workaround to make my series work. Currently, commit
chain will be simplified if pathspecs are given. That would make
pack-objects generate commit chain with gaps.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Equivalence of Elijah's evil commit, 14/15.

 builtin/pack-objects.c |    1 +
 revision.c             |    2 +-
 upload-pack.c          |    1 +
 3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0e81673..789f6bf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2072,6 +2072,7 @@ static void get_object_list(int ac, const char **=
av)
=20
 	init_revisions(&revs, NULL);
 	save_commit_buffer =3D 0;
+	revs.simplify_history =3D 0;
 	setup_revisions(ac, av, &revs, NULL);
=20
 	while (fgets(line, sizeof(line), stdin) !=3D NULL) {
diff --git a/revision.c b/revision.c
index 55c4586..ea64970 100644
--- a/revision.c
+++ b/revision.c
@@ -372,7 +372,7 @@ static void try_to_simplify_commit(struct rev_info =
*revs, struct commit *commit)
 	/*
 	 * If we don't do pruning, everything is interesting
 	 */
-	if (!revs->prune)
+	if (!revs->prune || !revs->simplify_history)
 		return;
=20
 	if (!commit->tree)
diff --git a/upload-pack.c b/upload-pack.c
index fc79dde..cc1983f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -115,6 +115,7 @@ static int do_rev_list(int in, int out, void *user_=
data)
 	revs.tag_objects =3D 1;
 	revs.tree_objects =3D 1;
 	revs.blob_objects =3D 1;
+	revs.simplify_history =3D 0;
 	if (use_thin_pack)
 		revs.edge_hint =3D 1;
=20
--=20
1.7.1.rc1.69.g24c2f7
