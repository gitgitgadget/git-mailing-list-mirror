Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E55A1F609
	for <e@80x24.org>; Thu, 29 Nov 2018 00:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeK2Lbr (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 06:31:47 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:55105 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeK2Lbr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 06:31:47 -0500
Received: by mail-qt1-f201.google.com with SMTP id z6so148667qtj.21
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 16:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tvU9dTNmDlKUlMg/Y4rezjD0vXRZgIt34r455l5zCyE=;
        b=FWKW8/EqLJ031jjrKzuUZWE6smI/Ybj0Yv3bHBLZ+OPIaHy80RkIQrW36nhSo1esfr
         aPY+xQwA3Bi4609IpgC7F47NonJVsU2qIVi37qicohlvEj0TV+I5gVCbWr3Otz6RY0mm
         bwE7TIIvpT3RnLPwUVz2t2urD8c1KH2vaAFjXAcndy6/1k3YxXH2HdboFP3dazVgH+bm
         sCy9JT0hYHykBy2ji3lli5oq7PzWVYxpwgnN91SnbyrCkyeghE/cSdszBPYzd8awo4Tj
         OAJdSs36uEB9KeCRuWlvlk7TdqU0ewhqBsUpEk44QmSMe4RRy39e3RTUBoL8HPCb9gyw
         oajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tvU9dTNmDlKUlMg/Y4rezjD0vXRZgIt34r455l5zCyE=;
        b=SQL7EnrNOaTzfR1d8BjNNKAOxZmOCGDez3Nclh0HO/R4/qlQY9ov6K7JWHgMHs/9Sr
         Zy0o1CjUblbtznOd8LJAuUFIk4PDv1nKQF0IkDGl0dP5WfAhXdIkre2f7mYz9YZSKEYu
         lHRJ8TEKiYvgViccxGkc/hiXpMFfvNMftg8pUnV2QlZuM5LnQ2OYcXQ4HO4NGfaRy5fm
         3IBD2MO+KI3gKCntNg9gy1RosfRAOqEv3veQOeUYPwnwLXDlY7BEtoM9gfyrZ06YEykr
         FLdMcQs8Ac0xP07bVOqj3Ful5lvfzb7C+TXDMOAYv8DmSxrxuYEdTh2gcjr0MlMwSCqL
         XKaw==
X-Gm-Message-State: AA+aEWbmUh4Vb1/j3jumlr+skzPAs0WciEyPdH9LEyZ4bTdT7KjbHF5Q
        AdB6bFTwp36f09FHbgbY9Zm5lzrZV//e+sauOn/fRBPO3xcEuXM1g0nWqmZzn9lG3xBBsfTyryy
        woSshQ/yYRfPoVQQynzWQcFJhcH0TS1VDSvvaLwydIJ4WrbyTtVx3nq2YnaxU
X-Google-Smtp-Source: AFSGD/VI+dKezll33bi3SM34rJ5926stECI/mAC39WCa3gFVXRe0JQDu5KLPSKsHB3Q5LnAy4brR5jSEbkZu
X-Received: by 2002:a37:1f62:: with SMTP id f95mr4955426qkf.46.1543451300008;
 Wed, 28 Nov 2018 16:28:20 -0800 (PST)
Date:   Wed, 28 Nov 2018 16:27:55 -0800
In-Reply-To: <20181129002756.167615-1-sbeller@google.com>
Message-Id: <20181129002756.167615-9-sbeller@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH 8/9] submodule.c: fetch in submodules git directory instead of
 in worktree
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the properties introduced in 10f5c52656 (submodule: avoid
auto-discovery in prepare_submodule_repo_env(), 2016-09-01), by fixating
the git directory of the submodule.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 77ace5e784..d1b6646f42 100644
--- a/submodule.c
+++ b/submodule.c
@@ -494,6 +494,12 @@ void prepare_submodule_repo_env(struct argv_array *out)
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
+static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
+{
+	prepare_submodule_repo_env_no_git_dir(out);
+	argv_array_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
@@ -1327,8 +1333,8 @@ static int get_next_submodule(struct child_process *cp,
 		repo = get_submodule_repo_for(spf->r, submodule);
 		if (repo) {
 			child_process_init(cp);
-			cp->dir = xstrdup(repo->worktree);
-			prepare_submodule_repo_env(&cp->env_array);
+			cp->dir = xstrdup(repo->gitdir);
+			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
-- 
2.20.0.rc1.387.gf8505762e3-goog

