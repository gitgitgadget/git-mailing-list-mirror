From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/6] worktree.c: use is_dot_or_dotdot()
Date: Sun, 22 May 2016 16:33:54 +0700
Message-ID: <20160522093356.22389-5-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160522093356.22389-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 11:34:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Pmc-0001QU-U2
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 11:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbcEVJer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 05:34:47 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35206 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbcEVJep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 05:34:45 -0400
Received: by mail-pa0-f66.google.com with SMTP id rw9so15069773pab.2
        for <git@vger.kernel.org>; Sun, 22 May 2016 02:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kLTEGrQTc3gg7qfUyUKHBvOU+G0NwCzjRl4bNUJgAM=;
        b=Z88afH15MHsgxBvHa/t/uMbJDnUCriJEoZgC4J0qtPj4ZODb7xWhUKbtbVc0zGMUTy
         AE2YW7/iRhmKvOOj+o7BzqFfQfay/nv0dCJ8iRD42P/h8OoWWm5hy8ezSwSmIvmduwWZ
         o8AohAiJNtuDsZhTz8T+3tjoEfmFR+NIb16R+wOonDDxIh+dKaewyQW75sA5z3xW83ZN
         iLuZhC1CQ/ksHmcBNlFSkO9mz2qMpguty8+77p5cN3VgHL4RDZsajPvvLe0seklfbYNL
         4UVIyh1HEIGtlNDfDEOtVgOiVXy9ylM+HzlRHHY1Ja63G9vZVa3RzRKi8o6dHQaQpXlf
         WddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kLTEGrQTc3gg7qfUyUKHBvOU+G0NwCzjRl4bNUJgAM=;
        b=XGKovnH0gLLzG6Zr/X3czeWjliYtLKR5obIn82YQHflaUW6tUVwldt1N2Ji4p+sOwH
         cZ4p6jS4ixEJpD385/ZjRYFleihoxuf0EO4Dh8LC8wUap9xSXDML5M3asdOIYPI0s/Vu
         DBaMo1hEezMdY9Qsd1kVbiIfw/vOuVnBCjB80YxLN4/Ukav9or4htI+oh1IekNxZY9LJ
         lthv5afMttw2l7kE3blMgxy3peRstGlcU8wF4XBi3pYMOMfPC2jU9MWXR6449LMZnZ2b
         Rl06wFA9CZBbkSbNNAGniaV7CZTvdePpMONJCY6grJqB8bcqOX4YHxAv+OYWRQc+9Bqe
         ePtA==
X-Gm-Message-State: AOPr4FV27ANocuKecjpjPVK0aqCzhpbSJd+27YPm1ll3eA7Qa/urOHlfw9eNJaRJoebcUw==
X-Received: by 10.66.138.16 with SMTP id qm16mr18656558pab.28.1463909685069;
        Sun, 22 May 2016 02:34:45 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id g77sm38644978pfg.78.2016.05.22.02.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 02:34:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 16:34:40 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522093356.22389-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295264>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 2 +-
 worktree.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index bf80111..aaee0e2 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -95,7 +95,7 @@ static void prune_worktrees(void)
 	if (!dir)
 		return;
 	while ((d =3D readdir(dir)) !=3D NULL) {
-		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+		if (is_dot_or_dotdot(d->d_name))
 			continue;
 		strbuf_reset(&reason);
 		if (!prune_worktree(d->d_name, &reason))
diff --git a/worktree.c b/worktree.c
index 6a11611..f4a4f38 100644
--- a/worktree.c
+++ b/worktree.c
@@ -187,7 +187,7 @@ struct worktree **get_worktrees(void)
 	if (dir) {
 		while ((d =3D readdir(dir)) !=3D NULL) {
 			struct worktree *linked =3D NULL;
-			if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			if (is_dot_or_dotdot(d->d_name))
 				continue;
=20
 			if ((linked =3D get_linked_worktree(d->d_name))) {
--=20
2.8.2.524.g6ff3d78
