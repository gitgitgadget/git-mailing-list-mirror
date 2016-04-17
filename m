From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/7] worktree.c: avoid referencing to worktrees[i] multiple times
Date: Sun, 17 Apr 2016 19:59:24 +0700
Message-ID: <1460897965-486-7-git-send-email-pclouds@gmail.com>
References: <CACsJy8BOwzJSmS3PPeeRuaRwq=+kYLH8NX0i7P_wfDW9gLt6bA@mail.gmail.com>
 <1460897965-486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 15:00:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1armJS-0007OU-7N
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 15:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbcDQNA1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2016 09:00:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33252 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbcDQNAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 09:00:25 -0400
Received: by mail-pf0-f193.google.com with SMTP id e190so14451483pfe.0
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uu/Y3wbnJostFTlHYMLvwc3Z+b2h942GKxSDV1K3Cvo=;
        b=O2FcfZGJnolDb+hPvYfc6zhYW6KA4CckdziDKnxRxdPtIFyOI01heq9FGxYw5iH+dF
         yamE5YQSHNDouX7nL5huIYF0UM0aMrBmQSL1xgtow8p75s1I+op1r2Fv08zzVW3hdO7L
         RqkdeoeQfKWIcdYqYuZzDLTFqTN75gDC62WIK3wjcUYP61F+9LxWS+XVqx1Y1lEkOP+L
         1ifo9vOkvBbc5BgR/rdvLxHOe7lDi/ke6ZFxV7EZmrt6mvZe1j0ji5IDnmHg2rE7lubK
         TAUg/CVfb73Xq8d8Bq2i0GPKVHiKcjfBT0scygU+TWmdXyw7y+TJV3Oe0awzncewhEQy
         K2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uu/Y3wbnJostFTlHYMLvwc3Z+b2h942GKxSDV1K3Cvo=;
        b=hhCs6taf9xGFv86romA74IbZbep78iznf6W3iyiM3aup9XlHqZwGLUEetqbFRRzczO
         4W2F8+cxmPO7ebrApjnuKQ+PFnfsviAG5ucayMCP+FiPVRdQz/K5hfpEX8ZU5qo6cGOv
         u1dw8uDA8/K+KQ0kBzySIfBKUvez6jWueQTwevCULLDAMxX94/aP1DbAFDOfNMdu2fDL
         VtsYarYP8POjo8MeSX9XzKdkyVYbO21CFJxV3VOWaho99dw18Msonrc47+ixgQ7eT8xX
         9DzvYgnukRL93G1Fw19IpO4QuZepRJGRdr6f4GTjylSDfWUF1bfwJDmC4A/gO6dMZ9EW
         7I3g==
X-Gm-Message-State: AOPr4FXbyYSVgPC5V0Fm61aNOUbEcpRiF9cii3IPyV0tBATi6DZ1ZqbWHrm9ew/LNfoVtg==
X-Received: by 10.98.93.67 with SMTP id r64mr23652844pfb.133.1460898024876;
        Sun, 17 Apr 2016 06:00:24 -0700 (PDT)
Received: from lanh ([171.232.186.84])
        by smtp.gmail.com with ESMTPSA id h85sm76823796pfj.52.2016.04.17.06.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 06:00:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 17 Apr 2016 20:00:33 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460897965-486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291755>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/worktree.c b/worktree.c
index c5bf583..3b7c6f2 100644
--- a/worktree.c
+++ b/worktree.c
@@ -200,10 +200,12 @@ char *find_shared_symref(const char *symref, cons=
t char *target)
 	int i =3D 0;
=20
 	for (i =3D 0; worktrees[i]; i++) {
+		struct worktree *wt =3D worktrees[i];
+
 		strbuf_reset(&path);
 		strbuf_reset(&sb);
 		strbuf_addf(&path, "%s/%s",
-			    get_worktree_git_dir(worktrees[i]),
+			    get_worktree_git_dir(wt),
 			    symref);
=20
 		if (parse_ref(path.buf, &sb, NULL)) {
@@ -211,7 +213,7 @@ char *find_shared_symref(const char *symref, const =
char *target)
 		}
=20
 		if (!strcmp(sb.buf, target)) {
-			existing =3D xstrdup(worktrees[i]->path);
+			existing =3D xstrdup(wt->path);
 			break;
 		}
 	}
--=20
2.8.0.rc0.210.gd302cd2
