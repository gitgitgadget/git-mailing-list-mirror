From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 19/26] worktree.c: add is_worktree_locked()
Date: Tue, 16 Feb 2016 20:29:20 +0700
Message-ID: <1455629367-26193-20-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:31:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfiq-0003mH-RM
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbcBPNbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:31:12 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36128 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932405AbcBPNbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:31:07 -0500
Received: by mail-pf0-f170.google.com with SMTP id e127so105512817pfe.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XF7a4UNSElcT5En5QlVQy3d1JAqO7iOOHdVOlQebRA4=;
        b=EFHBxq8pmNfsqFZWtcrm2UwWmgwtiz0ZEyIKBk6zAX7M0TLgFDCMW+OZnFID4YSEnF
         7pRgGw1hQgMCy8Oe8wT7Zz5BoU5WlGCk5zgIEGhxmniEnQ4gq8JX033HqT5VNlJbVOSf
         st0HjdD/rbKPxy1j06UTDZtEulYwkljAqN4qn1Ov8R6sXMUjKeEEW0IYDDb9tl8RUsuL
         6cUA8fAHc0q+3TZbYPb06PjGW+SGh3RrEaX7N+PEhTlucu95t6R2fWn9Po9rRwIVgwr5
         HeKvnqmZHGpgyKLx/G6c5WkDGLW1NXBf7pLqTMFZ5OJlJw8RLjt+X0AoepFKISwYeU0Q
         3oPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=XF7a4UNSElcT5En5QlVQy3d1JAqO7iOOHdVOlQebRA4=;
        b=KhrKbsIChXenm3FocdCB3NDeaGjGFEAgpwbMmz5Cbf7HTKfMIUe+WY5MLifVD/NeaO
         hfbSR9qJJiJIwEgN2YpLv6WPlm7TO6HILN3Sw8mB1wUenjNVEpxPyDj1rwFLK/ZQ21g1
         bQ5WSzoI1TRcX1Hi6//6Ej1CGbEukM+0hkL6yAkNPX0QKckQcI/6jF4qSIxjrR0agKmD
         +YCzGoNcIKVOIS6BwiE5F6gh4jyzpBLB18vgxfBoHUFMV71TPAFkshzhlRAm4UGb22aq
         hZw8yAC3vcAMzXItqlnRy5pyVjApwmUPUtdkfbClFRSZInRjorbk9fDJUyMT2GtdYwHa
         CUAw==
X-Gm-Message-State: AG10YOTuxyqapxCOaoy4cAxkljOCzP4EXrCgZ5B6LpFe3dDjfXEaB1n4TmDajroQWPYjGQ==
X-Received: by 10.98.69.1 with SMTP id s1mr9166059pfa.120.1455629467237;
        Tue, 16 Feb 2016 05:31:07 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id bx1sm46063366pab.33.2016.02.16.05.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:31:06 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:31:30 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286386>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 18 ++++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/worktree.c b/worktree.c
index 04aac73..facb907 100644
--- a/worktree.c
+++ b/worktree.c
@@ -219,6 +219,24 @@ int is_main_worktree(const struct worktree *wt)
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
 static int report(int quiet, const char *fmt, ...)
 {
 	va_list params;
diff --git a/worktree.h b/worktree.h
index bbe40ef..cbd5389 100644
--- a/worktree.h
+++ b/worktree.h
@@ -39,6 +39,12 @@ extern struct worktree *find_worktree_by_path(struct=
 worktree **list,
 extern int is_main_worktree(const struct worktree *wt);
=20
 /*
+ * Return the reason string if the given worktree is locked. Return
+ * NULL otherwise.
+ */
+extern const char *is_worktree_locked(const struct worktree *wt);
+
+/*
  * Return zero if the worktree is in good condition.
  */
 extern int validate_worktree(const struct worktree *wt, int quiet);
--=20
2.7.0.377.g4cd97dd
