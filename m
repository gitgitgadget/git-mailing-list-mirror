From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 09/13] worktree.c: avoid referencing to worktrees[i] multiple times
Date: Fri, 22 Apr 2016 20:01:32 +0700
Message-ID: <1461330096-21783-10-git-send-email-pclouds@gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:02:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atajI-0007W6-BA
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbcDVNCg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 09:02:36 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34362 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbcDVNCf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:02:35 -0400
Received: by mail-pa0-f68.google.com with SMTP id yl2so6250174pac.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UnANz1hfXPlALWUNtYP8SHQK3irFKKXD2pBKOkJLheE=;
        b=TgY/QVbN1EAs9PnbNQRwjjC035aP3ZOI8RhSW17ffHKzpx2+MiygX7Ro0yqK3mwe9S
         bgPlwmNQu6qAH2Mz6F9zm4v+kAHBZLow/7Wh8dddiRGDmTEP6ysx9vWULxktUJVjQ5Ro
         iJ1Rn5Ef7wP+HOEhlvpLn+ZwrDUVWCurxyxMlnAyyJIbdli+pF0k2bY5tfS37ad7MhXJ
         HuJpQaybm3fB2pndER3k7WzPOVzHbAJpBn4SH61ywBMowiaLbHKqscjNC+daVLz6//mH
         TxnFkZ+Vnh0e/0Z/R59r+cu6NqtYfRzpISD9MgufiCIQ3erbCMq84uYexKQpPKI3k//E
         tBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnANz1hfXPlALWUNtYP8SHQK3irFKKXD2pBKOkJLheE=;
        b=LKQWJCnfpPPhiuDmhuQeCJqGxP+6+wqFjCRqC8jxX8LZJ67xDw5uB+ngTAy5IyM0Fu
         ioIgaIiMU5Qe9zl8TgTt0UXA6l4duH/lxKTTqJ0oCsxiRE2UMUA/8Mu8RdL4VaP1Dnku
         8uEri0kc+NqvJGuW6y35aERijkkPAZvgsECQC8e9ZtWYTMUM6sRJoyWrPi9FwyZfSM3E
         WZHDrSiuBU6TwKnYU7++f+8EDGYr1sCHo5SH6jwmGTcbFhVSYtyKeLzSQ6eyzKPVwpz8
         eKKW31pB6iNv30S/kWfL41Z6BCVqItk6U0EIp1T/K7n8wMKjHBGAjc5u95FyzjTii7An
         kcQw==
X-Gm-Message-State: AOPr4FU1CsVPfpU4EqTtYybv6qzZT1ek9G5fskZDB2OUILqIiCO0tRF4w5H5g9Wr5Ghcxw==
X-Received: by 10.66.236.232 with SMTP id ux8mr28423956pac.145.1461330154888;
        Fri, 22 Apr 2016 06:02:34 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id o65sm8477156pfb.24.2016.04.22.06.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:02:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:02:48 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292198>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/worktree.c b/worktree.c
index dc092a7..927905b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -229,10 +229,12 @@ const struct worktree *find_shared_symref(const c=
har *symref,
 	worktrees =3D get_worktrees();
=20
 	for (i =3D 0; worktrees[i]; i++) {
+		struct worktree *wt =3D worktrees[i];
+
 		strbuf_reset(&path);
 		strbuf_reset(&sb);
 		strbuf_addf(&path, "%s/%s",
-			    get_worktree_git_dir(worktrees[i]),
+			    get_worktree_git_dir(wt),
 			    symref);
=20
 		if (parse_ref(path.buf, &sb, NULL)) {
@@ -240,7 +242,7 @@ const struct worktree *find_shared_symref(const cha=
r *symref,
 		}
=20
 		if (!strcmp(sb.buf, target)) {
-			existing =3D worktrees[i];
+			existing =3D wt;
 			break;
 		}
 	}
--=20
2.8.0.rc0.210.gd302cd2
