Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8F920A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 23:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLGXyo (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 18:54:44 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:44888 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXyo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 18:54:44 -0500
Received: by mail-qk1-f201.google.com with SMTP id f22so4766568qkm.11
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 15:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3mE2CUQFRCTCZVGE/1A680VZScdt43GpdjJtbVpqD04=;
        b=ZdGKqRMd/Acf+SYEDZfGB1GT77fzn3BGC8Wu12rqbrpdj26EsCAYm4QvQCUa95njfk
         e8NlW0PwN9gnaz0zXWKMmGp8r33/4F2HAxFTr+TDmwRUEMYbJ/+D7JEZ0DUTzQwLwN3j
         quAEp/NKM7YyGc9LSDCIQW02iJFMDOi6biVB231sC7oX0VKYVdZDCMuiuL7o08FPz1zp
         SFagh+f3hupVc99KoWPGRe+cSUh6L11LBys7KO1ycUf3hI6boqSMPqBbzP0nfOpgdcUI
         GxHqcettrqM53Agcse7YBSeljmDemdG6O5NAVVnjxjXwngptpIUP9jhUU6jt+fep4vbH
         n4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3mE2CUQFRCTCZVGE/1A680VZScdt43GpdjJtbVpqD04=;
        b=or97KVacLzJ2yOE1KwlwMPn1JkCQeSpOSVvuO8NIZfFZ+QvaJ7ZWKis6QCUiYFCb2u
         hQ2TRNHazobplV9lwY3LHElGk2R5F+h7bl5anlcVorFGEBO/nQvMBiNWM5BTGDaAnjQ5
         sWoT1C6pK+VCMBFG6ij0n07z9R6gqkkFwbqubnrG1pajMKCAHiKnCBZd581pJfmf7BBo
         +vjglq0QXzmPf7gYgBaPSmrOhVC9TsmcXjOH7nYkxasknHbxMXwRInzy5bspKF+jIVj6
         YxtCFKQe2AVJBD5AYN+i3hjaI9lUvaPHkIPrTqljvQUOyYd2jAM+uqzrnlAX1MFDt3Tp
         7USw==
X-Gm-Message-State: AA+aEWbiy6Y8n/31gvRGwnzt9ve29Xsqb9L1MgYW4us+E8XsPMPaJtzE
        Dg126g3NgHv2y46kGeVWKELmFoEE5FbdM2wMIN6ex6IOKkv8/FxQeTkEvP3jJA/eJYbUNJcF7JW
        rCDCi2+hgVqpN2rabKCpC4Kcghjpzf/JSHfj/EDcO/uoHH/Gyi5hjo/+Str5J
X-Google-Smtp-Source: AFSGD/UqL+F71+9Il5Ce6l9ozQRTnRSDSCUdPRULsWBqmagoMcARmnvj51/VIiuJXP3FjFQ3p5SbFvPMFeD1
X-Received: by 2002:a0c:9219:: with SMTP id a25mr3142100qva.39.1544226883425;
 Fri, 07 Dec 2018 15:54:43 -0800 (PST)
Date:   Fri,  7 Dec 2018 15:54:23 -0800
In-Reply-To: <20181207235425.128568-1-sbeller@google.com>
Message-Id: <20181207235425.128568-3-sbeller@google.com>
Mime-Version: 1.0
References: <20181207235425.128568-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH 2/4] submodule: unset core.worktree if no working tree is present
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reintroduces 4fa4f90ccd (submodule: unset core.worktree if no working
tree is present, 2018-06-12), which was reverted as part of f178c13fda
(Revert "Merge branch 'sb/submodule-core-worktree'", 2018-09-07).

4fa4f90ccd was reverted as its followup commit was faulty, but without
the accompanying change of the followup, we'd have an incomplete workflow
of setting `core.worktree` again, when it is needed such as checking out
a revision that contains a submodule.

So re-introduce that commit as-is, focusing on fixing up the followup

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               | 14 ++++++++++++++
 submodule.h               |  2 ++
 t/lib-submodule-update.sh |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 6415cc5580..d393e947e6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1561,6 +1561,18 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	return ret;
 }
 
+void submodule_unset_core_worktree(const struct submodule *sub)
+{
+	char *config_path = xstrfmt("%s/modules/%s/config",
+				    get_git_common_dir(), sub->name);
+
+	if (git_config_set_in_file_gently(config_path, "core.worktree", NULL))
+		warning(_("Could not unset core.worktree setting in submodule '%s'"),
+			  sub->path);
+
+	free(config_path);
+}
+
 static const char *get_super_prefix_or_empty(void)
 {
 	const char *s = get_super_prefix();
@@ -1726,6 +1738,8 @@ int submodule_move_head(const char *path,
 
 			if (is_empty_dir(path))
 				rmdir_or_warn(path);
+
+			submodule_unset_core_worktree(sub);
 		}
 	}
 out:
diff --git a/submodule.h b/submodule.h
index a680214c01..9e18e9b807 100644
--- a/submodule.h
+++ b/submodule.h
@@ -131,6 +131,8 @@ int submodule_move_head(const char *path,
 			const char *new_head,
 			unsigned flags);
 
+void submodule_unset_core_worktree(const struct submodule *sub);
+
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific environment variables, but
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 016391723c..51d4555549 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -709,7 +709,8 @@ test_submodule_recursing_with_args_common() {
 			git branch -t remove_sub1 origin/remove_sub1 &&
 			$command remove_sub1 &&
 			test_superproject_content origin/remove_sub1 &&
-			! test -e sub1
+			! test -e sub1 &&
+			test_must_fail git config -f .git/modules/sub1/config core.worktree
 		)
 	'
 	# ... absorbing a .git directory along the way.
-- 
2.20.0.rc2.403.gdbc3b29805-goog

