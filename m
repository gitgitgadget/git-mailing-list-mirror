From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] worktree.c: add is_main_worktree()
Date: Tue, 10 May 2016 21:17:26 +0700
Message-ID: <20160510141729.23063-2-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 10 16:17:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08Tu-0000K5-JA
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbcEJORq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 10:17:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36724 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbcEJORp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:17:45 -0400
Received: by mail-pf0-f194.google.com with SMTP id g132so1065761pfb.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxjSILARrH2kOrTsAwAbm8os2j3nAbAVjOcK57aGmuQ=;
        b=Fgbg+ZeKOulEPZKhlZbFSrasnUGYJMditS2z3WROHpdpDM5sF2O5lYVcSg8vrw5qpt
         FHGhz/xCWZurYOZziDC8dya/6a7yBPVqLqqbLhXyNGAL4zPV83z3/S77N1QZJMFi6pFl
         SOmc98J5fEy+UFzhbN4S7weXJDG7ssZ9ZAb2vXzy+8Y1gvixHcPMtCgRrLqwNpHa8mxg
         YuQpSJNHRrZl4V/CNY+OxdiSQPOG1YxvvUaqWkzpv7SykUKENmVrNZgqroDnjURaUaeB
         p41oAsU5+SvvYz8Ur4ybphnshwkNS4lyLJUT9/oyrn156sn0tzG5XRgNW72+/coTQKSI
         UnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxjSILARrH2kOrTsAwAbm8os2j3nAbAVjOcK57aGmuQ=;
        b=mzumoyAw6hqG3dogNeNcRca41FkUFJseMU8fOFbdM0WjAEtsh9XfRJCdhPg42E+zxu
         esBH4ts3UHFkHFA+aIHTeoZnUgC16OagfZIRcM7VGloQEn4/p/3LdCkz6fMljLCavr9Y
         j3PyFG2Xgb5xOunWHQA2/XWZHxJitY3czW7VLrIp1hwV0GfiSyv4SikSXWSd5JfNpOEC
         Jqv5AZGRRergal1rxyrPeAgFjBoLXP9MAucyn8MlH5zYB4rvrhcmrDv70wSgj7QJEf0h
         J4TKbWjwxkRuWo0v1rxkXMtjzym0ZLS/HYZ6eEGrlQJKcqLhmrYbd7Bri6E40CK2fIVe
         HCxg==
X-Gm-Message-State: AOPr4FXI/NQXysOV61BZxYr/XWvWm6bOLul7y3C+tgCS5EywNTIfhArKt1YtPavE4HUukA==
X-Received: by 10.98.38.196 with SMTP id m187mr22845094pfm.57.1462889865049;
        Tue, 10 May 2016 07:17:45 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id g77sm4953220pfg.78.2016.05.10.07.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:17:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:17:46 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141729.23063-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294144>

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
index a6d1ad1..37fea3d 100644
--- a/worktree.c
+++ b/worktree.c
@@ -238,6 +238,11 @@ struct worktree *find_worktree_by_path(struct work=
tree **list,
 	return wt;
 }
=20
+int is_main_worktree(const struct worktree *wt)
+{
+	return wt && !wt->id;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 7775d1b..77a9e09 100644
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
  * Free up the memory for worktree
  */
--=20
2.8.2.524.g6ff3d78
