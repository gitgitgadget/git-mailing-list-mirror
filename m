Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46635C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 16:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244728AbiHWQcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbiHWQbs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 12:31:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A6923CB
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 06:03:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n4so16896698wrp.10
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=5miujd8eQmzYhL6fsXqMLgsGlKgK2RxCYEXNpDWNabE=;
        b=AvC64bNpbQ6vn4tveRYkst96+F3ivteNlSUC+3Y9fC2WbWqw2Fi+/4ELq7MiLTzMlI
         iVUGHXYkFMcwnsC52GBpemp7Jc3Mie8PqK+eZwRVO6JoBVuaGC7YDcYTwYcIVNDfqaCI
         vqlymHbOj/I9H6Aw7v1ALq90J/cDJBFOnNWNrel+aHcKhm9NPtuAjO5hV1+z2nKqhSbz
         AAZuQ1cNRYPYJ80Qe7+p75MhWn2M7qtJMGyNYf8Ybg38jevSycQMM+ME0NlcyNnV+Ei2
         rifoHJEMPshkOr9CfMzmtCV7mEs6atlXRf2xRTOhvL7GjiXRhaeJIoinlprNJ84WSuh7
         /cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=5miujd8eQmzYhL6fsXqMLgsGlKgK2RxCYEXNpDWNabE=;
        b=M+ZrDq+uCO+CUoszDEtJ7u4bNpyg3XsTDJwL1cPHxY62Qb1WYW6ZzKrDdO8W7lu0UY
         Ih6x8IZY6ctJ++w9h15mDTBaFjtYbyHhVqMW/TXzw0ROHXvkkyOeqA44XkFZvrJm0b9h
         fxy3QJPAh3ain1viSyc+hKx/i9OsX7YsJ6qcwGUQxlmVnqOSmpVtlDdQ/B5dAZKDi1fS
         WuJgjyIG7PleDqjvzD9wEGdeN6yDE74Jg7SDPaBz2UvVKEJZQMYR+fHUP8VewZBdAjH8
         l66g1qPUnyQ4EJgDVCTaiFS9RpKk+0BhtZ05LsYEjmSaRcEd2qHPE71DmNHYe/A4gm63
         8hdA==
X-Gm-Message-State: ACgBeo07luwVcRwA5U12APT4MrZ/b6fzOxfklFrcmjQpe6ee1qRbwPIF
        VXmEO71BGvns15sq7O0Lu1Z4GRiC71o=
X-Google-Smtp-Source: AA6agR4oNqexq/RnyGilaToUg2APDA4ZA1ubidzcVwJaSY7dC9FwusTIE8iqFqftABWJjzqdDN8Jag==
X-Received: by 2002:a05:6000:15c7:b0:225:4ec1:4389 with SMTP id y7-20020a05600015c700b002254ec14389mr7426679wry.573.1661259822197;
        Tue, 23 Aug 2022 06:03:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2-20020a05600c41c200b003a541d893desm16830969wmh.38.2022.08.23.06.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:03:41 -0700 (PDT)
Message-Id: <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 13:03:36 +0000
Subject: [PATCH v2 0/4] fsmonitor: option to allow fsmonitor to run against network-mounted repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cc: Johannes Schindelin Johannes.Schindelin@gmx.de cc: Jeff Hostetler
git@jeffhostetler.com cc: Eric Sunshine sunshine@sunshineco.com cc: Torsten
Bögershausen tboegi@web.de

Eric DeCosta (2):
  fsmonitor: option to allow fsmonitor to run against network-mounted
    repos
  fsmonitor: macOS: allow fsmonitor to run against network-mounted repos

edecosta (2):
  Check working directory and Unix domain socket file for compatability
  Minor refactoring and simplification of Windows settings checks

 compat/fsmonitor/fsm-settings-darwin.c | 72 +++++++++++++++++++-------
 compat/fsmonitor/fsm-settings-win32.c  | 47 ++++++++++++++++-
 fsmonitor-ipc.c                        | 40 ++++++++++++--
 fsmonitor-ipc.h                        |  6 +++
 fsmonitor-settings.c                   | 67 +++++++++++++++++++++++-
 fsmonitor-settings.h                   |  4 ++
 6 files changed, 210 insertions(+), 26 deletions(-)


base-commit: 9bf691b78cf906751e65d65ba0c6ffdcd9a5a12c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v1:

 -:  ----------- > 1:  40ce21e85c9 fsmonitor: option to allow fsmonitor to run against network-mounted repos
 -:  ----------- > 2:  46b4efd96cc fsmonitor: macOS: allow fsmonitor to run against network-mounted repos
 1:  425df16ac0b ! 3:  9b128a98149 fsmonitor: option to allow fsmonitor to run against network-mounted repos
     @@
       ## Metadata ##
     -Author: Eric DeCosta <edecosta@mathworks.com>
     +Author: edecosta <edecosta@mathworks.com>
      
       ## Commit message ##
     -    fsmonitor: option to allow fsmonitor to run against network-mounted repos
     +    Check working directory and Unix domain socket file for compatability
      
     -    Though perhaps not common, there are uses cases where users have large,
     -    network-mounted repos. Having the ability to run fsmonitor against
     -    network paths would benefit those users.
     +    Perform separate checks for the working directory and Unix domain socket
     +    (UDS) file location. The working directory may be located on a
     +    network-mounted file system if 'fsmonitor.allowRemote' is true. The UDS
     +    file may never be located on a network-mounted file system; additionally
     +    it may not be located on FAT32 or NTFS file systems.
      
     -    As a first step towards enabling fsmonitor to work against
     -    network-mounted repos, a configuration option, 'fsmonitor.allowRemote'
     -    was introduced for Windows. Setting this option to true will override
     -    the default behavior (erroring-out) when a network-mounted repo is
     -    detected by fsmonitor. In order for macOS to have parity with Windows,
     -    the same option is now introduced for macOS.
     -
     -    The the added wrinkle being that the Unix domain socket (UDS) file
     -    used for IPC cannot be created in a network location; instead the
     -    temporary directory is used.
     -
     -    Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
     +    Signed-off-by: edecosta <edecosta@mathworks.com>
      
       ## compat/fsmonitor/fsm-settings-darwin.c ##
      @@
     - #include "config.h"
       #include "repository.h"
       #include "fsmonitor-settings.h"
     -+#include "fsmonitor-ipc.h"
       #include "fsmonitor.h"
     ++#include "fsmonitor-ipc.h"
       #include <sys/param.h>
       #include <sys/mount.h>
       
     -+/*
     -+ * Check if monitoring remote working directories is allowed.
     -+ *
     -+ * By default, monitoring remote working directories is
     -+ * disabled.  Users may override this behavior in enviroments where
     -+ * they have proper support.
     -+ */
     -+static int check_config_allowremote(struct repository *r)
     -+{
     -+	int allow;
     -+
     -+	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
     -+		return allow;
     -+
     -+	return -1; /* fsmonitor.allowremote not set */
     -+}
     -+
       /*
     -  * [1] Remote working directories are problematic for FSMonitor.
     +- * [1] Remote working directories are problematic for FSMonitor.
     ++ * Remote working directories are problematic for FSMonitor.
        *
     +  * The underlying file system on the server machine and/or the remote
     +  * mount type (NFS, SAMBA, etc.) dictates whether notification events
      @@
        * In theory, the above issues need to be addressed whether we are
        * using the Hook or IPC API.
        *
     -+ * So (for now at least), mark remote working directories as
     -+ * incompatible by default.
     -+ *
     -  * For the builtin FSMonitor, we create the Unix domain socket for the
     +- * For the builtin FSMonitor, we create the Unix domain socket for the
      - * IPC in the .git directory.  If the working directory is remote,
      - * then the socket will be created on the remote file system.  This
      - * can fail if the remote file system does not support UDS file types
     @@ compat/fsmonitor/fsm-settings-darwin.c
      - * well-known local directory on the client machine, but care should
      - * be taken to ensure that $HOME is actually local and not a managed
      - * file share.)
     -+ * IPC in the temporary directory.  If the temporary directory is
     -+ * remote, then the socket will be created on the remote file system.
     -+ * This can fail if the remote file system does not support UDS file
     -+ * types (e.g. smbfs to a Windows server) or if the remote kernel does
     -+ * not allow a non-local process to bind() the socket.
     -  *
     -- * So (for now at least), mark remote working directories as
     +- *
     +  * So (for now at least), mark remote working directories as
      - * incompatible.
     -+ * Therefore remote UDS locations are marked as incompatible.
     -  *
     -  *
     -  * [2] FAT32 and NTFS working directories are problematic too.
     -  *
     +- *
     +- *
     +- * [2] FAT32 and NTFS working directories are problematic too.
     +- *
      - * The builtin FSMonitor uses a Unix domain socket in the .git
     -+ * The builtin FSMonitor uses a Unix domain socket in the temporary
     -  * directory for IPC.  These Windows drive formats do not support
     -  * Unix domain sockets, so mark them as incompatible for the daemon.
     +- * directory for IPC.  These Windows drive formats do not support
     +- * Unix domain sockets, so mark them as incompatible for the daemon.
     ++ * incompatible unless fsmonitor.allowRemote is true.
        *
     +  */
     + static enum fsmonitor_reason check_volume(struct repository *r)
      @@ compat/fsmonitor/fsm-settings-darwin.c: static enum fsmonitor_reason check_volume(struct repository *r)
       			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
       			 r->worktree, fs.f_type, fs.f_flags, fs.f_fstypename);
       
     -+	if (!(fs.f_flags & MNT_LOCAL)) {
     -+		switch (check_config_allowremote(r)) {
     -+		case 0: /* config overrides and disables */
     ++	if (!(fs.f_flags & MNT_LOCAL)
     ++		&& (fsm_settings__get_allow_remote(r) < 1))
      +			return FSMONITOR_REASON_REMOTE;
     -+		case 1: /* config overrides and enables */
     -+			return FSMONITOR_REASON_OK;
     -+		default:
     -+			break; /* config has no opinion */
     -+		}
     -+
     -+		return FSMONITOR_REASON_REMOTE;
     -+	}
      +
      +	return FSMONITOR_REASON_OK;
      +}
      +
     ++/*
     ++ * For the builtin FSMonitor, we create the Unix domain socket (UDS)
     ++ * for the IPC in the .git directory by default or $HOME if
     ++ * fsmonitor.allowRemote is true.  If the directory is remote,
     ++ * then the socket will be created on the remote file system. This
     ++ * can fail if the remote file system does not support UDS file types
     ++ * (e.g. smbfs to a Windows server) or if the remote kernel does not
     ++ * allow a non-local process to bind() the socket.
     ++ *
     ++ * Therefore remote UDS locations are marked as incompatible.
     ++ *
     ++ * FAT32 and NTFS working directories are problematic too.
     ++ *
     ++ * These Windows drive formats do not support Unix domain sockets, so
     ++ * mark them as incompatible for the location of the UDS file.
     ++ *
     ++ */
      +static enum fsmonitor_reason check_uds_volume(void)
      +{
      +	struct statfs fs;
     -+	const char *path = fsmonitor_ipc__get_path();
     ++	struct strbuf path = STRBUF_INIT;
     ++	const char *ipc_path = fsmonitor_ipc__get_path();
     ++	strbuf_add(&path, ipc_path, strlen(ipc_path));
      +
     -+	if (statfs(path, &fs) == -1) {
     ++	if (statfs(dirname(path.buf), &fs) == -1) {
      +		int saved_errno = errno;
      +		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
     -+				 path, strerror(saved_errno));
     ++				 path.buf, strerror(saved_errno));
      +		errno = saved_errno;
     ++		strbuf_release(&path);
      +		return FSMONITOR_REASON_ERROR;
      +	}
      +
      +	trace_printf_key(&trace_fsmonitor,
      +			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
     -+			 path, fs.f_type, fs.f_flags, fs.f_fstypename);
     ++			 path.buf, fs.f_type, fs.f_flags, fs.f_fstypename);
     ++	strbuf_release(&path);
      +
       	if (!(fs.f_flags & MNT_LOCAL))
       		return FSMONITOR_REASON_REMOTE;
     @@ compat/fsmonitor/fsm-settings-darwin.c: enum fsmonitor_reason fsm_os__incompatib
      +
       	return FSMONITOR_REASON_OK;
       }
     -
     - ## fsmonitor-ipc.c ##
     -@@
     - #include "fsmonitor-ipc.h"
     - #include "run-command.h"
     - #include "strbuf.h"
     -+#include "tempfile.h"
     - #include "trace2.h"
     - 
     - #ifndef HAVE_FSMONITOR_DAEMON_BACKEND
     -@@ fsmonitor-ipc.c: int fsmonitor_ipc__is_supported(void)
     - 	return 1;
     - }
     - 
     --GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
     -+GIT_PATH_FUNC(fsmonitor_ipc__get_pathfile, "fsmonitor--daemon.ipc")
     -+
     -+static char *gen_ipc_file(void)
     -+{
     -+	char *retval = NULL;
     -+	struct tempfile *ipc;
     -+
     -+	const char *ipc_file = fsmonitor_ipc__get_pathfile();
     -+	FILE *fp = fopen(ipc_file, "w");
     -+
     -+	if (!fp)
     -+		die_errno("error opening '%s'", ipc_file);
     -+	ipc = mks_tempfile_t("fsmonitor_ipc_XXXXXX");
     -+	strbuf_write(&ipc->filename, fp);
     -+	fclose(fp);
     -+	retval = strbuf_detach(&ipc->filename, NULL);
     -+	strbuf_release(&ipc->filename);
     -+	return retval;
     -+}
     -+
     -+const char *fsmonitor_ipc__get_path(void)
     -+{
     -+	char *retval = NULL;
     -+	struct strbuf sb = STRBUF_INIT;
     -+
     -+	const char *ipc_file = fsmonitor_ipc__get_pathfile();
     -+	FILE *fp = fopen(ipc_file, "r");
     -+
     -+	if (!fp) {
     -+		return gen_ipc_file();
     -+	} else {
     -+		strbuf_read(&sb, fileno(fp), 0);
     -+		fclose(fp);
     -+		fp = fopen(sb.buf, "r");
     -+		if (!fp) { /* generate new file */
     -+			if (unlink(ipc_file) < 0)
     -+				die_errno("could not remove '%s'", ipc_file);
     -+			return gen_ipc_file();
     -+		}
     -+		fclose(fp);
     -+		retval = strbuf_detach(&sb, NULL);
     -+		strbuf_release(&sb);
     -+		return retval;
     -+	}
     -+}
     - 
     - enum ipc_active_state fsmonitor_ipc__get_state(void)
     - {
     -
     - ## fsmonitor-ipc.h ##
     -@@ fsmonitor-ipc.h: int fsmonitor_ipc__is_supported(void);
     -  */
     - const char *fsmonitor_ipc__get_path(void);
     - 
     -+/*
     -+ * Returns the pathname to the file that contains the pathname to the
     -+ * IPC named pipe or Unix domain socket.
     -+ */
     -+const char *fsmonitor_ipc__get_pathfile(void);
     -+
     - /*
     -  * Try to determine whether there is a `git-fsmonitor--daemon` process
     -  * listening on the IPC pipe/socket.
 -:  ----------- > 4:  15c965801f8 Minor refactoring and simplification of Windows settings checks

-- 
gitgitgadget
