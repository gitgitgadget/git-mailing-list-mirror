Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498AAC432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B4D2070B
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5tA9yGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfLBT6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:58:05 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:53087 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfLBT6E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 14:58:04 -0500
Received: by mail-pf1-f201.google.com with SMTP id f20so495587pfn.19
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8sFz/JY51jyqsOn2Eqwxq77LNldC4AQN/WSY8Seax5Q=;
        b=A5tA9yGbD1vpDIKC/Wl1cum/ecwCF2+oxqktMa366Fnis8Ts6tm0aDXBlHH9eakeej
         aKGz/gY90k7RzOZwRsgEZGdP4mKTl3iGES/8nHIxNxNw+2qN9Ir58YMuLgahxB9ETacd
         +JZFt3a0XjpIFAY87SIe4HDB0K6zdhSf3yNJeY3Eg8s+kIjj0hwRaYDRIb4pibLHzPNJ
         k3oKfRJy4zdAsjPPHlLPtwIG/8cNqmcEkYEvOhHx2i0SqMteLRTjSTv9wDmUnarHXppY
         jtL3AYskby75Go/kBOFpkaV2I9OpbEt7RP9Xj3HG79nxus01LJ9fZo33kMw+fYC0cl/Z
         5kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8sFz/JY51jyqsOn2Eqwxq77LNldC4AQN/WSY8Seax5Q=;
        b=oIepKy6gGAbFPLwb2PB623C88B13auxEFIPp7VvYI2UuW8jzCOder7Qu+Y7/7AMJS1
         MZEFtuOD8lZwS1iK+thPer6ACtPV7wGunwzTL6ROdE33dBGbq/8wRXNvj/LJNYpmYyb4
         Ax8pEW7ioUBncWMECy3dVgDU02gZWDBZZRv7frVlyOIM2xEX3EHCyRIgg1vjjgnMGkw0
         LaetP53AgUSG5XHXAiliHr/a14+lBp3qwutUzOv6sveSgqszF3aa6+0J93enNqv69eXc
         Xn5wtSQuf8FjRHQ5l9sfNG1XJ4ur7W7Yem/aZxf/yFO1DAIwIyRxKt7JZI3T0F02xsOn
         UG6g==
X-Gm-Message-State: APjAAAX/LTcVuS6YO0pJ67w1+Ooh2gpCbORoJc6g0I6BZPNevYMgMWPX
        P42qQspw8owvDI5sDqJS5UtylW+ETdQ8HSHaDfkpg0jQi+s84v9urrwGIB6fIx6DFR3sVc9dU9F
        T7CQe9Ms6W/2M1bkgOvBULo2Sd2a3eCDZ89u1BKhfjuBChU1PTfxegU4mWne2aqqIA4hfx99aDM
        BF
X-Google-Smtp-Source: APXvYqwog7P9BPWsTN2QeCFjwy4UPLdgWRKmePTn92EGOeCY8s0csITdHOwoarvoX71eUH18FuEHSANoXYDqDfd5MI9F
X-Received: by 2002:a63:b22:: with SMTP id 34mr917485pgl.90.1575316682360;
 Mon, 02 Dec 2019 11:58:02 -0800 (PST)
Date:   Mon,  2 Dec 2019 11:57:52 -0800
In-Reply-To: <cover.1575316490.git.jonathantanmy@google.com>
Message-Id: <4f2182aa26b3da1fb80700e67f81e721778ea046.1575316490.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1574731649.git.jonathantanmy@google.com> <cover.1575316490.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2 2/2] submodule--helper: advise on fatal alternate error
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
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
index 2c2395a620..12d546dfbb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -19,6 +19,7 @@
 #include "diffcore.h"
 #include "diff.h"
 #include "object-store.h"
+#include "advice.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -1268,6 +1269,13 @@ struct submodule_alternate_setup {
 #define SUBMODULE_ALTERNATE_SETUP_INIT { NULL, \
 	SUBMODULE_ALTERNATE_ERROR_IGNORE, NULL }
 
+static const char alternate_error_advice[] = N_(
+"An alternate computed from a superproject's alternate is invalid.\n"
+"To allow Git to clone without an alternate in such a case, set\n"
+"submodule.alternateErrorStrategy to 'info' or, equivalently, clone with\n"
+"'--reference-if-able' instead of '--reference'."
+);
+
 static int add_possible_reference_from_superproject(
 		struct object_directory *odb, void *sas_cb)
 {
@@ -1299,6 +1307,8 @@ static int add_possible_reference_from_superproject(
 		} else {
 			switch (sas->error_mode) {
 			case SUBMODULE_ALTERNATE_ERROR_DIE:
+				if (advice_submodule_alternate_error_strategy_die)
+					advise(_(alternate_error_advice));
 				die(_("submodule '%s' cannot add alternate: %s"),
 				    sas->submodule_name, err.buf);
 			case SUBMODULE_ALTERNATE_ERROR_INFO:
-- 
2.24.0.393.g34dc348eaf-goog

