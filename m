Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A57601F404
	for <e@80x24.org>; Wed,  5 Sep 2018 23:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIFDw1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 23:52:27 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:44414 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeIFDw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 23:52:26 -0400
Received: by mail-pl1-f201.google.com with SMTP id 2-v6so4477989plc.11
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 16:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yKxZNwa02jGhfFbmMMW1MO+/O/e0b3XmhgKe8R9hg5o=;
        b=uOculedezVshN6CvgCjMlU6e8sIi1IhUKtwl4sj2L1ajEoeiyH15fdmfeUFrPSVSaV
         9JdioI2qXvPyBPPwhGxCi+uXPe3AotSeoYaCwdNQGWm6uaeeFK/0jdmhk3HYbkVC/MQ9
         KJvJNikd+7AZYkFssb4Hw8SDqLYQUSNp9zNoJU18QKMgW8uBrWK7wzFnhdzLIE3LinTg
         nhh93c6l+KOgH0tzA5kI3+6q9NXavXupGqOa92BVRanFFvtbvIS48rWuy8QA9+KGXFbj
         rUi/t5tfvTb+Tv4S2yn+0rjocuhhnxjCBt7VcwLo2o/LozQjMFOBJfka00VpgNt2cWyU
         UJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yKxZNwa02jGhfFbmMMW1MO+/O/e0b3XmhgKe8R9hg5o=;
        b=VPRCzkBS6VDtLtNXWQ6Pu9L/QETlKKcuMBKkvZYpsBPptrgoyMrqeWcOBCt03LuY4M
         cgq3AIrXQ7oeUYa1PhCb89pevvMd73SzWPCQLmtY78VQiZAEcvREzPWaShqF4294axJa
         0AhIyM1FL8sV3Mcj2yv7xOT6YAEDMmMOnTf/2KKIjjsemAeVgHOGJqifG6HZXvv7+KIa
         AGC3KL0+2s+Iz7AwmI5d05Dl7ohytjjwa0DwgoDVwamA4STGGxfZ7VXznRnmNszlVnZV
         ol2QInlVIjCuvtw3JDmw2Cgq1qUEgPEszFZ9ogcCfpyMozmB/E0YdQq/ya5dvLNplVUp
         ewLg==
X-Gm-Message-State: APzg51AxWJEs1mUKZFf0Na6it+zHtvnWaJO/WcDGJ70nMSzQ5B4rTnv+
        4FMJZQrVsijtP4iDTcOGGIY1Pxx9QswEWeKLmuwlcNFWrXf1/7M0kMknSMCpZ/LTy5TSKbVNFS/
        yh+eYDpBJPBCuRAW3p9twcBkAtLDb4aAVZq6RztLTyJbLNcAzMGnOMXue1UHc
X-Google-Smtp-Source: ANB0VdbG9De9ly9hO9evmdCB0U9+fuCi+wCDCE3GlO6zbZFBPmnsAHDnQL5Mlu3tlPUpZRDBp8zqHJrUwioD
X-Received: by 2002:a63:5d26:: with SMTP id r38-v6mr810pgb.154.1536189600141;
 Wed, 05 Sep 2018 16:20:00 -0700 (PDT)
Date:   Wed,  5 Sep 2018 16:19:52 -0700
In-Reply-To: <20180905231952.28145-1-sbeller@google.com>
Message-Id: <20180905231952.28145-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180905231952.28145-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH 2/2] submodule.c: warn about missing submodule commit in
 recursive actions
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By checking if a submodule commit exists before attempting the update
we can improve the error message from the
    error(_("Submodule '%s' could not be updated."), path);
to the new and more specific
    error(_("Submodule '%s' doesn't have commit '%s'"),
          path, oid_to_hex(new_oid));

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/submodule.c b/submodule.c
index da2ed8696f5..56104af1c7c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1605,6 +1605,7 @@ int submodule_move_head(const char *path,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const struct submodule *sub;
 	int *error_code_ptr, error_code;
+	struct repository subrepo;
 
 	if (!is_submodule_active(the_repository, path))
 		return 0;
@@ -1627,6 +1628,13 @@ int submodule_move_head(const char *path,
 	if (!sub)
 		BUG("could not get submodule information for '%s'", path);
 
+	if (repo_submodule_init(&subrepo, the_repository, path) < 0)
+		warning(_("Could not get submodule repository for submodule 's'"), path);
+	else if (new_oid && !lookup_commit(subrepo, new_oid)) {
+		return error(_("Submodule '%s' doesn't have commit '%s'"),
+			     path, oid_to_hex(new_oid));
+	}
+
 	if (old_head && !(flags & SUBMODULE_MOVE_HEAD_FORCE)) {
 		/* Check if the submodule has a dirty index. */
 		if (submodule_has_dirty_index(sub))
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

