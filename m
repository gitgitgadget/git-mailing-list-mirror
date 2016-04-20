From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/12] worktree.c: test if branch being bisected in another worktree
Date: Wed, 20 Apr 2016 20:24:52 +0700
Message-ID: <1461158693-21289-12-git-send-email-pclouds@gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 15:26:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ass9e-0005FC-8a
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbcDTN0u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 09:26:50 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:32848 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbcDTN0t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:26:49 -0400
Received: by mail-pf0-f180.google.com with SMTP id 184so18582625pff.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHSSiBDHSI1r8/gbNmC52KpR00TfqN7w+3TOIihPim8=;
        b=VL5+zHbiVxUSHWXSlaF3jOIZXYbetFF1oQQj97UvvLcd5IXjBszPpLmsrdsQNkfP3W
         qUJA+cEf7vkuGclC85o7Ct+Dt/c0GJ/cMfseSjX7k9JLWm5UQ2OKGsYDH4Mxd35l4cIJ
         ISybY/6Bu/YCuuTz/6EXTjl1gV4BIVUAT+pnfqbqtecxmJw1QL4OghOZ+J/8JBpKitrl
         5t2GlCr1vBSfmet5YecgX5OmBE5sNDWIFvhOqKvLIMyMDdSU+sl38re8QPRmnaoDLdoV
         zKOLgiFX0yX+bEVWlwzX8YLNHtebe0npyQQL9S4NU6FZQI+T/f7UPz52qeMGuGRIRzq+
         +qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHSSiBDHSI1r8/gbNmC52KpR00TfqN7w+3TOIihPim8=;
        b=L7hI6pbCwpC29xaxxPxDBfWw7higPnEoOGPu56COesfsLbpO93x+Vwb/HudWughM0A
         9bnAr60JkCQ6F6gMdWBaWntZHg4E3vQ0AioUR++UdUPyEQQjUUpDkXwDYyVAhr9Vvqfi
         LkJ627Ldc8o465A4ayfCjU+2JhEFnqfq+YaCuXhHHH/ipT8hHTa1deA2vqFXrSJ2l51G
         n6JNOxBJPbSe/ozLQidlaWKHxfpUBCMy4JAj4Ywws8NpOw1dzHkFBRcI7ZKBMRA4k3F9
         B8O/I7C13F5X5uHBAoBzKeidZqGOTeqJ8XWC6+V9E2zAJquNOk8ydWFDtz98R1eBa/h0
         p0uA==
X-Gm-Message-State: AOPr4FVSD98Gt1/c625l26RWvM+Mf+ldV+3p4E6bBk75jZBC91VlrtFTD45GT5JW/WL36Q==
X-Received: by 10.98.36.195 with SMTP id k64mr12239115pfk.88.1461158809006;
        Wed, 20 Apr 2016 06:26:49 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id z28sm27358377pfi.32.2016.04.20.06.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 06:26:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:27:01 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292019>

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
index dc380a2..7b66071 100644
--- a/worktree.c
+++ b/worktree.c
@@ -226,6 +226,21 @@ static int is_worktree_being_rebased(const struct =
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
 const struct worktree *find_shared_symref(const char *symref,
 					  const char *target,
 					  int ignore_current_worktree)
@@ -251,6 +266,10 @@ const struct worktree *find_shared_symref(const ch=
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
