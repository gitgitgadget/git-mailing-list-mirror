Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8D6C001B0
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 19:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjF0Txd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjF0TxU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 15:53:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B059295B
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:17 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2630c837b85so870087a91.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687895597; x=1690487597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LlVT+KPD+T9RWFovvrmKT61e3O814ep9SnoSsrWKRBw=;
        b=H9Sm9yUsk6D2UanQjTmFEUkNW2oC1bAWAk9kqQ0MmmkzoutYoY4+MSUQSLogXorXk4
         3+mD3dL83811C3+Dr0wSeM1JfB0/6LhxQvrcoRePtDr+oa/I7yZV+P8BeZkNkhNQL3Dm
         R7InzHPu5kMHb0fj/OpyaPZbG7mqiMaGvyfjZqpgeO0kB63+ygSdRmwFgnZEfk45/+Ut
         iTANnNq1ba8Jkcn3xS+6Our5JmTVgEC6WeYtWz/3uiAqhx/qscW0X6oQYw4US9Ika/wN
         NZyiQztec9uYsx3yu0bzFPQrX+a1xzjDvY365qQdl8OvrhREv1EcpQ1I4d+aStwrQQNx
         6mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895597; x=1690487597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlVT+KPD+T9RWFovvrmKT61e3O814ep9SnoSsrWKRBw=;
        b=YPghHqlOxDk926W8yZKzhXWSCBT11+tew3I1wOhf1eFjiafy7DyJF4RU4rXTfiL4oK
         cUjF9z6ZcZ+2sySxnxaU7ld2ok8kL9bmhoo3SM8Y2LW2dA5/cO5+bF5076gLFCGTU7Zx
         dDzI51W7ARSWpuJZUzBc8GsZ9XE8+S6D0MNukoHKFHOYJg6CK6uQp+VrWO9AbhSYE02S
         B2WqFYdts6voqmIwGoWZKOPfJzXnZJrdX9lpnTVIDVlWNJWClRaX1+t8cHXBOl1aq5Je
         I1wRGM8q+JjpOEcbx4+cF4HpIoBSrcDgCxQ16nYq0+I6oius1FfGRjwnzgkedbgr/DE7
         ihPQ==
X-Gm-Message-State: AC+VfDxrLySXa0Y3GdwqOij/EqPyG955Z09/TgC1M4XADSbECB0DvzKA
        nRnDvkik3oMQAqVFL10TmXKTHd+IBNQgUs3QBYkFnO2ye/6/8lrATXLY1cwTzvC8jCj12h4kLxf
        YL4XnmCBS20spIKCsjiCrdEz1i2blCMizsFjXPxMwfJngTuZkVZ0T0eUJZ/PN7ochcA==
X-Google-Smtp-Source: ACHHUZ4FN2f++xtAjopizAA/F16dJer2fmB4+GxuP2OCE8dV/K44dmOhayR7YcS7RZm5EFK8GJVgRdra7CR1PEE=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:f013:b0:262:e6b6:e0b1 with SMTP
 id bt19-20020a17090af01300b00262e6b6e0b1mr1099268pjb.4.1687895596983; Tue, 27
 Jun 2023 12:53:16 -0700 (PDT)
Date:   Tue, 27 Jun 2023 19:52:50 +0000
In-Reply-To: <20230627195251.1973421-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627195251.1973421-8-calvinwan@google.com>
Subject: [RFC PATCH 7/8] git-std-lib: introduce git standard library
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Git Standard Library intends to serve as the foundational library
and root dependency that other libraries in Git will be built off of.
That is to say, suppose we have libraries X and Y; a user that wants to
use X and Y would need to include X, Y, and this Git Standard Library.

Add Documentation/technical/git-std-lib.txt to further explain the
design and rationale.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/technical/git-std-lib.txt | 182 ++++++++++++++++++++++++
 Makefile                                |  28 +++-
 git-compat-util.h                       |   7 +-
 symlinks.c                              |   2 +
 usage.c                                 |   8 ++
 5 files changed, 225 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/technical/git-std-lib.txt

diff --git a/Documentation/technical/git-std-lib.txt b/Documentation/technical/git-std-lib.txt
new file mode 100644
index 0000000000..3dce36c9f9
--- /dev/null
+++ b/Documentation/technical/git-std-lib.txt
@@ -0,0 +1,182 @@
+Git Standard Library
+================
+
+The Git Standard Library intends to serve as the foundational library
+and root dependency that other libraries in Git will be built off of.
+That is to say, suppose we have libraries X and Y; a user that wants to
+use X and Y would need to include X, Y, and this Git Standard Library.
+This does not mean that the Git Standard Library will be the only
+possible root dependency in the future, but rather the most significant
+and widely used one.
+
+Dependency graph in libified Git
+================
+
+If you look in the Git Makefile, all of the objects defined in the Git
+library are compiled and archived into a singular file, libgit.a, which
+is linked against by common-main.o with other external dependencies and
+turned into the Git executable. In other words, the Git executable has
+dependencies on libgit.a and a couple of external libraries. The
+libfication of Git will not affect this current build flow, but instead
+will provide an alternate method for building Git.
+
+With our current method of building Git, we can imagine the dependency
+graph as such:
+
+        Git
+         /\
+        /  \
+       /    \
+  libgit.a   ext deps
+
+In libifying parts of Git, we want to shrink the dependency graph to
+only the minimal set of dependencies, so libraries should not use
+libgit.a. Instead, it would look like:
+
+                Git
+                /\
+               /  \
+              /    \
+          libgit.a  ext deps
+             /\
+            /  \
+           /    \
+object-store.a  (other lib)
+      |        /
+      |       /
+      |      /
+ config.a   / 
+      |    /
+      |   /
+      |  /
+git-std-lib.a
+
+Instead of containing all of the objects in Git, libgit.a would contain
+objects that are not built by libraries it links against. Consequently,
+if someone wanted their own custom build of Git with their own custom
+implementation of the object store, they would only have to swap out
+object-store.a rather than do a hard fork of Git.
+
+Rationale behind Git Standard Library
+================
+
+The rationale behind Git Standard Library essentially is the result of
+two observations within the Git codebase: every file includes
+git-compat-util.h which defines functions in a couple of different
+files, and wrapper.c + usage.c have difficult-to-separate circular
+dependencies with each other and other files.
+
+Ubiquity of git-compat-util.h and circular dependencies
+========
+
+Every file in the Git codebase includes git-compat-util.h. It serves as
+"a compatibility aid that isolates the knowledge of platform specific
+inclusion order and what feature macros to define before including which
+system header" (Junio[1]). Since every file includes git-compat-util.h, and
+git-compat-util.h includes wrapper.h and usage.h, it would make sense
+for wrapper.c and usage.c to be a part of the root library. They have
+difficult to separate circular dependencies with each other so they
+can't be independent libraries. Wrapper.c has dependencies on parse.c,
+abspath.c, strbuf.c, which in turn also have dependencies on usage.c and
+wrapper.c -- more circular dependencies. 
+
+Tradeoff between swappability and refactoring
+========
+
+From the above dependency graph, we can see that git-std-lib.a could be
+many smaller libraries rather than a singular library. So why choose a
+singular library when multiple libraries can be individually easier to
+swap and are more modular? A singular library requires less work to
+separate out circular dependencies within itself so it becomes a
+tradeoff question between work and reward. While there may be a point in
+the future where a file like usage.c would want its own library so that
+someone can have custom die() or error(), the work required to refactor
+out the circular dependencies in some files would be enormous due to
+their ubiquity so therefore I believe it is not worth the tradeoff
+currently. Additionally, we can in the future choose to do this refactor
+and change the API for the library if there becomes enough of a reason
+to do so (remember we are avoiding promising stability of the interfaces
+of those libraries).
+
+Reuse of compatibility functions in git-compat-util.h
+========
+
+Most functions defined in git-compat-util.h are implemented in compat/
+and have dependencies limited to strbuf.h and wrapper.h so they can be
+easily included in git-std-lib.a, which as a root dependency means that
+higher level libraries do not have to worry about compatibility files in
+compat/. The rest of the functions defined in git-compat-util.h are
+implemented in top level files and, in this patch set, are hidden behind
+an #ifdef if their implementation is not in git-std-lib.a.
+
+Rationale summary
+========
+
+The Git Standard Library allows us to get the libification ball rolling
+with other libraries in Git. By not spending many
+more months attempting to refactor difficult circular dependencies and
+instead spending that time getting to a state where we can test out
+swapping a library out such as config or object store, we can prove the
+viability of Git libification on a much faster time scale. Additionally
+the code cleanups that have happened so far have been minor and
+beneficial for the codebase. It is probable that making large movements
+would negatively affect code clarity.
+
+Git Standard Library boundary
+================
+
+While I have described above some useful heuristics for identifying
+potential candidates for git-std-lib.a, a standard library should not
+have a shaky definition for what belongs in it.
+
+ - Low-level files (aka operates only on other primitive types) that are
+   used everywhere within the codebase (wrapper.c, usage.c, strbuf.c)
+   - Dependencies that are low-level and widely used
+     (abspath.c, date.c, hex-ll.c, parse.c, utf8.c)
+ - low-level git/* files with functions defined in git-compat-util.h
+   (ctype.c)
+ - compat/*
+
+There are other files that might fit this definition, but that does not
+mean it should belong in git-std-lib.a. Those files should start as
+their own separate library since any file added to git-std-lib.a loses
+its flexibility of being easily swappable.
+
+Files inside of Git Standard Library
+================
+
+The initial set of files in git-std-lib.a are:
+abspath.c
+ctype.c
+date.c
+hex-ll.c
+parse.c
+strbuf.c
+usage.c
+utf8.c
+wrapper.c
+relevant compat/ files
+
+Pitfalls
+================
+
+In patch 7, I use #ifdef GIT_STD_LIB to both stub out code and hide
+certain function headers. As other parts of Git are libified, if we
+have to use more ifdefs for each different library, then the codebase
+will become uglier and harder to understand. 
+
+There are a small amount of files under compat/* that have dependencies
+not inside of git-std-lib.a. While those functions are not called on
+Linux, other OSes might call those problematic functions. I don't see
+this as a major problem, just moreso an observation that libification in
+general may also require some minor compatibility work in the future.
+
+Testing
+================
+
+Unit tests should catch any breakages caused by changes to files in
+git-std-lib.a (i.e. introduction of a out of scope dependency) and new
+functions introduced to git-std-lib.a will require unit tests written
+for them.
+
+[1] https://lore.kernel.org/git/xmqqwn17sydw.fsf@gitster.g/
\ No newline at end of file
diff --git a/Makefile b/Makefile
index e9ad9f9ef1..255bd10b82 100644
--- a/Makefile
+++ b/Makefile
@@ -2162,6 +2162,11 @@ ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
 endif
 
+ifdef GIT_STD_LIB
+	BASIC_CFLAGS += -DGIT_STD_LIB
+	BASIC_CFLAGS += -DNO_GETTEXT
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -3654,7 +3659,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB) $(STD_LIB_FILE)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
@@ -3834,3 +3839,24 @@ $(FUZZ_PROGRAMS): all
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
 fuzz-all: $(FUZZ_PROGRAMS)
+
+### Libified Git rules
+
+# git-std-lib
+# `make git-std-lib GIT_STD_LIB=YesPlease`
+STD_LIB = git-std-lib.a
+
+GIT_STD_LIB_OBJS += abspath.o
+GIT_STD_LIB_OBJS += ctype.o
+GIT_STD_LIB_OBJS += date.o
+GIT_STD_LIB_OBJS += hex-ll.o
+GIT_STD_LIB_OBJS += parse.o
+GIT_STD_LIB_OBJS += strbuf.o
+GIT_STD_LIB_OBJS += usage.o
+GIT_STD_LIB_OBJS += utf8.o
+GIT_STD_LIB_OBJS += wrapper.o
+
+$(STD_LIB): $(GIT_STD_LIB_OBJS) $(COMPAT_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
+git-std-lib: $(STD_LIB)
diff --git a/git-compat-util.h b/git-compat-util.h
index 481dac22b0..75aa9b263e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -396,8 +396,8 @@ static inline int noop_core_config(const char *var UNUSED,
 #define platform_core_config noop_core_config
 #endif
 
+#if !defined(__MINGW32__) && !defined(_MSC_VER) && !defined(GIT_STD_LIB)
 int lstat_cache_aware_rmdir(const char *path);
-#if !defined(__MINGW32__) && !defined(_MSC_VER)
 #define rmdir lstat_cache_aware_rmdir
 #endif
 
@@ -787,9 +787,11 @@ const char *inet_ntop(int af, const void *src, char *dst, size_t size);
 #endif
 
 #ifdef NO_PTHREADS
+#ifdef GIT_STD_LIB
 #define atexit git_atexit
 int git_atexit(void (*handler)(void));
 #endif
+#endif
 
 /*
  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
@@ -951,14 +953,17 @@ int git_access(const char *path, int mode);
 # endif
 #endif
 
+#ifndef GIT_STD_LIB
 int cmd_main(int, const char **);
 
 /*
  * Intercept all calls to exit() and route them to trace2 to
  * optionally emit a message before calling the real exit().
  */
+
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
+#endif
 
 /*
  * You can mark a stack variable with UNLEAK(var) to avoid it being
diff --git a/symlinks.c b/symlinks.c
index b29e340c2d..bced721a0c 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -337,6 +337,7 @@ void invalidate_lstat_cache(void)
 	reset_lstat_cache(&default_cache);
 }
 
+#if !defined(__MINGW32__) && !defined(_MSC_VER) && !defined(GIT_STD_LIB)
 #undef rmdir
 int lstat_cache_aware_rmdir(const char *path)
 {
@@ -348,3 +349,4 @@ int lstat_cache_aware_rmdir(const char *path)
 
 	return ret;
 }
+#endif
diff --git a/usage.c b/usage.c
index 09f0ed509b..58994e0d5c 100644
--- a/usage.c
+++ b/usage.c
@@ -5,7 +5,15 @@
  */
 #include "git-compat-util.h"
 #include "gettext.h"
+
+#ifdef GIT_STD_LIB
+#undef trace2_cmd_name
+#undef trace2_cmd_error_va
+#define trace2_cmd_name(x) 
+#define trace2_cmd_error_va(x, y)
+#else
 #include "trace2.h"
+#endif
 
 static void vreportf(const char *prefix, const char *err, va_list params)
 {
-- 
2.41.0.162.gfafddb0af9-goog

