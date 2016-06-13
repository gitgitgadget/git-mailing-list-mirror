From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 3/6] worktree.c: add is_worktree_locked()
Date: Mon, 13 Jun 2016 19:18:23 +0700
Message-ID: <20160613121826.21631-4-pclouds@gmail.com>
References: <20160603121944.28980-1-pclouds@gmail.com>
 <20160613121826.21631-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 14:19:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCQpu-0004X6-Ov
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 14:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbcFMMTR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 08:19:17 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33574 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965049AbcFMMTP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 08:19:15 -0400
Received: by mail-pa0-f66.google.com with SMTP id ts6so3395149pac.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8e4n8LaTRZ18wkHWDnP2znRpYTx1xQlqQs2EKVxZzCM=;
        b=EZ5/+4nYTvTXNzP1iStX94wXBr5srrEbBRhCWKDWVN3LIngXRZZJi2G3TcvS9m75TH
         8JYkxgp0darhn3MTn/XOMgtL5qSEA6T8KtN9bXSiqPolgaeRQDunQbiw/aDtmZlJgaDJ
         MBUWTYnMFAE2LGHcQ9AwAAp0XcIAskvtiWfVTr76O0+Jz/khJ5bFD3YcL88Ptje/z6Bp
         RgoQL8ReUQKTm+qGwCDakhyqfnE7kCYAuTMVwiJWCnMSpTer8kh1eBEnInaiFEw8XhDC
         dKz1jXU3O8XKWQz0YktLqJ+Dq8WGKmcbjhXPxXzatg6WhVhcMGQAGgHo6AKnNSizdX8i
         SxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8e4n8LaTRZ18wkHWDnP2znRpYTx1xQlqQs2EKVxZzCM=;
        b=lagOb6l/4/55Zbh7YqCky6KIPX8TnD9tVaGPUWq9OROQK4vmRq8IoAhaHfqKSfOnNf
         QY0/3WAC80WAjd8WeUS2BSGJj0c8apgrgkUQ/DkgdTzNQse++kYtjWrT2q4pJDxbqBjF
         qbu/iJRA/ICS9XXOmWkE7zfFU+tTtzUw+ZeZDM1TgdCTBOfGpYmyi85uwfkOFjpQ6bEf
         NDa3BjC/DDqvcPLYvprZXa7MGS3xCozpe1ZSxlxKyC9UcFN7YepiBsTxmg5uyppDawMk
         CKS+A0QbYGXSIs/MWp4PlvzgFRe9Im7TP9IqhoxRQYZqhz2ZEnYmEqx50++u3zhwxYeH
         XMlA==
X-Gm-Message-State: ALyK8tIcDXkOccviQLAjUxgRmmLvsI+S4Ue9GEDOpEe1LBPjcxdQBzt+CXH8w2undKpfLg==
X-Received: by 10.66.221.66 with SMTP id qc2mr21498115pac.147.1465820355003;
        Mon, 13 Jun 2016 05:19:15 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id i17sm37343978pfj.77.2016.06.13.05.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2016 05:19:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Jun 2016 19:19:10 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160613121826.21631-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297183>

We need this later to avoid double locking a worktree, or unlocking one
when it's not even locked.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 28 ++++++++++++++++++++++++++++
 worktree.h |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/worktree.c b/worktree.c
index 12a766a..2bcfff3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -13,6 +13,7 @@ void free_worktrees(struct worktree **worktrees)
 		free(worktrees[i]->path);
 		free(worktrees[i]->id);
 		free(worktrees[i]->head_ref);
+		free(worktrees[i]->lock_reason);
 		free(worktrees[i]);
 	}
 	free (worktrees);
@@ -98,6 +99,8 @@ static struct worktree *get_main_worktree(void)
 	worktree->is_detached =3D is_detached;
 	worktree->is_current =3D 0;
 	add_head_info(&head_ref, worktree);
+	worktree->lock_reason =3D NULL;
+	worktree->lock_reason_valid =3D 0;
=20
 done:
 	strbuf_release(&path);
@@ -143,6 +146,8 @@ static struct worktree *get_linked_worktree(const c=
har *id)
 	worktree->is_detached =3D is_detached;
 	worktree->is_current =3D 0;
 	add_head_info(&head_ref, worktree);
+	worktree->lock_reason =3D NULL;
+	worktree->lock_reason_valid =3D 0;
=20
 done:
 	strbuf_release(&path);
@@ -234,6 +239,29 @@ int is_main_worktree(const struct worktree *wt)
 	return !wt->id;
 }
=20
+const char *is_worktree_locked(struct worktree *wt)
+{
+	assert(!is_main_worktree(wt));
+
+	if (!wt->lock_reason_valid) {
+		struct strbuf path =3D STRBUF_INIT;
+
+		strbuf_addstr(&path, worktree_git_path(wt, "locked"));
+		if (file_exists(path.buf)) {
+			struct strbuf lock_reason =3D STRBUF_INIT;
+			if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
+				die_errno(_("failed to read '%s'"), path.buf);
+			strbuf_trim(&lock_reason);
+			wt->lock_reason =3D strbuf_detach(&lock_reason, NULL);
+		} else
+			wt->lock_reason =3D NULL;
+		wt->lock_reason_valid =3D 1;
+		strbuf_release(&path);
+	}
+
+	return wt->lock_reason;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index e1c4715..90e1311 100644
--- a/worktree.h
+++ b/worktree.h
@@ -5,10 +5,12 @@ struct worktree {
 	char *path;
 	char *id;
 	char *head_ref;
+	char *lock_reason;	/* internal use */
 	unsigned char head_sha1[20];
 	int is_detached;
 	int is_bare;
 	int is_current;
+	int lock_reason_valid;
 };
=20
 /* Functions for acting on the information about worktrees. */
@@ -42,6 +44,12 @@ extern struct worktree *find_worktree(struct worktre=
e **list,
  */
 extern int is_main_worktree(const struct worktree *wt);
=20
+/*
+ * Return the reason string if the given worktree is locked or NULL
+ * otherwise.
+ */
+extern const char *is_worktree_locked(struct worktree *wt);
+
 /*
  * Free up the memory for worktree(s)
  */
--=20
2.8.2.524.g6ff3d78
