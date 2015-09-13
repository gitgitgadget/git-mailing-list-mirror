From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/5] fix local clone from a linked checkout
Date: Sun, 13 Sep 2015 08:02:23 +0700
Message-ID: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
References: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 03:02:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zavgb-0006Ws-TR
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 03:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987AbbIMBCV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 21:02:21 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33051 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbbIMBCL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 21:02:11 -0400
Received: by pacex6 with SMTP id ex6so108928876pac.0
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4bKY2wESIKvvRAdY3YPh43/JVEf5vOs6QmBqRSszcOA=;
        b=qxFPZYeS88IpXrH0MEZVLQjoohGoC8ut6E/tH9KtPk5OSKEBnUbQk6SZWs2xb5oTGN
         tSnEtzkGh5JGRtnLPcTDSW65xo6T49SqAjG86At6wcRXT1Y7tsb1y78O5b0tza1Bkec4
         llxidTQwFCRdUMWZxGFrEbNuJI7QIye/pPfQjjsCJMlUv04MrI/2+0TVbRyF40N40/eO
         2+38zFoxlhV/f25VuzgkMlzA+fmFKZugCKPTMkefjvg531up6nU+rsDEsFTUXWEAjh1d
         IzOR5l/XG/Dwwg6LVPK4VUKiwbwR62oo6rUHj5ki86pq8suT93WrNFozlfP404kYQhLV
         +JWA==
X-Received: by 10.66.142.132 with SMTP id rw4mr16114027pab.19.1442106130643;
        Sat, 12 Sep 2015 18:02:10 -0700 (PDT)
Received: from lanh ([171.233.230.25])
        by smtp.gmail.com with ESMTPSA id k10sm7937261pbq.78.2015.09.12.18.02.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 18:02:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Sep 2015 08:02:29 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277744>

=46ixes strbuf_addf in 4/5. Makes a note about the relation of
enter_repo to this local clone in 3/5. Changes since v1

-- 8< --
diff --git a/builtin/clone.c b/builtin/clone.c
index 7a010bb..3e14491 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -432,7 +432,7 @@ static void clone_local(const char *src_repo, const=
 char *dest_repo)
 		get_common_dir(&src, src_repo);
 		get_common_dir(&dest, dest_repo);
 		strbuf_addstr(&src, "/objects");
-		strbuf_addf(&dest, "/objects");
+		strbuf_addstr(&dest, "/objects");
 		copy_or_link_directory(&src, &dest, src_repo, src.len);
 		strbuf_release(&src);
 		strbuf_release(&dest);
-- 8< --

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  path.c: delete an extra space
  enter_repo: avoid duplicating logic, use is_git_directory() instead
  enter_repo: allow .git files in strict mode
  clone: allow --local from a linked checkout
  clone: better error when --reference is a linked checkout

 builtin/clone.c         | 13 ++++++++++---
 path.c                  | 14 +++++++++-----
 t/t2025-worktree-add.sh |  5 +++++
 3 files changed, 24 insertions(+), 8 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
