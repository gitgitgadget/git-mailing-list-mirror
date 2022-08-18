Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489FCC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 20:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbiHRUsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 16:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiHRUsa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 16:48:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF75511141
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 13:48:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so1544711wms.5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=XsXwobsNekxsYRQepQ1xy0i+bhhl3dKG9RHxqwATQNE=;
        b=nYVDQR3IHQFd2sqTjbya/PGBBm0PZR16gsoFk38cPp15RJrTjzMOI3CLoD8jf2N2Wh
         aMMSyaApQt6YSmByhFV4b3rMpiTxcFXmm137kmlZhI+JTMveekZ3CJfhLZV+ptuSCKp6
         p9D1H4QH1jQyuwcElN+TMalyVIaJoPKl8F6PLASGq0fqT3x/+rismPuNFCVIEwssBZME
         IHwtVjhf5rpJ+D04+Qkq3E+EdlCEbyfvG9zxUk+n9PrGnN0waoqCwrRv84Z9851d6NRU
         3495ItIdxnhJZ8wteXEcvicOVokk56684xp3cL2kEiihrG3RqhvQ+WwiRQRCyMpyqwKN
         6CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=XsXwobsNekxsYRQepQ1xy0i+bhhl3dKG9RHxqwATQNE=;
        b=h0VZ2geDi98Wx6qhvaeqI9viSRuNq+xsvMjLMxKrzPpou1lO7SypAG+w/dGFRXyYlp
         YYdOltWrKnMQHQs/bdblJ7uksn7XDKVPuSsT6j9JJpIuLlYeo1Yfbpk4zmY0LRCukJCB
         rwusXfjyOuKESwd/6WcMBRXSDk/yV+VSuZrHWSHzusfmtTnAEwg5zBpfb7B+s1JkyT+x
         sUIuagGdV/DgIQ+woaP4RoKSufbUgBZ+Sdc9XRjMffPkHWwAlV/S7odrooV/DCGFVZyr
         YG6wM3dCMcY5+q5R/MitbfmuOiTAuRXwkSAYuqNVXmhGJcUnXFLQEY+rqtfIsdqGpsQu
         MMDg==
X-Gm-Message-State: ACgBeo0ImiIC3aUhp5Dk5OvTfQceRnLi3Yk4HbiVC6ZdqRUMKsEf8qFs
        iQVBpXBztVmrlQ41Wdop6OnQ8Rtx754=
X-Google-Smtp-Source: AA6agR4sn1ZEZIvVttkl/sDeZ2popUD2/osjN+Q2fvtWP5MVL6qzccBgVIZxlc/QiCJuC6pvdGrI7w==
X-Received: by 2002:a05:600c:1c9a:b0:3a6:1c85:7a0c with SMTP id k26-20020a05600c1c9a00b003a61c857a0cmr2787260wms.155.1660855704920;
        Thu, 18 Aug 2022 13:48:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003a2e92edeccsm5909257wmp.46.2022.08.18.13.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:48:24 -0700 (PDT)
Message-Id: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 20:48:23 +0000
Subject: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Though perhaps not common, there are uses cases where users have large,
network-mounted repos. Having the ability to run fsmonitor against
network paths would benefit those users.

As a first step towards enabling fsmonitor to work against
network-mounted repos, a configuration option, 'fsmonitor.allowRemote'
was introduced for Windows. Setting this option to true will override
the default behavior (erroring-out) when a network-mounted repo is
detected by fsmonitor. In order for macOS to have parity with Windows,
the same option is now introduced for macOS.

The the added wrinkle being that the Unix domain socket (UDS) file
used for IPC cannot be created in a network location; instead the
temporary directory is used.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
    fsmonitor: option to allow fsmonitor to run against network-mounted
    repos

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

 compat/fsmonitor/fsm-settings-darwin.c | 77 ++++++++++++++++++++++----
 fsmonitor-ipc.c                        | 47 +++++++++++++++-
 fsmonitor-ipc.h                        |  6 ++
 3 files changed, 117 insertions(+), 13 deletions(-)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index efc732c0f31..9e2ea3b90cc 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -2,10 +2,28 @@
 #include "config.h"
 #include "repository.h"
 #include "fsmonitor-settings.h"
+#include "fsmonitor-ipc.h"
 #include "fsmonitor.h"
 #include <sys/param.h>
 #include <sys/mount.h>
 
+/*
+ * Check if monitoring remote working directories is allowed.
+ *
+ * By default, monitoring remote working directories is
+ * disabled.  Users may override this behavior in enviroments where
+ * they have proper support.
+ */
+static int check_config_allowremote(struct repository *r)
+{
+	int allow;
+
+	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
+		return allow;
+
+	return -1; /* fsmonitor.allowremote not set */
+}
+
 /*
  * [1] Remote working directories are problematic for FSMonitor.
  *
@@ -27,24 +45,22 @@
  * In theory, the above issues need to be addressed whether we are
  * using the Hook or IPC API.
  *
+ * So (for now at least), mark remote working directories as
+ * incompatible by default.
+ *
  * For the builtin FSMonitor, we create the Unix domain socket for the
- * IPC in the .git directory.  If the working directory is remote,
- * then the socket will be created on the remote file system.  This
- * can fail if the remote file system does not support UDS file types
- * (e.g. smbfs to a Windows server) or if the remote kernel does not
- * allow a non-local process to bind() the socket.  (These problems
- * could be fixed by moving the UDS out of the .git directory and to a
- * well-known local directory on the client machine, but care should
- * be taken to ensure that $HOME is actually local and not a managed
- * file share.)
+ * IPC in the temporary directory.  If the temporary directory is
+ * remote, then the socket will be created on the remote file system.
+ * This can fail if the remote file system does not support UDS file
+ * types (e.g. smbfs to a Windows server) or if the remote kernel does
+ * not allow a non-local process to bind() the socket.
  *
- * So (for now at least), mark remote working directories as
- * incompatible.
+ * Therefore remote UDS locations are marked as incompatible.
  *
  *
  * [2] FAT32 and NTFS working directories are problematic too.
  *
- * The builtin FSMonitor uses a Unix domain socket in the .git
+ * The builtin FSMonitor uses a Unix domain socket in the temporary
  * directory for IPC.  These Windows drive formats do not support
  * Unix domain sockets, so mark them as incompatible for the daemon.
  *
@@ -65,6 +81,39 @@ static enum fsmonitor_reason check_volume(struct repository *r)
 			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
 			 r->worktree, fs.f_type, fs.f_flags, fs.f_fstypename);
 
+	if (!(fs.f_flags & MNT_LOCAL)) {
+		switch (check_config_allowremote(r)) {
+		case 0: /* config overrides and disables */
+			return FSMONITOR_REASON_REMOTE;
+		case 1: /* config overrides and enables */
+			return FSMONITOR_REASON_OK;
+		default:
+			break; /* config has no opinion */
+		}
+
+		return FSMONITOR_REASON_REMOTE;
+	}
+
+	return FSMONITOR_REASON_OK;
+}
+
+static enum fsmonitor_reason check_uds_volume(void)
+{
+	struct statfs fs;
+	const char *path = fsmonitor_ipc__get_path();
+
+	if (statfs(path, &fs) == -1) {
+		int saved_errno = errno;
+		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
+				 path, strerror(saved_errno));
+		errno = saved_errno;
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
+			 path, fs.f_type, fs.f_flags, fs.f_fstypename);
+
 	if (!(fs.f_flags & MNT_LOCAL))
 		return FSMONITOR_REASON_REMOTE;
 
@@ -85,5 +134,9 @@ enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 	if (reason != FSMONITOR_REASON_OK)
 		return reason;
 
+	reason = check_uds_volume();
+	if (reason != FSMONITOR_REASON_OK)
+		return reason;
+
 	return FSMONITOR_REASON_OK;
 }
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 789e7397baa..6e9b40a03d5 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -4,6 +4,7 @@
 #include "fsmonitor-ipc.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "tempfile.h"
 #include "trace2.h"
 
 #ifndef HAVE_FSMONITOR_DAEMON_BACKEND
@@ -47,7 +48,51 @@ int fsmonitor_ipc__is_supported(void)
 	return 1;
 }
 
-GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
+GIT_PATH_FUNC(fsmonitor_ipc__get_pathfile, "fsmonitor--daemon.ipc")
+
+static char *gen_ipc_file(void)
+{
+	char *retval = NULL;
+	struct tempfile *ipc;
+
+	const char *ipc_file = fsmonitor_ipc__get_pathfile();
+	FILE *fp = fopen(ipc_file, "w");
+
+	if (!fp)
+		die_errno("error opening '%s'", ipc_file);
+	ipc = mks_tempfile_t("fsmonitor_ipc_XXXXXX");
+	strbuf_write(&ipc->filename, fp);
+	fclose(fp);
+	retval = strbuf_detach(&ipc->filename, NULL);
+	strbuf_release(&ipc->filename);
+	return retval;
+}
+
+const char *fsmonitor_ipc__get_path(void)
+{
+	char *retval = NULL;
+	struct strbuf sb = STRBUF_INIT;
+
+	const char *ipc_file = fsmonitor_ipc__get_pathfile();
+	FILE *fp = fopen(ipc_file, "r");
+
+	if (!fp) {
+		return gen_ipc_file();
+	} else {
+		strbuf_read(&sb, fileno(fp), 0);
+		fclose(fp);
+		fp = fopen(sb.buf, "r");
+		if (!fp) { /* generate new file */
+			if (unlink(ipc_file) < 0)
+				die_errno("could not remove '%s'", ipc_file);
+			return gen_ipc_file();
+		}
+		fclose(fp);
+		retval = strbuf_detach(&sb, NULL);
+		strbuf_release(&sb);
+		return retval;
+	}
+}
 
 enum ipc_active_state fsmonitor_ipc__get_state(void)
 {
diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
index b6a7067c3af..63277dea39e 100644
--- a/fsmonitor-ipc.h
+++ b/fsmonitor-ipc.h
@@ -18,6 +18,12 @@ int fsmonitor_ipc__is_supported(void);
  */
 const char *fsmonitor_ipc__get_path(void);
 
+/*
+ * Returns the pathname to the file that contains the pathname to the
+ * IPC named pipe or Unix domain socket.
+ */
+const char *fsmonitor_ipc__get_pathfile(void);
+
 /*
  * Try to determine whether there is a `git-fsmonitor--daemon` process
  * listening on the IPC pipe/socket.

base-commit: 9bf691b78cf906751e65d65ba0c6ffdcd9a5a12c
-- 
gitgitgadget
