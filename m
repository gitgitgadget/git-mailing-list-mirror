From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 6/6] worktree.c: find_worktree() search by path suffix
Date: Mon, 13 Jun 2016 19:18:26 +0700
Message-ID: <20160613121826.21631-7-pclouds@gmail.com>
References: <20160603121944.28980-1-pclouds@gmail.com>
 <20160613121826.21631-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 14:19:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCQq8-0004he-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 14:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbcFMMTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 08:19:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35518 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965186AbcFMMTa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 08:19:30 -0400
Received: by mail-pf0-f196.google.com with SMTP id t190so10563377pfb.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qnmVg55x97HkFCeebrw3SQ4u3+ToZ6A48jYf4u9GFec=;
        b=bgsgTi3oq40lIf/QXgBiskr6jAEXfAvCNUIfz6mOrcnuu60XGFe2rqzYslT9QheJwp
         M1ooKONdwtFZnG2kCejdojRIeEFGX8sxi5BLEf5P+6C5ejxr8po0N0g/7psRQvz7CqRG
         CH1B+iEZ4941mDB43hLKDnctKUeuQ8XZgBS1Dp0SPqKo4YXM99At21f5qWfm80Mq+bZ0
         ckTzOq5lrIZEmZGpXZh5/IqXy2ft9dMzdpcsmIZLYbMKiZ0cmM2WR15StAHEJVS5rbxz
         iYw64rA6316w0Givvcb46MCRg4xCIyZgvEXu4vjZuP+exPDP4baehNWuybs3uU0H2SEK
         13OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qnmVg55x97HkFCeebrw3SQ4u3+ToZ6A48jYf4u9GFec=;
        b=QbmAKjX6YpUeJ4IX8U982oY+AgWKvPdwj9QSpBDXcm8wp1UZkHy5ZZWLXnktEya0ZQ
         y1EJm58tVOq2HcY48pp65RrVHPbyEiPPD/ie4r5exTU82BDKURrJbicomxSrCPCaRaUM
         SJhILQU6RyXdDu5jqyRQDmMue/1egFZ1mhDLqFdMn5NVc1fx2Qc0bF3IT4zYAGxbGRP7
         cg9e9WhwUfqKury6/HOvFpsEXtNMX0jPNLzrEHi/C7IyUmENupc8Ie9SG1tGx51hb7jn
         QHnE9it6bGQVpgwPB6WnH2ex1BZ+zUAVh5Oo+CwqaDMAE29xSf8gS3eUBvO3YA2LsyOX
         qNzw==
X-Gm-Message-State: ALyK8tJX2bUClsSpTGQ/i2w80DYc+IIqm0EiHgCl4bDKcJO9SapeId95hX2pjEJ5MpV+rg==
X-Received: by 10.98.80.69 with SMTP id e66mr21521153pfb.139.1465820369581;
        Mon, 13 Jun 2016 05:19:29 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id u4sm17553023pfi.53.2016.06.13.05.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2016 05:19:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Jun 2016 19:19:25 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160613121826.21631-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297187>

This allows the user to do something like "worktree lock foo" or
"worktree lock to/foo" instead of "worktree lock /long/path/to/foo" if
it's unambiguous.

With completion support it could be quite convenient. While this base
name search can be done in the same worktree iteration loop, the code i=
s
split into a separate function for clarity.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt |  5 +++++
 worktree.c                     | 29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 27330c5..7850dee 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -129,6 +129,11 @@ OPTIONS
 <worktree>::
 	Working trees can be identified by path, either relative or
 	absolute.
++
+If the last path components in the working tree's path is unique among
+working trees, it can be used to identify worktrees. For example if
+you only have to working trees at "/abc/def/ghi" and "/abc/def/ggg",
+then "ghi" or "def/ghi" is enough to point to the former working tree.
=20
 DETAILS
 -------
diff --git a/worktree.c b/worktree.c
index 2bcfff3..2107c06 100644
--- a/worktree.c
+++ b/worktree.c
@@ -219,12 +219,41 @@ const char *get_worktree_git_dir(const struct wor=
ktree *wt)
 		return git_common_path("worktrees/%s", wt->id);
 }
=20
+static struct worktree *find_worktree_by_suffix(struct worktree **list=
,
+						const char *suffix)
+{
+	struct worktree *found =3D NULL;
+	int nr_found =3D 0, suffixlen;
+
+	suffixlen =3D strlen(suffix);
+	if (!suffixlen)
+		return NULL;
+
+	for (; *list && nr_found < 2; list++) {
+		const char	*path	 =3D (*list)->path;
+		int		 pathlen =3D strlen(path);
+		int		 start	 =3D pathlen - suffixlen;
+
+		/* suffix must start at directory boundary */
+		if ((!start || (start > 0 && is_dir_sep(path[start - 1]))) &&
+		    !fspathcmp(suffix, path + start)) {
+			found =3D *list;
+			nr_found++;
+		}
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
+	if ((wt =3D find_worktree_by_suffix(list, arg)))
+		return wt;
+
 	arg =3D prefix_filename(prefix, strlen(prefix), arg);
 	path =3D xstrdup(real_path(arg));
 	for (; *list; list++)
--=20
2.8.2.524.g6ff3d78
