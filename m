Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E33C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 21:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiJFV1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 17:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiJFV1J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 17:27:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFC4BA246
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 14:27:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k2so7425858ejr.2
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PojzCa2rG2Q6rJD6CgajjptSKJR0GhyPojDPK7gOWfw=;
        b=PNkbPLLvaWcqTaHHTEuBwgimFaepiLLscdGsmDEugEzvSd61YYQdgBk8qPymZnaIO/
         PI9P002Qa2hvv2LIpkNPflU0aZwpckQWIZr95tHkBprygNswfzP9K3gfA1PPF12kaoHk
         EQkaPGo08SJScFJ4Rd94wwgKBsG6Sqr+4sM/SKPjWHlbRGownASAXahU0bFtutw/M74U
         V2raiZHPUXedr7ReaqJv7GCpibGl3PphlPrkro52NDRe8ORy7Du/msyt2pP0GeGhaHdZ
         dMBoF2LCi+lELKdiLIps5axCvERnoaXLgIClOkuPDwwt25no54yVuilskFUFVtHSm4+Q
         512Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PojzCa2rG2Q6rJD6CgajjptSKJR0GhyPojDPK7gOWfw=;
        b=iBogky3PK02o+5CBv4c1u8rVJauDzpwVvdyn3SZEloHspIrohYWCUmOnYkF00MGn5L
         5N2ajJh3yQNyDDY3GCqUCcHLInCd+KuP3EeRFt5C+2Xoj/c8KcvrPvn76gwkc0g59XXh
         prnm14rjgoUzlMRfTXr1A1Ec/XxNaevbBh6Iw66tn3pWNOEYUBHGCP4t1kBIT721MH0x
         zfCgp3z2nwgwmn2Dcpt0/bvp/K1prwpAVSFOJMIIxqmfjMNBiQCVNJbkkb4+YwwXy9Ux
         0CUoLS9XMQXAqPoi2WluISyZzwKUnsa/PmBm4g8i7ZJuEwPwPFcXIIfUVpQ76f4BFWMS
         1xTA==
X-Gm-Message-State: ACrzQf0j6TgcMKuArphR7fNEED2CI1jM/UbY67w66FjgOLvqD+RGIt6k
        Dlrim4qlC78eFmp1J0TV0UL3HXM9oeM=
X-Google-Smtp-Source: AMsMyM5Iip+3X3HqSHuZrJY17s4fTzDJhG+l45tN33dbA9kbZ2HphZ9NC5mm375UI52FOUBY7K7FUQ==
X-Received: by 2002:a17:907:2d27:b0:78a:7cd5:9880 with SMTP id gs39-20020a1709072d2700b0078a7cd59880mr1457248ejc.217.1665091621066;
        Thu, 06 Oct 2022 14:27:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b007836d075152sm187526ejo.187.2022.10.06.14.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 14:27:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogYOR-0035iE-1D;
        Thu, 06 Oct 2022 23:26:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Aleajndro R =?utf-8?Q?Sede=C3=B1o?= <asedeno@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: GCC deprecated only takes a message
 in GCC 4.5+
Date:   Thu, 06 Oct 2022 23:15:16 +0200
References: <20221003212318.3092010-1-asedeno@google.com>
 <YzthTugwy+eaIUxr@tapette.crustytoothpaste.net>
 <CAOO-Oz2WnodBnw86mi2GZ+jLGoGy_saX=kCpwPdm2xohDO1s_Q@mail.gmail.com>
 <Yz2afjRezq5oGN4g@coredump.intra.peff.net>
 <221006.86lepts927.gmgdl@evledraar.gmail.com>
 <Yz7HGAThrOcPdmjm@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Yz7HGAThrOcPdmjm@coredump.intra.peff.net>
Message-ID: <221006.86edvkr6cc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 06 2022, Jeff King wrote:

> On Thu, Oct 06, 2022 at 09:29:11AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > This will cause some mild hardships, as later patches will need to
>> > #define UNUSED in other spots, as well, in order to get full coverage =
of
>> > the code base (I have written those annotation patches, but they're not
>> > applied upstream yet).
>>=20
>> Sorry about any trouble in having to rebase those on UNUSED.
>
> That part was not too bad, and is already done.
>
> The trickiest part is that the headers get included in odd orders, and
> if the macros don't match, the compiler will complain (this has to do
> with compat/ headers which don't necessarily start by including
> git-compat-util.h).
>
> But if the definition gets much more complicated, then it's probably
> worth pulling it out rather than repeating it.

Yeah, I've dealt with that pain before in other contexts. It would be
great to have a git-compiler-compat.h with just the various
__attribute__ stuff split off from git-compat-util.h.

Maybe (compiles, but otherwise untested):

 git-compat-util.h   | 52 +-------------------------------------------------
 git-compiler-util.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 56 insertions(+), 51 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b90b64718eb..bfa44921c03 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1,18 +1,6 @@
 #ifndef GIT_COMPAT_UTIL_H
 #define GIT_COMPAT_UTIL_H
-
-#if __STDC_VERSION__ - 0 < 199901L
-/*
- * Git is in a testing period for mandatory C99 support in the compiler.  =
If
- * your compiler is reasonably recent, you can try to enable C99 support (=
or,
- * for MSVC, C11 support).  If you encounter a problem and can't enable C99
- * support with your compiler (such as with "-std=3Dgnu99") and don't have=
 access
- * to one with this support, such as GCC or Clang, you can remove this #if
- * directive, but please report the details of your system to
- * git@vger.kernel.org.
- */
-#error "Required C99 support is in a test phase.  Please see git-compat-ut=
il.h for more details."
-#endif
+#include "git-compiler-util.h"
=20
 #ifdef USE_MSVC_CRTDBG
 /*
@@ -189,13 +177,6 @@ struct strbuf;
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
=20
-#if defined(__GNUC__)
-#define UNUSED __attribute__((unused)) \
-	__attribute__((deprecated ("parameter declared as UNUSED")))
-#else
-#define UNUSED
-#endif
-
 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
 # if !defined(_WIN32_WINNT)
 #  define _WIN32_WINNT 0x0600
@@ -557,37 +538,6 @@ static inline int git_has_dir_sep(const char *path)
 #endif
 #endif
=20
-#if defined(__HP_cc) && (__HP_cc >=3D 61000)
-#define NORETURN __attribute__((noreturn))
-#define NORETURN_PTR
-#elif defined(__GNUC__) && !defined(NO_NORETURN)
-#define NORETURN __attribute__((__noreturn__))
-#define NORETURN_PTR __attribute__((__noreturn__))
-#elif defined(_MSC_VER)
-#define NORETURN __declspec(noreturn)
-#define NORETURN_PTR
-#else
-#define NORETURN
-#define NORETURN_PTR
-#ifndef __GNUC__
-#ifndef __attribute__
-#define __attribute__(x)
-#endif
-#endif
-#endif
-
-/* The sentinel attribute is valid from gcc version 4.0 */
-#if defined(__GNUC__) && (__GNUC__ >=3D 4)
-#define LAST_ARG_MUST_BE_NULL __attribute__((sentinel))
-/* warn_unused_result exists as of gcc 3.4.0, but be lazy and check 4.0 */
-#define RESULT_MUST_BE_USED __attribute__ ((warn_unused_result))
-#else
-#define LAST_ARG_MUST_BE_NULL
-#define RESULT_MUST_BE_USED
-#endif
-
-#define MAYBE_UNUSED __attribute__((__unused__))
-
 #include "compat/bswap.h"
=20
 #include "wildmatch.h"
diff --git a/git-compiler-util.h b/git-compiler-util.h
new file mode 100644
index 00000000000..25fa0bc65d7
--- /dev/null
+++ b/git-compiler-util.h
@@ -0,0 +1,55 @@
+#ifndef GIT_COMPILER_UTIL_H
+#define GIT_COMPILER_UTIL_H
+
+#if __STDC_VERSION__ - 0 < 199901L
+/*
+ * Git is in a testing period for mandatory C99 support in the compiler.  =
If
+ * your compiler is reasonably recent, you can try to enable C99 support (=
or,
+ * for MSVC, C11 support).  If you encounter a problem and can't enable C99
+ * support with your compiler (such as with "-std=3Dgnu99") and don't have=
 access
+ * to one with this support, such as GCC or Clang, you can remove this #if
+ * directive, but please report the details of your system to
+ * git@vger.kernel.org.
+ */
+#error "Required C99 support is in a test phase.  Please see git-compiler-=
util.h for more details."
+#endif
+
+#if defined(__GNUC__)
+#define UNUSED __attribute__((unused)) \
+	__attribute__((deprecated ("parameter declared as UNUSED")))
+#else
+#define UNUSED
+#endif
+
+#endif
+
+#if defined(__HP_cc) && (__HP_cc >=3D 61000)
+#define NORETURN __attribute__((noreturn))
+#define NORETURN_PTR
+#elif defined(__GNUC__) && !defined(NO_NORETURN)
+#define NORETURN __attribute__((__noreturn__))
+#define NORETURN_PTR __attribute__((__noreturn__))
+#elif defined(_MSC_VER)
+#define NORETURN __declspec(noreturn)
+#define NORETURN_PTR
+#else
+#define NORETURN
+#define NORETURN_PTR
+#ifndef __GNUC__
+#ifndef __attribute__
+#define __attribute__(x)
+#endif
+#endif
+#endif
+
+/* The sentinel attribute is valid from gcc version 4.0 */
+#if defined(__GNUC__) && (__GNUC__ >=3D 4)
+#define LAST_ARG_MUST_BE_NULL __attribute__((sentinel))
+/* warn_unused_result exists as of gcc 3.4.0, but be lazy and check 4.0 */
+#define RESULT_MUST_BE_USED __attribute__ ((warn_unused_result))
+#else
+#define LAST_ARG_MUST_BE_NULL
+#define RESULT_MUST_BE_USED
+#endif
+
+#define MAYBE_UNUSED __attribute__((__unused__))

>> If you're taking requests it would be really useful to prioritize
>> changes to shared headers and the like, e.g. DEVOPTS=3Dextra-all on pret=
ty
>> much any file will start with:
>>=20=09
>> 	git-compat-util.h: In function =E2=80=98precompose_argv_prefix=E2=80=99:
>> 	git-compat-util.h:313:54: error: unused parameter =E2=80=98argc=E2=80=
=99 [-Werror=3Dunused-parameter]
>> 	  313 | static inline const char *precompose_argv_prefix(int argc, cons=
t char **argv, const char *prefix)
>> 	      |                                                  ~~~~^~~~
>> 	git-compat-util.h:313:73: error: unused parameter =E2=80=98argv=E2=80=
=99 [-Werror=3Dunused-parameter]
>> 	  313 | static inline const char *precompose_argv_prefix(int argc, cons=
t char **argv, const char *prefix)
>> 	      |                                                            ~~~~=
~~~~~~~~~^~~~
>> 	git-compat-util.h: In function =E2=80=98git_has_dos_drive_prefix=E2=80=
=99:
>> 	git-compat-util.h:423:56: error: unused parameter =E2=80=98path=E2=80=
=99 [-Werror=3Dunused-parameter]
>> 	  423 | static inline int git_has_dos_drive_prefix(const char *path)
>> 	      |                                            ~~~~~~~~~~~~^~~~
>> 	git-compat-util.h: In function =E2=80=98git_skip_dos_drive_prefix=E2=80=
=99:
>> 	git-compat-util.h:431:52: error: unused parameter =E2=80=98path=E2=80=
=99 [-Werror=3Dunused-parameter]
>> 	  431 | static inline int git_skip_dos_drive_prefix(char **path)
>
> Yeah, those are near the top of my list. I have a group classified as
> "trivial": functions which are compat placeholders and have no body.
> I'll be mostly offline for about a week, but I hope to send another
> round of unused-mark patches when I get back. (Of course it is not
> really useful until _all_ of the patches are there anyway).

I was ad-hoc testing this earlier and just dug this back out of my
stash, maybe going in something like this direction is useful:
=09
	diff --git a/config.mak.dev b/config.mak.dev
	index 4fa19d361b7..60bc8c406cf 100644
	--- a/config.mak.dev
	+++ b/config.mak.dev
	@@ -54,6 +54,47 @@ DEVELOPER_CFLAGS +=3D -Wno-empty-body
	 DEVELOPER_CFLAGS +=3D -Wno-missing-field-initializers
	 DEVELOPER_CFLAGS +=3D -Wno-sign-compare
	 DEVELOPER_CFLAGS +=3D -Wno-unused-parameter
	+
	+define use-unused-parameter
	+$(1): DEVELOPER_CFLAGS +=3D -Wunused-parameter
	+
	+endef
	+
	+TEST_BUILTINS_NO_UNUSED =3D
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-ctype.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-date.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-drop-caches.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-dump-cache-tree.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-dump-fsmonitor.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-dump-split-index.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-dump-untracked-cache.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-example-decorate.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-fsmonitor-client.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-index-version.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-match-trees.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-mergesort.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-oid-array.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-oidmap.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-oidtree.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-oidtree.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-online-cpus.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-parse-options.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-path-utils.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-prio-queue.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-read-graph.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-ref-store.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-run-command.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-scrap-cache-tree.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-sigchain.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-simple-ipc.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-strcmp-offset.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-submodule-config.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-trace2.o
	+TEST_BUILTINS_OBJS_NO_UNUSED +=3D test-xml-encode.o
	+
	+TEST_BUILTINS_OBJS_CHECK_UNUSED =3D $(filter-out $(TEST_BUILTINS_OBJS_NO_=
UNUSED),$(TEST_BUILTINS_OBJS))
	+
	+$(eval $(foreach obj,$(TEST_BUILTINS_OBJS_CHECK_UNUSED:%=3Dt/helper/%), $=
(call use-unused-parameter,$(obj))))
	 endif
	 endif
=09=20
It's probably too painful to maintain that on a per-file basis, but if
you can get to a point where e.g. t/helper/ is -Wunused-parameter clean
we can just append -Wunused-parameter to DEVELOPER_CFLAGS for those
paths.

That'll ensure that we don't have "regressions" in newly added
parameters for files we've already cleared.

Maybe not worth it, I don't know if we'd be re-adding these at a
sufficient rate to make it worth it, probably you'll send all these in
and we'll find there's maybe 1-5 easily tackled regressions before we
remove that "DEVELOPER_CFLAGS +=3D -Wno-unused-parameter" line.
