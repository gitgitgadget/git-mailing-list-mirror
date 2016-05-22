From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/5] worktree.c: add is_main_worktree()
Date: Sun, 22 May 2016 17:43:38 +0700
Message-ID: <20160522104341.656-3-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 22 12:44:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Qry-0001uR-4f
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 12:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbcEVKoX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 06:44:23 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35765 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbcEVKoV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 06:44:21 -0400
Received: by mail-pa0-f67.google.com with SMTP id rw9so15154449pab.2
        for <git@vger.kernel.org>; Sun, 22 May 2016 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=50xHo6lR5oIBKvooedXlbVZxCHMPghqn0toXVUa7Vf4=;
        b=H5T0z8I7xpOplBURCYX1SqMQ3MX9fc4HHp7v77JMwizTA6lIhINLhjxs+xuVf58etW
         DEoWLfyfPTj1t/fwiNtLA7MU4+5uKB9GOZUP40ZYkVl/mTVX3Sfq50pkOUiN/HHlZSgf
         ESMWu1GayGkOirkcGtVl0K6GwBFl8flkrCGsZ4I1s9FX4YdPUlU4h1GLeAxXHG4WZX8+
         UlIhbzW3friO0tF+2JYk667eCV++HXbFcJAJQLXLRoNcV9qfMYvDG7rv1f9GkmM91HiR
         0fKSAYdLnrqCuk/MJFzsVBQWRLDl85t2HIDxJy0WYjf02VIG7iK0Ba7JP5jpVySEI5Uj
         Mq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=50xHo6lR5oIBKvooedXlbVZxCHMPghqn0toXVUa7Vf4=;
        b=lVLa6kQPBnfQLcB4MXeg6gUpVH7rli/4pSPxKuVkvp1SeWL36cyjNtWGzE3mATS8Zx
         tlnrh+mgy4M1XJQNZFzi8oFHwfLHQ9dPzH9H1OUSmKqKv3L8DIIEMJsUoimcCvRk+xM7
         9NkhcxI+KVKXnQ6DxC6WbYsxWFBpF9VMSNwJhOGxVIT8y9s9WLxCmCnFojXVHglr6aTA
         v/YhZJZwjbANQwbeQQUHo3EGcNs68cwLzVgmJHKQxOBuZcUzwbX0LvoKHw5FRcNRBKWo
         Mo0ZJwg39700OBY65WHy9RqxSgzgg0hUmOzLlVmfMqVvQVoT7tjvCioK6LerGzCBrsv1
         /IVA==
X-Gm-Message-State: AOPr4FU7AdeLtBFowsEm2kxitc08yWhTkhoAVuZyUCSMuGKdgevJsEnnfwWShdBmY/MVqw==
X-Received: by 10.66.152.164 with SMTP id uz4mr18882472pab.9.1463913860520;
        Sun, 22 May 2016 03:44:20 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id m190sm38985865pfm.29.2016.05.22.03.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 03:44:19 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 17:44:13 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522104341.656-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295272>

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
index c5d45a6..6b3015b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -226,6 +226,11 @@ struct worktree *find_worktree_by_path(struct work=
tree **list,
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
index 91627fd..39f1aa2 100644
--- a/worktree.h
+++ b/worktree.h
@@ -35,6 +35,11 @@ extern const char *get_worktree_git_dir(const struct=
 worktree *wt);
 extern struct worktree *find_worktree_by_path(struct worktree **list,
 					      const char *path_);
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
