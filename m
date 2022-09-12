Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B21CC6FA82
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 15:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiILP1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 11:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiILP1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 11:27:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDA0220F0
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 08:27:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id e68so8976811pfe.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=WUBOCQSYkeRXMGbMXnx4wVoruOBiSxmCYokYjYMmvjg=;
        b=CCueYfm1TFdwiF5ggywXSy1mi25nj+5k6N1QHrhZkIwthKGKIlpE4FsSnyfsLdtbNz
         ef0UEhEuMzo4ThrnPUJhXuTnXLGIoNvsWR408D5R9n9T3RdfcE2ftYQjpg5e1+tsYYSb
         KttZwspQaQgrx21PuRzzzrIZkT2gmqfnv5GYinX/+kUNsl5TmQDCC2O5mE/1hJzeeq7k
         fmubJeoLtO5tjMQYzy35iXwbnj48nExdLWTego/K8TV3DiiLFpi+TPATDW1MrT1Qnr1Z
         olsCJWkSABpRGo/qBdPu3cf1bbnd0x5jm2nJxSgobU4U9ZSw2YVVsxJmE8xND4Qp23D6
         5w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=WUBOCQSYkeRXMGbMXnx4wVoruOBiSxmCYokYjYMmvjg=;
        b=DmyNgNajI0ssAeXLyHAktHabSVwRo+oX2dakJWa65Q59emQSv0sdGA2P7wTQm4QR/K
         GgvmdvhXKWuuVB/FBagFyuG5Uj7IrXeVAS6ikQg522o8P8J5+dz3BVelxOTlOqNY43AQ
         zuiFJ7L2xH2tZAY0S/DGKPMfX6pgBGsAHUo8b2N4NislXgnDfg97t5fiuKyja7DozQOd
         qYnE8yJ9LWg22Va7ElxYaTLZB7qVudSnPqlNN0NFr3FQpLC1HEIkZMDar8B/0noDmdtH
         msfVLSCGbhpELdi9bheN1ehHP2Dd6xHFAoah7N59g9LNzTAHvsIJFGYBy8u1dWbGEt+l
         fKww==
X-Gm-Message-State: ACgBeo2F6tFqOUVztN1gb2EiLLg7b2s4Ro0zEaXhEeNwCp6UxTaqHHpZ
        E+OnYe1OQoqw8W7tvHmz91A=
X-Google-Smtp-Source: AA6agR5BXkqd6ifvDEhyp9k/PsLusmA8moGmzBeMZ9+/m6KzT6GNWuP722WKkvae4aoBW9IeKx+tHA==
X-Received: by 2002:a63:b4a:0:b0:438:c97c:994d with SMTP id a10-20020a630b4a000000b00438c97c994dmr9005906pgl.597.1662996425281;
        Mon, 12 Sep 2022 08:27:05 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902650600b00172a567d910sm6030648plk.289.2022.09.12.08.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:27:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v5 0/4] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
References: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
        <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
Date:   Mon, 12 Sep 2022 08:27:04 -0700
In-Reply-To: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Sat, 10 Sep 2022 20:00:27
        +0000")
Message-ID: <xmqqedwghauv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Follow-on to the work done to allow Windows to work against network-mounted
> repos for macOS.
>
> Have macOS take advantage of the same configuration option,
> 'fsmonitor.allowRemote' that was introduced for Windows. Setting this option
> to true will override the default behavior (erroring-out) when a
> network-mounted repo is detected by fsmonitor.
>
> The added wrinkle being that the Unix domain socket (UDS) file used for IPC
> cannot be created in a network location; instead $HOME is used if the
> default location is on the network. The user may, optionally, set the
> 'fsmonitor.socketDir' configuration option to a valid, local directory if
> $HOME itself is on the network or is simply not the desired location for the
> UDS file.
>
> An additional issue is that for mount points in the root directory, FSEvents
> does not report a path that matches the worktree directory due to the
> introduction of 'synthetic firmlinks'. fsmonitor must map the FSEvents paths
> to the worktree directory by interrogating the root filesystem for synthetic
> firmlinks and using that information to translate the path.
>
> Eric DeCosta (4):
>   fsmonitor: refactor filesystem checks to common interface
>   fsmonitor: relocate socket file if .git directory is remote
>   fsmonitor: avoid socket location check if using hook
>   fsmonitor: deal with synthetic firmlinks on macOS

It looks like this one is organized quite differently from the last
iteration <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>

Unless the changes since the last iteration is so obvious [*] that
range-diff will explain all of it, it would help the topic to make
it easier for reviewers what has changed relative to the previous
one in your own words here in the cover letter.

[*} Here, "obvious" does not mean "diff is small and can be read in
10 minutes".  It is "diff shows the reason why these changes are
made, so there is no need for additional explanation", e.g. typofixes,
renaming of variables, making a helper function that was added as
extern in the previous iteration to static, etc.

Thanks.

>  Makefile                                 |   2 +
>  builtin/fsmonitor--daemon.c              |   8 ++
>  compat/fsmonitor/fsm-ipc-darwin.c        |  46 ++++++++
>  compat/fsmonitor/fsm-ipc-win32.c         |   4 +
>  compat/fsmonitor/fsm-listen-darwin.c     |   6 +-
>  compat/fsmonitor/fsm-path-utils-darwin.c | 131 +++++++++++++++++++++++
>  compat/fsmonitor/fsm-path-utils-win32.c  | 106 ++++++++++++++++++
>  compat/fsmonitor/fsm-settings-darwin.c   |  70 ++++--------
>  compat/fsmonitor/fsm-settings-win32.c    | 106 +-----------------
>  contrib/buildsystems/CMakeLists.txt      |   4 +
>  fsmonitor--daemon.h                      |   6 ++
>  fsmonitor-ipc.c                          |   2 -
>  fsmonitor-path-utils.h                   |  49 +++++++++
>  fsmonitor-settings.c                     |  58 +++++++++-
>  fsmonitor-settings.h                     |   2 +-
>  15 files changed, 441 insertions(+), 159 deletions(-)
>  create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
>  create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
>  create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
>  create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
>  create mode 100644 fsmonitor-path-utils.h
>
>
> base-commit: be1a02a17ede4082a86dfbfee0f54f345e8b43ac
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/1326
>
> Range-diff vs v4:
>
>  -:  ----------- > 1:  2f647b53e4d fsmonitor: refactor filesystem checks to common interface
>  2:  2cb026a6317 ! 2:  28d08bcf808 fsmonitor: generate unique Unix socket file name in the desired location
>      @@ Metadata
>       Author: Eric DeCosta <edecosta@mathworks.com>
>       
>        ## Commit message ##
>      -    fsmonitor: generate unique Unix socket file name in the desired location
>      +    fsmonitor: relocate socket file if .git directory is remote
>       
>      -    Based on the values of fsmonitor.allowRemote and fsmonitor.socketDir
>      -    locate the Unix domain socket file in the desired location (either
>      -    the .git directory, $HOME, or fsmonitor.socketDir). If the location
>      -    is other than the .git directory, generate a unique file name based
>      -    on the SHA1 has of the path to the .git directory.
>      +    If the .git directory is on a remote file system, create the socket
>      +    file in 'fsmonitor.socketDir' if it is defined, else create it in $HOME.
>       
>           Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
>       
>      - ## fsmonitor-ipc.c ##
>      -@@
>      - #include "cache.h"
>      --#include "fsmonitor.h"
>      --#include "simple-ipc.h"
>      - #include "fsmonitor-ipc.h"
>      -+#include "fsmonitor-settings.h"
>      - #include "run-command.h"
>      - #include "strbuf.h"
>      - #include "trace2.h"
>      -@@ fsmonitor-ipc.c: int fsmonitor_ipc__is_supported(void)
>      - 	return 1;
>      - }
>      + ## Makefile ##
>      +@@ Makefile: ifdef FSMONITOR_DAEMON_BACKEND
>      + 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
>      + 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
>      + 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
>      ++	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
>      + endif
>        
>      --GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
>      -+GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
>      + ifdef FSMONITOR_OS_SETTINGS
>      +
>      + ## compat/fsmonitor/fsm-ipc-darwin.c (new) ##
>      +@@
>      ++#include "cache.h"
>      ++#include "config.h"
>      ++#include "strbuf.h"
>      ++#include "fsmonitor.h"
>      ++#include "fsmonitor-ipc.h"
>      ++#include "fsmonitor-path-utils.h"
>      ++
>      ++static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
>       +
>       +const char *fsmonitor_ipc__get_path(void)
>       +{
>      -+#ifdef WIN32
>      -+	return fsmonitor_ipc__get_default_path();
>      -+#else
>      -+	char *retval;
>      ++	static const char *ipc_path;
>       +	SHA_CTX sha1ctx;
>      -+	const char *git_dir;
>      -+	const char *sock_dir;
>      ++	char *sock_dir;
>       +	struct strbuf ipc_file = STRBUF_INIT;
>       +	unsigned char hash[SHA_DIGEST_LENGTH];
>       +
>      -+	if (fsm_settings__get_allow_remote(the_repository) < 1)
>      -+		return fsmonitor_ipc__get_default_path();
>      ++	if (ipc_path)
>      ++		return ipc_path;
>       +
>      -+	git_dir = get_git_dir();
>      -+	sock_dir = fsm_settings__get_socket_dir(the_repository);
>      ++	ipc_path = fsmonitor_ipc__get_default_path();
>      ++
>      ++	/* By default the socket file is created in the .git directory */
>      ++	if (fsmonitor__is_fs_remote(ipc_path) < 1)
>      ++		return ipc_path;
>       +
>       +	SHA1_Init(&sha1ctx);
>      -+	SHA1_Update(&sha1ctx, git_dir, strlen(git_dir));
>      ++	SHA1_Update(&sha1ctx, the_repository->worktree, strlen(the_repository->worktree));
>       +	SHA1_Final(hash, &sha1ctx);
>       +
>      ++	repo_config_get_string(the_repository, "fsmonitor.socketdir", &sock_dir);
>      ++
>      ++	/* Create the socket file in either socketDir or $HOME */
>       +	if (sock_dir && *sock_dir)
>       +		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
>       +					sock_dir, hash_to_hex(hash));
>       +	else
>       +		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
>      -+	retval = interpolate_path(ipc_file.buf, 1);
>      -+	if (!retval)
>      ++
>      ++	ipc_path = interpolate_path(ipc_file.buf, 1);
>      ++	if (!ipc_path)
>       +		die(_("Invalid path: %s"), ipc_file.buf);
>      ++
>       +	strbuf_release(&ipc_file);
>      -+	return retval;
>      -+#endif
>      ++	return ipc_path;
>       +}
>      +
>      + ## compat/fsmonitor/fsm-ipc-win32.c (new) ##
>      +@@
>      ++#include "cache.h"
>      ++#include "fsmonitor-ipc.h"
>      ++
>      ++GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
>      +
>      + ## contrib/buildsystems/CMakeLists.txt ##
>      +@@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
>      + 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
>      + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
>      + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
>      ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-win32.c)
>      + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-win32.c)
>        
>      - enum ipc_active_state fsmonitor_ipc__get_state(void)
>      - {
>      + 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
>      +@@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
>      + 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
>      + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
>      + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
>      ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
>      + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
>      + 
>      + 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
>       
>      - ## fsmonitor-ipc.h ##
>      -@@ fsmonitor-ipc.h: int fsmonitor_ipc__is_supported(void);
>      -  */
>      - const char *fsmonitor_ipc__get_path(void);
>      + ## fsmonitor-ipc.c ##
>      +@@ fsmonitor-ipc.c: int fsmonitor_ipc__is_supported(void)
>      + 	return 1;
>      + }
>        
>      -+/*
>      -+ * Returns the pathname to the default IPC named pipe or Unix domain
>      -+ * socket.
>      -+ */
>      -+const char *fsmonitor_ipc__get_default_path(void);
>      -+
>      - /*
>      -  * Try to determine whether there is a `git-fsmonitor--daemon` process
>      -  * listening on the IPC pipe/socket.
>      +-GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
>      +-
>      + enum ipc_active_state fsmonitor_ipc__get_state(void)
>      + {
>      + 	return ipc_get_active_state(fsmonitor_ipc__get_path());
>  1:  836a791e6b7 ! 3:  ff54b6e0bb5 fsmonitor: add two new config options, allowRemote and socketDir
>      @@ Metadata
>       Author: Eric DeCosta <edecosta@mathworks.com>
>       
>        ## Commit message ##
>      -    fsmonitor: add two new config options, allowRemote and socketDir
>      +    fsmonitor: avoid socket location check if using hook
>       
>      -    Introduce two new configuration options
>      -
>      -       fsmonitor.allowRemote - setting this to true overrides fsmonitor's
>      -       default behavior of erroring out when enountering network file
>      -       systems. Additionly, when true, the Unix domain socket (UDS) file
>      -       used for IPC is located in $HOME rather than in the .git directory.
>      -
>      -       fsmonitor.socketDir - allows for the UDS file to be located
>      -       anywhere the user chooses rather $HOME.
>      +    If monitoring is done via fsmonitor hook rather than IPC there is no
>      +    need to check if the location of the Unix Domain socket (UDS) file is
>      +    on a remote filesystem.
>       
>           Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
>       
>      - ## fsmonitor-settings.c ##
>      -@@
>      - struct fsmonitor_settings {
>      - 	enum fsmonitor_mode mode;
>      + ## compat/fsmonitor/fsm-settings-darwin.c ##
>      +@@ compat/fsmonitor/fsm-settings-darwin.c: static enum fsmonitor_reason check_uds_volume(struct repository *r)
>      + 	return FSMONITOR_REASON_OK;
>      + }
>      + 
>      +-enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
>      ++enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
>      + {
>        	enum fsmonitor_reason reason;
>      -+	int allow_remote;
>      - 	char *hook_path;
>      -+	char *sock_dir;
>      - };
>        
>      - static enum fsmonitor_reason check_for_incompatible(struct repository *r)
>      -@@ fsmonitor-settings.c: static struct fsmonitor_settings *alloc_settings(void)
>      - 	CALLOC_ARRAY(s, 1);
>      - 	s->mode = FSMONITOR_MODE_DISABLED;
>      - 	s->reason = FSMONITOR_REASON_UNTESTED;
>      -+	s->allow_remote = -1;
>      +-	reason = check_uds_volume(r);
>      +-	if (reason != FSMONITOR_REASON_OK)
>      +-		return reason;
>      ++	if (ipc) {
>      ++		reason = check_uds_volume(r);
>      ++		if (reason != FSMONITOR_REASON_OK)
>      ++			return reason;
>      ++	}
>        
>      - 	return s;
>      + 	return FSMONITOR_REASON_OK;
>        }
>      -@@ fsmonitor-settings.c: static void lookup_fsmonitor_settings(struct repository *r)
>      - 		fsm_settings__set_disabled(r);
>      +
>      + ## compat/fsmonitor/fsm-settings-win32.c ##
>      +@@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4git(struct repository *r)
>      + 	return FSMONITOR_REASON_OK;
>        }
>        
>      -+int fsm_settings__get_allow_remote(struct repository *r)
>      -+{
>      -+	if (!r)
>      -+		r = the_repository;
>      -+	if (!r->settings.fsmonitor)
>      -+		lookup_fsmonitor_settings(r);
>      -+
>      -+	return r->settings.fsmonitor->allow_remote;
>      -+}
>      -+
>      -+const char *fsm_settings__get_socket_dir(struct repository *r)
>      -+{
>      -+	if (!r)
>      -+		r = the_repository;
>      -+	if (!r->settings.fsmonitor)
>      -+		lookup_fsmonitor_settings(r);
>      -+
>      -+	return r->settings.fsmonitor->sock_dir;
>      -+}
>      -+
>      - enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
>      +-enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
>      ++enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
>        {
>      - 	if (!r)
>      -@@ fsmonitor-settings.c: enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
>      - 	return r->settings.fsmonitor->mode;
>      + 	enum fsmonitor_reason reason;
>      + 
>      +
>      + ## fsmonitor-settings.c ##
>      +@@ fsmonitor-settings.c: static enum fsmonitor_reason check_remote(struct repository *r)
>        }
>      + #endif
>        
>      -+
>      - const char *fsm_settings__get_hook_path(struct repository *r)
>      +-static enum fsmonitor_reason check_for_incompatible(struct repository *r)
>      ++static enum fsmonitor_reason check_for_incompatible(struct repository *r, int ipc)
>        {
>      - 	if (!r)
>      + 	if (!r->worktree) {
>      + 		/*
>      +@@ fsmonitor-settings.c: static enum fsmonitor_reason check_for_incompatible(struct repository *r)
>      + 		reason = check_remote(r);
>      + 		if (reason != FSMONITOR_REASON_OK)
>      + 			return reason;
>      +-		reason = fsm_os__incompatible(r);
>      ++		reason = fsm_os__incompatible(r, ipc);
>      + 		if (reason != FSMONITOR_REASON_OK)
>      + 			return reason;
>      + 	}
>       @@ fsmonitor-settings.c: const char *fsm_settings__get_hook_path(struct repository *r)
>      - 	return r->settings.fsmonitor->hook_path;
>      - }
>        
>      -+void fsm_settings__set_allow_remote(struct repository *r)
>      -+{
>      -+	int allow;
>      -+
>      -+	if (!r)
>      -+		r = the_repository;
>      -+	if (!r->settings.fsmonitor)
>      -+		r->settings.fsmonitor = alloc_settings();
>      -+	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
>      -+		r->settings.fsmonitor->allow_remote = allow;
>      -+
>      -+	return;
>      -+}
>      -+
>      -+void fsm_settings__set_socket_dir(struct repository *r)
>      -+{
>      -+	const char *path;
>      -+
>      -+	if (!r)
>      -+		r = the_repository;
>      -+	if (!r->settings.fsmonitor)
>      -+		r->settings.fsmonitor = alloc_settings();
>      -+
>      -+	if (!repo_config_get_pathname(r, "fsmonitor.socketdir", &path)) {
>      -+		FREE_AND_NULL(r->settings.fsmonitor->sock_dir);
>      -+		r->settings.fsmonitor->sock_dir = strdup(path);
>      -+	}
>      -+
>      -+	return;
>      -+}
>      -+
>        void fsm_settings__set_ipc(struct repository *r)
>        {
>       -	enum fsmonitor_reason reason = check_for_incompatible(r);
>      -+	enum fsmonitor_reason reason;
>      -+
>      -+	fsm_settings__set_allow_remote(r);
>      -+	fsm_settings__set_socket_dir(r);
>      -+	reason = check_for_incompatible(r);
>      ++	enum fsmonitor_reason reason = check_for_incompatible(r, 1);
>        
>        	if (reason != FSMONITOR_REASON_OK) {
>        		fsm_settings__set_incompatible(r, reason);
>      @@ fsmonitor-settings.c: void fsm_settings__set_ipc(struct repository *r)
>        void fsm_settings__set_hook(struct repository *r, const char *path)
>        {
>       -	enum fsmonitor_reason reason = check_for_incompatible(r);
>      -+	enum fsmonitor_reason reason;
>      -+
>      -+	fsm_settings__set_allow_remote(r);
>      -+	fsm_settings__set_socket_dir(r);
>      -+	reason = check_for_incompatible(r);
>      ++	enum fsmonitor_reason reason = check_for_incompatible(r, 0);
>        
>        	if (reason != FSMONITOR_REASON_OK) {
>        		fsm_settings__set_incompatible(r, reason);
>       
>        ## fsmonitor-settings.h ##
>      -@@ fsmonitor-settings.h: enum fsmonitor_reason {
>      - 	FSMONITOR_REASON_NOSOCKETS, /* NTFS,FAT32 do not support Unix sockets */
>      - };
>      - 
>      -+void fsm_settings__set_allow_remote(struct repository *r);
>      -+void fsm_settings__set_socket_dir(struct repository *r);
>      - void fsm_settings__set_ipc(struct repository *r);
>      - void fsm_settings__set_hook(struct repository *r, const char *path);
>      - void fsm_settings__set_disabled(struct repository *r);
>      - void fsm_settings__set_incompatible(struct repository *r,
>      - 				    enum fsmonitor_reason reason);
>      - 
>      -+int fsm_settings__get_allow_remote(struct repository *r);
>      -+const char *fsm_settings__get_socket_dir(struct repository *r);
>      - enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
>      - const char *fsm_settings__get_hook_path(struct repository *r);
>      +@@ fsmonitor-settings.h: struct fsmonitor_settings;
>      +  * fsm_os__* routines should considered private to fsm_settings__
>      +  * routines.
>      +  */
>      +-enum fsmonitor_reason fsm_os__incompatible(struct repository *r);
>      ++enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc);
>      + #endif /* HAVE_FSMONITOR_OS_SETTINGS */
>        
>      + #endif /* FSMONITOR_SETTINGS_H */
>  3:  a3110f1e25a < -:  ----------- fsmonitor: ensure filesystem and unix socket filesystem are compatible
>  4:  56cabf3be3b ! 4:  b7d6cf44695 fsmonitor: normalize FSEvents event paths to the real path
>      @@ Metadata
>       Author: Eric DeCosta <edecosta@mathworks.com>
>       
>        ## Commit message ##
>      -    fsmonitor: normalize FSEvents event paths to the real path
>      +    fsmonitor: deal with synthetic firmlinks on macOS
>       
>      -    Consider the following network working directory that is mounted under
>      -    /System/Volumes/Data:
>      +    Starting with macOS 10.15 (Catalina), Apple introduced a new feature
>      +    called 'firmlinks' in order to separate the boot volume into two
>      +    volumes, one read-only and one writable but still present them to the
>      +    user as a single volume. Along with this change, Apple removed the
>      +    ability to create symlinks in the root directory and replaced them with
>      +    'synthetic firmlinks'. See 'man synthetic.conf'
>       
>      -    /network/working/directory
>      +    When FSEevents reports the path of changed files, if the path invloves
>      +    a synthetic firmlink, the path is reported from the point of the
>      +    synthetic firmlink and not the real path. For example:
>       
>      -    The git working directory path is:
>      +    Real path:
>      +    /System/Volumes/Data/network/working/directory/foo.txt
>       
>      -    /System/Volumes/Data/network/working/directory
>      +    Synthetic firmlink:
>      +    /network -> /System/Volumes/Data/network
>       
>      -    The paths reported by FSEvents always start with /network. fsmonitor
>      -    expects paths to be under the working directory; therefore it
>      -    fails to match /network/... and ignores the change.
>      +    FSEvents path:
>      +    /network/working/directory/foo.txt
>       
>      -    Change things such that if fsmonitor.allowRemote is true that the
>      -    paths reported via FSEevents are normalized to the real path.
>      +    This causes the FSEvents path to not match against the worktree
>      +    directory.
>      +
>      +    There are several ways in which synthetic firmlinks can be created:
>      +    they can be defined in /etc/synthetic.conf, the automounter can create
>      +    them, and there may be other means. Simply reading /etc/synthetic.conf
>      +    is insufficient. No matter what process creates synthetic firmlinks,
>      +    they all get created in the root directory.
>      +
>      +    Therefore, in order to deal with synthetic firmlinks, the root directory
>      +    is scanned and the first possible synthetic firmink that, when resolved,
>      +    is a prefix of the worktree is used to map FSEvents paths to worktree
>      +    paths.
>       
>           Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
>       
>      + ## builtin/fsmonitor--daemon.c ##
>      +@@
>      + #include "parse-options.h"
>      + #include "fsmonitor.h"
>      + #include "fsmonitor-ipc.h"
>      ++#include "fsmonitor-path-utils.h"
>      + #include "compat/fsmonitor/fsm-health.h"
>      + #include "compat/fsmonitor/fsm-listen.h"
>      + #include "fsmonitor--daemon.h"
>      +@@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
>      + 	strbuf_addstr(&state.path_worktree_watch, absolute_path(get_git_work_tree()));
>      + 	state.nr_paths_watching = 1;
>      + 
>      ++	strbuf_init(&state.alias.alias, 0);
>      ++	strbuf_init(&state.alias.points_to, 0);
>      ++	if (fsmonitor__get_alias(state.path_worktree_watch.buf, &state.alias)) {
>      ++		err = error(_("could not get worktree alias"));
>      ++		goto done;
>      ++	}
>      ++
>      + 	/*
>      + 	 * We create and delete cookie files somewhere inside the .git
>      + 	 * directory to help us keep sync with the file system.  If
>      +
>        ## compat/fsmonitor/fsm-listen-darwin.c ##
>       @@
>        #include "fsmonitor.h"
>        #include "fsm-listen.h"
>        #include "fsmonitor--daemon.h"
>      -+#include "fsmonitor-settings.h"
>      ++#include "fsmonitor-path-utils.h"
>        
>        struct fsm_listen_data
>        {
>      -@@ compat/fsmonitor/fsm-listen-darwin.c: static void my_add_path(struct fsmonitor_batch *batch, const char *path)
>      - 	free(composed);
>      - }
>      - 
>      --
>      - static void fsevent_callback(ConstFSEventStreamRef streamRef,
>      - 			     void *ctx,
>      - 			     size_t num_of_events,
>       @@ compat/fsmonitor/fsm-listen-darwin.c: static void fsevent_callback(ConstFSEventStreamRef streamRef,
>        		/*
>        		 * On Mac, we receive an array of absolute paths.
>        		 */
>       -		path_k = paths[k];
>      -+		if (fsm_settings__get_allow_remote(the_repository) > 0) {
>      -+			strbuf_reset(&tmp);
>      -+			strbuf_realpath_forgiving(&tmp, paths[k], 0);
>      -+			path_k = tmp.buf;
>      -+		} else
>      ++		path_k = fsmonitor__resolve_alias(paths[k], &state->alias);
>      ++		if (!path_k)
>       +			path_k = paths[k];
>        
>        		/*
>        		 * If you want to debug FSEvents, log them to GIT_TRACE_FSMONITOR.
>       @@ compat/fsmonitor/fsm-listen-darwin.c: static void fsevent_callback(ConstFSEventStreamRef streamRef,
>      - 
>        			fsmonitor_force_resync(state);
>        			fsmonitor_batch__free_list(batch);
>      -+			batch = NULL;
>        			string_list_clear(&cookie_list, 0);
>      ++			batch = NULL;
>        
>        			/*
>      -@@ compat/fsmonitor/fsm-listen-darwin.c: static void fsevent_callback(ConstFSEventStreamRef streamRef,
>      + 			 * We assume that any events that we received
>      +
>      + ## compat/fsmonitor/fsm-path-utils-darwin.c ##
>      +@@
>      + #include "fsmonitor.h"
>      + #include "fsmonitor-path-utils.h"
>      ++#include <dirent.h>
>      ++#include <errno.h>
>      ++#include <fcntl.h>
>      + #include <sys/param.h>
>      + #include <sys/mount.h>
>      + 
>      +@@ compat/fsmonitor/fsm-path-utils-darwin.c: int fsmonitor__is_fs_remote(const char *path)
>      + 		return -1;
>      + 	return fs.is_remote;
>      + }
>      ++
>      ++/*
>      ++ * Scan the root directory for synthetic firmlinks that when resolved
>      ++ * are a prefix of the path, stopping at the first one found.
>      ++ *
>      ++ * Some information about firmlinks and synthetic firmlinks:
>      ++ * https://eclecticlight.co/2020/01/23/catalina-boot-volumes/
>      ++ *
>      ++ * macOS no longer allows symlinks in the root directory; any link found
>      ++ * there is therefore a synthetic firmlink.
>      ++ *
>      ++ * If this function gets called often, will want to cache all the firmlink
>      ++ * information, but for now there is only one caller of this function.
>      ++ *
>      ++ * If there is more than one alias for the path, that is another
>      ++ * matter altogteher.
>      ++ */
>      ++int fsmonitor__get_alias(const char *path, struct alias_info *info)
>      ++{
>      ++	DIR * dir;
>      ++	int read;
>      ++	int retval;
>      ++	struct dirent *de;
>      ++	struct strbuf alias;
>      ++	struct strbuf points_to;
>      ++
>      ++	retval = 0;
>      ++	dir = opendir("/");
>      ++	if (!dir)
>      ++		return -1;
>      ++
>      ++	strbuf_init(&alias, 256);
>      ++	strbuf_init(&points_to, MAXPATHLEN);
>      ++
>      ++	while ((de = readdir(dir)) != NULL) {
>      ++		strbuf_reset(&alias);
>      ++		strbuf_addch(&alias, '/');
>      ++		strbuf_add(&alias, de->d_name, strlen(de->d_name));
>      ++
>      ++		read = readlink(alias.buf, points_to.buf, MAXPATHLEN);
>      ++		if (read > 0) {
>      ++			strbuf_setlen(&points_to, read);
>      ++			if ((strncmp(points_to.buf, path, points_to.len) == 0)
>      ++				&& path[points_to.len] == '/') {
>      ++				strbuf_addbuf(&info->alias, &alias);
>      ++				strbuf_addbuf(&info->points_to, &points_to);
>      ++				trace_printf_key(&trace_fsmonitor,
>      ++					"Found alias for '%s' : '%s' -> '%s'",
>      ++					path, info->alias.buf, info->points_to.buf);
>      ++				retval = 0;
>      ++				goto done;
>      ++			}
>      ++		} else if (errno != EINVAL) { /* Something other than not a link */
>      ++			trace_printf_key(&trace_fsmonitor, "Error %s", strerror(errno));
>      ++			retval = -1;
>      ++			goto done;
>      ++		}
>      ++	}
>      ++
>      ++	done:
>      ++	closedir(dir);
>      ++	strbuf_release(&alias);
>      ++	strbuf_release(&points_to);
>      ++	return retval;
>      ++}
>      ++
>      ++char *fsmonitor__resolve_alias(const char *path,
>      ++	const struct alias_info *info)
>      ++{
>      ++	int len = info->alias.len;
>      ++
>      ++	if (!len)
>      ++		return NULL;
>      ++
>      ++	if ((strncmp(info->alias.buf, path, len) == 0)
>      ++		&& path[len] == '/') {
>      ++		struct strbuf tmp;
>      ++		const char *remainder = path + len;
>      ++		int rem_len = strlen(remainder);
>      ++
>      ++		strbuf_init(&tmp, info->points_to.len + rem_len);
>      ++		strbuf_addbuf(&tmp, &info->points_to);
>      ++		strbuf_add(&tmp, remainder, rem_len);
>      ++		return strbuf_detach(&tmp, NULL);
>      ++	}
>      ++
>      ++	return NULL;
>      ++}
>      +
>      + ## compat/fsmonitor/fsm-path-utils-win32.c ##
>      +@@ compat/fsmonitor/fsm-path-utils-win32.c: int fsmonitor__is_fs_remote(const char *path)
>      + 		return -1;
>      + 	return fs.is_remote;
>      + }
>      ++
>      ++/*
>      ++ * No-op for now.
>      ++ */
>      ++int fsmonitor__get_alias(const char *path, struct alias_info *info)
>      ++{
>      ++	return 0;
>      ++}
>      ++
>      ++/*
>      ++ * No-op for now.
>      ++ */
>      ++char *fsmonitor__resolve_alias(const char *path,
>      ++	const struct alias_info *info)
>      ++{
>      ++	return NULL;
>      ++}
>      +
>      + ## fsmonitor--daemon.h ##
>      +@@
>      + #include "run-command.h"
>      + #include "simple-ipc.h"
>      + #include "thread-utils.h"
>      ++#include "fsmonitor-path-utils.h"
>      + 
>      + struct fsmonitor_batch;
>      + struct fsmonitor_token_data;
>      +@@ fsmonitor--daemon.h: struct fsmonitor_daemon_state {
>      + 
>      + 	struct strbuf path_worktree_watch;
>      + 	struct strbuf path_gitdir_watch;
>      ++	struct alias_info alias;
>      + 	int nr_paths_watching;
>      + 
>      + 	struct fsmonitor_token_data *current_token_data;
>      +@@ fsmonitor--daemon.h: struct fsmonitor_daemon_state {
>      + 
>      + 	struct ipc_server_data *ipc_server_data;
>      + 	struct strbuf path_ipc;
>      ++
>      + };
>      + 
>      + /*
>      +@@ fsmonitor--daemon.h: void fsmonitor_publish(struct fsmonitor_daemon_state *state,
>      +  */
>      + void fsmonitor_force_resync(struct fsmonitor_daemon_state *state);
>      + 
>      ++char *fsmonitor_resolve_alias(const char *path,
>      ++	struct alias_info *alias);
>      ++
>      + #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
>      + #endif /* FSMONITOR_DAEMON_H */
>      +
>      + ## fsmonitor-path-utils.h ##
>      +@@
>      + #ifndef FSM_PATH_UTILS_H
>      + #define FSM_PATH_UTILS_H
>        
>      - 		case IS_WORKDIR_PATH:
>      - 			/* try to queue normal pathnames */
>      --
>      - 			if (trace_pass_fl(&trace_fsmonitor))
>      - 				log_flags_set(path_k, event_flags[k]);
>      ++#include "strbuf.h"
>      ++
>      ++struct alias_info
>      ++{
>      ++	struct strbuf alias;
>      ++	struct strbuf points_to;
>      ++};
>      ++
>      + struct fs_info {
>      + 	int is_remote;
>      + 	char *typename;
>      +@@ fsmonitor-path-utils.h: int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info);
>      +  */
>      + int fsmonitor__is_fs_remote(const char *path);
>        
>      ++/*
>      ++ * Get the alias in given path, if any.
>      ++ *
>      ++ * Sets alias to the first alias that matches any part of the path.
>      ++ *
>      ++ * Returns -1 on error, 0 otherwise.
>      ++ */
>      ++int fsmonitor__get_alias(const char *path, struct alias_info *info);
>      ++
>      ++/*
>      ++ * Resolve the path against the given alias.
>      ++ *
>      ++ * Returns the resolved path if there is one, NULL otherwise.
>      ++ */
>      ++char *fsmonitor__resolve_alias(const char *path,
>      ++	const struct alias_info *info);
>      ++
>      ++
>      + #endif
