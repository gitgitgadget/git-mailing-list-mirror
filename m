Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B941C433FE
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 15:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbiBOP77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:59:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbiBOP7y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:59:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95348BDE62
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i14so32845370wrc.10
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rKlKildQJZ1+OIIunPCbX80u3V0q8AF3Opxe15VhUHs=;
        b=JtoQxUs9HMe7PnmlVaEfws8HTjdy3W/2nOutTZd7c4s3ZJl0Wf4fHegy55g1Z6YE6m
         RHjcYnnw+7XVGl3DGCEILpZ4mjPVDl3JwbeIed4KDfFmAkVF6JsPksuN+xdB4QlaxH7D
         83p2xtj6C/lDuC7TO3G3FR8RPRCRuxdkn1k3LgUq6B/ISnADOJr71tKGHu0P4wc8sZMT
         XnOdcb67V+ix7eT4NvT6AKAe5svgXgrMo+wRxNhzQ633QpJpz1gjS3cYHi9vAsNv4tl6
         w1GAn+A7nPNsOjwChrbH7Wzo4hpCxXRjHouotFGHZyTOi5+KdoMAsnISzXoXcHA3mHA1
         6STw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rKlKildQJZ1+OIIunPCbX80u3V0q8AF3Opxe15VhUHs=;
        b=osbYTC4rxzAnBhRp83lru54PT4MEioqea8718XGZw11YbuDI+A7OqMvV3CpTiYmK7U
         FdL0FjV/v7VdyBFSoaBZLBBoDBwHuWQ+u8zpO6sobqoKoZqyqQZOJj5AZfnoFhK6wrjk
         pDXIUvjVx4bzqFTY46NgHWcf0gqN0xb73V55lKy+pUk6Jd2r4i8kRR02z6rFE6q5hiIl
         ++m/RqZYTi3GliVWGWwlPOnUkGIzb9Imx4tcZMaFQ41Jt3BkyvTdAy27FY4efJrP00My
         nWmoL+IPsjQXS5//MYbnJQfPfRrHSmNFKFuBkaXj9nzmwmK4oDZK43BtCbGH+nzgB4b4
         RoCQ==
X-Gm-Message-State: AOAM530wkF9G9Rv0N3q1dhiNLIgFzFecGOxBZnMyIgikYrzztF/fiqjv
        qBu2Jv7AIXVjEM1+cUCmMdaKbCMJs5o=
X-Google-Smtp-Source: ABdhPJz8dfKuwyWyelRE9kXE413wkl9kdQjlSLYStNwx9L0RVAgqlCoWkXA3+EdVQrJKlAj12Qc0Tw==
X-Received: by 2002:a5d:4c89:: with SMTP id z9mr3922987wrs.365.1644940783065;
        Tue, 15 Feb 2022 07:59:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d14sm16623913wrv.50.2022.02.15.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:42 -0800 (PST)
Message-Id: <4e856d60e385d64158f17ec1226f97eb323bc55e.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:17 +0000
Subject: [PATCH 07/23] fsmonitor-settings: virtual repos are incompatible with
 FSMonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Virtual repos, such as GVFS (aka VFS for Git), are incompatible
with FSMonitor.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-win32.c | 26 ++++++++++++++++++++++++++
 fsmonitor-settings.c                  |  5 +++++
 fsmonitor-settings.h                  |  1 +
 t/t7519-status-fsmonitor.sh           |  9 +++++++++
 4 files changed, 41 insertions(+)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 176a6f5726c..7caa79570af 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -3,7 +3,33 @@
 #include "repository.h"
 #include "fsmonitor-settings.h"
 
+/*
+ * GVFS (aka VFS for Git) is incompatible with FSMonitor.
+ *
+ * Granted, core Git does not know anything about GVFS and we
+ * shouldn't make assumptions about a downstream feature, but users
+ * can install both versions.  And this can lead to incorrect results
+ * from core Git commands.  So, without bringing in any of the GVFS
+ * code, do a simple config test for a published config setting.  (We
+ * do not look at the various *_TEST_* environment variables.)
+ */
+static enum fsmonitor_reason is_virtual(struct repository *r)
+{
+	const char *const_str;
+
+	if (!repo_config_get_value(r, "core.virtualfilesystem", &const_str))
+		return FSMONITOR_REASON_VIRTUAL;
+
+	return FSMONITOR_REASON_ZERO;
+}
+
 enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
+	enum fsmonitor_reason reason;
+
+	reason = is_virtual(r);
+	if (reason)
+		return reason;
+
 	return FSMONITOR_REASON_ZERO;
 }
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index e445572354e..bb2ddd2457f 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -156,6 +156,11 @@ static void create_reason_message(struct repository *r,
 			      _("bare repos are incompatible with fsmonitor"));
 		return;
 
+	case FSMONITOR_REASON_VIRTUAL:
+		strbuf_addstr(buf_reason,
+			      _("virtual repos are incompatible with fsmonitor"));
+		return;
+
 	default:
 		BUG("Unhandled case in create_reason_message '%d'", s->reason);
 	}
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index b52bf8edaf1..c169683bf2d 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -16,6 +16,7 @@ enum fsmonitor_mode {
 enum fsmonitor_reason {
 	FSMONITOR_REASON_ZERO = 0,
 	FSMONITOR_REASON_BARE = 1,
+	FSMONITOR_REASON_VIRTUAL = 2,
 };
 
 void fsm_settings__set_ipc(struct repository *r);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 3c4e6f5f89c..d7540931a16 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -81,6 +81,15 @@ test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
 	grep "bare repos are incompatible with fsmonitor" actual
 '
 
+test_expect_success MINGW,FSMONITOR_DAEMON 'run fsmonitor-daemon in virtual repo' '
+	test_when_finished "rm -rf ./fake-virtual-clone actual" &&
+	git init fake-virtual-clone &&
+	test_must_fail git -C ./fake-virtual-clone \
+			   -c core.virtualfilesystem=true \
+			   fsmonitor--daemon run 2>actual &&
+	grep "virtual repos are incompatible with fsmonitor" actual
+'
+
 test_expect_success 'setup' '
 	mkdir -p .git/hooks &&
 	: >tracked &&
-- 
gitgitgadget

