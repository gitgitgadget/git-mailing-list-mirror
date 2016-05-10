From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] worktree.c: add is_worktree_locked()
Date: Tue, 10 May 2016 21:17:27 +0700
Message-ID: <20160510141729.23063-3-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160510141729.23063-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 16:18:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08U5-0000Nv-TX
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbcEJORx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 10:17:53 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33684 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbcEJORw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:17:52 -0400
Received: by mail-pa0-f67.google.com with SMTP id gh9so1007006pac.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPUwmk15aIIDfgJdjkJ9LWOJ9I0C0WdlxPuOytRQ7lk=;
        b=H/PYK5GszSkt2PvKd+A4vPJ2kbFxLJvgKsVUdbLXmNnhxJFOXrp0KeZjrF70WRp0t4
         HUoFTmAmb7e3U/mh1vlrf10A7a8U5eHB0EGgkPcOL3rM/vdhu37xKTuN6GhbBlz0sEql
         yGEFvP5iFaLYyh/7ZdvANiXa3FoRcMg8ipPHztkmPLEX05izHGyy64TkNV5EX3woWGDo
         aMAC852tuirDUVzlgTtSE9oh+ltmYEIt2niJqk4D/04Rm6S965MbeJ3y880Ap7KV7+KY
         6DHp1yq8GZgeO6FzeMVwjVrMRWplXKyb1Pxvdo7OKOhAQyZJL+O+Q+HhbQeJD3+NbpJg
         nM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPUwmk15aIIDfgJdjkJ9LWOJ9I0C0WdlxPuOytRQ7lk=;
        b=SwuZxA98mGQVZ4K4Dp30Zkos7so98zAl/+iFfUUq4XiCpf6fgPBqrnIwYgb/Ed67cm
         2rQpWzP+dbCymVGYoN/xs7fZSsiTDCYJ5IzKNKZ13VIdqzAJc02RChIx73kTvksS/JRb
         1Vopx4fZ6VTJFOCsVtu09ZkVTGDY5UOA0uWRBbkZhsrBsS4k6xNVzVvNMnrQu6Dk/5+3
         tPo25yBb1gK91G955tMX8ljHpKZ3jV248K+iTzdplIwbFWV4QHR5Pw+onIQiYdNI9d48
         J4ie3Ho0GACAifEleMxIE/WtTK9lNMveSxVIXdehUlOn4/MvuHEg1y8AhlRAPD0rgPBs
         WGog==
X-Gm-Message-State: AOPr4FXJVTDUj00zZl3+4jk+A1UkVxxswtj2RFRW/hdUU9KO3Kbh7eUW9yaYwQm/W4BHIA==
X-Received: by 10.66.139.199 with SMTP id ra7mr57707496pab.111.1462889871543;
        Tue, 10 May 2016 07:17:51 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id yp9sm4932957pab.42.2016.05.10.07.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:17:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:17:53 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141729.23063-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294145>

This provides an API for checking if a worktree is locked. We need to
check this to avoid double locking a worktree, or try to unlock one whe=
n
it's not even locked.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 18 ++++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/worktree.c b/worktree.c
index 37fea3d..6805deb 100644
--- a/worktree.c
+++ b/worktree.c
@@ -243,6 +243,24 @@ int is_main_worktree(const struct worktree *wt)
 	return wt && !wt->id;
 }
=20
+const char *is_worktree_locked(const struct worktree *wt)
+{
+	static struct strbuf sb =3D STRBUF_INIT;
+
+	if (!file_exists(git_common_path("worktrees/%s/locked", wt->id)))
+		return NULL;
+
+	strbuf_reset(&sb);
+	if (strbuf_read_file(&sb,
+			     git_common_path("worktrees/%s/locked", wt->id),
+			     0) < 0)
+		die_errno(_("failed to read '%s'"),
+			  git_common_path("worktrees/%s/locked", wt->id));
+
+	strbuf_rtrim(&sb);
+	return sb.buf;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 77a9e09..12906be 100644
--- a/worktree.h
+++ b/worktree.h
@@ -40,6 +40,12 @@ extern struct worktree *find_worktree_by_path(struct=
 worktree **list,
  */
 extern int is_main_worktree(const struct worktree *wt);
=20
+/*
+ * Return the reason string if the given worktree is locked. Return
+ * NULL otherwise.
+ */
+extern const char *is_worktree_locked(const struct worktree *wt);
+
 /*
  * Free up the memory for worktree
  */
--=20
2.8.2.524.g6ff3d78
