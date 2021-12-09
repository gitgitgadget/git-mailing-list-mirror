Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C1FC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 18:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhLISxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhLISxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 13:53:34 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FE3C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 10:50:01 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id p8-20020a17090a748800b001a6cceee8afso4121237pjk.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 10:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8gDIpSjgsxdkrFB+PSm70WgF5BKfUXhUrmfWPrnp41w=;
        b=RUxW3VZZtV7CxND5V60iH87x8UWN/VJ9D0LyVOOMyo9YrZVVtve52o7LCamp6EDx6b
         a5ewwdtETch058urRJ5mJ2scJjjkZLmWiI3FG0H8gO5tiYe4fnIfyfviC+rH23KrTTQ8
         4BB6ifCrwO6LTRnWEmqRELef3Y/Oc+6MidQi8tIs7sOdjjHAJsP8r13Y00fv3l/ICfl7
         +YhXNPFWq+8UfRyjbMvpPXDTOjiaFwFednxRnqS05GgHg50WCwhESZCrUBfftbswuPK/
         RvJkccYL3D5r/eeidESYWKYNk9g1usWLXxyt0tkpFvFrg/CloLGc9Mn/9etL2AprtQKi
         kDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8gDIpSjgsxdkrFB+PSm70WgF5BKfUXhUrmfWPrnp41w=;
        b=LBEveM/7cATecxhObl2dBCmqs0/Qvyuk9f0WBmBegM9C6W/8UILwNz5Jr6hCeommzA
         Bp3+c0g/LfD40Qpwj0RduKS8nx3WbUsMclknyq91UBrP/DOU9yLCUveJtNsn+gQwHVH6
         1t50UmLQQx/ygiyDQ7D29mNBKDrW9SkOwq6EyPgePfa1U2B244uZAq1GO0GJU1SND9bH
         yz4PnUB8ccy7vm8XwyhfHsz5huMg1npPwLJvc/da1CK+D0TEwLPMbaF+W8xFCn1E6UL5
         j9qyBqcng7VFhZu/s508+zprcqw8atPPoVSNlR4ucRunz4d9BZRfSI2pL8kvWq3yvHu5
         KzfA==
X-Gm-Message-State: AOAM530VQszj9RKMNpxj2bxYGQfI+di4njpU+Lz2kTJQjLAJ9ZqGez+X
        9fYijJTlsEKNf4U57uGTx6MPX7NdhB8Dtjwxv4XeIiHkG4+4hF7RYF3Tn4fRaaOZFWnPxBdgkLO
        jbSNHozUom86gf58G30phIwI3NySat2YkdZyhXxv7eYwdFsR0EoNFEKsr37m9Ypo=
X-Google-Smtp-Source: ABdhPJyuYZ9YrJI4zKHdXTe6oLAYELUMgzxuad43d983+9GhVjakZhXprUPvaTihgIFTgphAtxqxGWSgl+qFBw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:14c7:0:b0:4a2:a6f2:2227 with SMTP id
 190-20020a6214c7000000b004a2a6f22227mr13463490pfu.22.1639075800447; Thu, 09
 Dec 2021 10:50:00 -0800 (PST)
Date:   Thu,  9 Dec 2021 10:49:25 -0800
In-Reply-To: <20211209184928.71413-1-chooglen@google.com>
Message-Id: <20211209184928.71413-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211206215528.97050-1-chooglen@google.com> <20211209184928.71413-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 2/5] branch: remove forward declaration of validate_branch_start()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit, validate_branch_start() was forward declared in
order to preserve the function order and minimize the diff. Since the
forward declaration is no longer needed, remove it by moving
setup_tracking() to the appropriate position.

Signed-off-by: Glen Choo <chooglen@google.com>
---
This patch is logically part of the previous patch because it just
cleans up the artificial forward declaration that exists only to shrink
the diff for reviewers.

As such, if/when this series is merged, I would prefer for this patch to
be squashed with the previous one.

 branch.c | 98 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 47 insertions(+), 51 deletions(-)

diff --git a/branch.c b/branch.c
index 9429936734..6b9d64cdf9 100644
--- a/branch.c
+++ b/branch.c
@@ -209,57 +209,6 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 	return 0;
 }
 
-static void validate_branch_start(struct repository *r, const char *start_name,
-				  enum branch_track track,
-				  struct object_id *oid, char **real_ref);
-
-void setup_tracking(const char *new_ref, const char *orig_ref,
-			   enum branch_track track, int quiet, int expand_orig)
-{
-	struct tracking tracking;
-	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
-	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
-	char *full_orig_ref;
-	struct object_id unused_oid;
-
-	memset(&tracking, 0, sizeof(tracking));
-	if (expand_orig)
-		validate_branch_start(the_repository, orig_ref, track, &unused_oid, &full_orig_ref);
-	else
-		full_orig_ref = xstrdup(orig_ref);
-
-	tracking.spec.dst = full_orig_ref;
-	tracking.srcs = &tracking_srcs;
-	if (track != BRANCH_TRACK_INHERIT)
-		for_each_remote(find_tracked_branch, &tracking);
-	else if (inherit_tracking(&tracking, orig_ref))
-		return;
-
-	if (!tracking.matches)
-		switch (track) {
-		case BRANCH_TRACK_ALWAYS:
-		case BRANCH_TRACK_EXPLICIT:
-		case BRANCH_TRACK_OVERRIDE:
-			break;
-		default:
-			goto cleanup;
-		}
-
-	if (tracking.matches > 1)
-		die(_("Not tracking: ambiguous information for ref %s"),
-		    full_orig_ref);
-
-	if (tracking.srcs->nr < 1)
-		string_list_append(tracking.srcs, full_orig_ref);
-	if (install_branch_config_multiple_remotes(config_flags, new_ref, tracking.remote,
-			      tracking.srcs) < 0)
-		exit(-1);
-
-cleanup:
-	string_list_clear(tracking.srcs, 0);
-	free(full_orig_ref);
-}
-
 int read_branch_desc(struct strbuf *buf, const char *branch_name)
 {
 	char *v = NULL;
@@ -407,6 +356,53 @@ static void validate_branch_start(struct repository *r, const char *start_name,
 	oidcpy(oid, &commit->object.oid);
 }
 
+void setup_tracking(const char *new_ref, const char *orig_ref,
+			   enum branch_track track, int quiet, int expand_orig)
+{
+	struct tracking tracking;
+	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
+	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
+	char *full_orig_ref;
+	struct object_id unused_oid;
+
+	memset(&tracking, 0, sizeof(tracking));
+	if (expand_orig)
+		validate_branch_start(the_repository, orig_ref, track, &unused_oid, &full_orig_ref);
+	else
+		full_orig_ref = xstrdup(orig_ref);
+
+	tracking.spec.dst = full_orig_ref;
+	tracking.srcs = &tracking_srcs;
+	if (track != BRANCH_TRACK_INHERIT)
+		for_each_remote(find_tracked_branch, &tracking);
+	else if (inherit_tracking(&tracking, orig_ref))
+		return;
+
+	if (!tracking.matches)
+		switch (track) {
+		case BRANCH_TRACK_ALWAYS:
+		case BRANCH_TRACK_EXPLICIT:
+		case BRANCH_TRACK_OVERRIDE:
+			break;
+		default:
+			goto cleanup;
+		}
+
+	if (tracking.matches > 1)
+		die(_("Not tracking: ambiguous information for ref %s"),
+		    full_orig_ref);
+
+	if (tracking.srcs->nr < 1)
+		string_list_append(tracking.srcs, full_orig_ref);
+	if (install_branch_config_multiple_remotes(config_flags, new_ref, tracking.remote,
+			      tracking.srcs) < 0)
+		exit(-1);
+
+cleanup:
+	string_list_clear(tracking.srcs, 0);
+	free(full_orig_ref);
+}
+
 void create_branch(struct repository *r, const char *name,
 		   const char *start_name, int force, int clobber_head_ok,
 		   int reflog, int quiet, enum branch_track track)
-- 
2.33.GIT

