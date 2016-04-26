From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/15] cmd_status: respect submodule groups
Date: Tue, 26 Apr 2016 13:50:31 -0700
Message-ID: <1461703833-10350-14-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9x5-0006iJ-62
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbcDZUvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:51:14 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33315 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbcDZUvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:51:04 -0400
Received: by mail-pf0-f173.google.com with SMTP id 206so11461707pfu.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OtIfGG9V9u0fn3ol5RL8Eyjlvyq0lH8Jy2WNzUPsboQ=;
        b=py0p7rF9OVm1qYtZ68yr2ePKdxMeae8EN8sxsaQPbfHOAi0uS7mEqgUDPo4bFFd4Ks
         OovCAJIRq4Ll2P3kBxssG5knxsEWc/7QPwrMw36ateSALWW+ztLFQVcupKfJjYWMbH9i
         UBAUvAKX1gOj/hifLfB938UFn9SogWNFslkmcMwMarHvWWgeR1e7JjQceGFMIia0OWf8
         4Id/HFeQAOHh6cAcSTgYCTwszeB/VgDzbEnnJlTCGf2qo75aVDYLxM/ILrZpRdkP8RpH
         xOUxrcLJLhviirHESCxB8TcOSs8X/8H0dDpbyd0Ov68Qnxv//3HK/7vho6CNJj8GXSuG
         cQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OtIfGG9V9u0fn3ol5RL8Eyjlvyq0lH8Jy2WNzUPsboQ=;
        b=FR9rgVGpL9S0YJzrE0WfX2kAc4ejAwIeRjtJfpI0OhVRyXWv7NbIkiORGxV5qpuZGd
         qKaYRZxis62DkZ+5TZKb/QcZ4RTEwmU985AEDgCEpXF2koqAzmX3JJ05UYn9tCZtYY2r
         BSaEto2WhS/mG9VQTRb8ay3oukCDL2Lli9IBSOulQggbfYWFIjuXLsgrrXFPGuWaaBen
         S4dMqIpB0YUF3YmvfZgbcUNhunNcasV3VvPNAyzMmiQsHZu6PX5ano//aYyVRYM8gHpi
         +cX0aRI/gW164pXyqYaCbG+qhCAZL0hB8NCN+lhzOx+XiyZltb8lVWgQj4k+ZEin0+ip
         /02w==
X-Gm-Message-State: AOPr4FUlJMOcRoORD1zdaDUDDwGuhRhclCGHHwsllmHMGByEKCfioBiHNn6VonTvciFWpMCY
X-Received: by 10.98.71.203 with SMTP id p72mr6511695pfi.165.1461703863254;
        Tue, 26 Apr 2016 13:51:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id 1sm2276031pah.7.2016.04.26.13.51.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:51:02 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292677>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/commit.c             |  3 +++
 t/t7413-submodule--helper.sh | 15 +++++++++++++++
 wt-status.c                  |  2 ++
 wt-status.h                  |  1 +
 4 files changed, 21 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index b3bd2d4..d29134d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1369,6 +1369,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	s.ignore_submodule_arg = ignore_submodule_arg;
+	s.submodule_groups = string_list_duplicate(
+		git_config_get_value_multi("submodule.defaultGroup"), 1);
+
 	wt_status_collect(&s);
 
 	if (0 <= fd)
diff --git a/t/t7413-submodule--helper.sh b/t/t7413-submodule--helper.sh
index d01cdc6..a3dbfea 100755
--- a/t/t7413-submodule--helper.sh
+++ b/t/t7413-submodule--helper.sh
@@ -252,4 +252,19 @@ test_expect_success 'git submodule summary respects groups' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git status respects groups' '
+	# use setup from previous test
+	(
+		cd super_clone &&
+		git config --add submodule.defaultGroup *bit1 &&
+		git config --add submodule.defaultGroup ./sub0 &&
+		git status >../actual
+		git config --unset-all submodule.defaultGroup
+	) &&
+	test_i18ngrep "modified:   sub0" actual &&
+	test_i18ngrep "modified:   sub1" actual &&
+	test_i18ngrep ! "modified:   sub2" actual &&
+	test_i18ngrep "modified:   sub3" actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index ef74864..0d494ac 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -502,6 +502,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
 	}
+	rev.diffopt.submodule_groups = s->submodule_groups;
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data = s;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
@@ -532,6 +533,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 		 */
 		handle_ignore_submodules_arg(&rev.diffopt, "dirty");
 	}
+	rev.diffopt.submodule_groups = s->submodule_groups;
 
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_collect_updated_cb;
diff --git a/wt-status.h b/wt-status.h
index c9b3b74..d66a2b5 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -73,6 +73,7 @@ struct wt_status {
 	struct string_list change;
 	struct string_list untracked;
 	struct string_list ignored;
+	struct string_list *submodule_groups;
 	uint32_t untracked_in_ms;
 };
 
-- 
2.8.0.41.g8d9aeb3
