Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597BDC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347030AbiDRR0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347007AbiDRR0p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:26:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC9C33E24
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso12136925wme.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LAvTaXAvKL5ezrbSDRR+msYEp5RzIEW5X53CXkBmELM=;
        b=ZMIPzGjFzsmSmX8rXmXonvDJj6BkI02dzGfusAFCsHVGfVt91eKc9aJcxUJoDG26FG
         m6E2EOLoNydaMi0uvQgMzCvLK29RIw8KiA+bSPtWQ37bRTgg8hZZCBjTCNlsa2L6BIxx
         tD3FeZVr3k2nFhx9qARTvY5IZwxgeqIQsoRDCN0iJG/fcMgDM1i+uuwvPTPbEsiBKV7h
         vgk3i2NWHGadljvTk69JIv0zrN70OKoiGZBaiY0DUe5gE+GIQb7p5R7OGydXvVdjZvzt
         gng4J/e/Xogp6dlww4UA0Y+qXXONGfubscF7DkuCOE19cnc+V5AfE5f986D18xqRFoTp
         F42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LAvTaXAvKL5ezrbSDRR+msYEp5RzIEW5X53CXkBmELM=;
        b=urrlBD58igsW/dhXTcos0jKBOgpaPFOvR+cpGoghwl1bk0Dh7jgbmmWSEwC27TnXoQ
         gYwsjh1KOfVZT3zVAgxDP7PhLpfSyqK4DE155r1QI/wPwjNFZKCHAPcWMljMiI1dkTse
         81x7ob9i6kfvARj76Km+cs/RJFik6g08m7OwwNvE/60XOi5j+c6k3wWQVI4JuiUubcWw
         n3/BVyCb6noOo77So2JPboRCxPg+AZniJUxBpNO2QiPzOfgrD/JNKVksrdTVr9/5u1yJ
         wxu0T7wp/aT1vXgcCE1KTtzLkO+Pokjp8S2a0SZS5eSB9mhD8nIqUt61Vin7k8p0iJTO
         OrnQ==
X-Gm-Message-State: AOAM533024dSNyXOJCROg6LSnKEQ+ufw3LG7AZD7Nu9Wk+NBfPWqeR0F
        YXRDxPUwYX8uk86L2Yetr3NRxTk4zw3HxA==
X-Google-Smtp-Source: ABdhPJybfce89Y3GRXBDGju/Hmd03SVMy7bIqgg2bHFuaB1isfr8AiGdMmhuoKfrRrhbVShPZX2PLQ==
X-Received: by 2002:a05:600c:1993:b0:392:90f1:66ec with SMTP id t19-20020a05600c199300b0039290f166ecmr8901778wmq.146.1650302640954;
        Mon, 18 Apr 2022 10:24:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 00/36] bundle-uri: a "dumb CDN" for git + TOC format
Date:   Mon, 18 Apr 2022 19:23:17 +0200
Message-Id: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This RFC series is a start at trying to combine the two differing RFC
versions of bundle URIs I [1] and Derrick Stolee [2] were kicking
around.

= Layout

This series arranged in the following way:

* 01-08: "Prep" patches from both [1] and [2] which in principle could
  graduate first to "master".

  I.e. they're prep fixes added for the two bundle-uri
  implementations, but which either justify themselves, or e.g. expose
  a now-static function via an API.

  I tried to move things into the "justify themselves" category
  whenever possible, but may have overdone it e.g. for 02/36
  (originally an idea/commit of Derrick's, but I changed the
  authorship as pretty much all of it at this point is something I
  changed).

  For the "prep" changes that are only needed for later changes in the
  series perhaps we should just squash them if they're small enough.

* 09-16: My RFC series at [1], minus things extracted to the below and
  docs (see below).

* 17-33: Derrick's RFC series at [2], minos <ditto above>

* 34-36: I peeled off the Documentation/technical/bundle-uri.txt from
  both to put at the end, and renamed Derrick's to
  "bundle-uri-TOC.txt" so most of the change wouldn't be a massive
  diff.

  These obviously need to be unified too, but I figured doing so was
  better once we shake out what features/interfaces we want to keep.

= Overall state

Derrick: Sorry about the long delay in submitting this. I spent a lot
of time trying to get further in semantically merging the two in terms
of getting some some sensible user-usable end-result, but ultimately
wasn't happy with how opinionated that result was without looping you
in earlier.

So I figured that a better start was a a version of this where we
could test the two against one another, see where feature
differences/parity etc. were, and depending on those discussions
eventually unify the config, tests, features etc. for the two.

= About the range-diff

The range-diff was produced by rebasing my [1] on "master", fixing
conflicts, then rebasing a version of Derrick's [2] on it where I'd
munged it in some minimal way to reduce conflicts between the two, but
without "really" changing anything (mainly moving added functions to
slightly different places in the same files to reduce textual
conflicts).

When in doubt don't trust the range-diff, I figured it was better than
not including one at all, and it does a good job of pointing towards
the main areas of differences v.s. [1] and [2]. But it's not "real",
and will e.g. omit changes I made while getting to the point where I
could run the range-diff at all...

= Outstanding issues

Aside from the large issue of needing to more sensibly combine these
two, there are:

 * A CI failure on Windows: https://github.com/avar/git/actions/runs/2184857264

   This is in my [1], the implementation currently shells out to
   "curl", which is failing somehow. Note that the tests are "failing"
   on e.g. linux-musl too in that there's no /usr/bin/curl there, but
   in a way where they'll recover and fall back to a non-bundle-uri
   clone. So the same tests are testing graceful recovery elsewhere.

 * I didn't include the "incremental" fetch in my version. As noted in
   "overall state" I figured starting with a smaller version in this
   already-huge 33-patch series was better, and while I have that
   locally adding it is even more code...

1. https://lore.kernel.org/git/RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com/
2. https://lore.kernel.org/git/pull.1160.git.1645641063.gitgitgadget@gmail.com/

Derrick Stolee (21):
  http: make http_get_file() external
  remote: move relative_url()
  remote: allow relative_url() to return an absolute url
  remote-curl: add 'get' capability
  bundle: implement 'fetch' command for direct bundles
  bundle: parse table of contents during 'fetch'
  bundle: add --filter option to 'fetch'
  bundle: allow relative URLs in table of contents
  bundle: make it easy to call 'git bundle fetch'
  clone: add --bundle-uri option
  clone: --bundle-uri cannot be combined with --depth
  bundle: only fetch bundles if timestamp is new
  fetch: fetch bundles before fetching original data
  protocol-caps: implement cap_features()
  serve: understand but do not advertise 'features' capability
  serve: advertise 'features' when config exists
  connect: implement get_recommended_features()
  transport: add connections for 'features' capability
  clone: use server-recommended bundle URI
  t5601: basic bundle URI test
  docs: document bundle URI standard

Ævar Arnfjörð Bjarmason (15):
  connect.c: refactor sending of agent & object-format
  dir API: add a generalized path_match_flags() function
  fetch-pack: add a deref_without_lazy_fetch_extended()
  fetch-pack: move --keep=* option filling to a function
  bundle.h: make "fd" version of read_bundle_header() public
  protocol v2: add server-side "bundle-uri" skeleton
  bundle-uri client: add "bundle-uri" parsing + tests
  bundle-uri client: add minimal NOOP client
  bundle-uri client: add "git ls-remote-bundle-uri"
  bundle-uri client: add transfer.injectBundleURI support
  bundle-uri client: add boolean transfer.bundleURI setting
  bundle-uri client: support for bundle-uri with "clone"
  bundle-uri: make the download program configurable
  protocol v2: add server-side "bundle-uri" skeleton (docs)
  bundle-uri docs: add design notes

 Documentation/config/transfer.txt          |  33 ++
 Documentation/git-bundle.txt               |   1 +
 Documentation/git-ls-remote-bundle-uri.txt |  62 +++
 Documentation/git-ls-remote.txt            |   1 +
 Documentation/gitremote-helpers.txt        |   6 +
 Documentation/technical/bundle-uri-TOC.txt | 404 +++++++++++++++++
 Documentation/technical/bundle-uri.txt     | 119 +++++
 Documentation/technical/protocol-v2.txt    | 214 +++++++++
 Makefile                                   |   3 +
 builtin.h                                  |   1 +
 builtin/bundle.c                           | 481 +++++++++++++++++++++
 builtin/clone.c                            |  57 +++
 builtin/fetch.c                            |  17 +
 builtin/ls-remote-bundle-uri.c             |  90 ++++
 builtin/submodule--helper.c                | 141 +-----
 bundle-uri.c                               | 183 ++++++++
 bundle-uri.h                               |  29 ++
 bundle.c                                   |  29 +-
 bundle.h                                   |  11 +
 command-list.txt                           |   1 +
 compat/mingw.c                             |   2 +-
 compat/win32/path-utils.h                  |   6 +-
 connect.c                                  | 116 ++++-
 dir.c                                      |  29 ++
 dir.h                                      |  63 +++
 fetch-pack.c                               | 306 ++++++++++++-
 fetch-pack.h                               |   6 +
 fsck.c                                     |  23 +-
 git-compat-util.h                          |   8 +-
 git.c                                      |   1 +
 http.c                                     |   4 +-
 http.h                                     |   9 +
 path.c                                     |   2 +-
 protocol-caps.c                            |  66 +++
 protocol-caps.h                            |   1 +
 remote-curl.c                              |  32 ++
 remote.c                                   |  99 +++++
 remote.h                                   |  40 ++
 serve.c                                    |  29 ++
 submodule-config.c                         |   6 +-
 t/helper/test-bundle-uri.c                 |  83 ++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/lib-t5730-protocol-v2-bundle-uri.sh      | 458 ++++++++++++++++++++
 t/t5601-clone.sh                           |  15 +
 t/t5701-git-serve.sh                       | 133 +++++-
 t/t5730-protocol-v2-bundle-uri-file.sh     |  36 ++
 t/t5731-protocol-v2-bundle-uri-git.sh      |  17 +
 t/t5732-protocol-v2-bundle-uri-http.sh     |  17 +
 t/t5750-bundle-uri-parse.sh                | 153 +++++++
 transport-helper.c                         |  26 ++
 transport-internal.h                       |  16 +
 transport.c                                | 158 +++++++
 transport.h                                |  27 ++
 54 files changed, 3680 insertions(+), 192 deletions(-)
 create mode 100644 Documentation/git-ls-remote-bundle-uri.txt
 create mode 100644 Documentation/technical/bundle-uri-TOC.txt
 create mode 100644 Documentation/technical/bundle-uri.txt
 create mode 100644 builtin/ls-remote-bundle-uri.c
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100644 t/lib-t5730-protocol-v2-bundle-uri.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh
 create mode 100755 t/t5750-bundle-uri-parse.sh

Range-diff against v1:
 4:  034d371472e =  1:  95c53a3e779 connect.c: refactor sending of agent & object-format
15:  02563939040 !  2:  8f6e4f12e8a dir: extract starts_with_dot[_dot]_slash()
    @@
      ## Metadata ##
    -Author: Derrick Stolee <derrickstolee@github.com>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    dir: extract starts_with_dot[_dot]_slash()
    +    dir API: add a generalized path_match_flags() function
     
    -    We will want to use this logic to assist checking if paths are absolute
    -    or relative, so extract it into a helpful place. This creates a
    -    collision with similar methods in builtin/fsck.c, but those methods have
    -    important differences. Prepend "fsck_" to those methods to emphasize
    -    that they are custom to the fsck builtin.
    +    Add a path_match_flags() function and have the two sets of
    +    starts_with_dot_{,dot_}slash() functions added in
    +    63e95beb085 (submodule: port resolve_relative_url from shell to C,
    +    2016-04-15) and a2b26ffb1a8 (fsck: convert gitmodules url to URL
    +    passed to curl, 2020-04-18) be thin wrappers for it.
    +
    +    As the latter of those notes the fsck version was copied from the
    +    initial builtin/submodule--helper.c version.
    +
    +    Since the code added in a2b26ffb1a8 was doing really doing the same as
    +    win32_is_dir_sep() added in 1cadad6f658 (git clone <url>
    +    C:\cygwin\home\USER\repo' is working (again), 2018-12-15) let's move
    +    the latter to git-compat-util.h is a is_xplatform_dir_sep(). We can
    +    then call either it or the platform-specific is_dir_sep() from this
    +    new function.
    +
    +    Let's likewise change code in various other places that was hardcoding
    +    checks for "'/' || '\\'" with the new is_xplatform_dir_sep(). As can
    +    be seen in those callers some of them still concern themselves with
    +    ':' (Mac OS classic?), but let's leave the question of whether that
    +    should be consolidated for some other time.
    +
    +    As we expect to make wider use of the "native" case in the future,
    +    define and use two starts_with_dot_{,dot_}slash_native() convenience
    +    wrappers. This makes the diff in builtin/submodule--helper.c much
    +    smaller.
     
         Signed-off-by: Derrick Stolee <derrickstolee@github.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static char *get_default_remote(void)
    @@ builtin/submodule--helper.c: static char *get_default_remote(void)
      /*
       * Returns 1 if it was the last chop before ':'.
       */
    +@@ builtin/submodule--helper.c: static int chop_last_dir(char **remoteurl, int is_relative)
    + 	return 0;
    + }
    + 
    ++static int starts_with_dot_slash(const char *const path)
    ++{
    ++	return starts_with_dot_slash_native(path);;
    ++}
    ++
    ++static int starts_with_dot_dot_slash(const char *const path)
    ++{
    ++	return starts_with_dot_dot_slash_native(path);
    ++}
    ++
    + /*
    +  * The `url` argument is the URL that navigates to the submodule origin
    +  * repo. When relative, this URL is relative to the superproject origin
    +
    + ## compat/mingw.c ##
    +@@ compat/mingw.c: int is_valid_win32_path(const char *path, int allow_literal_nul)
    + 			}
    + 
    + 			c = path[i];
    +-			if (c && c != '.' && c != ':' && c != '/' && c != '\\')
    ++			if (c && c != '.' && c != ':' && !is_xplatform_dir_sep(c))
    + 				goto not_a_reserved_name;
    + 
    + 			/* contains reserved name */
    +
    + ## compat/win32/path-utils.h ##
    +@@ compat/win32/path-utils.h: int win32_has_dos_drive_prefix(const char *path);
    + 
    + int win32_skip_dos_drive_prefix(char **path);
    + #define skip_dos_drive_prefix win32_skip_dos_drive_prefix
    +-static inline int win32_is_dir_sep(int c)
    +-{
    +-	return c == '/' || c == '\\';
    +-}
    +-#define is_dir_sep win32_is_dir_sep
    ++#define is_dir_sep is_xplatform_dir_sep
    + static inline char *win32_find_last_dir_sep(const char *path)
    + {
    + 	char *ret = NULL;
    +
    + ## dir.c ##
    +@@ dir.c: void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_
    + 
    + 	connect_work_tree_and_git_dir(path, new_git_dir, 0);
    + }
    ++
    ++int path_match_flags(const char *const str, const enum path_match_flags flags)
    ++{
    ++	const char *p = str;
    ++
    ++	if (flags & PATH_MATCH_NATIVE &&
    ++	    flags & PATH_MATCH_XPLATFORM)
    ++		BUG("path_match_flags() must get one match kind, not multiple!");
    ++	else if (!(flags & PATH_MATCH_KINDS_MASK))
    ++		BUG("path_match_flags() must get at least one match kind!");
    ++
    ++	if (flags & PATH_MATCH_STARTS_WITH_DOT_SLASH &&
    ++	    flags & PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH)
    ++		BUG("path_match_flags() must get one platform kind, not multiple!");
    ++	else if (!(flags & PATH_MATCH_PLATFORM_MASK))
    ++		BUG("path_match_flags() must get at least one platform kind!");
    ++
    ++	if (*p++ != '.')
    ++		return 0;
    ++	if (flags & PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH &&
    ++	    *p++ != '.')
    ++		return 0;
    ++
    ++	if (flags & PATH_MATCH_NATIVE)
    ++		return is_dir_sep(*p);
    ++	else if (flags & PATH_MATCH_XPLATFORM)
    ++		return is_xplatform_dir_sep(*p);
    ++	BUG("unreachable");
    ++}
     
      ## dir.h ##
     @@ dir.h: void connect_work_tree_and_git_dir(const char *work_tree,
    @@ dir.h: void connect_work_tree_and_git_dir(const char *work_tree,
      		     const char *old_git_dir,
      		     const char *new_git_dir);
     +
    -+static inline int starts_with_dot_slash(const char *str)
    ++/**
    ++ * The "enum path_matches_kind" determines how path_match_flags() will
    ++ * behave. The flags come in sets, and one (and only one) must be
    ++ * provided out of each "set":
    ++ *
    ++ * PATH_MATCH_NATIVE:
    ++ *	Path separator is is_dir_sep()
    ++ * PATH_MATCH_XPLATFORM:
    ++ *	Path separator is is_xplatform_dir_sep()
    ++ *
    ++ * Do we use is_dir_sep() to check for a directory separator
    ++ * (*_NATIVE), or do we always check for '/' or '\' (*_XPLATFORM). The
    ++ * "*_NATIVE" version on Windows is the same as "*_XPLATFORM",
    ++ * everywhere else "*_NATIVE" means "only /".
    ++ *
    ++ * PATH_MATCH_STARTS_WITH_DOT_SLASH:
    ++ *	Match a path starting with "./"
    ++ * PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH:
    ++ *	Match a path starting with "../"
    ++ *
    ++ * The "/" in the above is adjusted based on the "*_NATIVE" and
    ++ * "*_XPLATFORM" flags.
    ++ */
    ++enum path_match_flags {
    ++	PATH_MATCH_NATIVE = 1 << 0,
    ++	PATH_MATCH_XPLATFORM = 1 << 1,
    ++	PATH_MATCH_STARTS_WITH_DOT_SLASH = 1 << 2,
    ++	PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH = 1 << 3,
    ++};
    ++#define PATH_MATCH_KINDS_MASK (PATH_MATCH_STARTS_WITH_DOT_SLASH | \
    ++	PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH)
    ++#define PATH_MATCH_PLATFORM_MASK (PATH_MATCH_NATIVE | PATH_MATCH_XPLATFORM)
    ++
    ++/**
    ++ * path_match_flags() checks if a given "path" matches a given "enum
    ++ * path_match_flags" criteria.
    ++ */
    ++int path_match_flags(const char *const path, const enum path_match_flags f);
    ++
    ++/**
    ++ * starts_with_dot_slash_native(): convenience wrapper for
    ++ * path_match_flags() with PATH_MATCH_STARTS_WITH_DOT_SLASH and
    ++ * PATH_MATCH_NATIVE.
    ++ */
    ++static inline int starts_with_dot_slash_native(const char *const path)
     +{
    -+	return str[0] == '.' && is_dir_sep(str[1]);
    ++	const enum path_match_flags what = PATH_MATCH_STARTS_WITH_DOT_SLASH;
    ++
    ++	return path_match_flags(path, what | PATH_MATCH_NATIVE);
     +}
     +
    -+static inline int starts_with_dot_dot_slash(const char *str)
    ++/**
    ++ * starts_with_dot_slash_native(): convenience wrapper for
    ++ * path_match_flags() with PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH and
    ++ * PATH_MATCH_NATIVE.
    ++ */
    ++static inline int starts_with_dot_dot_slash_native(const char *const path)
     +{
    -+	return str[0] == '.' && str[1] == '.' && is_dir_sep(str[2]);
    -+}
    ++	const enum path_match_flags what = PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH;
     +
    ++	return path_match_flags(path, what | PATH_MATCH_NATIVE);
    ++}
      #endif
     
      ## fsck.c ##
     @@ fsck.c: int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
    + 	return ret;
      }
      
    - /*
    +-/*
     - * Like builtin/submodule--helper.c's starts_with_dot_slash, but without
    -+ * Like dir.h's starts_with_dot_slash, but without
    -  * relying on the platform-dependent is_dir_sep helper.
    -  *
    -  * This is for use in checking whether a submodule URL is interpreted as
    -  * relative to the current directory on any platform, since \ is a
    -  * directory separator on Windows but not on other platforms.
    -  */
    +- * relying on the platform-dependent is_dir_sep helper.
    +- *
    +- * This is for use in checking whether a submodule URL is interpreted as
    +- * relative to the current directory on any platform, since \ is a
    +- * directory separator on Windows but not on other platforms.
    +- */
     -static int starts_with_dot_slash(const char *str)
    -+static int fsck_starts_with_dot_slash(const char *str)
    ++static int starts_with_dot_slash(const char *const path)
      {
    - 	return str[0] == '.' && (str[1] == '/' || str[1] == '\\');
    +-	return str[0] == '.' && (str[1] == '/' || str[1] == '\\');
    ++	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_SLASH |
    ++				PATH_MATCH_XPLATFORM);
      }
      
    - /*
    +-/*
     - * Like starts_with_dot_slash, this is a variant of submodule--helper's
     - * helper of the same name with the twist that it accepts backslash as a
    -+ * Like fsck_starts_with_dot_slash, this is a variant of dir.h's
    -+ * helper with the twist that it accepts backslash as a
    -  * directory separator even on non-Windows platforms.
    -  */
    +- * directory separator even on non-Windows platforms.
    +- */
     -static int starts_with_dot_dot_slash(const char *str)
    -+static int fsck_starts_with_dot_dot_slash(const char *str)
    ++static int starts_with_dot_dot_slash(const char *const path)
      {
     -	return str[0] == '.' && starts_with_dot_slash(str + 1);
    -+	return str[0] == '.' && fsck_starts_with_dot_slash(str + 1);
    ++	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH |
    ++				PATH_MATCH_XPLATFORM);
      }
      
      static int submodule_url_is_relative(const char *url)
    +
    + ## git-compat-util.h ##
    +@@
    + #include <sys/sysctl.h>
    + #endif
    + 
    ++/* Used by compat/win32/path-utils.h, and more */
    ++static inline int is_xplatform_dir_sep(int c)
    ++{
    ++	return c == '/' || c == '\\';
    ++}
    ++
    + #if defined(__CYGWIN__)
    + #include "compat/win32/path-utils.h"
    + #endif
    +@@ git-compat-util.h: static inline int git_skip_dos_drive_prefix(char **path)
    + #define skip_dos_drive_prefix git_skip_dos_drive_prefix
    + #endif
    + 
    +-#ifndef is_dir_sep
    + static inline int git_is_dir_sep(int c)
      {
    --	return starts_with_dot_slash(url) || starts_with_dot_dot_slash(url);
    -+	return fsck_starts_with_dot_slash(url) || fsck_starts_with_dot_dot_slash(url);
    + 	return c == '/';
      }
    ++#ifndef is_dir_sep
    + #define is_dir_sep git_is_dir_sep
    + #endif
      
    - /*
    +
    + ## path.c ##
    +@@ path.c: int is_ntfs_dotgit(const char *name)
    + 
    + 	for (;;) {
    + 		c = *(name++);
    +-		if (!c || c == '\\' || c == '/' || c == ':')
    ++		if (!c || is_xplatform_dir_sep(c) || c == ':')
    + 			return 1;
    + 		if (c != '.' && c != ' ')
    + 			return 0;
    +
    + ## submodule-config.c ##
    +@@ submodule-config.c: int check_submodule_name(const char *name)
    + 		return -1;
    + 
    + 	/*
    +-	 * Look for '..' as a path component. Check both '/' and '\\' as
    ++	 * Look for '..' as a path component. Check is_xplatform_dir_sep() as
    + 	 * separators rather than is_dir_sep(), because we want the name rules
    + 	 * to be consistent across platforms.
    + 	 */
    + 	goto in_component; /* always start inside component */
    + 	while (*name) {
    + 		char c = *name++;
    +-		if (c == '/' || c == '\\') {
    ++		if (is_xplatform_dir_sep(c)) {
    + in_component:
    + 			if (name[0] == '.' && name[1] == '.' &&
    +-			    (!name[2] || name[2] == '/' || name[2] == '\\'))
    ++			    (!name[2] || is_xplatform_dir_sep(name[2])))
    + 				return -1;
    + 		}
    + 	}
 9:  e93306308f9 =  3:  7823a177fd7 fetch-pack: add a deref_without_lazy_fetch_extended()
10:  d7633791083 =  4:  0315bda0dac fetch-pack: move --keep=* option filling to a function
18:  0bfc59ad308 =  5:  6e1f4296896 http: make http_get_file() external
16:  eea2816bc8f !  6:  97a9f38f08d remote: move relative_url()
    @@ Commit message
         similar functionality in the bundle URI feature, extract this to be
         available in remote.h.
     
    -    The code is exactly the same. The prototype is different only in
    -    whitespace. The documentation comment only adds explicit instructions on
    -    what happens when supplying two absolute URLs.
    +    The code is almost exactly the same, except for the following trivial
    +    differences:
    +
    +     * Fix whitespace and wrapping issues with the prototype and argument
    +       lists.
    +
    +     * Let's call starts_with_dot_{,dot_}slash_native() instead of the
    +       functionally identical "starts_with_dot_{,dot_}slash()" wrappers
    +       "builtin/submodule--helper.c".
     
         Signed-off-by: Derrick Stolee <derrickstolee@github.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static char *get_default_remote(void)
    @@ builtin/submodule--helper.c: static char *get_default_remote(void)
     -	return 0;
     -}
     -
    +-static int starts_with_dot_slash(const char *const path)
    +-{
    +-	return starts_with_dot_slash_native(path);;
    +-}
    +-
    +-static int starts_with_dot_dot_slash(const char *const path)
    +-{
    +-	return starts_with_dot_dot_slash_native(path);
    +-}
    +-
     -/*
     - * The `url` argument is the URL that navigates to the submodule origin
     - * repo. When relative, this URL is relative to the superproject origin
    @@ builtin/submodule--helper.c: static char *get_default_remote(void)
      static char *resolve_relative_url(const char *rel_url, const char *up_path, int quiet)
      {
      	char *remoteurl, *resolved_url;
    +@@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **argv, const char *prefix)
    + 	return 0;
    + }
    + 
    ++static int starts_with_dot_slash(const char *const path)
    ++{
    ++	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_SLASH |
    ++				PATH_MATCH_XPLATFORM);
    ++}
    ++
    ++static int starts_with_dot_dot_slash(const char *const path)
    ++{
    ++	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH |
    ++				PATH_MATCH_XPLATFORM);
    ++}
    ++
    + struct init_cb {
    + 	const char *prefix;
    + 	const char *superprefix;
     
      ## remote.c ##
     @@
    @@ remote.c: void remote_state_clear(struct remote_state *remote_state)
     +	return 0;
     +}
     +
    -+/*
    -+ * NEEDSWORK: Given how chop_last_dir() works, this function is broken
    -+ * when a local part has a colon in its path component, too.
    -+ */
    -+char *relative_url(const char *remote_url,
    -+		   const char *url,
    ++char *relative_url(const char *remote_url, const char *url,
     +		   const char *up_path)
     +{
     +	int is_relative = 0;
    @@ remote.c: void remote_state_clear(struct remote_state *remote_state)
     +		 * Prepend a './' to ensure all relative
     +		 * remoteurls start with './' or '../'
     +		 */
    -+		if (!starts_with_dot_slash(remoteurl) &&
    -+		    !starts_with_dot_dot_slash(remoteurl)) {
    ++		if (!starts_with_dot_slash_native(remoteurl) &&
    ++		    !starts_with_dot_dot_slash_native(remoteurl)) {
     +			strbuf_reset(&sb);
     +			strbuf_addf(&sb, "./%s", remoteurl);
     +			free(remoteurl);
    @@ remote.c: void remote_state_clear(struct remote_state *remote_state)
     +	 * last directory in remoteurl.
     +	 */
     +	while (url) {
    -+		if (starts_with_dot_dot_slash(url)) {
    ++		if (starts_with_dot_dot_slash_native(url)) {
     +			url += 3;
     +			colonsep |= chop_last_dir(&remoteurl, is_relative);
    -+		} else if (starts_with_dot_slash(url))
    ++		} else if (starts_with_dot_slash_native(url))
     +			url += 2;
     +		else
     +			break;
    @@ remote.c: void remote_state_clear(struct remote_state *remote_state)
     +		strbuf_setlen(&sb, sb.len - 1);
     +	free(remoteurl);
     +
    -+	if (starts_with_dot_slash(sb.buf))
    ++	if (starts_with_dot_slash_native(sb.buf))
     +		out = xstrdup(sb.buf + 2);
     +	else
     +		out = xstrdup(sb.buf);
    @@ remote.h: int parseopt_push_cas_option(const struct option *, const char *arg, i
     + * http://a.com/b  ../../../c       http:/c          error out
     + * http://a.com/b  ../../../../c    http:c           error out
     + * http://a.com/b  ../../../../../c    .:c           error out
    ++ * NEEDSWORK: Given how chop_last_dir() works, this function is broken
    ++ * when a local part has a colon in its path component, too.
     + */
    -+char *relative_url(const char *remote_url,
    -+		   const char *url,
    ++char *relative_url(const char *remote_url, const char *url,
     +		   const char *up_path);
     +
      #endif
17:  68b10e64382 !  7:  2917cdd8277 remote: allow relative_url() to return an absolute url
    @@ Commit message
         concatenate 'remote_url' with 'url'. Instead, we want to return 'url' in
         this case.
     
    +    The documentation now discusses what happens when supplying two
    +    absolute URLs.
    +
         Signed-off-by: Derrick Stolee <derrickstolee@github.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## remote.c ##
    -@@ remote.c: char *relative_url(const char *remote_url,
    +@@ remote.c: char *relative_url(const char *remote_url, const char *url,
      	int is_relative = 0;
      	int colonsep = 0;
      	char *out;
    @@ remote.h: void apply_push_cas(struct push_cas_option *, struct remote *, struct
       * http://a.com/b  ../../../../c    http:c           error out
       * http://a.com/b  ../../../../../c    .:c           error out
     + * http://a.com/b  http://d.org/e   http://d.org/e   as is
    +  * NEEDSWORK: Given how chop_last_dir() works, this function is broken
    +  * when a local part has a colon in its path component, too.
       */
    - char *relative_url(const char *remote_url,
    - 		   const char *url,
11:  1f5a48c712c =  8:  2b236af147b bundle.h: make "fd" version of read_bundle_header() public
 1:  3875bf2a294 !  9:  1496b89ea6a protocol v2: add server-side "bundle-uri" skeleton
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## Documentation/technical/protocol-v2.txt ##
    -@@ Documentation/technical/protocol-v2.txt: and associated requested information, each separated by a single space.
    - 	attr = "size"
    - 
    - 	obj-info = obj-id SP obj-size
    -+
    -+bundle-uri
    -+~~~~~~~~~~
    -+
    -+If the 'bundle-uri' capability is advertised, the server supports the
    -+`bundle-uri' command.
    -+
    -+The capability is currently advertised with no value (i.e. not
    -+"bundle-uri=somevalue"), a value may be added in the future for
    -+supporting command-wide extensions. Clients MUST ignore any unknown
    -+capability values and proceed with the 'bundle-uri` dialog they
    -+support.
    -+
    -+The 'bundle-uri' command is intended to be issued before `fetch` to
    -+get URIs to bundle files (see linkgit:git-bundle[1]) to "seed" and
    -+inform the subsequent `fetch` command.
    -+
    -+The client CAN issue `bundle-uri` before or after any other valid
    -+command. To be useful to clients it's expected that it'll be issued
    -+after an `ls-refs` and before `fetch`, but CAN be issued at any time
    -+in the dialog.
    -+
    -+DISCUSSION of bundle-uri
    -+^^^^^^^^^^^^^^^^^^^^^^^^
    -+
    -+The intent of the feature is optimize for server resource consumption
    -+in the common case by changing the common case of fetching a very
    -+large PACK during linkgit:git-clone[1] into a smaller incremental
    -+fetch.
    -+
    -+It also allows servers to achieve better caching in combination with
    -+an `uploadpack.packObjectsHook` (see linkgit:git-config[1]).
    -+
    -+By having new clones or fetches be a more predictable and common
    -+negotiation against the tips of recently produces *.bundle file(s).
    -+Servers might even pre-generate the results of such negotiations for
    -+the `uploadpack.packObjectsHook` as new pushes come in.
    -+
    -+I.e. the server would anticipate that fresh clones will download a
    -+known bundle, followed by catching up to the current state of the
    -+repository using ref tips found in that bundle (or bundles).
    -+
    -+PROTOCOL for bundle-uri
    -+^^^^^^^^^^^^^^^^^^^^^^^
    -+
    -+A `bundle-uri` request takes no arguments, and as noted above does not
    -+currently advertise a capability value. Both may be added in the
    -+future.
    -+
    -+When the client issues a `command=bundle-uri` the response is a list
    -+of URIs the server would like the client to fetch out-of-bounds before
    -+proceeding with the `fetch` request in this format:
    -+
    -+	output = bundle-uri-line
    -+		 bundle-uri-line* flush-pkt
    -+
    -+	bundle-uri-line = PKT-LINE(bundle-uri)
    -+			  *(SP bundle-feature-key *(=bundle-feature-val))
    -+			  LF
    -+
    -+	bundle-uri = A URI such as a https://, ssh:// etc. URI
    -+
    -+	bundle-feature-key = Any printable ASCII characters except SP or "="
    -+	bundle-feature-val = Any printable ASCII characters except SP or "="
    -+
    -+No `bundle-feature-key`=`bundle-feature-value` fields are currently
    -+defined. See the discussion of features below.
    -+
    -+Clients are still expected to fully parse the line according to the
    -+above format, lines that do not conform to the format SHOULD be
    -+discarded. The user MAY be warned in such a case.
    -+
    -+bundle-uri CLIENT AND SERVER EXPECTATIONS
    -+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    -+
    -+".bundle" FORMAT
    -+++++++++++++++++
    -+
    -+The advertised bundle(s) MUST be in a format that "git bundle verify"
    -+would accept. I.e. they MUST contain one or more reference tips for
    -+use by the client, MUST indicate prerequisites (in any) with standard
    -+"-" prefixes, and MUST indicate their "object-format", if
    -+applicable. Create "*.bundle" files with "git bundle create".
    -+
    -+bundle-uri CLIENT ERROR RECOVERY
    -+++++++++++++++++++++++++++++++++
    -+
    -+A client MUST above all gracefully degrade on errors, whether that
    -+error is because of bad missing/data in the bundle URI(s), because
    -+that client is too dumb to e.g. understand and fully parse out bundle
    -+headers and their prerequisite relationships, or something else.
    -+
    -+Server operators should feel confident in turning on "bundle-uri" and
    -+not worry if e.g. their CDN goes down that clones or fetches will run
    -+into hard failures. Even if the server bundle bundle(s) are
    -+incomplete, or bad in some way the client should still end up with a
    -+functioning repository, just as if it had chosen not to use this
    -+protocol extension.
    -+
    -+All subsequent discussion on client and server interaction MUST keep
    -+this in mind.
    -+
    -+bundle-uri SERVER TO CLIENT
    -++++++++++++++++++++++++++++
    -+
    -+The ordering of the returned bundle uris is not significant. Clients
    -+MUST parse their headers to discover their contained OIDS and
    -+prerequisites. A client MUST consider the content of the bundle(s)
    -+themselves and their header as the ultimate source of truth.
    -+
    -+A server MAY even return bundle(s) that don't have any direct
    -+relationship to the repository being cloned (either through accident,
    -+or intentional "clever" configuration), and expect a client to sort
    -+out what data they'd like from the bundle(s), if any.
    -+
    -+bundle-uri CLIENT TO SERVER
    -++++++++++++++++++++++++++++
    -+
    -+The client SHOULD provide reference tips found in the bundle header(s)
    -+as 'have' lines in any subsequent `fetch` request. A client MAY also
    -+ignore the bundle(s) entirely if doing so is deemed worse for some
    -+reason, e.g. if the bundles can't be downloaded, it doesn't like the
    -+tips it finds etc.
    -+
    -+WHEN ADVERTISED BUNDLE(S) REQUIRE NO FURTHER NEGOTIATION
    -+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    -+
    -+If after issuing `bundle-uri` and `ls-refs`, and getting the header(s)
    -+of the bundle(s) the client finds that the ref tips it wants can be
    -+retrieved entirety from advertised bundle(s), it MAY disconnect. The
    -+results of such a 'clone' or 'fetch' should be indistinguishable from
    -+the state attained without using bundle-uri.
    -+
    -+EARLY CLIENT DISCONNECTIONS AND ERROR RECOVERY
    -+++++++++++++++++++++++++++++++++++++++++++++++
    -+
    -+A client MAY perform an early disconnect while still downloading the
    -+bundle(s) (having streamed and parsed their headers). In such a case
    -+the client MUST gracefully recover from any errors related to
    -+finishing the download and validation of the bundle(s).
    -+
    -+I.e. a client might need to re-connect and issue a 'fetch' command,
    -+and possibly fall back to not making use of 'bundle-uri' at all.
    -+
    -+This "MAY" behavior is specified as such (and not a "SHOULD") on the
    -+assumption that a server advertising bundle uris is more likely than
    -+not to be serving up a relatively large repository, and to be pointing
    -+to URIs that have a good chance of being in working order. A client
    -+MAY e.g. look at the payload size of the bundles as a heuristic to see
    -+if an early disconnect is worth it, should falling back on a full
    -+"fetch" dialog be necessary.
    -+
    -+WHEN ADVERTISED BUNDLE(S) REQUIRE FURTHER NEGOTIATION
    -++++++++++++++++++++++++++++++++++++++++++++++++++++++
    -+
    -+A client SHOULD commence a negotiation of a PACK from the server via
    -+the "fetch" command using the OID tips found in advertised bundles,
    -+even if's still in the process of downloading those bundle(s).
    -+
    -+This allows for aggressive early disconnects from any interactive
    -+server dialog. The client blindly trusts that the advertised OID tips
    -+are relevant, and issues them as 'have' lines, it then requests any
    -+tips it would like (usually from the "ls-refs" advertisement) via
    -+'want' lines. The server will then compute a (hopefully small) PACK
    -+with the expected difference between the tips from the bundle(s) and
    -+the data requested.
    -+
    -+The only connection the client then needs to keep active is to the
    -+concurrently downloading static bundle(s), when those and the
    -+incremental PACK are retrieved they should be inflated and
    -+validated. Any errors at this point should be gracefully recovered
    -+from, see above.
    -+
    -+bundle-uri PROTOCOL FEATURES
    -+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    -+
    -+As noted above no `bundle-feature-key`=`bundle-feature-value` fields
    -+are currently defined.
    -+
    -+They are intended for future per-URI metadata which older clients MUST
    -+ignore and gracefully degrade on. Any fields they do recognize they
    -+CAN also ignore.
    -+
    -+Any backwards-incompatible addition of pre-URI key-value will be
    -+guarded by a new value or values in 'bundle-uri' capability
    -+advertisement itself, and/or by new future `bundle-uri` request
    -+arguments.
    -+
    -+While no per-URI key-value are currently supported currently they're
    -+intended to support future features such as:
    -+
    -+ * Add a "hash=<val>" or "size=<bytes>" advertise the expected hash or
    -+   size of the bundle file.
    -+
    -+ * Advertise that one or more bundle files are the same (to e.g. have
    -+   clients round-robin or otherwise choose one of N possible files).
    -+
    -+ * A "oid=<OID>" shortcut and "prerequisite=<OID>" shortcut. For
    -+   expressing the common case of a bundle with one tip and no
    -+   prerequisites, or one tip and one prerequisite.
    -++
    -+This would allow for optimizing the common case of servers who'd like
    -+to provide one "big bundle" containing only their "main" branch,
    -+and/or incremental updates thereof.
    -++
    -+A client receiving such a a response MAY assume that they can skip
    -+retrieving the header from a bundle at the indicated URI, and thus
    -+save themselves and the server(s) the request(s) needed to inspect the
    -+headers of that bundle or bundles.
    -
      ## Makefile ##
     @@ Makefile: LIB_OBJS += blob.o
      LIB_OBJS += bloom.o
 3:  edff9c34c0f ! 10:  2a487981328 bundle-uri client: add "bundle-uri" parsing + tests
    @@ bundle-uri.c: int bundle_uri_command(struct repository *r,
     +			BUG("should have no fields=0");
     +		case 1:
     +			if (!strlen(arg)) {
    -+				err = error("bundle-uri: column %lu: got an empty attribute (full line was '%s')",
    -+					    i, line);
    ++				err = error("bundle-uri: column %"PRIuMAX": got an empty attribute (full line was '%s')",
    ++					    (uintmax_t)i, line);
     +				break;
     +			}
     +			/*
    @@ bundle-uri.c: int bundle_uri_command(struct repository *r,
     +			break;
     +		}
     +		default:
    -+			err = error("bundle-uri: column %lu: '%s' more than one '=' character (full line was '%s')",
    -+				    i, arg, line);
    ++			err = error("bundle-uri: column %"PRIuMAX": '%s' more than one '=' character (full line was '%s')",
    ++				    (uintmax_t)i, arg, line);
     +			break;
     +		}
     +
 5:  e3a235fb11a ! 11:  b85c2a1c0df bundle-uri client: add minimal NOOP client
    @@ t/lib-t5730-protocol-v2-bundle-uri.sh (new)
     +		;;
     +	*)
     +		grep "^fatal:" err >fatal.actual &&
    -+		test_cmp fatal.expect fatal.actual
    ++		# Due to the same race conditions this might be
    ++		# "fatal: read error: Connection reset by peer", "fatal: the remote end
    ++		# hung up unexpectedly" etc.
    ++		cat fatal.actual &&
    ++		test_file_not_empty fatal.actual
     +		;;
     +	esac &&
     +
 6:  9d67cb640c1 ! 12:  54149dcb0aa bundle-uri client: add "git ls-remote-bundle-uri"
    @@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success !T5730_HTTP "bad clie
     +
     +test_expect_success "ls-remote-bundle-uri --[no-]quiet with $T5730_PROTOCOL:// using protocol v2" '
     +	test_when_finished "rm -f log" &&
    -+
    -+	cat >err.expect <<-\EOF &&
    -+	Cloning into '"'"'child'"'"'...
    -+	EOF
    -+
     +	test_when_finished "rm -rf child" &&
    -+	GIT_TRACE_PACKET="$PWD/log" \
    ++	env GIT_TRACE_PACKET="$PWD/log" \
     +	git \
     +		-c protocol.version=2 \
    -+		 clone "$T5730_URI" child \
    -+		 >out 2>err.actual &&
    -+	test_cmp err.expect err.actual &&
    -+	test_must_be_empty out &&
    ++		 clone "$T5730_URI" child &&
     +
     +	test_config -C "$T5730_PARENT" uploadpack.bundleURI \
     +		"$T5730_BUNDLE_URI_ESCAPED" &&
 7:  f78d970975b = 13:  5c50daa92bb bundle-uri client: add transfer.injectBundleURI support
 8:  716470488c5 = 14:  e66aa1f18b4 bundle-uri client: add boolean transfer.bundleURI setting
12:  6176c4554ce ! 15:  f19d2bcbc66 bundle-uri client: support for bundle-uri with "clone"
    @@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success "ls-remote-bundle-uri
     +	test_cmp expect actual
     +}
     +
    -+test_expect_success "clone with bundle-uri protocol v2 over $T5730_PROTOCOL:// 1.bdl via $T5730_URI_BDL_PROTO" '
    ++show_cr () {
    ++	tr '\015' Q | sed -e "s/Q/<CR>\\$LF/g"
    ++}
    ++
    ++test_expect_success CURL "clone with bundle-uri protocol v2 over $T5730_PROTOCOL:// 1.bdl via $T5730_URI_BDL_PROTO" '
     +	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/1.bdl | test_uri_escape)" &&
     +
    -+	test_when_finished "rm -rf log child" &&
    ++	test_when_finished "rm -rf event log child" &&
    ++	GIT_TRACE2_EVENT="$PWD/event" \
     +	GIT_TRACE_PACKET="$PWD/log" \
     +	git \
     +		-c protocol.version=2 \
     +		-c fetch.uriProtocols=file,http \
     +		clone --verbose --verbose \
    -+		"$T5730_URI" child >out 2>err &&
    -+	grep -F "Receiving bundle (1/1)" err &&
    ++		"$T5730_URI" child &&
    ++	test_region progress "Receiving bundle (1/1)" event &&
     +	grep "clone> want " log &&
     +	test_cmp_repo_refs "$T5730_PARENT" child refs/heads refs/tags
     +'
    @@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success "ls-remote-bundle-uri
     +
     +	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/1.bdl | test_uri_escape)" &&
     +
    -+	test_when_finished "rm -rf log child" &&
    ++	test_when_finished "rm -rf event log child" &&
     +	git init --bare child &&
     +	git -C child remote add --mirror=fetch origin "$T5730_URI" &&
    ++
    ++	GIT_TRACE2_EVENT="$PWD/event" \
     +	GIT_TRACE_PACKET="$PWD/log" \
     +	git -C child \
     +		-c protocol.version=2 \
     +		-c fetch.uriProtocols=file,http \
    -+		fetch --verbose --verbose >out 2>err &&
    -+	# Fetch is not supported yet
    -+	! grep -F "Receiving bundle (1/1)" err &&
    -+	grep "fetch> want " log &&
    ++		fetch --verbose --verbose &&
    ++
    ++	if test_have_prereq CURL
    ++	then
    ++		# Fetch is not supported yet
    ++		! test_region progress "Receiving bundle (1/1)" event &&
    ++		grep "fetch> want " log
    ++	else
    ++		! grep "fetch-pack: unable to spawn" event
    ++	fi &&
    ++
     +	test_cmp_repo_refs "$T5730_PARENT" child refs/heads refs/tags
     +'
     +
    @@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success "ls-remote-bundle-uri
     +	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/2-3.bdl | test_uri_escape)" --add &&
     +	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/3-4.bdl | test_uri_escape)" --add &&
     +
    -+	test_when_finished "rm -rf log child" &&
    ++	test_when_finished "rm -rf event log child" &&
    ++	GIT_TRACE2_EVENT="$PWD/event" \
     +	GIT_TRACE_PACKET="$PWD/log" \
     +	git \
     +		-c protocol.version=2 \
     +		-c fetch.uriProtocols=file,http \
     +		clone --verbose --verbose \
    -+		"$T5730_URI" child >out 2>err &&
    -+	grep -F "Receiving bundle (4/4)" err &&
    ++		"$T5730_URI" child &&
    ++
    ++	if test_have_prereq CURL
    ++	then
    ++		test_region progress "Receiving bundle (1/4)" event &&
    ++		test_region progress "Receiving bundle (2/4)" event &&
    ++		test_region progress "Receiving bundle (3/4)" event &&
    ++		test_region progress "Receiving bundle (4/4)" event
    ++	else
    ++		grep "fetch-pack: unable to spawn" event
    ++	fi &&
    ++
     +	test_cmp_repo_refs "$T5730_PARENT" child refs/heads refs/tags &&
     +	grep "clone> want " log
     +'
    @@ t/lib-t5730-protocol-v2-bundle-uri.sh: test_expect_success "ls-remote-bundle-uri
     +	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/4-5.bdl | test_uri_escape)" --add &&
     +	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/5-6.bdl | test_uri_escape)" --add &&
     +
    -+	test_when_finished "rm -rf log child" &&
    ++	test_when_finished "rm -rf event log child" &&
    ++	GIT_TRACE2_EVENT="$PWD/event" \
     +	GIT_TRACE_PACKET="$PWD/log" \
     +	git \
     +		-c protocol.version=2 \
     +		-c fetch.uriProtocols=file,http \
     +		clone --verbose --verbose \
    -+		"$T5730_URI" child >out 2>err &&
    -+	grep -F "Receiving bundle (6/6)" err &&
    -+	test_cmp_repo_refs "$T5730_PARENT" child refs/heads refs/tags &&
    -+	! grep "clone> want " log
    ++		"$T5730_URI" child &&
    ++
    ++	if test_have_prereq CURL
    ++	then
    ++		test_region progress "Receiving bundle (1/6)" event &&
    ++		test_region progress "Receiving bundle (2/6)" event &&
    ++		test_region progress "Receiving bundle (3/6)" event &&
    ++		test_region progress "Receiving bundle (4/6)" event &&
    ++		test_region progress "Receiving bundle (5/6)" event &&
    ++		test_region progress "Receiving bundle (6/6)" event &&
    ++		! grep "clone> want " log
    ++	else
    ++		grep "fetch-pack: unable to spawn" event
    ++	fi &&
    ++
    ++	test_cmp_repo_refs "$T5730_PARENT" child refs/heads refs/tags
     +'
     
      ## transport.c ##
13:  be59495d81b = 16:  632c68b224f bundle-uri: make the download program configurable
19:  4398efebcec = 17:  8ac5bfca545 remote-curl: add 'get' capability
20:  5cbaa40b365 ! 18:  ff9a7afaccd bundle: implement 'fetch' command for direct bundles
    @@ Commit message
     
         Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     
    + ## Documentation/git-bundle.txt ##
    +@@ Documentation/git-bundle.txt: SYNOPSIS
    + 'git bundle' create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]
    + 		    [--version=<version>] <file> <git-rev-list-args>
    + 'git bundle' verify [-q | --quiet] <file>
    ++'git bundle' fetch [--filter=<spec>] <uri>
    + 'git bundle' list-heads <file> [<refname>...]
    + 'git bundle' unbundle [--progress] <file> [<refname>...]
    + 
    +
      ## builtin/bundle.c ##
     @@
      #include "parse-options.h"
21:  6c055bc2613 ! 19:  a5245a31a12 bundle: parse table of contents during 'fetch'
    @@ Commit message
         RFC-TODO: create tests that check these erroneous cases.
     
         Signed-off-by: Derrick Stolee <derrickstolee@github.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/bundle.c ##
     @@
    @@ builtin/bundle.c: struct remote_bundle_info {
     +	 */
     +	unsigned pushed:1;
      };
    - 
    ++#define REMOTE_BUNDLE_INFO_INIT { \
    ++	.file = STRBUF_INIT, \
    ++}
    ++
     +static int remote_bundle_cmp(const void *unused_cmp_data,
     +			     const struct hashmap_entry *a,
     +			     const struct hashmap_entry *b,
    @@ builtin/bundle.c: struct remote_bundle_info {
     +	struct hashmap *toc = data;
     +	const char *key1, *key2, *id_end;
     +	struct strbuf id = STRBUF_INIT;
    -+	struct remote_bundle_info info_lookup;
    ++	struct remote_bundle_info info_lookup = REMOTE_BUNDLE_INFO_INIT;
     +	struct remote_bundle_info *info;
     +
     +	if (!skip_prefix(key, "bundle.", &key1))
    @@ builtin/bundle.c: struct remote_bundle_info {
     +	/* Return 0 here to ignore unknown options. */
     +	return 0;
     +}
    -+
    + 
      static void download_uri_to_file(const char *uri, const char *file)
      {
    - 	struct child_process cp = CHILD_PROCESS_INIT;
     @@ builtin/bundle.c: static void unbundle_fetched_bundle(struct remote_bundle_info *info)
      
      static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
    @@ builtin/bundle.c: static int cmd_bundle_fetch(int argc, const char **argv, const
      			 * push it onto the stack.
      			 */
     +			struct remote_bundle_info *info;
    -+			struct remote_bundle_info info_lookup = { 0 };
    ++			struct remote_bundle_info info_lookup = REMOTE_BUNDLE_INFO_INIT;
     +			info_lookup.id = stack->requires_id;
     +
     +			hashmap_entry_init(&info_lookup.ent, strhash(info_lookup.id));
22:  af61b29a571 = 20:  c3a60a9bc72 bundle: add --filter option to 'fetch'
23:  de4845ef1c0 = 21:  c08406cd9c2 bundle: allow relative URLs in table of contents
24:  19d25702355 = 22:  1350c19c3a1 bundle: make it easy to call 'git bundle fetch'
25:  a20e4a5b207 ! 23:  62623324d2f clone: add --bundle-uri option
    @@ builtin/clone.c: static struct option builtin_clone_options[] = {
      	OPT_BOOL(0, "sparse", &option_sparse_checkout,
      		    N_("initialize sparse-checkout file to include only files at root")),
     +	OPT_STRING(0, "bundle-uri", &bundle_uri,
    -+		   N_("uri"), N_("A URI for downloading bundles before fetching from origin remote")),
    ++		   N_("uri"), N_("a URI for downloading bundles before fetching from origin remote")),
      	OPT_END()
      };
      
26:  277091d5eeb = 24:  d79901dddb0 clone: --bundle-uri cannot be combined with --depth
28:  7b414176313 ! 25:  ab349b1cbea bundle: only fetch bundles if timestamp is new
    @@ Commit message
     
         RFC-TODO: Add 'fetch.bundleTimestamp' to Documentation/config/
     
    +    RFC-TODO @ Ævar: I replaced the git_config_get_timestamp() with
    +    parse_expiry_date(), but as noted perhaps we want *nix epochs here
    +    only, in that case we could add an "isdigit" loop here.
    +
         Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     
      ## builtin/bundle.c ##
    @@ builtin/bundle.c: static int cmd_bundle_fetch(int argc, const char **argv, const
     +	const char *timestamp_key = "fetch.bundletimestamp";
     +	timestamp_t stored_time = 0;
     +	timestamp_t max_time = 0;
    ++	const char *value;
      
      	struct option options[] = {
      		OPT_BOOL(0, "progress", &progress,
    @@ builtin/bundle.c: static int cmd_bundle_fetch(int argc, const char **argv, const
      	if (!startup_info->have_repository)
      		die(_("'fetch' requires a repository"));
      
    -+	git_config_get_timestamp(timestamp_key, &stored_time);
    ++	/*
    ++	 * TODO: Is it important re
    ++	 * https://lore.kernel.org/git/220311.86pmmshahy.gmgdl@evledraar.gmail.com/
    ++	 * that we don't accept "2.days.ago" etc., and only *nix
    ++	 * epochs?
    ++	 */
    ++	if (!git_config_get_string_tmp(timestamp_key, &value) &&
    ++	    parse_expiry_date(value, &stored_time))
    ++		return error(_("'%s' for '%s' is not a valid timestamp"),
    ++			     value, timestamp_key);
     +
      	/*
      	 * Step 1: determine protocol for uri, and download contents to
29:  857f9be78e5 = 26:  0a238641247 fetch: fetch bundles before fetching original data
30:  85ebf44038e = 27:  5e8cec1e193 protocol-caps: implement cap_features()
31:  e30d9a9f95d = 28:  145c660ca52 serve: understand but do not advertise 'features' capability
32:  cf07392921d = 29:  2c9886c64ea serve: advertise 'features' when config exists
33:  1e8c52dbe47 = 30:  e834e633e84 connect: implement get_recommended_features()
34:  b8044bb09f0 = 31:  6611dd08f93 transport: add connections for 'features' capability
35:  3aa4d42d2ac = 32:  2b424bedfc5 clone: use server-recommended bundle URI
36:  6e4da9ccc85 ! 33:  52ee1e08dec t5601: basic bundle URI test
    @@ t/t5601-clone.sh: test_expect_success 'reject cloning shallow repository using H
     +	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
     +		git -c protocol.version=2 clone \
     +		$HTTPD_URL/smart/repo2.git repo &&
    -+	test_subcommand_inexact git bundle unbundle <trace.txt
    ++	cat >pat <<-\EOF &&
    ++	"event":"child_start".*"argv":\["git","bundle","unbundle"
    ++	EOF
    ++	grep -f pat trace.txt
     +'
     +
      # DO NOT add non-httpd-specific tests here, because the last part of this
 -:  ----------- > 34:  f872793cac2 protocol v2: add server-side "bundle-uri" skeleton (docs)
 2:  6bc2316d2fd = 35:  cfda9323aaa bundle-uri docs: add design notes
14:  54c4ccafd9a ! 36:  764f82a0c0a docs: document bundle URI standard
    @@ Documentation/technical/bundle-uri-TOC.txt (new)
     +
     +[2] https://github.com/microsoft/VFSForGit/blob/master/Protocol.md
     +    The GVFS Protocol
    - \ No newline at end of file
27:  1173ceeb08a <  -:  ----------- config: add git_config_get_timestamp()
-- 
2.36.0.rc2.902.g60576bbc845

