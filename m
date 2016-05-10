From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/7] worktree: simplify prefixing paths
Date: Tue, 10 May 2016 21:15:53 +0700
Message-ID: <20160510141553.22967-7-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160510141553.22967-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 16:17:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08TM-00087u-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbcEJORF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 10:17:05 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33459 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbcEJORC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:17:02 -0400
Received: by mail-pa0-f67.google.com with SMTP id gh9so1005715pac.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=phE7b5zQFSElY3k4ynmGk/VGUmlKxHp0fuTaX08Vels=;
        b=UPZ9rG0QW7q09tTlgp4yI3Pk1V6XZKbAyBHDEezvBJ96siNewjec58vQUq32cOMKvj
         o16ZZXD7G3WIqAzwEs1aSlWxRT4IKqO/Jgz8N9lz+eIKZs19S79XnuZGD3/xhP3rd2Ni
         U0CKPY7RdzxXFY47JevjHthBUJctacg+KM90OLhDH4jpDSw+PYIO78a3CJVYIAxmj6Uc
         yGZY3o0euEubSW7F7jUqfm90yltG+0uMkcXkjUlSdU7FtGT5UOFmyviIAsREpFDBjpK6
         967H23GcVn/ywS+GDzemQojUkbnbBxt9yUoFvU0zairaDixan1n7nWpvNz6XpOjeFdK6
         XzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=phE7b5zQFSElY3k4ynmGk/VGUmlKxHp0fuTaX08Vels=;
        b=SKWz3tqeTVz1hguz9W+FLrL3UiKPkMCekbxIrEY4u/FM4I0x3+WX0qI5WCBkjU2wb6
         JaKeEz0AGrOXrAVx/9UisSLhC+QhJhZvcDRzxr+FaPkqMm9P1okPmga2BGS5Q7TSrEJZ
         jDNL/uRNjea8mIZ/NOyKlsgBacTJCS62Z0D57D+l+Lch6sS0DFqCZrm0uslDsiLYAZPY
         c6UwCCi7JJSU68hOuKmX42qKevF4NH7LZRtTZMVyuxEto6ee2RxzGVXyYvWzbDHumg3O
         d7qL15H0QCJwSsdpRdEEGO0vg3bUoXmRhXFQREdqc5FmoSehBrfrv35Wn+EzdovEx/rR
         Lowg==
X-Gm-Message-State: AOPr4FVT3UkFV71vKLXXqiwKEc9Ybi8U3a1IO6YAcKv9Xc/ZfZP0RWvnnK9MKXcvzt15Qg==
X-Received: by 10.66.141.73 with SMTP id rm9mr58036022pab.84.1462889822243;
        Tue, 10 May 2016 07:17:02 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id fh14sm4952984pab.31.2016.05.10.07.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:17:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:16:58 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141553.22967-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294141>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index b53f802..f9dac37 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -337,7 +337,7 @@ static int add(int ac, const char **av, const char =
*prefix)
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
=20
-	path =3D prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : av=
[0];
+	path =3D prefix_filename(prefix, strlen(prefix), av[0]);
 	branch =3D ac < 2 ? "HEAD" : av[1];
=20
 	opts.force_new_branch =3D !!new_branch_force;
@@ -467,6 +467,8 @@ int cmd_worktree(int ac, const char **av, const cha=
r *prefix)
=20
 	if (ac < 2)
 		usage_with_options(worktree_usage, options);
+	if (!prefix)
+		prefix =3D "";
 	if (!strcmp(av[1], "add"))
 		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
--=20
2.8.2.524.g6ff3d78
