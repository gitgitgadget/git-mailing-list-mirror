Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB92C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbiBOQAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241095AbiBOP75 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:59:57 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FADBBD2FE
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w11so32907727wra.4
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KA8mn4mhpWKDhLHwnGplr1Fa1mftVzp7hVz63ubKL28=;
        b=iLjQsWXWXbQv4nR2IzaQldWS6q5xCIGRfrIV+TWLLHN9kGpkxiCr7UyQ4Z/C3qCQmI
         g1M7syS5yTRyytv+ofnooQ+iyPJ3c3QVvauAUacbHIk1FtjCHZf/BRevQol9ceQlaEhP
         hTvgyLb3VyYZFDFkE77qcgOtCA+ufPn1BvMDPxewnPSR6o051zHS2ONxOyhOo4nCuuGh
         GFAq29WM+JzHbUpiipXWJm2DnK6+m1gc3deV8Jnsy+P21Csexdg8MKumswTsTOky/JCu
         ffp2XvEwdosovUHxoM0PCIQCwH27pThmm//bqG+KS7xtH/IIrejtebxdtfxyqKr3tDW1
         s92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KA8mn4mhpWKDhLHwnGplr1Fa1mftVzp7hVz63ubKL28=;
        b=aMSph9W4oFueK5vKO1dqrUewy7VviBE2SASNmkU0BnEXe5iEzFzSuSjGAGQUOAf0aO
         +s9njyGpx+HK2AruVQIhwEe+XJAGZm7Czy5cRQEyLYJxCA+oOC1ootvyyuyh5UdtZryL
         VFWWeuXq1BjAGTuCGUu5nxIp7zD7fJlGu/BxJs0HbsepAEfSWrlU+Rk3qIWUXnMNKR/V
         0df4ekWkX0PYETHgGNyJDhjK2yF+uiYDM8aEY/U3KLibpGU6iKu2xSJFwyC3ZLzqll4v
         r6m4ZMAxqaR26jdOdkoFPQ7fsMPU4/Lk/6jX81SBETUBSNWAiYr6Y1apYnht4Hcvr/cD
         7uCQ==
X-Gm-Message-State: AOAM5318bc35zO8V1rMBtuPvnzrqAW9m3G8cpqjf+pJYr/8gWybBZpEs
        ALyGJJ9IxNorKWYebHtxsMx5v0lp+H8=
X-Google-Smtp-Source: ABdhPJxRXoFl+ONuQDW2jxl7QGZxOW3y8J44r08Unjg3sHD548lFtLrEYYKWJAWY/NQBM4Tq8/QVyQ==
X-Received: by 2002:adf:e98f:: with SMTP id h15mr3749489wrm.93.1644940784800;
        Tue, 15 Feb 2022 07:59:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg26sm17399012wmb.48.2022.02.15.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:44 -0800 (PST)
Message-Id: <412fbc45868e7f2a05a03e424584b53ded4842e9.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:19 +0000
Subject: [PATCH 09/23] fsmonitor-settings: remote repos on macOS are
 incompatible with FSMonitor
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

Teach Git to detect remote working directories on macOS and mark them as
incompatible with FSMonitor.

With this, `git fsmonitor--daemon run` will error out with a message
like it does for bare repos.

Client commands, like `git status`, will not attempt to start the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 66 ++++++++++++++++++++++++++
 fsmonitor-settings.c                   |  5 ++
 fsmonitor-settings.h                   |  1 +
 3 files changed, 72 insertions(+)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 176a6f5726c..c3b719d6fb0 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -2,8 +2,74 @@
 #include "config.h"
 #include "repository.h"
 #include "fsmonitor-settings.h"
+#include "fsmonitor.h"
+#include <sys/param.h>
+#include <sys/mount.h>
+
+/*
+ * Remote working directories are problematic for FSMonitor.
+ *
+ * The underlying file system on the server machine and/or the remote
+ * mount type (NFS, SAMBA, etc.) dictates whether notification events
+ * are available at all to remote client machines.
+ *
+ * Kernel differences between the server and client machines also
+ * dictate the how (buffering, frequency, de-dup) the events are
+ * delivered to client machine processes.
+ *
+ * A client machine (such as a laptop) may choose to suspend/resume
+ * and it is unclear (without lots of testing) whether the watcher can
+ * resync after a resume.  We might be able to treat this as a normal
+ * "events were dropped by the kernel" event and do our normal "flush
+ * and resync" --or-- we might need to close the existing (zombie?)
+ * notification fd and create a new one.
+ *
+ * In theory, the above issues need to be addressed whether we are
+ * using the Hook or IPC API.
+ *
+ * For the builtin FSMonitor, we create the Unix domain socket for the
+ * IPC in the .git directory.  If the working directory is remote,
+ * then the socket will be created on the remote file system.  This
+ * can fail if the remote file system does not support UDS file types
+ * (e.g. smbfs to a Windows server) or if the remote kernel does not
+ * allow a non-local process to bind() the socket.  (These problems
+ * could be fixed by moving the UDS out of the .git directory and to a
+ * well-known local directory on the client machine, but care should
+ * be taken to ensure that $HOME is actually local and not a managed
+ * file share.)
+ *
+ * So (for now at least), mark remote working directories as
+ * incompatible.
+ */
+static enum fsmonitor_reason is_remote(struct repository *r)
+{
+	struct statfs fs;
+
+	if (statfs(r->worktree, &fs) == -1) {
+		int saved_errno = errno;
+		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
+				 r->worktree, strerror(saved_errno));
+		errno = saved_errno;
+		return FSMONITOR_REASON_ZERO;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
+			 r->worktree, fs.f_type, fs.f_flags, fs.f_fstypename);
+
+	if (!(fs.f_flags & MNT_LOCAL))
+		return FSMONITOR_REASON_REMOTE;
+
+	return FSMONITOR_REASON_ZERO;
+}
 
 enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
 {
+	enum fsmonitor_reason reason;
+
+	reason = is_remote(r);
+	if (reason)
+		return reason;
+
 	return FSMONITOR_REASON_ZERO;
 }
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index bb2ddd2457f..de69ace246a 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -161,6 +161,11 @@ static void create_reason_message(struct repository *r,
 			      _("virtual repos are incompatible with fsmonitor"));
 		return;
 
+	case FSMONITOR_REASON_REMOTE:
+		strbuf_addstr(buf_reason,
+			      _("remote repos are incompatible with fsmonitor"));
+		return;
+
 	default:
 		BUG("Unhandled case in create_reason_message '%d'", s->reason);
 	}
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index c169683bf2d..fca25887c0f 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -17,6 +17,7 @@ enum fsmonitor_reason {
 	FSMONITOR_REASON_ZERO = 0,
 	FSMONITOR_REASON_BARE = 1,
 	FSMONITOR_REASON_VIRTUAL = 2,
+	FSMONITOR_REASON_REMOTE = 3,
 };
 
 void fsm_settings__set_ipc(struct repository *r);
-- 
gitgitgadget

