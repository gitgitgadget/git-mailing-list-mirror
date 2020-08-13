Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AFEC433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1598620791
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="uUmHyML1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMPIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgHMPIm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 11:08:42 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6626BC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 08:08:42 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id w2so2750084qvh.12
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bJ1HU5FCGsBoGksmsADtMsXbsmgvkos3/tDqZFK4NZ0=;
        b=uUmHyML1N3i/ivHp05dYLuHXhh67aEqL2fBpmp++89bkj0+T57VUE8FzveCRcdKAPF
         lIYmsA184/PuUIQVdcPgXph1nQFi+TlQMhsCuxiyJAZ+7vlkb+HxPY5lJ+I+pSDqMO34
         CLzyB00v2GWvWrTkxL8fsmsyeBaij+/wXzJVXKzZSnDIgTTpUWMnd9eexk0LL4jao9eQ
         vUoOrzS9B6KH8y4ElxjgwopZe3sU500pTNsEcb+3zybwn0YSafgh9M7YsYxt8R42vLYE
         XUS5iqG4w/GSJSnchaHtYP59VTVmIpappPoCbeCGEdnvlVskAVb7AHyA2Nz5rTJYQFp9
         6TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bJ1HU5FCGsBoGksmsADtMsXbsmgvkos3/tDqZFK4NZ0=;
        b=Et7ENjVvr2eUSw1vZj1WGqb3Z0mYuyxXQ2AUHz9sjJKK3j57f/vsEf80ZaSYKam7gx
         Uk3DVHDaM033v1ndSdbrm+gexDKMbXD0lY+2DgVThiiuJv//7w1WZsl80Hx12nmadkkp
         vwuXlIYnkQyCw+tkVgi6DbvdiERbNX4fC7IwPsNqSe+8gZ6n2NR0QCzfULU5oACxs69a
         iVM1PAyF/wUHi9visKDb8G7ABhAf6CM4c+bO0OpV4v/C5enJeVEcMb50fjIew2uKISLG
         zkJNZ5KvXzjqY19lE5aFT5FjVsU7bQhcMZzheuMZGNoj7A6pEYaoEmZiuH/hGA7ISinb
         J6nw==
X-Gm-Message-State: AOAM5333N8FDFzuRB0HDf/WtOPfb+LRWL6C20jSBJ86LdPGTl8wbfF6l
        YtmcubOCE6gqL5rkV5pr+w7hCLjw8cepZw==
X-Google-Smtp-Source: ABdhPJwAijCyQfAOe29ZpaZyHHQdIpEn0u8GCWz7O2LtAeAK2RkTNDpkP/Ft9WSzXYquE+51kn24Hg==
X-Received: by 2002:ad4:54d4:: with SMTP id j20mr5056487qvx.6.1597331321388;
        Thu, 13 Aug 2020 08:08:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:cdcd:c658:5bb1:ebc9])
        by smtp.gmail.com with ESMTPSA id f31sm7297353qte.35.2020.08.13.08.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 08:08:40 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:08:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] make credential helpers builtins
Message-ID: <20200813150839.GB2244@syl.lan>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145855.GB891370@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813145855.GB891370@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 10:58:55AM -0400, Jeff King wrote:
> There's no real reason for credential helpers to be separate binaries. I
> did them this way originally under the notion that helper don't _need_
> to be part of Git, and so can be built totally separately (and indeed,
> the ones in contrib/credential are). But the ones in our main Makefile
> build on libgit.a, and the resulting binaries are reasonably large.

Could you clarify which helpers you mean here? Git's own
credential-cache and store make sense to convert, but the helpers in
contrib definitely don't.

For what it's worth, I'm almost positive that you mean the in-tree
helpers (where in-tree means "in git.git but not in contrib"), in which
case I'm in favor of this direcftion.

> We can slim down our total disk footprint by just making them builtins.
> This reduces the size of:
>
>   make strip install
>
> from 29MB to 24MB on my Debian system.

Great.

> Note that credential-cache can't operate without support for Unix
> sockets. Currently we just don't build it at all when NO_UNIX_SOCKETS is
> set. We could continue that with conditionals in the Makefile and our
> list of builtins. But instead, let's build a dummy implementation that
> dies with an informative message. That has two advantages:
>
>   - it's simpler, because the conditional bits are all kept inside
>     the credential-cache source
>
>   - a user who is expecting it to exist will be told _why_ they can't
>     use it, rather than getting the "credential-cache is not a git
>     command" error which makes it look like the Git install is broken.
>
> Note that our dummy implementation does still respond to "-h" in order
> to appease t0012 (and this may be a little friendlier for users, as
> well).

Yep, that makes sense and I think this approach seems fine.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile                                      |  8 ++---
>  builtin.h                                     |  3 ++
>  .../credential-cache--daemon.c                | 29 ++++++++++++++++---
>  .../credential-cache.c                        | 29 ++++++++++++++++---
>  .../credential-store.c                        |  6 ++--
>  contrib/buildsystems/CMakeLists.txt           | 20 +------------
>  git.c                                         |  3 ++
>  7 files changed, 63 insertions(+), 35 deletions(-)
>  rename credential-cache--daemon.c => builtin/credential-cache--daemon.c (91%)
>  rename credential-cache.c => builtin/credential-cache.c (83%)
>  rename credential-store.c => builtin/credential-store.c (96%)
>
> diff --git a/Makefile b/Makefile
> index 271b96348e..5b43c0fafb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -672,7 +672,6 @@ EXTRA_PROGRAMS =
>  PROGRAMS += $(EXTRA_PROGRAMS)
>
>  PROGRAM_OBJS += bugreport.o
> -PROGRAM_OBJS += credential-store.o
>  PROGRAM_OBJS += daemon.o
>  PROGRAM_OBJS += fast-import.o
>  PROGRAM_OBJS += http-backend.o
> @@ -1052,6 +1051,9 @@ BUILTIN_OBJS += builtin/checkout-index.o
>  BUILTIN_OBJS += builtin/checkout.o
>  BUILTIN_OBJS += builtin/clean.o
>  BUILTIN_OBJS += builtin/clone.o
> +BUILTIN_OBJS += builtin/credential-cache.o
> +BUILTIN_OBJS += builtin/credential-cache--daemon.o
> +BUILTIN_OBJS += builtin/credential-store.o
>  BUILTIN_OBJS += builtin/column.o
>  BUILTIN_OBJS += builtin/commit-graph.o
>  BUILTIN_OBJS += builtin/commit-tree.o
> @@ -1634,11 +1636,8 @@ ifdef NO_INET_PTON
>  endif
>  ifdef NO_UNIX_SOCKETS
>  	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
> -	EXCLUDED_PROGRAMS += git-credential-cache git-credential-cache--daemon
>  else
>  	LIB_OBJS += unix-socket.o
> -	PROGRAM_OBJS += credential-cache.o
> -	PROGRAM_OBJS += credential-cache--daemon.o
>  endif
>
>  ifdef NO_ICONV
> @@ -2901,7 +2900,6 @@ ifdef MSVC
>  	# because it is just a copy/hardlink of git.exe, rather than a unique binary.
>  	$(INSTALL) git.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) git-shell.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
> -	$(INSTALL) git-credential-store.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) git-daemon.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) git-fast-import.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) git-http-backend.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> diff --git a/builtin.h b/builtin.h
> index a5ae15bfe5..4a0aed5448 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -138,6 +138,9 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix);
>  int cmd_config(int argc, const char **argv, const char *prefix);
>  int cmd_count_objects(int argc, const char **argv, const char *prefix);
>  int cmd_credential(int argc, const char **argv, const char *prefix);
> +int cmd_credential_cache(int argc, const char **argv, const char *prefix);
> +int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix);
> +int cmd_credential_store(int argc, const char **argv, const char *prefix);
>  int cmd_describe(int argc, const char **argv, const char *prefix);
>  int cmd_diff_files(int argc, const char **argv, const char *prefix);
>  int cmd_diff_index(int argc, const char **argv, const char *prefix);
> diff --git a/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> similarity index 91%
> rename from credential-cache--daemon.c
> rename to builtin/credential-cache--daemon.c
> index ec1271f89c..c61f123a3b 100644
> --- a/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -1,9 +1,12 @@
> -#include "cache.h"
> +#include "builtin.h"
> +#include "parse-options.h"
> +
> +#ifndef NO_UNIX_SOCKETS
> +
>  #include "config.h"
>  #include "tempfile.h"
>  #include "credential.h"
>  #include "unix-socket.h"
> -#include "parse-options.h"
>
>  struct credential_cache_entry {
>  	struct credential item;
> @@ -257,7 +260,7 @@ static void init_socket_directory(const char *path)
>  	free(path_copy);
>  }
>
> -int cmd_main(int argc, const char **argv)
> +int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
>  {
>  	struct tempfile *socket_file;
>  	const char *socket_path;
> @@ -275,7 +278,7 @@ int cmd_main(int argc, const char **argv)
>
>  	git_config_get_bool("credentialcache.ignoresighup", &ignore_sighup);
>
> -	argc = parse_options(argc, argv, NULL, options, usage, 0);
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
>  	socket_path = argv[0];
>
>  	if (!socket_path)
> @@ -295,3 +298,21 @@ int cmd_main(int argc, const char **argv)
>
>  	return 0;
>  }
> +
> +#else
> +
> +int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
> +{
> +	const char * const usage[] = {
> +		"git credential-cache--daemon [options] <action>",
> +		"",
> +		"credential-cache--daemon is disabled in this build of Git",
> +		NULL
> +	};
> +	struct option options[] = { OPT_END() };
> +
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +	die(_("credential-cache--daemon unavailable; no unix socket support"));
> +}
> +
> +#endif /* NO_UNIX_SOCKET */
> diff --git a/credential-cache.c b/builtin/credential-cache.c
> similarity index 83%
> rename from credential-cache.c
> rename to builtin/credential-cache.c
> index 1cccc3a0b9..d0fafdeb9e 100644
> --- a/credential-cache.c
> +++ b/builtin/credential-cache.c
> @@ -1,7 +1,10 @@
> -#include "cache.h"
> +#include "builtin.h"
> +#include "parse-options.h"
> +
> +#ifndef NO_UNIX_SOCKETS
> +
>  #include "credential.h"
>  #include "string-list.h"
> -#include "parse-options.h"
>  #include "unix-socket.h"
>  #include "run-command.h"
>
> @@ -96,7 +99,7 @@ static char *get_socket_path(void)
>  	return socket;
>  }
>
> -int cmd_main(int argc, const char **argv)
> +int cmd_credential_cache(int argc, const char **argv, const char *prefix)
>  {
>  	char *socket_path = NULL;
>  	int timeout = 900;
> @@ -113,7 +116,7 @@ int cmd_main(int argc, const char **argv)
>  		OPT_END()
>  	};
>
> -	argc = parse_options(argc, argv, NULL, options, usage, 0);
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
>  	if (!argc)
>  		usage_with_options(usage, options);
>  	op = argv[0];
> @@ -134,3 +137,21 @@ int cmd_main(int argc, const char **argv)
>
>  	return 0;
>  }
> +
> +#else
> +
> +int cmd_credential_cache(int argc, const char **argv, const char *prefix)
> +{
> +	const char * const usage[] = {
> +		"git credential-cache [options] <action>",
> +		"",
> +		"credential-cache is disabled in this build of Git",
> +		NULL
> +	};
> +	struct option options[] = { OPT_END() };
> +
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +	die(_("credential-cache unavailable; no unix socket support"));
> +}
> +
> +#endif /* NO_UNIX_SOCKETS */
> diff --git a/credential-store.c b/builtin/credential-store.c
> similarity index 96%
> rename from credential-store.c
> rename to builtin/credential-store.c
> index 294e771681..5331ab151a 100644
> --- a/credential-store.c
> +++ b/builtin/credential-store.c
> @@ -1,4 +1,4 @@
> -#include "cache.h"
> +#include "builtin.h"
>  #include "lockfile.h"
>  #include "credential.h"
>  #include "string-list.h"
> @@ -143,7 +143,7 @@ static void lookup_credential(const struct string_list *fns, struct credential *
>  			return; /* Found credential */
>  }
>
> -int cmd_main(int argc, const char **argv)
> +int cmd_credential_store(int argc, const char **argv, const char *prefix)
>  {
>  	const char * const usage[] = {
>  		"git credential-store [<options>] <action>",
> @@ -161,7 +161,7 @@ int cmd_main(int argc, const char **argv)
>
>  	umask(077);
>
> -	argc = parse_options(argc, (const char **)argv, NULL, options, usage, 0);
> +	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
>  	if (argc != 1)
>  		usage_with_options(usage, options);
>  	op = argv[0];
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 47215df25b..4be61247e5 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -501,15 +501,9 @@ unset(CMAKE_REQUIRED_INCLUDES)
>
>  #programs
>  set(PROGRAMS_BUILT
> -	git git-bugreport git-credential-store git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
> +	git git-bugreport git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
>  	git-shell git-remote-testsvn)
>
> -if(NO_UNIX_SOCKETS)
> -	list(APPEND excluded_progs git-credential-cache git-credential-cache--daemon)
> -else()
> -	list(APPEND PROGRAMS_BUILT git-credential-cache git-credential-cache--daemon)
> -endif()
> -
>  if(NOT CURL_FOUND)
>  	list(APPEND excluded_progs git-http-fetch git-http-push)
>  	add_compile_definitions(NO_CURL)
> @@ -633,9 +627,6 @@ target_link_libraries(git common-main)
>  add_executable(git-bugreport ${CMAKE_SOURCE_DIR}/bugreport.c)
>  target_link_libraries(git-bugreport common-main)
>
> -add_executable(git-credential-store ${CMAKE_SOURCE_DIR}/credential-store.c)
> -target_link_libraries(git-credential-store common-main)
> -
>  add_executable(git-daemon ${CMAKE_SOURCE_DIR}/daemon.c)
>  target_link_libraries(git-daemon common-main)
>
> @@ -672,15 +663,6 @@ endif()
>  add_executable(git-remote-testsvn ${CMAKE_SOURCE_DIR}/remote-testsvn.c)
>  target_link_libraries(git-remote-testsvn common-main vcs-svn)
>
> -if(NOT NO_UNIX_SOCKETS)
> -	add_executable(git-credential-cache ${CMAKE_SOURCE_DIR}/credential-cache.c)
> -	target_link_libraries(git-credential-cache common-main)
> -
> -	add_executable(git-credential-cache--daemon ${CMAKE_SOURCE_DIR}/credential-cache--daemon.c)
> -	target_link_libraries(git-credential-cache--daemon common-main)
> -endif()
> -
> -
>  set(git_builtin_extra
>  	cherry cherry-pick format-patch fsck-objects
>  	init merge-subtree restore show
> diff --git a/git.c b/git.c
> index 8bd1d7551d..39a160fa52 100644
> --- a/git.c
> +++ b/git.c
> @@ -499,6 +499,9 @@ static struct cmd_struct commands[] = {
>  	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
>  	{ "count-objects", cmd_count_objects, RUN_SETUP },
>  	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
> +	{ "credential-cache", cmd_credential_cache },
> +	{ "credential-cache--daemon", cmd_credential_cache_daemon },
> +	{ "credential-store", cmd_credential_store },
>  	{ "describe", cmd_describe, RUN_SETUP },
>  	{ "diff", cmd_diff, NO_PARSEOPT },
>  	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
> --
> 2.28.0.573.gec6564704b
>
Thanks,
Taylor
