From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/6] worktree.c: add is_main_worktree()
Date: Mon, 30 May 2016 17:49:36 +0700
Message-ID: <20160530104939.28407-4-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 30 12:50:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7KmF-0005KH-2h
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 12:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbcE3KuZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 06:50:25 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35206 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbcE3KuX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 06:50:23 -0400
Received: by mail-pf0-f194.google.com with SMTP id f144so15014218pfa.2
        for <git@vger.kernel.org>; Mon, 30 May 2016 03:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vzp776LmnDHZLrhLOeT+gsKDkherEIfh0+P5srkJfZE=;
        b=f3hhtE1NLcQzmsOBcv2rohDQzpVkwgXDpaJG4vTqJ6JbTNP9chEsbK7SJXE6E+g2Ee
         NZ8nY9o4kjPlDb2volsndzLN5UHmb8lfEKqjb9l4FLG6VlHloe3Ck+TSLhGhGsm8Pegx
         x3o2ss0MwStqOfD1kktiD2RBcwDXHb+gXQrt6Ao+QF+mgF3COiZELmiIVCv9udsi+adV
         oabe21qmCop7s7nYZSTspFTv/POa9tvPiAdch+CYw284Y6f9TMIFUZEdPUJKLq57XNMl
         MVs8MgT0fWGraaTyOyEe5yhrgirvM6NkdWlrQ62PCt/8+hpD6r4uGPdiOYYL1gHrUSY6
         +qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vzp776LmnDHZLrhLOeT+gsKDkherEIfh0+P5srkJfZE=;
        b=VtgIdmpc4ntDhFeQa0y/TzL6t/2GHewzNfQOaFXjZ0H+vbMTKwGIYTfdl52lbjg6J8
         s2c12feVitfS6X51EQ6JYg422no0Ytjx/p26MGGZXIoy7P+E8dKaIefIiRQohvHVwpbD
         zXj8IYUAEbm2dhoRpnZIhsfcSm9oUREgLUcbZQ32h+hrrspcAG8VBVOWDOI3whcARg5R
         UkRSXiTK/nyfkk7gSw2P2CWh+aX2t397QoE9sL8U4GL4YZfYdlOnnfMSHaOIaQzYU5xk
         cYXVY/VePk458VDCC8Gu39459+nB4Yc/YieyNiPhMeXUw2toimH5DHR47YR1HllA5pOC
         uvgQ==
X-Gm-Message-State: ALyK8tKsgT9XkIrB8htzRKa6xycvBupXUVw/H8s5nzYf7jHTTAiSAATGJ1L6PaVpp/8i0g==
X-Received: by 10.98.22.141 with SMTP id 135mr44609949pfw.116.1464605423044;
        Mon, 30 May 2016 03:50:23 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id o2sm31978111pfi.85.2016.05.30.03.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2016 03:50:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 30 May 2016 17:50:17 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160530104939.28407-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295882>

Main worktree _is_ different. You can lock a linked worktree but not th=
e
main one, for example. Provide an API for checking that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 5 +++++
 worktree.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/worktree.c b/worktree.c
index 4dd7b77..6432eec 100644
--- a/worktree.c
+++ b/worktree.c
@@ -250,6 +250,11 @@ struct worktree *find_worktree(struct worktree **l=
ist,
 	return *list;
 }
=20
+int is_main_worktree(const struct worktree *wt)
+{
+	return !wt->id;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 7ad15da..e1c4715 100644
--- a/worktree.h
+++ b/worktree.h
@@ -37,6 +37,11 @@ extern struct worktree *find_worktree(struct worktre=
e **list,
 				      const char *prefix,
 				      const char *arg);
=20
+/*
+ * Return true if the given worktree is the main one.
+ */
+extern int is_main_worktree(const struct worktree *wt);
+
 /*
  * Free up the memory for worktree(s)
  */
--=20
2.8.2.524.g6ff3d78
