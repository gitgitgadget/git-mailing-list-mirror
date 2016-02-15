From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] worktree: fix "add -B"
Date: Mon, 15 Feb 2016 20:35:32 +0700
Message-ID: <1455543333-25814-1-git-send-email-pclouds@gmail.com>
References: <20160215094154.GA11698@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	kirill.likhodedov@jetbrains.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 14:36:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVJKS-0003f3-VM
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 14:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbcBONgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 08:36:37 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34616 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbcBONgg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 08:36:36 -0500
Received: by mail-pa0-f65.google.com with SMTP id yy13so7214425pab.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 05:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nmoEC9bDqZlLjQNraLPxH7Wbwqmk1XV4rYCLOTUEEP8=;
        b=R/G2/bUySrKqAXh0hZkZcUOltJw6089RY/GZDC1wpnIv05NwHQH+qN6+Ol/pDt03Vg
         U0WTs3XOaXj0K9ItqylTaHQKZjms/zSlmAwj9tCrNybCtxDlF3r2m3bk7R0iz5DV0pYz
         YDRru+iLxIF91tfjP3pDX0kx9b/Q9sXRxAI9jXx6M0WBtn10eO3uqo+8NqhX9H0cWDQm
         MoTYlK7AT6y5zNAcskytscqqA5mTkfgucp7oRkWdWCsD5O3l55sOzaU7OHZ0hH9OMkVd
         Q4SUiSHcNGqwz+/vkuj43ZG6cpIKtmBRhds3ipRdR9LW3jveBsuOVcyTfDgngQeeJzHh
         N7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=nmoEC9bDqZlLjQNraLPxH7Wbwqmk1XV4rYCLOTUEEP8=;
        b=ASxrVdfemLFKAUYJ+RerkErIrRrEKb6bgIWAcQDNG29eADPtfUsTtiGdPi/s/ThwH/
         rFIFfv4KGp1BXqpX2/0ho91Fo6qEMmNqhNAjzuXGm90+ehJ5Uk7HqETjLrxStCxkoqjV
         ba4J8C3GoLmMkg5315R7x802l0lR+tS3l6ide+LkwxEMDliIKvy67KITzDxsFeMsHH4q
         ROdruWduymGSLoGfmS7fqtkcRsfqoSANxnCMfF2Q92aEINWV8XG3wAUIyK8QphUAwTSc
         Ha8JwrlMZW24b5A+Qscs8TnrTsWujIoorb4BRikFCGnGTcL3Bsa8HvFIGdToGDJgq2V8
         JJWg==
X-Gm-Message-State: AG10YOTeEiFoTNP/P1h+3qAgIT1PsqgavHO/wBAwwEqF9Edy37VJkMBcQFCminaVcbJDcw==
X-Received: by 10.66.65.109 with SMTP id w13mr23148083pas.142.1455543395898;
        Mon, 15 Feb 2016 05:36:35 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id l21sm38770048pfi.63.2016.02.15.05.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 05:36:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 15 Feb 2016 20:36:56 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <20160215094154.GA11698@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286203>

Current code does not update "symref" when -B is used. This string
contains the new HEAD. Because it's empty "git worktree add -B" fails a=
t
symbolic-ref step.

Because branch creation is already done before calling add_worktree(),
-B is equivalent to -b from add_worktree() point of view. We do not nee=
d
the special case for -B.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Complete patch.

 builtin/worktree.c      | 4 +---
 t/t2025-worktree-add.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 475b958..6b9c946 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -201,9 +201,7 @@ static int add_worktree(const char *path, const cha=
r *refname,
 		die(_("'%s' already exists"), path);
=20
 	/* is 'refname' a branch or commit? */
-	if (opts->force_new_branch) /* definitely a branch */
-		;
-	else if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) =
&&
+	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
 		 ref_exists(symref.buf)) { /* it's a branch */
 		if (!opts->force)
 			die_if_checked_out(symref.buf);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 0a804da..a4d36c0 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -193,6 +193,14 @@ test_expect_success '"add" -B/--detach mutually ex=
clusive' '
 	test_must_fail git worktree add -B poodle --detach bamboo master
 '
=20
+test_expect_success 'add -B' '
+	git worktree add -B poodle bamboo2 master^ &&
+	git -C bamboo2 symbolic-ref HEAD >actual &&
+	echo refs/heads/poodle >expected &&
+	test_cmp expected actual &&
+	test_cmp_rev master^ poodle
+'
+
 test_expect_success 'local clone from linked checkout' '
 	git clone --local here here-clone &&
 	( cd here-clone && git fsck )
--=20
2.7.0.377.g4cd97dd
