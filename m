Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECCAC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 15:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbiBOP77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:59:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241072AbiBOP7y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:59:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5555BDE59
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:43 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d27so29119671wrb.5
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ql3BwyKnQQmRB4gTQ2bCfGNXZ0vsfhL/9Gg63XIFLq8=;
        b=Dg5yFaJNcJ7FJjlk6qFUpYSdMWfzdXn+8QWHLYWla37GqyQ/whkUmyn6YwAQuVdhyx
         ag2YsjbarLffxanrU4fKjxG6n/QvQf4rp8XEMRwJMKC3NeFZGFpLEuKHBwBX+SkDPAfy
         tm7accS/1nqKjlS5+xGaWtSWjQpcQVzIuu2CTSiJ4izodNIttP4VBntq0K9RXlIueIHu
         Ch0RFOtGP8uV13MA9aFqWsU/Za0l5HZNFDwYg9Ic8nHZ9TO76waV5kJJPlfPi/BtDQ3P
         Bs08aIOyL0k+xr6mTVer6XFee5Sa91drqfnjOxngdSCQVbIm0ofBMOPbp1AS6EibBgC/
         p8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ql3BwyKnQQmRB4gTQ2bCfGNXZ0vsfhL/9Gg63XIFLq8=;
        b=vNoR20wQc2R4FZFDXbGQSsJzaSHkr9nfih4N/009o0iBdSotud9dZy1W5IJudYel7F
         VsO+lmDfJNCnz9KTZecvl8TZMtv8YZ5oEbGZbctz4VaE6bT6bOLTO1zBMY8dvzcYaCvJ
         wByAmDWh1kU8hljqWR9zlBMxXwP/gkigjgriN5OKoyTvA+krS+ifBxqbKvw5Tc96bDI+
         XA2cWlM/wRdwj3A++LruvKfi3mksqduxbiWZaDnT812mHFUOKiIcmV34oN4jkIjsxRaN
         NVtH6pqBvq6jHQ8RyPdurm/y4NkIyeg4obPCjkXGuLjYl9foKlOnXXhAeuGEUZe2lVj8
         HW/w==
X-Gm-Message-State: AOAM532xRksmN1sspP8M4GJikNlquXpEuhWIYHnTTHC3VZgJbOgUlzAo
        tS9Zwv7pm2UykKKy0EvE/+ZRAtFYeUA=
X-Google-Smtp-Source: ABdhPJzdhqM19kGMJQGNfBfqKIaOuI1dVDg1Ktx1QMO+MDZUuJgGa148CFrt0bRvQAaIvjNTDLzK3w==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr3513961wru.633.1644940782170;
        Tue, 15 Feb 2022 07:59:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm3990259wro.104.2022.02.15.07.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:41 -0800 (PST)
Message-Id: <4715677f85ff3f47b437f82e2b82a8b5dd371c99.1644940773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:16 +0000
Subject: [PATCH 06/23] fsmonitor-settings: stub in platform-specific
 incompatibility checking
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

Extend generic incompatibility checkout with platform-specific
mechanism.  Stub in Win32 version.

In the existing fsmonitor-settings code we have a way to mark
types of repos as incompatible with fsmonitor (whether via the
hook and ipc APIs).  For example, we do this for bare repos,
since there are no files to watch.

Extend this exclusion mechanism for platfor-specific reasons.
This commit just creates the framework and adds a stub for Win32.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                              | 13 +++++++++++++
 compat/fsmonitor/fsm-settings-win32.c |  9 +++++++++
 config.mak.uname                      |  4 ++++
 contrib/buildsystems/CMakeLists.txt   |  3 +++
 fsmonitor-settings.c                  | 12 ++++++++++++
 fsmonitor-settings.h                  | 13 +++++++++++++
 6 files changed, 54 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-settings-win32.c

diff --git a/Makefile b/Makefile
index 5ad0cef69f4..ed3d5231ea1 100644
--- a/Makefile
+++ b/Makefile
@@ -470,6 +470,11 @@ all::
 # `compat/fsmonitor/fsm-listen-<name>.c` that implements the
 # `fsm_listen__*()` routines.
 #
+# If your platform has os-specific ways to tell if a repo is incompatible with
+# fsmonitor (whether the hook or ipc daemon version), set FSMONITOR_OS_SETTINGS
+# to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
+# that implements the `fsm_os_settings__*()` routines.
+#
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and family are auto detected, but could be overridden by defining
 # COMPILER_FEATURES (see config.mak.dev). You can still set
@@ -1941,6 +1946,11 @@ ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
+ifdef FSMONITOR_OS_SETTINGS
+	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
+	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -2819,6 +2829,9 @@ GIT-BUILD-OPTIONS: FORCE
 ifdef FSMONITOR_DAEMON_BACKEND
 	@echo FSMONITOR_DAEMON_BACKEND=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
 endif
+ifdef FSMONITOR_OS_SETTINGS
+	@echo FSMONITOR_OS_SETTINGS=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_OS_SETTINGS)))'\' >>$@+
+endif
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
new file mode 100644
index 00000000000..176a6f5726c
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -0,0 +1,9 @@
+#include "cache.h"
+#include "config.h"
+#include "repository.h"
+#include "fsmonitor-settings.h"
+
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
+{
+	return FSMONITOR_REASON_ZERO;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 81f21d9e201..219a04b4c66 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -441,6 +441,8 @@ ifeq ($(uname_S),Windows)
 	# These are always available, so we do not have to conditionally
 	# support it.
 	FSMONITOR_DAEMON_BACKEND = win32
+	FSMONITOR_OS_SETTINGS = win32
+
 	NO_SVN_TESTS = YesPlease
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
@@ -629,6 +631,8 @@ ifeq ($(uname_S),MINGW)
 	# These are always available, so we do not have to conditionally
 	# support it.
 	FSMONITOR_DAEMON_BACKEND = win32
+	FSMONITOR_OS_SETTINGS = win32
+
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 41395705ac6..7b8ea41967b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -289,6 +289,9 @@ if(SUPPORTS_SIMPLE_IPC)
 	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
+
+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 0fc5566eb8a..e445572354e 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -33,6 +33,18 @@ static int check_for_incompatible(struct repository *r)
 		return 1;
 	}
 
+#ifdef HAVE_FSMONITOR_OS_SETTINGS
+	{
+		enum fsmonitor_reason reason;
+
+		reason = fsm_os__incompatible(r);
+		if (reason != FSMONITOR_REASON_ZERO) {
+			set_incompatible(r, reason);
+			return 1;
+		}
+	}
+#endif
+
 	return 0;
 }
 
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index e5f145a2f79..b52bf8edaf1 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -29,4 +29,17 @@ enum fsmonitor_reason fsm_settings__get_reason(struct repository *r,
 
 struct fsmonitor_settings;
 
+#ifdef HAVE_FSMONITOR_OS_SETTINGS
+/*
+ * Ask platform-specific code whether the repository is incompatible
+ * with fsmonitor (both hook and ipc modes).  For example, if the working
+ * directory is on a remote volume and mounted via a technology that does
+ * not support notification events.
+ *
+ * fsm_os__* routines should considered private to fsm_settings__
+ * routines.
+ */
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r);
+#endif /* HAVE_FSMONITOR_OS_SETTINGS */
+
 #endif /* FSMONITOR_SETTINGS_H */
-- 
gitgitgadget

