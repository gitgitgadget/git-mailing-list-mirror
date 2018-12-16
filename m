Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773DB1F405
	for <e@80x24.org>; Sun, 16 Dec 2018 01:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeLPBFX (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 20:05:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39024 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeLPBFX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 20:05:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so4415165pgl.6
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 17:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pgP6K9BTvg1wv5kBxuw6BPGnTmyVr7yvYx5+CklBFJE=;
        b=TNjjfY0zBkjY9qO2eW7AHpQfuHPoHpn+FUPfLp7N2Hfkc6zc7Npf0WkEV607z6U1Fq
         ufq7BqhQAB4m7PiZ4qSIKQin9tiDsqiqiomZz6rZjaDpoukfzqzJ5mG+nuq+4W5x9liH
         4Zf+Nfet6FJe1lt6z6wTpxE02QwokAq8RpxjdNlbXNRUKqRO2E+mUzwc0V/7GHH0yInm
         IpcN4ccQ5L2ElenZsOuAKbjiT51G8cudOrCpMzno7Y6FsFBgbnq3Ut+Ivb+YbB8ZXxk8
         MKFuEmfGfpEOHqUP12MDTmuYio4z35rUrqSjOArTBHZfE7WDO6Lswkf4BdbnlGQeDYPg
         N6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pgP6K9BTvg1wv5kBxuw6BPGnTmyVr7yvYx5+CklBFJE=;
        b=mcK3036oureUyc+IS1RXTStiLe9E9cetQy5CNvNWQ/Yh+BWcuCi0QA+MuEVXq535ID
         8Cd1WFC8lIS+szbcILDJqUWhSZbsMal7OW7eJoWCQlYb2jeF7L3B4fohhd71HA12wG6I
         tr02a+tJexc7KcNXJdnlOs7Og8mzRT5rNk3j6/wZKIQ/kExUPfK4/s/IqfLMiuif+yVv
         IK4vOYdVS2++eHJn39VMkU/jeLrUQlKo02j5zli5iU1Wzvo35811x6TM9oDj2cn+ELO+
         9cbnTtEDIkulSZ5f1RHssx5ARP4OT6mjXvcDC9Wi2l9pd/AgX1vHV+PzvkCGX0gItiCV
         WovA==
X-Gm-Message-State: AA+aEWZ9Ywv3e9AgtAACP23GcYrfzMkMBF5naDrsca5bQG3ftYs4MpHu
        v1Fp12j3/lqU/YrK1pb4khE0BS1Y
X-Google-Smtp-Source: AFSGD/XhUQp3+3WwtKWiXSWg+njfZqo+KvvS6veXjy0TYoNuIVcQBxyjCQ6tm0PNbeq38PLeBYyLLA==
X-Received: by 2002:a63:f901:: with SMTP id h1mr7698414pgi.154.1544922321638;
        Sat, 15 Dec 2018 17:05:21 -0800 (PST)
Received: from localhost.localdomain ([162.250.210.102])
        by smtp.googlemail.com with ESMTPSA id f67sm12348706pfc.141.2018.12.15.17.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Dec 2018 17:05:20 -0800 (PST)
From:   Erin Dahlgren <eedahlgren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Erin Dahlgren <eedahlgren@gmail.com>
Subject: [PATCH v2] Simplify handling of setup_git_directory_gently() failure cases.
Date:   Sat, 15 Dec 2018 17:05:08 -0800
Message-Id: <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
References: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
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
---
Changes in v2:
  - Aligned indentation of second line of die message for case
  GIT_DIR_HIT_MOUNT_POINT.

 setup.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/setup.c b/setup.c
index 1be5037..e1a9e17 100644
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
+			      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
+					dir.buf);
+		*nongit_ok = 1;
+		strbuf_release(&dir);
+		return NULL;
 	default:
 		BUG("unhandled setup_git_directory_1() result");
 	}
-- 
2.7.4

