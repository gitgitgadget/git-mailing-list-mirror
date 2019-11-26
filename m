Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D64C43215
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7302B2082F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJhOu+KS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKZBbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:31:11 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:53371 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBbL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:31:11 -0500
Received: by mail-pf1-f202.google.com with SMTP id h2so10891005pfr.20
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aG3hoyBPa5gqigAjXPDQq8Bb6NO//R6ASZ/lLq8yukA=;
        b=TJhOu+KSUPVvkpCbTXJLhewsauswYCxQ0YF+Hr1uys6ZYnd7bD3Aupi7TzGynqZi87
         djlo6vS4mmirCkaDkavHnIi8sErN1zb5OYZXiQmoqWqFSM+HMGlpAFymuPrw825CA0HX
         N5DhCvzo+WDYzsgDo9q3A1o/z/snnlXi3kNsN7g8V50VcFl7L950HAHS/awlyVhgY/ch
         nwkfYuXziDnLdLBijhv2u34StzKs/b0MhtE3pUDyGQiaE/KD8avbZDL9WMeW7uQ/DbaM
         NV3LigmD0UrGLBT3xGiBwrF0BwM0tqGKOUuAC6lT4+a8ALYZ5CWywb86F2l3SGEvQmMs
         EkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aG3hoyBPa5gqigAjXPDQq8Bb6NO//R6ASZ/lLq8yukA=;
        b=sJP2LrDftfwnV/7K/hxCr5aSwJg3vnbEL8K1lXuQrsA+0VoPghIIx1yaI/I522t10g
         XxpdElrRglYimOk+XrcwfY6M0P38QydUm94Qaemr9zUbWVngEv6lhs8L42szeRHbZS92
         5LY6WLQhW/J4zDzWodaosGn4EZGQotabhNeY8eBM0HegpNifyTpD8OB1ggvToDH2Le4C
         ok7J13wwxEiKS2zNJY1stm9FSoIjPDTLuqSb8bC8FgV9dT4BFXZ3nu3eTrD7b21MMwT6
         99p12+tUw3tpfDgOdG0ohEth9YSw3sK4b3U8ZcPkP1Q9tXi9RyqaqsygPg3e/RhtAdAD
         f6Dw==
X-Gm-Message-State: APjAAAVZ5fiirht4sSIPqxkazLBX0wGcqTryQ98xDCtuBgeuOMDP0GKz
        5kvLbtxic2ptFoDWP08qgnoD0L+Jp1KpUn6xlRbg7juz8+UAv2HwZU/vBJYtci13vKGKbL0gs2f
        SlNnBxPGjDapt5P1shIgnFs2JX7mvXICbo6XeU3as+VcH9/fogRQx3Kol/L+sCJjYSEifIJ9rfQ
        83
X-Google-Smtp-Source: APXvYqyP+dC+k2RqrrSB1zyUAcF77DKW/QdOjEQ5qQPt+u8sb8FJ9HDbW9G5crhlxuGy2n78+GemFUorkpWFxvfId3D/
X-Received: by 2002:a63:4b03:: with SMTP id y3mr34950752pga.155.1574731869433;
 Mon, 25 Nov 2019 17:31:09 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:31:00 -0800
In-Reply-To: <cover.1574731649.git.jonathantanmy@google.com>
Message-Id: <26c3b388a24eef7f03eb423c10e21430bc3f019e.1574731649.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1574731649.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH 2/2] submodule--helper: advise on fatal alternate error
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When recursively cloning a superproject with some shallow modules
defined in its .gitmodules, then recloning with "--reference=<path>", an
error occurs. For example:

  git clone --recurse-submodules --branch=master -j8 \
    https://android.googlesource.com/platform/superproject \
    master
  git clone --recurse-submodules --branch=master -j8 \
    https://android.googlesource.com/platform/superproject \
    --reference master master2

fails with:

  fatal: submodule '<snip>' cannot add alternate: reference repository
  '<snip>' is shallow

When a alternate computed from the superproject's alternate cannot be
added, whether in this case or another, advise about configuring the
"submodule.alternateErrorStrategy" configuration option and using
"--reference-if-able" instead of "--reference" when cloning.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config/advice.txt |  3 +++
 advice.c                        |  2 ++
 advice.h                        |  1 +
 builtin/submodule--helper.c     | 10 ++++++++++
 4 files changed, 16 insertions(+)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 6aaa360202..d4e698cd3f 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -107,4 +107,7 @@ advice.*::
 		editor input from the user.
 	nestedTag::
 		Advice shown if a user attempts to recursively tag a tag object.
+	submoduleAlternateErrorStrategyDie:
+		Advice shown when a submodule.alternateErrorStrategy option
+		configured to "die" causes a fatal error.
 --
diff --git a/advice.c b/advice.c
index 3ee0ee2d8f..249c60dcf3 100644
--- a/advice.c
+++ b/advice.c
@@ -30,6 +30,7 @@ int advice_waiting_for_editor = 1;
 int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
 int advice_nested_tag = 1;
+int advice_submodule_alternate_error_strategy_die = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -89,6 +90,7 @@ static struct {
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
 	{ "nestedTag", &advice_nested_tag },
+	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
 
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index d015404843..b706780614 100644
--- a/advice.h
+++ b/advice.h
@@ -30,6 +30,7 @@ extern int advice_waiting_for_editor;
 extern int advice_graft_file_deprecated;
 extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_nested_tag;
+extern int advice_submodule_alternate_error_strategy_die;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2c2395a620..bdfc46fdea 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -19,6 +19,7 @@
 #include "diffcore.h"
 #include "diff.h"
 #include "object-store.h"
+#include "advice.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -1268,6 +1269,14 @@ struct submodule_alternate_setup {
 #define SUBMODULE_ALTERNATE_SETUP_INIT { NULL, \
 	SUBMODULE_ALTERNATE_ERROR_IGNORE, NULL }
 
+static void advise_submodule_alternate_error_die(void)
+{
+	if (!advice_submodule_alternate_error_strategy_die)
+		return;
+	advise(_("An alternate computed from a superproject's alternate is invalid."));
+	advise(_("To allow Git to clone without an alternate in such a case, set submodule.alternateErrorStrategy to 'info' or, equivalently, clone with '--reference-if-able' instead of '--reference'."));
+}
+
 static int add_possible_reference_from_superproject(
 		struct object_directory *odb, void *sas_cb)
 {
@@ -1299,6 +1308,7 @@ static int add_possible_reference_from_superproject(
 		} else {
 			switch (sas->error_mode) {
 			case SUBMODULE_ALTERNATE_ERROR_DIE:
+				advise_submodule_alternate_error_die();
 				die(_("submodule '%s' cannot add alternate: %s"),
 				    sas->submodule_name, err.buf);
 			case SUBMODULE_ALTERNATE_ERROR_INFO:
-- 
2.24.0.432.g9d3f5f5b63-goog

