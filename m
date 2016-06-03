From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 6/6] worktree.c: find_worktree() search by path suffix
Date: Fri,  3 Jun 2016 19:19:44 +0700
Message-ID: <20160603121944.28980-7-pclouds@gmail.com>
References: <20160530104939.28407-1-pclouds@gmail.com>
 <20160603121944.28980-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 14:20:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8o5n-0003Eg-KT
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbcFCMUn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 08:20:43 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35554 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178AbcFCMUk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 08:20:40 -0400
Received: by mail-pa0-f68.google.com with SMTP id gp3so5899032pac.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4hcYnAowKHSHvmwb1xVS42qCoyBfWkcdxcBmWUlkNA=;
        b=whIU+nsYjS5kBR/u/Fozyz3mke3EKAdJghMUl1tI7KzuWKZNV28B6L/72qozYac74D
         ta3J2sZnF1SpxnMSHYos4ozMJnfIO21caDsbM5q/5urvag/RHKQQWjJRnJZ4aKobMoOP
         dKhFbNt79CvwwHUX49bsM+YfddkIIo/hpyyifRx9TNaDuMwyDtSq0b3Our4bmHZKpXIM
         62tZv5X1V2t16nFazV2Qjr1qtBWBbrQmR8jOU1+QD+xaQNCammuBjkDACRFsFUr1+Nqm
         jgsbZcWbS/octGqNUiRWzoPdkNN+DUmLsLzBdBJEwJ8oq3VOy+6ONpJ3hc1tDbth21TQ
         xTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4hcYnAowKHSHvmwb1xVS42qCoyBfWkcdxcBmWUlkNA=;
        b=azU/71UpGvmZfzF+yE7EC67QNPbWlN1J50MmNm8nB1LjIVIiGlQmwLpFJ/P5qSeCnJ
         WekPuyyd7fi6clFNKqiIhojcpuZMXVPX8Ku2gs404riFg345a3eLYHzJ+YP/8jZ9VZNO
         cVI+uRc3YJSc0OSDoUcly4Uvz6CE6yPkk90GhAHNcIq/WsGGnPmY7dtTp61Zac/BeWYp
         NhC1vUUN5whdjzjnPoasz3OXIQeKT0grA9MeuZFFFafaEhIHyUwP2NpAyOAnj5G25Ucn
         NmWMg9ezguXSJfpGwlYnsDjM91CBENu9q7OUJ1VCgt5+GRfOKYFwKBbFi+GTZwdKWDkC
         O1ng==
X-Gm-Message-State: ALyK8tLNScRV4wRZlSi+a5YAGXiF0DvkV8W887xbN16QnYghsY1HEAvyLOay4VjPSeRuEQ==
X-Received: by 10.66.158.98 with SMTP id wt2mr4936384pab.53.1464956440112;
        Fri, 03 Jun 2016 05:20:40 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id u2sm5683059pan.45.2016.06.03.05.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 05:20:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Jun 2016 19:20:34 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160603121944.28980-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296313>

This allows the user to do something like "worktree lock foo" or
"worktree lock to/foo" instead of "worktree lock /long/path/to/foo" if
it's unambiguous. With completion support it could be quite convenient.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt |  5 +++++
 worktree.c                     | 29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 317c7d2..0aeb020 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -130,6 +130,11 @@ OPTIONS
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
index ee592a4..fd5c768 100644
--- a/worktree.c
+++ b/worktree.c
@@ -220,12 +220,41 @@ const char *get_worktree_git_dir(const struct wor=
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
