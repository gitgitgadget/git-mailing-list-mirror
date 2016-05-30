From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/6] worktree.c: find_worktree() learns to identify worktrees by basename
Date: Mon, 30 May 2016 17:49:35 +0700
Message-ID: <20160530104939.28407-3-pclouds@gmail.com>
References: <20160522104341.656-1-pclouds@gmail.com>
 <20160530104939.28407-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 12:50:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7KmA-0005IK-Am
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 12:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbcE3KuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 06:50:20 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34486 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbcE3KuT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 06:50:19 -0400
Received: by mail-pa0-f66.google.com with SMTP id x1so4706106pav.1
        for <git@vger.kernel.org>; Mon, 30 May 2016 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ePaA65DgbrzAvZz6Uvop7n2OPBVuE1+9qwHIaQ0r2o0=;
        b=EljCXPxIF4ARujvWiqy85TH0YQvr64JIZ66oZ1aKVHbNdeF0/xfGGsD1m/a+ktYXs0
         1ZU3u38Yzuq5riGKnaG4qdLDkG8IDewakO6pPdhtyGsI8GgMs6UAGAgyebAEB7BP71bI
         2PZWslvDLLMlnfuOiMmVOp8VlA+xR/T7NSvWKiqH5pp5l5pkjf+LOXrb6B4lKuMhpW86
         5ZcWs2wwUWUiJrMb9+HCqfTl1FrvNcsfHm/6A0wGHkmK+tklD7b6uKh1//X8Bz+Yzgls
         HUtzKdnOG87PxCevCpeUp1EuR2ATyB7b81dXAFYgUzbIqoWazPVGslH9g9H6M+No86xW
         HXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePaA65DgbrzAvZz6Uvop7n2OPBVuE1+9qwHIaQ0r2o0=;
        b=kiPsY/sy4LK2IBAQ+xnNJC6fHC6PsKXYW4w2K2KqnvZ1Gtuh73o+UK+I9/rpfUwPcR
         m2TcGIbrx9OeeCbh6llzk3K4RbKOYXFewBG9bt9S7WeAtzp0SsMQYACNbkH23QyNKCL2
         GlgFK8Ih/Q2ipV3x9/aZUbDCxApS+t1bxUhaXUXPfzEHeM/RYRp9JB9e0BMfpYEGUY+W
         +bNUY0P+aR18829hHIHlpZaGITrslOHiCL86OTDY4XXwQEuAGJ0iO7K3e67XC6FnyYIb
         1c+3P1zHobXUqYoTkF74ev6aeV8HU3JO2+DrqV9MWA2pJQFtXwi8UqVRx9DGSSInf9QT
         jGpw==
X-Gm-Message-State: ALyK8tIKJYzMnAQrWplIdGi6NCvkmKz/L2EL07G+zDCEWuimtHAqrcs3aLb28Q9ho2IDgg==
X-Received: by 10.66.6.35 with SMTP id x3mr45411475pax.135.1464605417450;
        Mon, 30 May 2016 03:50:17 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id f191sm32055333pfa.26.2016.05.30.03.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2016 03:50:16 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 30 May 2016 17:50:12 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160530104939.28407-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295881>

This allows the user to do something like "worktree lock foo" instead o=
f
"worktree lock <path/to/foo>". With completion support it could be quit=
e
convenient. While this base name search can be done in the same worktre=
e
iteration loop, the code is split into a separate function for clarity.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/worktree.c b/worktree.c
index 0782e00..4dd7b77 100644
--- a/worktree.c
+++ b/worktree.c
@@ -214,12 +214,33 @@ const char *get_worktree_git_dir(const struct wor=
ktree *wt)
 		return git_common_path("worktrees/%s", wt->id);
 }
=20
+static struct worktree *find_worktree_by_basename(struct worktree **li=
st,
+						  const char *base_name)
+{
+	struct worktree *found =3D NULL;
+	int nr_found =3D 0;
+
+	for (; *list && nr_found < 2; list++) {
+		char *path =3D xstrdup((*list)->path);
+		if (!fspathcmp(base_name, basename(path))) {
+			found =3D *list;
+			nr_found++;
+		}
+		free(path);
+	}
+	return nr_found =3D=3D 1 ? found : NULL;
+}
+
 struct worktree *find_worktree(struct worktree **list,
 			       const char *prefix,
 			       const char *arg)
 {
+	struct worktree *wt;
 	char *path;
=20
+	if ((wt =3D find_worktree_by_basename(list, arg)))
+		return wt;
+
 	arg =3D prefix_filename(prefix, strlen(prefix), arg);
 	path =3D xstrdup(real_path(arg));
 	for (; *list; list++)
--=20
2.8.2.524.g6ff3d78
