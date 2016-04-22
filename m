From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 12/13] worktree.c: check whether branch is bisected in another worktree
Date: Fri, 22 Apr 2016 20:01:35 +0700
Message-ID: <1461330096-21783-13-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Apr 22 15:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atajb-0007iM-Jw
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbcDVNCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 09:02:55 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34421 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbcDVNCy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:02:54 -0400
Received: by mail-pa0-f66.google.com with SMTP id yl2so6250610pac.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05WM4o99fY3GcckImcDTCW71n0di9MkzjpUuDUeJ26g=;
        b=G8kd4J5Ej20MkB8zFpJqQPCFgYTZdFAatdUFJDRFVgxYRfJ5vRKhd9DODfv3C5ipat
         QcZMELRDr3NSE5CT5MoUoM2IseBvNqacoxMhNO0nd1uCvHdZXNuW4qj6KyQhESsTifWG
         foB7Lbpf0a82E86RdIgf2LWp/JR2s5qK8wRp83Qzni7h8W4zVX4av5xKmhWL473xmeqW
         9DntKFEKvGVGyLsJ0hVHSbYyjDfdQwwcEWXa09VggLfB7AT6bl4fFRPH+KldSIf5fjZe
         +wdysUMs5CvGi4nisGq/tz4kvKutku43G+ZozD/3FMALNXhY4i3166T41dzbuF9WJjzW
         6YVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05WM4o99fY3GcckImcDTCW71n0di9MkzjpUuDUeJ26g=;
        b=YOf4f5BfCZf6QG3QJaewNNt/Ccl8/7Xulu398D69oavsoccJz4sh+u5Ic7wKDfCc7p
         2L80RE8UhdknQOz6DwNV/hAH3Nuzwc6wVE5ab5ooh0GsHkr1n3hbbNsKIPlxKZRm0ivz
         3Nj1itOys9U2rxUU38K1V2JnzsoR2D9rpTxAVqSRBh6qpvkSjwQiF5h4nrPJyeyqOUC6
         gk6C1Yv2pb+AlfRQ+4oPuI6tGZ+vaDnZsduiowz5+sH3UXZIsKSK7VdeWVPQe9uRK8FS
         FAEMTZfKyeLv42Q9EfZqw6WRBS4zieJt60GOs5KefY0e5Vppi/zmHvknDIxF+MX6+YOr
         V1OA==
X-Gm-Message-State: AOPr4FVvlAv+Q1yVypHhMDtUJksxsfQbAMtx34pz6CP+p0WfZQZcSUqoFOjLUQ8FLT7bgA==
X-Received: by 10.66.65.235 with SMTP id a11mr27968960pat.155.1461330173616;
        Fri, 22 Apr 2016 06:02:53 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id r70sm8414976pfb.74.2016.04.22.06.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:02:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:03:07 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292201>

Similar to the rebase case, we want to detect if "HEAD" in some worktre=
e
is being bisected because

1) we do not want to checkout this branch in another worktree, after
   bisect is done it will want to go back to this branch

2) we do not want to delete the branch is either or git bisect will
   fail to return to the (long gone) branch

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t2025-worktree-add.sh | 13 +++++++++++++
 worktree.c              | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index da54327..8f53944 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -263,4 +263,17 @@ test_expect_success 'check out from current worktr=
ee branch ok' '
 	)
 '
=20
+test_expect_success 'checkout a branch under bisect' '
+	git worktree add under-bisect &&
+	(
+		cd under-bisect &&
+		git bisect start &&
+		git bisect bad &&
+		git bisect good HEAD~2 &&
+		git worktree list | grep "under-bisect.*detached HEAD" &&
+		test_must_fail git worktree add new-bisect under-bisect &&
+		! test -d new-bisect
+	)
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index 5043756..aab4b95 100644
--- a/worktree.c
+++ b/worktree.c
@@ -234,6 +234,21 @@ static int is_worktree_being_rebased(const struct =
worktree *wt,
 	return found_rebase;
 }
=20
+static int is_worktree_being_bisected(const struct worktree *wt,
+				      const char *target)
+{
+	struct wt_status_state state;
+	int found_rebase;
+
+	memset(&state, 0, sizeof(state));
+	found_rebase =3D wt_status_check_bisect(wt, &state) &&
+		state.branch &&
+		starts_with(target, "refs/heads/") &&
+		!strcmp(state.branch, target + strlen("refs/heads/"));
+	free(state.branch);
+	return found_rebase;
+}
+
 /*
  * note: this function should be able to detect shared symref even if
  * HEAD is temporarily detached (e.g. in the middle of rebase or
@@ -261,6 +276,10 @@ const struct worktree *find_shared_symref(const ch=
ar *symref,
 				existing =3D wt;
 				break;
 			}
+			if (is_worktree_being_bisected(wt, target)) {
+				existing =3D wt;
+				break;
+			}
 		}
=20
 		strbuf_reset(&path);
--=20
2.8.0.rc0.210.gd302cd2
