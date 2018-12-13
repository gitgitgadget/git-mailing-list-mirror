Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9208E20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 17:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbeLMRbK (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 12:31:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38060 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbeLMRbK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 12:31:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so1440399pfi.5
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 09:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kL1azY7/XNo3wKti/RH4twIx91c4Q4Irdhc+QFpzTfI=;
        b=g4uAQm7PRs3cu3DW5TsTSTIRnf1IBP1TWaBvnfqXRGPW0ZnSFEAQvh/PC3a2YwBJqF
         B8hVa8KZxhTp67nw3RCAu8f5zw8jTZSGwf1REvfmTSLjr8sVpdpr+MtCE5dl5/zKjvIh
         s4O490+AI7c4AdXUmbcHPULsl9umI+FJnNsnCnW1/aMwofJkrf1kxjSZ3SaH+6aHDPQx
         92dXhlraZv1iyAracDDQfb4dkYKHTgsSU18Cnl5k2vqVM6pkykzAr3Zrnhqts8yFtYC/
         ii6+7u04YMCMiqCyxO2iJLZ8YZyxZT9h9qwd02wtalECSBC9TMgp7NUWLp3qSt0FFa92
         vMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kL1azY7/XNo3wKti/RH4twIx91c4Q4Irdhc+QFpzTfI=;
        b=CUiNGBcQ2LHJFqpGl95Ui83XrTkTfqOUNYJj7mTq5/EDN7zQb+KOUw/xW76YwIYDek
         vzqTaHAcm/PX6WVKW4WtEP9n3Z1V3omRVcIq3MUYWo53ViTuLImUjvXiwupQufLzNyEj
         dTMkMuQWDi40ra2/Akqa9ruPmdHhiuiOnXR/W5qT1qeTx804/bPPjA1vPfdjKiqEhBCD
         TbQoss9fPfy9QkzIkQQjLnrmh2z58IZA+XsqVy1TOhknujB9V1B2xcnFPu0o+E8/bLPY
         6aBp1HDkS0QrNijMw83vGy7V6+6QLwZDF/iUnHzK0uWvA6HzvakK1O77SCeJR+ivODVB
         96vA==
X-Gm-Message-State: AA+aEWaXZij13YblUedA1uukW6+aBk2nblrJs8w+mN8MepZd7qnHsExe
        1HBdufgfgx171ieB4N1McStYQ1Ev
X-Google-Smtp-Source: AFSGD/X7mbm2K556G/Vp6gtytkXZBGHMcckeMKRyGS1K0qXyI+bT+Gp8CYdH2hZjYZTLMR0GQmPE6g==
X-Received: by 2002:a63:2f07:: with SMTP id v7mr21195739pgv.368.1544722268766;
        Thu, 13 Dec 2018 09:31:08 -0800 (PST)
Received: from localhost.localdomain ([162.250.210.102])
        by smtp.googlemail.com with ESMTPSA id l19sm7278016pfi.71.2018.12.13.09.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 09:31:07 -0800 (PST)
From:   Erin Dahlgren <eedahlgren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Erin Dahlgren <eedahlgren@gmail.com>
Subject: [PATCH] Simplify handling of setup_git_directory_gently() failure cases.
Date:   Thu, 13 Dec 2018 09:30:11 -0800
Message-Id: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

setup_git_directory_gently() expects two types of failures to
discover a git directory (e.g. .git/):

  - GIT_DIR_HIT_CEILING: could not find a git directory in any
	parent directories of the cwd.
  - GIT_DIR_HIT_MOUNT_POINT: could not find a git directory in
	any parent directories up to the mount point of the cwd.

Both cases are handled in a similar way, but there are misleading
and unimportant differences. In both cases, setup_git_directory_gently()
should:

  - Die if we are not in a git repository. Otherwise:
  - Set nongit_ok = 1, indicating that we are not in a git repository
	but this is ok.
  - Call strbuf_release() on any non-static struct strbufs that we
	allocated.

Before this change are two misleading additional behaviors:

  - GIT_DIR_HIT_CEILING: setup_nongit() changes to the cwd for no
	apparent reason. We never had the chance to change directories
	up to this point so chdir(current cwd) is pointless.
  - GIT_DIR_HIT_MOUNT_POINT: strbuf_release() frees the buffer
	of a static struct strbuf (cwd). This is unnecessary because the
	struct is static so its buffer is always reachable. This is also
	misleading because nowhere else in the function is this buffer
	released.

This change eliminates these two misleading additional behaviors and
deletes setup_nogit() because the code is clearer without it. The
result is that we can see clearly that GIT_DIR_HIT_CEILING and
GIT_DIR_HIT_MOUNT_POINT lead to the same behavior (ignoring the
different help messages).

Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Erin Dahlgren <eedahlgren@gmail.com>
---
 setup.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/setup.c b/setup.c
index 1be5037..b441e39 100644
--- a/setup.c
+++ b/setup.c
@@ -831,16 +831,6 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 	return NULL;
 }
 
-static const char *setup_nongit(const char *cwd, int *nongit_ok)
-{
-	if (!nongit_ok)
-		die(_("not a git repository (or any of the parent directories): %s"), DEFAULT_GIT_DIR_ENVIRONMENT);
-	if (chdir(cwd))
-		die_errno(_("cannot come back to cwd"));
-	*nongit_ok = 1;
-	return NULL;
-}
-
 static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_len)
 {
 	struct stat buf;
@@ -1097,18 +1087,20 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		prefix = setup_bare_git_dir(&cwd, dir.len, &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
-		prefix = setup_nongit(cwd.buf, nongit_ok);
-		break;
+		if (!nongit_ok)
+			die(_("not a git repository (or any of the parent directories): %s"),
+					DEFAULT_GIT_DIR_ENVIRONMENT);
+		*nongit_ok = 1;
+		strbuf_release(&dir);
+		return NULL;
 	case GIT_DIR_HIT_MOUNT_POINT:
-		if (nongit_ok) {
-			*nongit_ok = 1;
-			strbuf_release(&cwd);
-			strbuf_release(&dir);
-			return NULL;
-		}
-		die(_("not a git repository (or any parent up to mount point %s)\n"
-		      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
-		    dir.buf);
+		if (!nongit_ok)
+			die(_("not a git repository (or any parent up to mount point %s)\n"
+						"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
+					dir.buf);
+		*nongit_ok = 1;
+		strbuf_release(&dir);
+		return NULL;
 	default:
 		BUG("unhandled setup_git_directory_1() result");
 	}
-- 
2.7.4

