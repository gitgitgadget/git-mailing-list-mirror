Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E366C11F6A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7296141C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhGAOuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhGAOuT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A175EC061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t15so5233655wry.11
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UndxecYkBUd8geXWxJgpRFw0FUDikBQaFuR7ho1gV2A=;
        b=UdN0WlKIYG/gkw1jGwXYKPTPKa5uy6q1ckQFbILsGmFzP7s1vhyyPpVLN9oBCOQx63
         9mE1PDlMS18tSpucolMDv/NRtZrpiHWzzJ0qC6+y00shVszJk+DhkrwIcikqTwhfO7hK
         hANVoC1O9BjSK3PKGqlrl0wvypHWX9zgLijWEhbSiUxq+sc/TGfKnJNnN5V8qTjaqLm4
         Fc/Zuyq6fAPAhv9ePoU4OIYHE3gY0/I0/t+W2i2Q/baZy4/v/Xy/MoJetmYp7ht+zjVO
         xMcFkgpkoH44R7JwXlq6D+wbP237AGqkj5T4TdMEKQc24QjrAQ/EFpaUKzXrIf3jgb1n
         h+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UndxecYkBUd8geXWxJgpRFw0FUDikBQaFuR7ho1gV2A=;
        b=YlFVvAX0clzJVd1QOBmGkh1Li+geoqHCDp+zyIkuUWzJC3xaWJvnsLTtoswewAelPb
         QNL7eVcec2LEVAvRvuEkU4KBXwgUF98LBaa3U2VFzpQRor8IXeWHwnnvrudIoqT6P0Oz
         lidrGDs13I6ZkyGelNg3xzeqOm6UgsTjQgqTaD8ibCBHmtxpG+Bz1Hqw1+hkbktax/vt
         vkEmNfNzBhc80yCPrxEZejXKTDSU3BL90sH8SeR7uAahq0me9RWUfLIOQ4lFL+wFoR05
         85xMipcw1if8b0zmsDChxGFALzGyI6dwwrptP6O1/6vaYnjSTdpELqvM+LjCQTStw0Z2
         ZKsg==
X-Gm-Message-State: AOAM532GsggJjvhYa8dtBB/E4gaRclh6c+M3yICLiCdoYwob4N0CmxYn
        blm0nI1kVBDkCbMWRzXMEkUH2bbopYg=
X-Google-Smtp-Source: ABdhPJz1Jf/t9TzLTqdYq/+qbOVFvw7mvUMXlsW+xvCXzWx+4E+B9yIOBWnb+np8twgTe+0a8ZKIlg==
X-Received: by 2002:adf:db41:: with SMTP id f1mr8802368wrj.153.1625150865694;
        Thu, 01 Jul 2021 07:47:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 204sm253034wma.30.2021.07.01.07.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:45 -0700 (PDT)
Message-Id: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:10 +0000
Subject: [PATCH v3 00/34] Builtin FSMonitor Feature
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V3 of my patch series to add a builtin FSMonitor daemon to Git. I
rebased this series onto v2.32.0.

V3 addresses most of the previous review comments and things we've learned
from our experimental testing of V2. (A version of V2 was shipped as an
experimental feature in the v2.32.0-based releases of Git for Windows and
VFS for Git.)

There are still a few items that I need to address, but that list is getting
very short.

The following items from my V2 cover have not yet been addressed:

[ ] Revisit the how the client handles the IPC_STATE__NOT_LISTENING state
(where a daemon appears to be running, but is non-responsive)

[ ] Consider having daemon chdir() out of the working directory to avoid
directory handle issues on Windows.

[ ] On Windows, If the daemon is started as an elevated process, then client
commands might not have access to communicate with it.

[ ] Review if/how we decide to shutdown the FSMonitor daemon after and a
significant idle period.

Also, there are potential problems with the untracked-cache that we have
been looking at. Concurrently, Tao Klerks independently noticed similar
problems with the untracked-cache and has reported/discussed them here on
the mailing list. I would like to get to the bottom of them before going
further -- at this point I don't know they are related to FSMonitor or not.

In this version, the first commit updates the Simple IPC API to make it
easier to pass binary data using {char *, size_t} rather than assuming that
the message is a null-terminated string. FSMonitor does not use binary
messages and doesn't really need this API change, but I thought it best to
fix the API now before we have other callers of IPC.

This patch series contains 34 commits and is rather large. If it would help
with the review, I could try to divide it into a client-side part 1 and a
daemon-side part 2 -- if there is interest.

Jeff Hostetler (34):
  simple-ipc: preparations for supporting binary messages.
  fsmonitor--daemon: man page
  fsmonitor--daemon: update fsmonitor documentation
  fsmonitor-ipc: create client routines for git-fsmonitor--daemon
  help: include fsmonitor--daemon feature flag in version info
  fsmonitor: config settings are repository-specific
  fsmonitor: use IPC to query the builtin FSMonitor daemon
  fsmonitor--daemon: add a built-in fsmonitor daemon
  fsmonitor--daemon: implement 'stop' and 'status' commands
  t/helper/fsmonitor-client: create IPC client to talk to FSMonitor
    Daemon
  fsmonitor-fs-listen-win32: stub in backend for Windows
  fsmonitor-fs-listen-macos: stub in backend for MacOS
  fsmonitor--daemon: implement 'run' command
  fsmonitor--daemon: implement 'start' command
  fsmonitor: do not try to operate on bare repos
  fsmonitor--daemon: add pathname classification
  fsmonitor--daemon: define token-ids
  fsmonitor--daemon: create token-based changed path cache
  fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
  fsmonitor-fs-listen-macos: add macos header files for FSEvent
  fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
  fsmonitor--daemon: implement handle_client callback
  t/helper/test-touch: add helper to touch a series of files
  t/perf/p7519: speed up test using "test-tool touch"
  t/perf: avoid copying builtin fsmonitor files into test repo
  t/perf/p7519: add fsmonitor--daemon test cases
  t7527: create test for fsmonitor--daemon
  fsmonitor--daemon: periodically truncate list of modified files
  fsmonitor--daemon: use a cookie file to sync with file system
  fsmonitor: enhance existing comments
  fsmonitor: force update index after large responses
  t7527: test status with untracked-cache and fsmonitor--daemon
  fsmonitor: handle shortname for .git
  t7527: test FS event reporing on MacOS WRT case and Unicode

 .gitignore                                   |    1 +
 Documentation/config/core.txt                |   56 +-
 Documentation/git-fsmonitor--daemon.txt      |   75 +
 Documentation/git-update-index.txt           |   27 +-
 Documentation/githooks.txt                   |    3 +-
 Makefile                                     |   17 +
 builtin.h                                    |    1 +
 builtin/fsmonitor--daemon.c                  | 1567 ++++++++++++++++++
 builtin/update-index.c                       |   20 +-
 cache.h                                      |    1 -
 compat/fsmonitor/fsmonitor-fs-listen-macos.c |  497 ++++++
 compat/fsmonitor/fsmonitor-fs-listen-win32.c |  663 ++++++++
 compat/fsmonitor/fsmonitor-fs-listen.h       |   49 +
 compat/simple-ipc/ipc-unix-socket.c          |   14 +-
 compat/simple-ipc/ipc-win32.c                |   14 +-
 config.c                                     |   14 -
 config.h                                     |    1 -
 config.mak.uname                             |    4 +
 contrib/buildsystems/CMakeLists.txt          |    8 +
 environment.c                                |    1 -
 fsmonitor--daemon.h                          |  140 ++
 fsmonitor-ipc.c                              |  179 ++
 fsmonitor-ipc.h                              |   48 +
 fsmonitor.c                                  |  189 ++-
 fsmonitor.h                                  |   14 +-
 git.c                                        |    1 +
 help.c                                       |    4 +
 repo-settings.c                              |   48 +
 repository.h                                 |   11 +
 simple-ipc.h                                 |    7 +-
 t/README                                     |    4 +-
 t/helper/test-fsmonitor-client.c             |  121 ++
 t/helper/test-simple-ipc.c                   |   34 +-
 t/helper/test-tool.c                         |    2 +
 t/helper/test-tool.h                         |    2 +
 t/helper/test-touch.c                        |  126 ++
 t/perf/p7519-fsmonitor.sh                    |   51 +-
 t/perf/perf-lib.sh                           |    2 +-
 t/t7519-status-fsmonitor.sh                  |   38 +
 t/t7527-builtin-fsmonitor.sh                 |  679 ++++++++
 t/test-lib.sh                                |    6 +
 41 files changed, 4618 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt
 create mode 100644 builtin/fsmonitor--daemon.c
 create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-macos.c
 create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-win32.c
 create mode 100644 compat/fsmonitor/fsmonitor-fs-listen.h
 create mode 100644 fsmonitor--daemon.h
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h
 create mode 100644 t/helper/test-fsmonitor-client.c
 create mode 100644 t/helper/test-touch.c
 create mode 100755 t/t7527-builtin-fsmonitor.sh


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-923%2Fjeffhostetler%2Fbuiltin-fsmonitor-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-923/jeffhostetler/builtin-fsmonitor-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/923

Range-diff vs v2:

  1:  763fa1ee7bb =  1:  cafc71c8d7d simple-ipc: preparations for supporting binary messages.
  2:  fc180e8591b =  2:  5db2c0390a6 fsmonitor--daemon: man page
  3:  d56f3e91db9 =  3:  86413bfe347 fsmonitor--daemon: update fsmonitor documentation
  4:  e4a26372877 !  4:  dfcd3e5ac97 fsmonitor-ipc: create client routines for git-fsmonitor--daemon
     @@ fsmonitor-ipc.c (new)
      +	struct ipc_client_connection *connection = NULL;
      +	struct ipc_client_connect_options options
      +		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
     ++	const char *tok = since_token ? since_token : "";
     ++	size_t tok_len = since_token ? strlen(since_token) : 0;
      +
      +	options.wait_if_busy = 1;
      +	options.wait_if_not_found = 0;
      +
      +	trace2_region_enter("fsm_client", "query", NULL);
     -+
     -+	trace2_data_string("fsm_client", NULL, "query/command",
     -+			   since_token);
     ++	trace2_data_string("fsm_client", NULL, "query/command", tok);
      +
      +try_again:
      +	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
     @@ fsmonitor-ipc.c (new)
      +	switch (state) {
      +	case IPC_STATE__LISTENING:
      +		ret = ipc_client_send_command_to_connection(
     -+			connection, since_token, strlen(since_token), answer);
     ++			connection, tok, tok_len, answer);
      +		ipc_client_close_connection(connection);
      +
      +		trace2_data_intmax("fsm_client", NULL,
     @@ fsmonitor-ipc.c (new)
      +		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
      +	int ret;
      +	enum ipc_active_state state;
     ++	const char *c = command ? command : "";
     ++	size_t c_len = command ? strlen(command) : 0;
      +
      +	strbuf_reset(answer);
      +
     @@ fsmonitor-ipc.c (new)
      +		return -1;
      +	}
      +
     -+	ret = ipc_client_send_command_to_connection(connection,
     -+						    command, strlen(command),
     ++	ret = ipc_client_send_command_to_connection(connection, c, c_len,
      +						    answer);
      +	ipc_client_close_connection(connection);
      +
      +	if (ret == -1) {
     -+		die("could not send '%s' command to fsmonitor--daemon",
     -+		    command);
     ++		die("could not send '%s' command to fsmonitor--daemon", c);
      +		return -1;
      +	}
      +
  5:  d5d09eb1635 !  5:  0aaca2f9390 help: include fsmonitor--daemon feature flag in version info
     @@ help.c: void get_version_info(struct strbuf *buf, int show_build_options)
       	}
       }
       
     +
     + ## t/test-lib.sh ##
     +@@ t/test-lib.sh: test_lazy_prereq REBASE_P '
     + # Tests that verify the scheduler integration must set this locally
     + # to avoid errors.
     + GIT_TEST_MAINT_SCHEDULER="none:exit 1"
     ++
     ++# Does this platform support `git fsmonitor--daemon`
     ++#
     ++test_lazy_prereq FSMONITOR_DAEMON '
     ++	git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
     ++'
  6:  67bcf57f594 !  6:  8b64b7cd367 config: FSMonitor is repository-specific
     @@
       ## Metadata ##
     -Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
     +Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    config: FSMonitor is repository-specific
     +    fsmonitor: config settings are repository-specific
      
     -    This commit refactors `git_config_get_fsmonitor()` into the `repo_*()`
     -    form that takes a parameter `struct repository *r`.
     +    Move FSMonitor config settings to `struct repo_settings`, get rid of
     +    the `core_fsmonitor` global variable, and add support for the new
     +    `core.useBuiltinFSMonitor` config setting.  Move config code to lookup
     +    `core.fsmonitor` into `prepare_repo_settings()` with the rest of the
     +    setup code.
      
     -    That change prepares for the upcoming `core.useBuiltinFSMonitor` flag which
     -    will be stored in the `repo_settings` struct.
     +    The `core_fsmonitor` global variable was used to store the pathname to
     +    the FSMonitor hook and it was used as a boolean to see if FSMonitor
     +    was enabled.  This dual usage will lead to confusion when we add
     +    support for a builtin FSMonitor based on IPC, since the builtin
     +    FSMonitor doesn't need the hook pathname.
      
     -    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Replace the boolean usage with an `enum fsmonitor_mode` to represent
     +    the state of FSMonitor.  And only set the pathname when in HOOK mode.
     +
     +    Also, disable FSMonitor when the repository working directory is
     +    incompatible.  For example, in bare repositories, since there aren't
     +    any files to watch.
     +
     +    Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## builtin/update-index.c ##
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       
       	if (fsmonitor > 0) {
      -		if (git_config_get_fsmonitor() == 0)
     -+		if (repo_config_get_fsmonitor(r) == 0)
     ++		if (r->settings.fsmonitor_mode == FSMONITOR_MODE_INCOMPATIBLE)
     ++			return error(
     ++				_("repository is incompatible with fsmonitor"));
     ++
     ++		if (r->settings.fsmonitor_mode == FSMONITOR_MODE_DISABLED) {
     ++			warning(_("core.useBuiltinFSMonitor is unset; "
     ++				"set it if you really want to enable the "
     ++				"builtin fsmonitor"));
       			warning(_("core.fsmonitor is unset; "
     - 				"set it if you really want to "
     - 				"enable fsmonitor"));
     +-				"set it if you really want to "
     +-				"enable fsmonitor"));
     ++				"set it if you really want to enable the "
     ++				"hook-based fsmonitor"));
     ++		}
       		add_fsmonitor(&the_index);
       		report(_("fsmonitor enabled"));
       	} else if (!fsmonitor) {
      -		if (git_config_get_fsmonitor() == 1)
     -+		if (repo_config_get_fsmonitor(r) == 1)
     ++		if (r->settings.fsmonitor_mode == FSMONITOR_MODE_IPC)
     ++			warning(_("core.useBuiltinFSMonitor is set; "
     ++				"remove it if you really want to "
     ++				"disable fsmonitor"));
     ++		if (r->settings.fsmonitor_mode == FSMONITOR_MODE_HOOK)
       			warning(_("core.fsmonitor is set; "
       				"remove it if you really want to "
       				"disable fsmonitor"));
      
     + ## cache.h ##
     +@@ cache.h: extern int core_preload_index;
     + extern int precomposed_unicode;
     + extern int protect_hfs;
     + extern int protect_ntfs;
     +-extern const char *core_fsmonitor;
     + 
     + extern int core_apply_sparse_checkout;
     + extern int core_sparse_checkout_cone;
     +
       ## config.c ##
      @@ config.c: int git_config_get_max_percent_split_change(void)
       	return -1; /* default value */
       }
       
      -int git_config_get_fsmonitor(void)
     -+int repo_config_get_fsmonitor(struct repository *r)
     - {
     +-{
      -	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
     -+	if (repo_config_get_pathname(r, "core.fsmonitor", &core_fsmonitor))
     - 		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
     - 
     - 	if (core_fsmonitor && !*core_fsmonitor)
     +-		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
     +-
     +-	if (core_fsmonitor && !*core_fsmonitor)
     +-		core_fsmonitor = NULL;
     +-
     +-	if (core_fsmonitor)
     +-		return 1;
     +-
     +-	return 0;
     +-}
     +-
     + int git_config_get_index_threads(int *dest)
     + {
     + 	int is_bool, val;
      
       ## config.h ##
      @@ config.h: int git_config_get_index_threads(int *dest);
     @@ config.h: int git_config_get_index_threads(int *dest);
       int git_config_get_split_index(void);
       int git_config_get_max_percent_split_change(void);
      -int git_config_get_fsmonitor(void);
     -+int repo_config_get_fsmonitor(struct repository *r);
       
       /* This dies if the configured or default date is in the future */
       int git_config_get_expiry(const char *key, const char **output);
      
     + ## environment.c ##
     +@@ environment.c: int protect_hfs = PROTECT_HFS_DEFAULT;
     + #define PROTECT_NTFS_DEFAULT 1
     + #endif
     + int protect_ntfs = PROTECT_NTFS_DEFAULT;
     +-const char *core_fsmonitor;
     + 
     + /*
     +  * The character that begins a commented line in user-editable file
     +
       ## fsmonitor.c ##
     +@@
     + #include "dir.h"
     + #include "ewah/ewok.h"
     + #include "fsmonitor.h"
     ++#include "fsmonitor-ipc.h"
     + #include "run-command.h"
     + #include "strbuf.h"
     + 
     +@@ fsmonitor.c: void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
     + /*
     +  * Call the query-fsmonitor hook passing the last update token of the saved results.
     +  */
     +-static int query_fsmonitor(int version, const char *last_update, struct strbuf *query_result)
     ++static int query_fsmonitor_hook(struct repository *r,
     ++				int version,
     ++				const char *last_update,
     ++				struct strbuf *query_result)
     + {
     + 	struct child_process cp = CHILD_PROCESS_INIT;
     + 	int result;
     + 
     +-	if (!core_fsmonitor)
     ++	if (r->settings.fsmonitor_mode != FSMONITOR_MODE_HOOK)
     + 		return -1;
     + 
     +-	strvec_push(&cp.args, core_fsmonitor);
     ++	assert(r->settings.fsmonitor_hook_path);
     ++	assert(*r->settings.fsmonitor_hook_path);
     ++
     ++	strvec_push(&cp.args, r->settings.fsmonitor_hook_path);
     + 	strvec_pushf(&cp.args, "%d", version);
     + 	strvec_pushf(&cp.args, "%s", last_update);
     + 	cp.use_shell = 1;
     +@@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     + 	struct strbuf last_update_token = STRBUF_INIT;
     + 	char *buf;
     + 	unsigned int i;
     ++	struct repository *r = istate->repo ? istate->repo : the_repository;
     + 
     +-	if (!core_fsmonitor || istate->fsmonitor_has_run_once)
     ++	if (r->settings.fsmonitor_mode <= FSMONITOR_MODE_DISABLED ||
     ++	    istate->fsmonitor_has_run_once)
     + 		return;
     + 
     +-	hook_version = fsmonitor_hook_version();
     +-
     + 	istate->fsmonitor_has_run_once = 1;
     + 
     + 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
     ++
     ++	if (r->settings.fsmonitor_mode == FSMONITOR_MODE_IPC) {
     ++		/* TODO */
     ++		return;
     ++	}
     ++
     ++	assert(r->settings.fsmonitor_mode == FSMONITOR_MODE_HOOK);
     ++
     ++	hook_version = fsmonitor_hook_version();
     ++
     + 	/*
     +-	 * This could be racy so save the date/time now and query_fsmonitor
     ++	 * This could be racy so save the date/time now and query_fsmonitor_hook
     + 	 * should be inclusive to ensure we don't miss potential changes.
     + 	 */
     + 	last_update = getnanotime();
     +@@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     + 		strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
     + 
     + 	/*
     +-	 * If we have a last update token, call query_fsmonitor for the set of
     ++	 * If we have a last update token, call query_fsmonitor_hook for the set of
     + 	 * changes since that token, else assume everything is possibly dirty
     + 	 * and check it all.
     + 	 */
     + 	if (istate->fsmonitor_last_update) {
     + 		if (hook_version == -1 || hook_version == HOOK_INTERFACE_VERSION2) {
     +-			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION2,
     ++			query_success = !query_fsmonitor_hook(
     ++				r, HOOK_INTERFACE_VERSION2,
     + 				istate->fsmonitor_last_update, &query_result);
     + 
     + 			if (query_success) {
     +@@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     + 		}
     + 
     + 		if (hook_version == HOOK_INTERFACE_VERSION1) {
     +-			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION1,
     ++			query_success = !query_fsmonitor_hook(
     ++				r, HOOK_INTERFACE_VERSION1,
     + 				istate->fsmonitor_last_update, &query_result);
     + 		}
     + 
     +-		trace_performance_since(last_update, "fsmonitor process '%s'", core_fsmonitor);
     +-		trace_printf_key(&trace_fsmonitor, "fsmonitor process '%s' returned %s",
     +-			core_fsmonitor, query_success ? "success" : "failure");
     ++		trace_performance_since(last_update, "fsmonitor process '%s'",
     ++					r->settings.fsmonitor_hook_path);
     ++		trace_printf_key(&trace_fsmonitor,
     ++				 "fsmonitor process '%s' returned %s",
     ++				 r->settings.fsmonitor_hook_path,
     ++				 query_success ? "success" : "failure");
     + 	}
     + 
     + 	/* a fsmonitor process can return '/' to indicate all entries are invalid */
      @@ fsmonitor.c: void remove_fsmonitor(struct index_state *istate)
       void tweak_fsmonitor(struct index_state *istate)
       {
       	unsigned int i;
      -	int fsmonitor_enabled = git_config_get_fsmonitor();
     -+	int fsmonitor_enabled = repo_config_get_fsmonitor(istate->repo ? istate->repo : the_repository);
     ++	struct repository *r = istate->repo ? istate->repo : the_repository;
     ++	int fsmonitor_enabled = r->settings.fsmonitor_mode > FSMONITOR_MODE_DISABLED;
       
       	if (istate->fsmonitor_dirty) {
       		if (fsmonitor_enabled) {
     +@@ fsmonitor.c: void tweak_fsmonitor(struct index_state *istate)
     + 		istate->fsmonitor_dirty = NULL;
     + 	}
     + 
     +-	switch (fsmonitor_enabled) {
     +-	case -1: /* keep: do nothing */
     +-		break;
     +-	case 0: /* false */
     +-		remove_fsmonitor(istate);
     +-		break;
     +-	case 1: /* true */
     ++	if (fsmonitor_enabled)
     + 		add_fsmonitor(istate);
     +-		break;
     +-	default: /* unknown value: do nothing */
     +-		break;
     +-	}
     ++	else
     ++		remove_fsmonitor(istate);
     + }
     +
     + ## fsmonitor.h ##
     +@@ fsmonitor.h: int fsmonitor_is_trivial_response(const struct strbuf *query_result);
     +  */
     + static inline int is_fsmonitor_refreshed(const struct index_state *istate)
     + {
     +-	return !core_fsmonitor || istate->fsmonitor_has_run_once;
     ++	struct repository *r = istate->repo ? istate->repo : the_repository;
     ++
     ++	return r->settings.fsmonitor_mode <= FSMONITOR_MODE_DISABLED ||
     ++		istate->fsmonitor_has_run_once;
     + }
     + 
     + /*
     +@@ fsmonitor.h: static inline int is_fsmonitor_refreshed(const struct index_state *istate)
     +  */
     + static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce)
     + {
     +-	if (core_fsmonitor && !(ce->ce_flags & CE_FSMONITOR_VALID)) {
     ++	struct repository *r = istate->repo ? istate->repo : the_repository;
     ++
     ++	if (r->settings.fsmonitor_mode > FSMONITOR_MODE_DISABLED &&
     ++	    !(ce->ce_flags & CE_FSMONITOR_VALID)) {
     + 		istate->cache_changed = 1;
     + 		ce->ce_flags |= CE_FSMONITOR_VALID;
     + 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
     +@@ fsmonitor.h: static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache
     +  */
     + static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
     + {
     +-	if (core_fsmonitor) {
     ++	struct repository *r = istate->repo ? istate->repo : the_repository;
     ++
     ++	if (r->settings.fsmonitor_mode > FSMONITOR_MODE_DISABLED) {
     + 		ce->ce_flags &= ~CE_FSMONITOR_VALID;
     + 		untracked_cache_invalidate_path(istate, ce->name, 1);
     + 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->name);
     +
     + ## repo-settings.c ##
     +@@
     + 
     + #define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } } while(0)
     + 
     ++/*
     ++ * Return 1 if the repo/workdir is incompatible with FSMonitor.
     ++ */
     ++static int is_repo_incompatible_with_fsmonitor(struct repository *r)
     ++{
     ++	const char *const_strval;
     ++
     ++	/*
     ++	 * Bare repositories don't have a working directory and
     ++	 * therefore, nothing to watch.
     ++	 */
     ++	if (!r->worktree)
     ++		return 1;
     ++
     ++	/*
     ++	 * GVFS (aka VFS for Git) is incompatible with FSMonitor.
     ++	 *
     ++	 * Granted, core Git does not know anything about GVFS and
     ++	 * we shouldn't make assumptions about a downstream feature,
     ++	 * but users can install both versions.  And this can lead
     ++	 * to incorrect results from core Git commands.  So, without
     ++	 * bringing in any of the GVFS code, do a simple config test
     ++	 * for a published config setting.  (We do not look at the
     ++	 * various *_TEST_* environment variables.)
     ++	 */
     ++	if (!repo_config_get_value(r, "core.virtualfilesystem", &const_strval))
     ++		return 1;
     ++
     ++	return 0;
     ++}
     ++
     + void prepare_repo_settings(struct repository *r)
     + {
     + 	int value;
     + 	char *strval;
     ++	const char *const_strval;
     + 
     + 	if (r->settings.initialized)
     + 		return;
     +@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
     + 	UPDATE_DEFAULT_BOOL(r->settings.commit_graph_read_changed_paths, 1);
     + 	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
     + 
     ++	r->settings.fsmonitor_hook_path = NULL;
     ++	r->settings.fsmonitor_mode = FSMONITOR_MODE_DISABLED;
     ++	if (is_repo_incompatible_with_fsmonitor(r))
     ++		r->settings.fsmonitor_mode = FSMONITOR_MODE_INCOMPATIBLE;
     ++	else if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value)
     ++		   && value)
     ++		r->settings.fsmonitor_mode = FSMONITOR_MODE_IPC;
     ++	else {
     ++		if (repo_config_get_pathname(r, "core.fsmonitor", &const_strval))
     ++			const_strval = getenv("GIT_TEST_FSMONITOR");
     ++		if (const_strval && *const_strval) {
     ++			r->settings.fsmonitor_hook_path = strdup(const_strval);
     ++			r->settings.fsmonitor_mode = FSMONITOR_MODE_HOOK;
     ++		}
     ++	}
     ++
     + 	if (!repo_config_get_int(r, "index.version", &value))
     + 		r->settings.index_version = value;
     + 	if (!repo_config_get_maybe_bool(r, "core.untrackedcache", &value)) {
     +
     + ## repository.h ##
     +@@ repository.h: enum fetch_negotiation_setting {
     + 	FETCH_NEGOTIATION_NOOP = 3,
     + };
     + 
     ++enum fsmonitor_mode {
     ++	FSMONITOR_MODE_INCOMPATIBLE = -2,
     ++	FSMONITOR_MODE_UNSET = -1,
     ++	FSMONITOR_MODE_DISABLED = 0,
     ++	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor */
     ++	FSMONITOR_MODE_IPC = 2, /* core.useBuiltinFSMonitor */
     ++};
     ++
     + struct repo_settings {
     + 	int initialized;
     + 
     +@@ repository.h: struct repo_settings {
     + 	int gc_write_commit_graph;
     + 	int fetch_write_commit_graph;
     + 
     ++	enum fsmonitor_mode fsmonitor_mode;
     ++	char *fsmonitor_hook_path;
     ++
     + 	int index_version;
     + 	enum untracked_cache_setting core_untracked_cache;
     + 
     +
     + ## t/README ##
     +@@ t/README: every 'git commit-graph write', as if the `--changed-paths` option was
     + passed in.
     + 
     + GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
     +-code path for utilizing a file system monitor to speed up detecting
     +-new or changed files.
     ++code path for utilizing a (hook based) file system monitor to speed up
     ++detecting new or changed files.
     + 
     + GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
     + for the index version specified.  Can be set to any valid version
     +
     + ## t/t7519-status-fsmonitor.sh ##
     +@@ t/t7519-status-fsmonitor.sh: test_expect_success 'status succeeds after staging/unstaging' '
     + 	)
     + '
     + 
     ++# Test that we detect and disallow repos that are incompatible with FSMonitor.
     ++test_expect_success 'incompatible bare repo' '
     ++	test_when_finished "rm -rf ./bare-clone" &&
     ++	git clone --bare . ./bare-clone &&
     ++	cat >expect <<-\EOF &&
     ++	error: repository is incompatible with fsmonitor
     ++	EOF
     ++	test_must_fail git -C ./bare-clone update-index --fsmonitor 2>actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'incompatible core.virtualfilesystem' '
     ++	test_when_finished "rm -rf ./fake-gvfs-clone" &&
     ++	git clone . ./fake-gvfs-clone &&
     ++	git -C ./fake-gvfs-clone config core.virtualfilesystem true &&
     ++	cat >expect <<-\EOF &&
     ++	error: repository is incompatible with fsmonitor
     ++	EOF
     ++	test_must_fail git -C ./fake-gvfs-clone update-index --fsmonitor 2>actual &&
     ++	test_cmp expect actual
     ++'
     ++
     + test_done
  7:  7e097cebc14 !  7:  c86b5651ecc fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
     @@
       ## Metadata ##
     -Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
     +Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
     +    fsmonitor: use IPC to query the builtin FSMonitor daemon
      
          Use simple IPC to directly communicate with the new builtin file
     -    system monitor daemon.
     -
     -    Define a new config setting `core.useBuiltinFSMonitor` to enable the
     -    builtin file system monitor.
     +    system monitor daemon when `core.useBuiltinFSMonitor` is set.
      
          The `core.fsmonitor` setting has already been defined as a HOOK
          pathname.  Historically, this has been set to a HOOK script that will
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     - ## config.c ##
     -@@ config.c: int git_config_get_max_percent_split_change(void)
     - 
     - int repo_config_get_fsmonitor(struct repository *r)
     - {
     -+	if (r->settings.use_builtin_fsmonitor > 0) {
     -+		core_fsmonitor = "(built-in daemon)";
     -+		return 1;
     -+	}
     -+
     - 	if (repo_config_get_pathname(r, "core.fsmonitor", &core_fsmonitor))
     - 		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
     - 
     -
       ## fsmonitor.c ##
     -@@
     - #include "dir.h"
     - #include "ewah/ewok.h"
     - #include "fsmonitor.h"
     -+#include "fsmonitor-ipc.h"
     - #include "run-command.h"
     - #include "strbuf.h"
     - 
     -@@ fsmonitor.c: static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
     - 
     - void refresh_fsmonitor(struct index_state *istate)
     - {
     -+	struct repository *r = istate->repo ? istate->repo : the_repository;
     - 	struct strbuf query_result = STRBUF_INIT;
     - 	int query_success = 0, hook_version = -1;
     - 	size_t bol = 0; /* beginning of line */
      @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     - 	istate->fsmonitor_has_run_once = 1;
     - 
       	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
     -+
     -+	if (r->settings.use_builtin_fsmonitor > 0) {
     + 
     + 	if (r->settings.fsmonitor_mode == FSMONITOR_MODE_IPC) {
     +-		/* TODO */
     +-		return;
      +		query_success = !fsmonitor_ipc__send_query(
     -+			istate->fsmonitor_last_update, &query_result);
     ++			istate->fsmonitor_last_update ?
     ++			istate->fsmonitor_last_update : "builtin:fake",
     ++			&query_result);
      +		if (query_success) {
      +			/*
      +			 * The response contains a series of nul terminated
     @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
      +		 * hook setting.
      +		 */
      +		goto apply_results;
     -+	}
     -+
     - 	/*
     - 	 * This could be racy so save the date/time now and query_fsmonitor
     - 	 * should be inclusive to ensure we don't miss potential changes.
     + 	}
     + 
     + 	assert(r->settings.fsmonitor_mode == FSMONITOR_MODE_HOOK);
      @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     - 			core_fsmonitor, query_success ? "success" : "failure");
     + 				 query_success ? "success" : "failure");
       	}
       
      +apply_results:
       	/* a fsmonitor process can return '/' to indicate all entries are invalid */
       	if (query_success && query_result.buf[bol] != '/') {
       		/* Mark all entries returned by the monitor as dirty */
     -
     - ## repo-settings.c ##
     -@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
     - 		r->settings.core_multi_pack_index = value;
     - 	UPDATE_DEFAULT_BOOL(r->settings.core_multi_pack_index, 1);
     - 
     -+	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) && value)
     -+		r->settings.use_builtin_fsmonitor = 1;
     -+
     - 	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
     - 		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
     - 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
     -
     - ## repository.h ##
     -@@ repository.h: enum fetch_negotiation_setting {
     - struct repo_settings {
     - 	int initialized;
     - 
     -+	int use_builtin_fsmonitor;
     -+
     - 	int core_commit_graph;
     - 	int commit_graph_read_changed_paths;
     - 	int gc_write_commit_graph;
  8:  f362a88632e =  8:  f88db92d425 fsmonitor--daemon: add a built-in fsmonitor daemon
  9:  4f401310539 !  9:  02e21384ef0 fsmonitor--daemon: implement client command options
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    fsmonitor--daemon: implement client command options
     +    fsmonitor--daemon: implement 'stop' and 'status' commands
      
          Implement `stop` and `status` client commands to control and query the
          status of a `fsmonitor--daemon` server process (and implicitly start a
     @@ builtin/fsmonitor--daemon.c
      +
      +	switch (state) {
      +	case IPC_STATE__LISTENING:
     -+		printf(_("The built-in file system monitor is active\n"));
     ++		printf(_("fsmonitor-daemon is watching '%s'\n"),
     ++		       the_repository->worktree);
      +		return 0;
      +
      +	default:
     -+		printf(_("The built-in file system monitor is not active\n"));
     ++		printf(_("fsmonitor-daemon is not watching '%s'\n"),
     ++		       the_repository->worktree);
      +		return 1;
      +	}
      +}
 10:  d21af7ff842 ! 10:  c2adac8ed4b t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
     @@ t/helper/test-fsmonitor-client.c (new)
      +#include "test-tool.h"
      +#include "cache.h"
      +#include "parse-options.h"
     -+//#include "fsmonitor.h"
      +#include "fsmonitor-ipc.h"
     -+//#include "compat/fsmonitor/fsmonitor-fs-listen.h"
     -+//#include "fsmonitor--daemon.h"
     -+//#include "simple-ipc.h"
      +
      +#ifndef HAVE_FSMONITOR_DAEMON_BACKEND
      +int cmd__fsmonitor_client(int argc, const char **argv)
 11:  49f9e2e3d49 ! 11:  5a9bda72203 fsmonitor-fs-listen-win32: stub in backend for Windows
     @@ config.mak.uname: ifneq (,$(findstring MINGW,$(uname_S)))
      
       ## contrib/buildsystems/CMakeLists.txt ##
      @@ contrib/buildsystems/CMakeLists.txt: else()
     - 	list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-unix-socket.c)
     + 	endif()
       endif()
       
      +if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 12:  2aa85151f03 = 12:  58758048947 fsmonitor-fs-listen-macos: stub in backend for MacOS
 13:  2aa05ad5c67 ! 13:  5d6646df93a fsmonitor--daemon: implement daemon command options
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    fsmonitor--daemon: implement daemon command options
     +    fsmonitor--daemon: implement 'run' command
      
     -    Implement `run` and `start` commands to try to
     -    begin listening for file system events.
     +    Implement `run` command to try to begin listening for file system events.
      
     -    This version defines the thread structure with a single
     -    fsmonitor_fs_listen thread to watch for file system events
     -    and a simple IPC thread pool to wait for connections from
     -    Git clients over a well-known named pipe or Unix domain
     -    socket.
     +    This version defines the thread structure with a single fsmonitor_fs_listen
     +    thread to watch for file system events and a simple IPC thread pool to
     +    watch for connection from Git clients over a well-known named pipe or
     +    Unix domain socket.
      
     -    This version does not actually do anything yet because the
     +    This commit does not actually do anything yet because the platform
          backends are still just stubs.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     @@ builtin/fsmonitor--daemon.c
       #include "khash.h"
       
       static const char * const builtin_fsmonitor__daemon_usage[] = {
     -+	N_("git fsmonitor--daemon start [<options>]"),
      +	N_("git fsmonitor--daemon run [<options>]"),
       	N_("git fsmonitor--daemon stop"),
       	N_("git fsmonitor--daemon status"),
     @@ builtin/fsmonitor--daemon.c
      +#define FSMONITOR__IPC_THREADS "fsmonitor.ipcthreads"
      +static int fsmonitor__ipc_threads = 8;
      +
     -+#define FSMONITOR__START_TIMEOUT "fsmonitor.starttimeout"
     -+static int fsmonitor__start_timeout_sec = 60;
     -+
      +static int fsmonitor_config(const char *var, const char *value, void *cb)
      +{
      +	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
     @@ builtin/fsmonitor--daemon.c
      +		return 0;
      +	}
      +
     -+	if (!strcmp(var, FSMONITOR__START_TIMEOUT)) {
     -+		int i = git_config_int(var, value);
     -+		if (i < 0)
     -+			return error(_("value of '%s' out of range: %d"),
     -+				     FSMONITOR__START_TIMEOUT, i);
     -+		fsmonitor__start_timeout_sec = i;
     -+		return 0;
     -+	}
     -+
      +	return git_default_config(var, value, cb);
      +}
      +
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
      +	state.nr_paths_watching = 1;
      +
      +	/*
     -+	 * We create/delete cookie files inside the .git directory to
     -+	 * help us keep sync with the file system.  If ".git" is not a
     -+	 * directory, then <gitdir> is not inside the cone of
     -+	 * <worktree-root>, so set up a second watch for it.
     ++	 * We create and delete cookie files somewhere inside the .git
     ++	 * directory to help us keep sync with the file system.  If
     ++	 * ".git" is not a directory, then <gitdir> is not inside the
     ++	 * cone of <worktree-root>, so set up a second watch to watch
     ++	 * the <gitdir> so that we get events for the cookie files.
      +	 */
      +	strbuf_init(&state.path_gitdir_watch, 0);
      +	strbuf_addbuf(&state.path_gitdir_watch, &state.path_worktree_watch);
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
      +	 * common error case.
      +	 */
      +	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
     -+		die("fsmonitor--daemon is already running.");
     -+
     -+	return !!fsmonitor_run_daemon();
     -+}
     -+
     -+#ifndef GIT_WINDOWS_NATIVE
     -+/*
     -+ * This is adapted from `daemonize()`.  Use `fork()` to directly create
     -+ * and run the daemon in a child process.  The fork-parent returns the
     -+ * child PID so that we can wait for the child to startup before exiting.
     -+ */
     -+static int spawn_background_fsmonitor_daemon(pid_t *pid)
     -+{
     -+	*pid = fork();
     -+
     -+	switch (*pid) {
     -+	case 0:
     -+		if (setsid() == -1)
     -+			error_errno(_("setsid failed"));
     -+		close(0);
     -+		close(1);
     -+		close(2);
     -+		sanitize_stdfds();
     -+
     -+		return !!fsmonitor_run_daemon();
     -+
     -+	case -1:
     -+		return error_errno(_("could not spawn fsmonitor--daemon in the background"));
     -+
     -+	default:
     -+		return 0;
     -+	}
     -+}
     -+#else
     -+/*
     -+ * Conceptually like `daemonize()` but different because Windows does not
     -+ * have `fork(2)`.  Spawn a normal Windows child process but without the
     -+ * limitations of `start_command()` and `finish_command()`.
     -+ */
     -+static int spawn_background_fsmonitor_daemon(pid_t *pid)
     -+{
     -+	char git_exe[MAX_PATH];
     -+	struct strvec args = STRVEC_INIT;
     -+	int in, out;
     -+
     -+	GetModuleFileNameA(NULL, git_exe, MAX_PATH);
     -+
     -+	in = open("/dev/null", O_RDONLY);
     -+	out = open("/dev/null", O_WRONLY);
     -+
     -+	strvec_push(&args, git_exe);
     -+	strvec_push(&args, "fsmonitor--daemon");
     -+	strvec_push(&args, "run");
     ++		die("fsmonitor--daemon is already running '%s'",
     ++		    the_repository->worktree);
      +
     -+	*pid = mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
     -+	close(in);
     -+	close(out);
     ++	printf(_("running fsmonitor-daemon in '%s'\n"),
     ++	       the_repository->worktree);
     ++	fflush(stdout);
      +
     -+	strvec_clear(&args);
     -+
     -+	if (*pid < 0)
     -+		return error(_("could not spawn fsmonitor--daemon in the background"));
     -+
     -+	return 0;
     -+}
     -+#endif
     -+
     -+/*
     -+ * This is adapted from `wait_or_whine()`.  Watch the child process and
     -+ * let it get started and begin listening for requests on the socket
     -+ * before reporting our success.
     -+ */
     -+static int wait_for_background_startup(pid_t pid_child)
     -+{
     -+	int status;
     -+	pid_t pid_seen;
     -+	enum ipc_active_state s;
     -+	time_t time_limit, now;
     -+
     -+	time(&time_limit);
     -+	time_limit += fsmonitor__start_timeout_sec;
     -+
     -+	for (;;) {
     -+		pid_seen = waitpid(pid_child, &status, WNOHANG);
     -+
     -+		if (pid_seen == -1)
     -+			return error_errno(_("waitpid failed"));
     -+		else if (pid_seen == 0) {
     -+			/*
     -+			 * The child is still running (this should be
     -+			 * the normal case).  Try to connect to it on
     -+			 * the socket and see if it is ready for
     -+			 * business.
     -+			 *
     -+			 * If there is another daemon already running,
     -+			 * our child will fail to start (possibly
     -+			 * after a timeout on the lock), but we don't
     -+			 * care (who responds) if the socket is live.
     -+			 */
     -+			s = fsmonitor_ipc__get_state();
     -+			if (s == IPC_STATE__LISTENING)
     -+				return 0;
     -+
     -+			time(&now);
     -+			if (now > time_limit)
     -+				return error(_("fsmonitor--daemon not online yet"));
     -+		} else if (pid_seen == pid_child) {
     -+			/*
     -+			 * The new child daemon process shutdown while
     -+			 * it was starting up, so it is not listening
     -+			 * on the socket.
     -+			 *
     -+			 * Try to ping the socket in the odd chance
     -+			 * that another daemon started (or was already
     -+			 * running) while our child was starting.
     -+			 *
     -+			 * Again, we don't care who services the socket.
     -+			 */
     -+			s = fsmonitor_ipc__get_state();
     -+			if (s == IPC_STATE__LISTENING)
     -+				return 0;
     -+
     -+			/*
     -+			 * We don't care about the WEXITSTATUS() nor
     -+			 * any of the WIF*(status) values because
     -+			 * `cmd_fsmonitor__daemon()` does the `!!result`
     -+			 * trick on all function return values.
     -+			 *
     -+			 * So it is sufficient to just report the
     -+			 * early shutdown as an error.
     -+			 */
     -+			return error(_("fsmonitor--daemon failed to start"));
     -+		} else
     -+			return error(_("waitpid is confused"));
     -+	}
     -+}
     -+
     -+static int try_to_start_background_daemon(void)
     -+{
     -+	pid_t pid_child;
     -+	int ret;
     -+
     -+	/*
     -+	 * Before we try to create a background daemon process, see
     -+	 * if a daemon process is already listening.  This makes it
     -+	 * easier for us to report an already-listening error to the
     -+	 * console, since our spawn/daemon can only report the success
     -+	 * of creating the background process (and not whether it
     -+	 * immediately exited).
     -+	 */
     -+	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
     -+		die("fsmonitor--daemon is already running.");
     -+
     -+	/*
     -+	 * Run the actual daemon in a background process.
     -+	 */
     -+	ret = spawn_background_fsmonitor_daemon(&pid_child);
     -+	if (pid_child <= 0)
     -+		return ret;
     -+
     -+	/*
     -+	 * Wait (with timeout) for the background child process get
     -+	 * started and begin listening on the socket/pipe.  This makes
     -+	 * the "start" command more synchronous and more reliable in
     -+	 * tests.
     -+	 */
     -+	ret = wait_for_background_startup(pid_child);
     -+
     -+	return ret;
     ++	return !!fsmonitor_run_daemon();
      +}
      +
       int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
      +		OPT_INTEGER(0, "ipc-threads",
      +			    &fsmonitor__ipc_threads,
      +			    N_("use <n> ipc worker threads")),
     -+		OPT_INTEGER(0, "start-timeout",
     -+			    &fsmonitor__start_timeout_sec,
     -+			    N_("Max seconds to wait for background daemon startup")),
     -+
       		OPT_END()
       	};
       
     @@ builtin/fsmonitor--daemon.c: int cmd_fsmonitor__daemon(int argc, const char **ar
      +		die(_("invalid 'ipc-threads' value (%d)"),
      +		    fsmonitor__ipc_threads);
      +
     -+	if (!strcmp(subcmd, "start"))
     -+		return !!try_to_start_background_daemon();
     -+
      +	if (!strcmp(subcmd, "run"))
      +		return !!try_to_run_foreground_daemon();
       
  -:  ----------- > 14:  9fe902aad87 fsmonitor--daemon: implement 'start' command
  -:  ----------- > 15:  eef39aa168f fsmonitor: do not try to operate on bare repos
 14:  d5ababfd03e = 16:  3b12f668060 fsmonitor--daemon: add pathname classification
 15:  c092cdf2c8b = 17:  37fdce5ec3a fsmonitor--daemon: define token-ids
 16:  2ed7bc3fae7 = 18:  84444c44c32 fsmonitor--daemon: create token-based changed path cache
 17:  9ea4b04b821 ! 19:  5bba5eb3d1b fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
     @@ compat/fsmonitor/fsmonitor-fs-listen-win32.c
      +
      +		t = fsmonitor_classify_path_gitdir_relative(path.buf);
      +
     -+		trace_printf_key(&trace_fsmonitor, "BBB: %s", path.buf);
     -+
      +		switch (t) {
      +		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
      +			/* special case cookie files within gitdir */
 18:  21b2b4f941b = 20:  175ae9a757e fsmonitor-fs-listen-macos: add macos header files for FSEvent
 19:  08474bad830 = 21:  5d12b5d808a fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
 20:  cc4a596d17c = 22:  39df123143b fsmonitor--daemon: implement handle_client callback
  -:  ----------- > 23:  3cf8f3cd771 t/helper/test-touch: add helper to touch a series of files
  -:  ----------- > 24:  f1ef9656fc3 t/perf/p7519: speed up test using "test-tool touch"
 28:  96a3eab819f = 25:  a83485fb10f t/perf: avoid copying builtin fsmonitor files into test repo
 26:  5b035c6e0d6 ! 26:  de517a8259a p7519: add fsmonitor--daemon
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    p7519: add fsmonitor--daemon
     +    t/perf/p7519: add fsmonitor--daemon test cases
      
          Repeat all of the fsmonitor perf tests using `git fsmonitor--daemon` and
          the "Simple IPC" interface.
     @@ t/perf/p7519-fsmonitor.sh: test_expect_success "setup without fsmonitor" '
      +# Explicitly start the daemon here and before we start client commands
      +# so that we can later add custom tracing.
      +#
     -+
     -+test_lazy_prereq HAVE_FSMONITOR_DAEMON '
     -+	git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
     -+'
     -+
     -+if test_have_prereq HAVE_FSMONITOR_DAEMON
     ++if test_have_prereq FSMONITOR_DAEMON
      +then
      +	USE_FSMONITOR_DAEMON=t
      +
 25:  c9159db718a ! 27:  99279c0ebd2 t7527: create test for fsmonitor--daemon
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +. ./test-lib.sh
      +
     -+git version --build-options | grep "feature:" | grep "fsmonitor--daemon" || {
     -+	skip_all="The built-in FSMonitor is not supported on this platform"
     ++if ! test_have_prereq FSMONITOR_DAEMON
     ++then
     ++	skip_all="fsmonitor--daemon is not supported on this platform"
      +	test_done
     -+}
     ++fi
      +
     -+kill_repo () {
     ++stop_daemon_delete_repo () {
      +	r=$1
      +	git -C $r fsmonitor--daemon stop >/dev/null 2>/dev/null
      +	rm -rf $1
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +}
      +
      +test_expect_success 'explicit daemon start and stop' '
     -+	test_when_finished "kill_repo test_explicit" &&
     ++	test_when_finished "stop_daemon_delete_repo test_explicit" &&
      +
      +	git init test_explicit &&
      +	start_daemon test_explicit &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +test_expect_success 'implicit daemon start' '
     -+	test_when_finished "kill_repo test_implicit" &&
     ++	test_when_finished "stop_daemon_delete_repo test_implicit" &&
      +
      +	git init test_implicit &&
      +	test_must_fail git -C test_implicit fsmonitor--daemon status &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	# but this test case is only concerned with whether the daemon was
      +	# implicitly started.)
      +
     -+	GIT_TRACE2_EVENT="$PWD/.git/trace" \
     ++	GIT_TRACE2_EVENT="$(pwd)/.git/trace" \
      +		test-tool -C test_implicit fsmonitor-client query --token 0 >actual &&
      +	nul_to_q <actual >actual.filtered &&
      +	grep "builtin:" actual.filtered &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +test_expect_success 'implicit daemon stop (delete .git)' '
     -+	test_when_finished "kill_repo test_implicit_1" &&
     ++	test_when_finished "stop_daemon_delete_repo test_implicit_1" &&
      +
      +	git init test_implicit_1 &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	# deleting the .git directory will implicitly stop the daemon.
      +	rm -rf test_implicit_1/.git &&
      +
     -+	# Create an empty .git directory so that the following Git command
     -+	# will stay relative to the `-C` directory.  Without this, the Git
     -+	# command will (override the requested -C argument) and crawl out
     -+	# to the containing Git source tree.  This would make the test
     -+	# result dependent upon whether we were using fsmonitor on our
     -+	# development worktree.
     -+
     ++	# [1] Create an empty .git directory so that the following Git
     ++	#     command will stay relative to the `-C` directory.
     ++	#
     ++	#     Without this, the Git command will override the requested
     ++	#     -C argument and crawl out to the containing Git source tree.
     ++	#     This would make the test result dependent upon whether we
     ++	#     were using fsmonitor on our development worktree.
     ++	#
      +	sleep 1 &&
      +	mkdir test_implicit_1/.git &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +test_expect_success 'implicit daemon stop (rename .git)' '
     -+	test_when_finished "kill_repo test_implicit_2" &&
     ++	test_when_finished "stop_daemon_delete_repo test_implicit_2" &&
      +
      +	git init test_implicit_2 &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	# renaming the .git directory will implicitly stop the daemon.
      +	mv test_implicit_2/.git test_implicit_2/.xxx &&
      +
     -+	# Create an empty .git directory so that the following Git command
     -+	# will stay relative to the `-C` directory.  Without this, the Git
     -+	# command will (override the requested -C argument) and crawl out
     -+	# to the containing Git source tree.  This would make the test
     -+	# result dependent upon whether we were using fsmonitor on our
     -+	# development worktree.
     -+
     ++	# See [1] above.
     ++	#
      +	sleep 1 &&
      +	mkdir test_implicit_2/.git &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +test_expect_success 'cannot start multiple daemons' '
     -+	test_when_finished "kill_repo test_multiple" &&
     ++	test_when_finished "stop_daemon_delete_repo test_multiple" &&
      +
      +	git init test_multiple &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	test_must_fail git -C test_multiple fsmonitor--daemon status
      +'
      +
     ++# These tests use the main repo in the trash directory
     ++
      +test_expect_success 'setup' '
      +	>tracked &&
      +	>modified &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	git config core.useBuiltinFSMonitor true
      +'
      +
     ++# The test already explicitly stopped (or tried to stop) the daemon.
     ++# This is here in case something else fails first.
     ++#
     ++redundant_stop_daemon () {
     ++	git fsmonitor--daemon stop
     ++	return 0
     ++}
     ++
      +test_expect_success 'update-index implicitly starts daemon' '
     ++	test_when_finished redundant_stop_daemon &&
     ++
      +	test_must_fail git fsmonitor--daemon status &&
      +
     -+	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_1" \
     ++	GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_1" \
      +		git update-index --fsmonitor &&
      +
      +	git fsmonitor--daemon status &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +test_expect_success 'status implicitly starts daemon' '
     ++	test_when_finished redundant_stop_daemon &&
     ++
      +	test_must_fail git fsmonitor--daemon status &&
      +
     -+	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_2" \
     ++	GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_2" \
      +		git status >actual &&
      +
      +	git fsmonitor--daemon status &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +}
      +
      +test_expect_success 'edit some files' '
     -+	test_when_finished "clean_up_repo_and_stop_daemon" &&
     ++	test_when_finished clean_up_repo_and_stop_daemon &&
      +
      +	(
     -+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
     ++		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
      +		export GIT_TRACE_FSMONITOR &&
      +
      +		start_daemon
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +test_expect_success 'create some files' '
     -+	test_when_finished "clean_up_repo_and_stop_daemon" &&
     ++	test_when_finished clean_up_repo_and_stop_daemon &&
      +
      +	(
     -+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
     ++		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
      +		export GIT_TRACE_FSMONITOR &&
      +
      +		start_daemon
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +test_expect_success 'delete some files' '
     -+	test_when_finished "clean_up_repo_and_stop_daemon" &&
     ++	test_when_finished clean_up_repo_and_stop_daemon &&
      +
      +	(
     -+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
     ++		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
      +		export GIT_TRACE_FSMONITOR &&
      +
      +		start_daemon
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +test_expect_success 'rename some files' '
     -+	test_when_finished "clean_up_repo_and_stop_daemon" &&
     ++	test_when_finished clean_up_repo_and_stop_daemon &&
      +
      +	(
     -+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
     ++		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
      +		export GIT_TRACE_FSMONITOR &&
      +
      +		start_daemon
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +test_expect_success 'rename directory' '
     -+	test_when_finished "clean_up_repo_and_stop_daemon" &&
     ++	test_when_finished clean_up_repo_and_stop_daemon &&
      +
      +	(
     -+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
     ++		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
      +		export GIT_TRACE_FSMONITOR &&
      +
      +		start_daemon
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +test_expect_success 'file changes to directory' '
     -+	test_when_finished "clean_up_repo_and_stop_daemon" &&
     ++	test_when_finished clean_up_repo_and_stop_daemon &&
      +
      +	(
     -+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
     ++		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
      +		export GIT_TRACE_FSMONITOR &&
      +
      +		start_daemon
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +test_expect_success 'directory changes to a file' '
     -+	test_when_finished "clean_up_repo_and_stop_daemon" &&
     ++	test_when_finished clean_up_repo_and_stop_daemon &&
      +
      +	(
     -+		GIT_TRACE_FSMONITOR="$PWD/.git/trace" &&
     ++		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
      +		export GIT_TRACE_FSMONITOR &&
      +
      +		start_daemon
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +# "flush" message to a running daemon and ask it to do a flush/resync.
      +
      +test_expect_success 'flush cached data' '
     -+	test_when_finished "kill_repo test_flush" &&
     ++	test_when_finished "stop_daemon_delete_repo test_flush" &&
      +
      +	git init test_flush &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +		GIT_TEST_FSMONITOR_TOKEN=true &&
      +		export GIT_TEST_FSMONITOR_TOKEN &&
      +
     -+		GIT_TRACE_FSMONITOR="$PWD/.git/trace_daemon" &&
     ++		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace_daemon" &&
      +		export GIT_TRACE_FSMONITOR &&
      +
      +		start_daemon test_flush
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	git -C wt-base worktree add ../wt-secondary &&
      +
      +	(
     -+		GIT_TRACE2_PERF="$PWD/trace2_wt_secondary" &&
     ++		GIT_TRACE2_PERF="$(pwd)/trace2_wt_secondary" &&
      +		export GIT_TRACE2_PERF &&
      +
     -+		GIT_TRACE_FSMONITOR="$PWD/trace_wt_secondary" &&
     ++		GIT_TRACE_FSMONITOR="$(pwd)/trace_wt_secondary" &&
      +		export GIT_TRACE_FSMONITOR &&
      +
      +		start_daemon wt-secondary
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	test_must_fail git -C wt-secondary fsmonitor--daemon status
      +'
      +
     ++# NEEDSWORK: Repeat one of the "edit" tests on wt-secondary and
     ++# confirm that we get the same events and behavior -- that is, that
     ++# fsmonitor--daemon correctly watches BOTH the working directory and
     ++# the external GITDIR directory and behaves the same as when ".git"
     ++# is a directory inside the working directory.
     ++
     ++test_expect_success 'cleanup worktrees' '
     ++	stop_daemon_delete_repo wt-secondary &&
     ++	stop_daemon_delete_repo wt-base
     ++'
     ++
      +test_done
 21:  f0da90e9b05 = 28:  3f36a31eb42 fsmonitor--daemon: periodically truncate list of modified files
 22:  bb7b1912bb4 ! 29:  555caca2216 fsmonitor--daemon: use a cookie file to sync with file system
     @@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon
       	/*
       	 * We expect `command` to be of the form:
      @@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon_state *state,
     - 		 */
     - 		do_flush = 1;
     - 		do_trivial = 1;
     -+		do_cookie = 1;
     - 
     - 	} else if (!skip_prefix(command, "builtin:", &p)) {
     - 		/* assume V1 timestamp or garbage */
     -@@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon_state *state,
     - 				  "fsmonitor: unsupported V1 protocol '%s'"),
     - 				 command);
     - 		do_trivial = 1;
     -+		do_cookie = 1;
     - 
     - 	} else {
     - 		/* We have "builtin:*" */
     -@@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon_state *state,
     - 					 "fsmonitor: invalid V2 protocol token '%s'",
     - 					 command);
     - 			do_trivial = 1;
     -+			do_cookie = 1;
     - 
     - 		} else {
     - 			/*
       			 * We have a V2 valid token:
       			 *     "builtin:<token_id>:<seq_nr>"
       			 */
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
      +	/*
      +	 * We will write filesystem syncing cookie files into
      +	 * <gitdir>/<fsmonitor-dir>/<cookie-dir>/<pid>-<seq>.
     ++	 *
     ++	 * The extra layers of subdirectories here keep us from
     ++	 * changing the mtime on ".git/" or ".git/foo/" when we create
     ++	 * or delete cookie files.
     ++	 *
     ++	 * There have been problems with some IDEs that do a
     ++	 * non-recursive watch of the ".git/" directory and run a
     ++	 * series of commands any time something happens.
     ++	 *
     ++	 * For example, if we place our cookie files directly in
     ++	 * ".git/" or ".git/foo/" then a `git status` (or similar
     ++	 * command) from the IDE will cause a cookie file to be
     ++	 * created in one of those dirs.  This causes the mtime of
     ++	 * those dirs to change.  This triggers the IDE's watch
     ++	 * notification.  This triggers the IDE to run those commands
     ++	 * again.  And the process repeats and the machine never goes
     ++	 * idle.
     ++	 *
     ++	 * Adding the extra layers of subdirectories prevents the
     ++	 * mtime of ".git/" and ".git/foo" from changing when a
     ++	 * cookie file is created.
      +	 */
      +	strbuf_init(&state.path_cookie_prefix, 0);
      +	strbuf_addbuf(&state.path_cookie_prefix, &state.path_gitdir_watch);
 23:  102e17cbc87 = 30:  75bb4bc8463 fsmonitor: enhance existing comments
 24:  11ea2f97def ! 31:  8b3c4f4e6dd fsmonitor: force update index after large responses
     @@ fsmonitor.c: static void fsmonitor_refresh_callback(struct index_state *istate,
      +
       void refresh_fsmonitor(struct index_state *istate)
       {
     - 	struct repository *r = istate->repo ? istate->repo : the_repository;
     + 	struct strbuf query_result = STRBUF_INIT;
      @@ fsmonitor.c: apply_results:
       		 *
       		 * This updates both the cache-entries and the untracked-cache.
 27:  1483c68855c ! 32:  97dce46d1d0 t7527: test status with untracked-cache and fsmonitor--daemon
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'setup' '
       	EOF
       
       	git -c core.useBuiltinFSMonitor= add . &&
     -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'worktree with .git file' '
     - 	test_must_fail git -C wt-secondary fsmonitor--daemon status
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'cleanup worktrees' '
     + 	stop_daemon_delete_repo wt-base
       '
       
     -+# TODO Repeat one of the "edit" tests on wt-secondary and confirm that
     -+# TODO we get the same events and behavior -- that is, that fsmonitor--daemon
     -+# TODO correctly listens to events on both the working directory and to the
     -+# TODO referenced GITDIR.
     -+
     -+test_expect_success 'cleanup worktrees' '
     -+	kill_repo wt-secondary &&
     -+	kill_repo wt-base
     -+'
     -+
      +# The next few tests perform arbitrary/contrived file operations and
      +# confirm that status is correct.  That is, that the data (or lack of
      +# data) from fsmonitor doesn't cause incorrect results.  And doesn't
  -:  ----------- > 33:  e32ba686f7e fsmonitor: handle shortname for .git
  -:  ----------- > 34:  627e27fe60b t7527: test FS event reporing on MacOS WRT case and Unicode

-- 
gitgitgadget
