From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 4/6] worktree.c: retrieve lock status (and optionally reason) in get_worktrees()
Date: Mon, 30 May 2016 17:49:37 +0700
Message-ID: <20160530104939.28407-5-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 30 12:50:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7KmJ-0005Lq-JK
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 12:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719AbcE3Ku3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 06:50:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34071 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbcE3Ku3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 06:50:29 -0400
Received: by mail-pf0-f194.google.com with SMTP id c84so14419164pfc.1
        for <git@vger.kernel.org>; Mon, 30 May 2016 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZdjewlLx1WvcUXVj4F5tVwv7hKrEJcDc8zdElvi9Qs=;
        b=XEgUHJjdaCa7ovo9u/DbU6m/53HgrjmiOldet7hgd5/WZ1rj/IvQkLRD1KXxPAx169
         5bxBri1jIxqQzuXqKnroRmiw9KJc5sG0wDas9S0KW4U4kRf2B8rmnVaH1vkJegOgOJn+
         YhxwwBdlu6ROWiwR4M8RUgpLC0zW0dcK+DqzHCZ5tpyk42qDrUqOzu24W+NRFfolFjHN
         uXYG1D6+KsHFXREoawxU+kNd2gzlzUzL28vSDMQgZL3DRxBYoudOVrQHamAcReAmKzQO
         VHD4rDgj767UOWB2Jrm0/3Ty55dGRU70ASdecJJy7iCgZyiYD0GtfYj62MtDkSHylkMW
         nC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZdjewlLx1WvcUXVj4F5tVwv7hKrEJcDc8zdElvi9Qs=;
        b=mdtbyltUJLCj0bOCf6FvGqyfKWF9diq78ijcU9l2TnPkzT7cQB+gwRl5Q7w4KRtPC7
         pp9uVmbz2ZPABNU53HCvk3TMtj+w22rUTlRTThhmzuBv/FSIK7eFpRNbIFWuCi9jw3Av
         RFIN+ryxPztbG3QDz3ru68rjde9psecYrHYpdgccsVDprmCPY9q44sOSZMjrwXdXdWBs
         KJKAy552drkF0mZQO0Lt94vbvhnBVRp/1yE4/33LN2UfYTAdAXg2kqvcDqZg+nq3aejs
         zduJjvu5iy+he46wKWwP9N5qbH8N2rVeT1J3u6u1UQCi5UZS2JmeCKWauGSRfhlv/Sij
         Ms9Q==
X-Gm-Message-State: ALyK8tLxmRMsDzitmuA0L81MiPFE2zS+qF+AzB+GtkC8wlUf57/MSDnKDGh8QT9otFv9rw==
X-Received: by 10.98.1.132 with SMTP id 126mr44898292pfb.27.1464605428227;
        Mon, 30 May 2016 03:50:28 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id 7sm32005225pfe.88.2016.05.30.03.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2016 03:50:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 30 May 2016 17:50:23 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160530104939.28407-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295883>

We need this later to avoid double locking a worktree, or unlocking one
when it's not even locked.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 12 ++++++++++++
 worktree.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/worktree.c b/worktree.c
index 6432eec..c6a64b1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -98,6 +98,7 @@ static struct worktree *get_main_worktree(void)
 	worktree->is_detached =3D is_detached;
 	worktree->is_current =3D 0;
 	add_head_info(&head_ref, worktree);
+	worktree->lock_reason =3D NULL;
=20
 done:
 	strbuf_release(&path);
@@ -144,6 +145,17 @@ static struct worktree *get_linked_worktree(const =
char *id)
 	worktree->is_current =3D 0;
 	add_head_info(&head_ref, worktree);
=20
+	strbuf_reset(&path);
+	strbuf_addf(&path, "%s/worktrees/%s/locked", get_git_common_dir(), id=
);
+	if (file_exists(path.buf)) {
+		struct strbuf lock_reason =3D STRBUF_INIT;
+		if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
+			die_errno(_("failed to read '%s'"), path.buf);
+		strbuf_trim(&lock_reason);
+		worktree->lock_reason =3D strbuf_detach(&lock_reason, NULL);
+	} else
+		worktree->lock_reason =3D NULL;
+
 done:
 	strbuf_release(&path);
 	strbuf_release(&worktree_path);
diff --git a/worktree.h b/worktree.h
index e1c4715..9932710 100644
--- a/worktree.h
+++ b/worktree.h
@@ -5,6 +5,7 @@ struct worktree {
 	char *path;
 	char *id;
 	char *head_ref;
+	char *lock_reason;	/* NULL means not locked */
 	unsigned char head_sha1[20];
 	int is_detached;
 	int is_bare;
--=20
2.8.2.524.g6ff3d78
