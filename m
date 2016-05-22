From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/5] worktree.c: add is_worktree_locked()
Date: Sun, 22 May 2016 17:43:39 +0700
Message-ID: <20160522104341.656-4-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160522104341.656-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 12:44:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Qs4-0001zn-4w
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 12:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbcEVKo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 06:44:29 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35784 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbcEVKo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 06:44:27 -0400
Received: by mail-pa0-f67.google.com with SMTP id rw9so15154575pab.2
        for <git@vger.kernel.org>; Sun, 22 May 2016 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4HqDyD0uN/D7KmF1KbDYLAqb1JUZMFX+0z8zOiZPj4=;
        b=V/3lBbUMjzW4pumym7TBTjNMKDh4qv1mWOhd5FM55kOeiMC47ykkf3lWV5HBkGsqkC
         9M/vBGr8ZnAfQcW2m9CMi6LsJ/jR5W1zV/Hj8JXwjgm/cFqtlKp2sstfiArBAZ4leofo
         dm3Nr29lWNZd9QNqnYaUx+9NOl/PQSj/zcSfvS20njGKw092w4Es7lxWTUZno7/WSwDu
         gLEFaF0Wj0BvqAQSCqyDVQ1QaJDbrrBCk41T3/3aRHbK5wMc8mNMsNv37F/kNO0bsknn
         +vvf++0Xvob6euyUGDfMVe6zKYuxoWeILEqZ2GFw+yzr5egdnJuch1+C4hjYTBdKFGW2
         YPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4HqDyD0uN/D7KmF1KbDYLAqb1JUZMFX+0z8zOiZPj4=;
        b=dCamTc8VOVT13m+tQUhfthYBgN3vfynFWdXdm2WxWxOvg9SthekX57JSVsA3GKQT7k
         0xRB0CVGPJwvvPnPAsvJYj+nx82bM70c1o4kmXMSXqnG+WA0s85AR8YDCfujNaMdQRgq
         KbOschuNkUUq20cQ7QgloXsfz7C1Pa/q/4tga9QQ86Mqk8I8WlLSz9d9eu7er+Ry1R/e
         K/FpgANol2P7FTbhi/reA4OpNTz3VxKiCO/PBVT8gGUptIOQyrYj+CUN+HSXBOWjv2k7
         O1RIL6/aoR7iPFQN3bCl2vZpbzwe1jBpPJieUynw6ZLkuVlcuR89PrXohk5pGlWvEUmY
         GrqQ==
X-Gm-Message-State: AOPr4FVS5rObm9FHDDH7dYFC4DXEmSZ7TUnsbTHxQfgtVQ61M4M6ioA9QJT5+74P1AZ7Gg==
X-Received: by 10.66.176.103 with SMTP id ch7mr18667421pac.20.1463913866731;
        Sun, 22 May 2016 03:44:26 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id b64sm38981895pfa.48.2016.05.22.03.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 03:44:26 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 17:44:20 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522104341.656-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295273>

This provides an API for checking if a worktree is locked. We need to
check this to avoid double locking a worktree, or try to unlock one whe=
n
it's not even locked.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 21 +++++++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/worktree.c b/worktree.c
index 6b3015b..cb30af3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -231,6 +231,27 @@ int is_main_worktree(const struct worktree *wt)
 	return !wt->id;
 }
=20
+const char *is_worktree_locked(const struct worktree *wt)
+{
+	static struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf path =3D STRBUF_INIT;
+
+	strbuf_git_common_path(&path, "worktrees/%s/locked", wt->id);
+
+	if (!file_exists(path.buf)) {
+		strbuf_release(&path);
+		return NULL;
+	}
+
+	strbuf_reset(&sb);
+	if (strbuf_read_file(&sb, path.buf, 0) < 0)
+		die_errno(_("failed to read '%s'"), path.buf);
+	strbuf_release(&path);
+
+	strbuf_trim(&sb);
+	return sb.buf;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 39f1aa2..3a780c2 100644
--- a/worktree.h
+++ b/worktree.h
@@ -40,6 +40,12 @@ extern struct worktree *find_worktree_by_path(struct=
 worktree **list,
  */
 extern int is_main_worktree(const struct worktree *wt);
=20
+/*
+ * Return the reason string if the given worktree is locked. Return
+ * NULL otherwise. Return value is only valid until the next invocatio=
n.
+ */
+extern const char *is_worktree_locked(const struct worktree *wt);
+
 /*
  * Free up the memory for worktree(s)
  */
--=20
2.8.2.524.g6ff3d78
