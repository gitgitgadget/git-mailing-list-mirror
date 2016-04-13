From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/25] worktree.c: add is_worktree_locked()
Date: Wed, 13 Apr 2016 20:15:39 +0700
Message-ID: <1460553346-12985-19-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:17:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKfk-0004bM-9q
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760676AbcDMNR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:17:29 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36647 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760672AbcDMNR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:17:26 -0400
Received: by mail-pa0-f67.google.com with SMTP id k3so3915194pav.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JMOC0efGhUqjKUR2vNKd5GVMTZHn/TsZBY38AR1mJF0=;
        b=leDg4ItvPhGYS+EGTOihn4dQPRtezqrlFAXZ21qEGob53PX8YHLgB6KrnANB+be7ZK
         l5UgN0ags7HPApuPFVYhA7ALjY46m7j6KrdLUzLCXYdhmSgNI40RTWunLRuTUctcqiJD
         N7U1gO0X7J+AXKRSH2qPr3bZVL8+t9WibiRLtRVKo944GynlXQyIAYLaYasoBfBU5FRx
         7HSdLY+b58cqtWvuC5xq8/8/YJJgGJ+sGCU8dxxI0kRuNxPOxh9KhPtGhB37MjWUO6PN
         xMfKJ4TUJSFhL1WK6M3tkABXYEOF1N4RlWB9p0e9YwRoWCHdPTF14WadgdHabH+wDR8W
         aKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JMOC0efGhUqjKUR2vNKd5GVMTZHn/TsZBY38AR1mJF0=;
        b=Ei3vlJMAgz500Di3kas5mUbmKeg6j4ebzYel/IpGhwrwz2zL7MESpH5lTATd7257+7
         ANzCX+V3XQPtFu40y+I4ULb6mifrzyMa+23ErzIqJc1uOWnqq1ZIl33PtgAJbRo0zt+4
         630RxUvTZ7TEvTLuinD12xxPaw1oDP1SILDmztVwovtj8GhLSurwcxCNr8Ktq8sxo56q
         H0cXo5UlwAE7ExOZshd5Z77YlUXselY2EEX3ubPIZlpclJYA33Mle1bTwXw3+Mo7v2kd
         hRkHl0Fa/2PqPQWR293YYTqN4SBLemq8hjJJ8/tm+gW+ASiTsPLzKQx18zuKsuUxUPM5
         pYPw==
X-Gm-Message-State: AOPr4FVxUg0IkFD4eqW5jAQzUJ0nrAmDPVrNZelD2ScRKxP5zX4Btil1hi99dmOkn8x91Q==
X-Received: by 10.66.232.226 with SMTP id tr2mr12893895pac.44.1460553446192;
        Wed, 13 Apr 2016 06:17:26 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id p189sm30677690pfb.51.2016.04.13.06.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:17:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:17:32 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291437>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 18 ++++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/worktree.c b/worktree.c
index e526e25..37eec09 100644
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
2.8.0.rc0.210.gd302cd2
