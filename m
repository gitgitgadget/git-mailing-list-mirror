Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37757C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiKAWhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiKAWgq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684781E3F9
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k2so40811940ejr.2
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0OIYTPPOX5DG9M04sU21hEG+QEyuRUiTTyMCrFvxSk=;
        b=djBNMpJtmav0cK3syI5iKTrmpfRFRkX3wZx24JPuFOD2eni0+JKh7QxvQPjUy0yTpz
         pAzkxH/Zu83exkMaZzGcuyrfksQ2fXSv183ND7zOBnrZhn/tcr4jy5EUPYG9nofqL249
         bkn34BM2B1rGCLXA7Og7TobSB7GmLQHS6wgMQOdjBPqZtjklWC6pnPJwmtGvL/Ulp4Dq
         PUToqN0tSj31XPuIoBHE3y7icztd3QMh6gSbzsw4T49Wdy02KZADJH68fj3jE7nYpB2E
         HJ6MsPzgvopjv2Vza60DhZiOCvV3ezFYI6KcGFQuPfOLb+kDmbcvjDx45Ka7zz6nQrE5
         LIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0OIYTPPOX5DG9M04sU21hEG+QEyuRUiTTyMCrFvxSk=;
        b=T0wA7THYQg/w9LVBHlR0RoAMgbsg5RbaRHgJr1Xje2ARkEiUaFrkkm0j123RV4dntf
         CIPXo157R3i8Dqr9aADMQ3fFiCUQsVinwuXnv8qFb8xZH3SbCtdu3y4Az0br4uV+STlO
         ePNgYJNJwQMM2euzPbOSyyVfzN+FuFf1FpWiJRiDCLjSCyG9a2+XqgRfKjbH3rlJoGfa
         LCgJgGVcRqGvZcg3Ptp9ciiDJtA5IbasOvtwkJUtVUZssBPVbrBu8Py98J550B/DPsdx
         wYvhrEBmTaSJSX3XgFJiDlDbCrIbom6DQXml/XpPy4HuPGQuQ31YCEzwYhRPUEout9Z3
         rm0A==
X-Gm-Message-State: ACrzQf1kgxv0BQao0Lka2wyHeNUXoAwuchmS403a++uxL4Ocbt5gpMMF
        cwoddFLa5GBpBCPa78NA8Nu8ygfKqWZa8A==
X-Google-Smtp-Source: AMsMyM4Jae3X183xcu4H27yYM3rUkLchREVOoBMfwGgsxygRvtMAKyREbOSKouxAUtphue6w+hmmIg==
X-Received: by 2002:a17:907:9729:b0:78d:9fb4:16e0 with SMTP id jg41-20020a170907972900b0078d9fb416e0mr19975548ejc.455.1667342173471;
        Tue, 01 Nov 2022 15:36:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 13/13] spatchcache: add a ccache-alike for "spatch"
Date:   Tue,  1 Nov 2022 23:35:55 +0100
Message-Id: <patch-v5-13.13-ef578c230ea-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a rather trivial "spatchcache", with this running e.g.:

	make cocciclean
	make contrib/coccinelle/free.cocci.patch \
		SPATCH=contrib/coccicheck/spatchcache \
		SPATCH_FLAGS=--very-quiet

Is cut down from ~20s to ~5s on my system. Much of that is either
fixable shell overhead, or the around 40 files we "CANTCACHE" (see the
implementation).

This uses "redis" as a cache by default, but it's configurable. See
the embedded documentation.

This is *not* like ccache in that we won't cache failed spatch
invocations, or those where spatch suggests changes for us. Those
cases are so rare that I didn't think it was worth the bother, by far
the most common case is that it has no suggested changes. We'll also
refuse to cache any "spatch" invocation that has output on stderr,
which means that "--very-quiet" must be added to "SPATCH_FLAGS".

Because we narrow the cache to that we don't need to save away stdout,
stderr & the exit code. We simply cache the cases where we had no
suggested changes.

Another benchmark is to compare this with the previous
SPATCH_BATCH_SIZE=N, as noted in [1]. Before this (on my 8 core system) running:

	make clean; time make contrib/coccinelle/array.cocci.patch SPATCH_BATCH_SIZE=0

Would take 33s, but with the preceding changes running without this
"spatchcache" is slightly slower, or around 35s:

	make clean; time make contrib/coccinelle/array.cocci.patch

Now doing the same with SPATCH=contrib/coccinelle/spatchcache will
take around 6s, but we'll need to compile the *.o files first to take
full advantage of it (which can be fast with "ccache"):

	make clean; make; time make contrib/coccinelle/array.cocci.patch SPATCH=contrib/coccinelle/spatchcache

1. https://lore.kernel.org/git/YwdRqP1CyUAzCEn2@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/README      |  20 +++
 contrib/coccinelle/spatchcache | 304 +++++++++++++++++++++++++++++++++
 2 files changed, 324 insertions(+)
 create mode 100755 contrib/coccinelle/spatchcache

diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
index 09b72bfd4e7..d1daa1f6263 100644
--- a/contrib/coccinelle/README
+++ b/contrib/coccinelle/README
@@ -70,3 +70,23 @@ Git-specific tips & things to know about how we run "spatch":
    my_name", v.s. anonymous "@@") needs to be unique across all our
    *.cocci files. You should only need to name rules if other rules
    depend on them (currently only one rule is named).
+
+ * To speed up incremental runs even more use the "spatchcache" tool
+   in this directory as your "SPATCH". It aimns to be a "ccache" for
+   coccinelle, and piggy-backs on "COMPUTE_HEADER_DEPENDENCIES".
+
+   It caches in Redis by default, see it source for a how-to.
+
+   In one setup with a primed cache "make coccicheck" followed by a
+   "make clean && make" takes around 10s to run, but 2m30s with the
+   default of "SPATCH_CONCAT_COCCI=Y".
+
+   With "SPATCH_CONCAT_COCCI=" the total runtime is around ~6m, sped
+   up to ~1m with "spatchcache".
+
+   Most of the 10s (or ~1m) being spent on re-running "spatch" on
+   files we couldn't cache, as we didn't compile them (in contrib/*
+   and compat/* mostly).
+
+   The absolute times will differ for you, but the relative speedup
+   from caching should be on that order.
diff --git a/contrib/coccinelle/spatchcache b/contrib/coccinelle/spatchcache
new file mode 100755
index 00000000000..29e9352d8a2
--- /dev/null
+++ b/contrib/coccinelle/spatchcache
@@ -0,0 +1,304 @@
+#!/bin/sh
+#
+# spatchcache: a poor-man's "ccache"-alike for "spatch" in git.git
+#
+# This caching command relies on the peculiarities of the Makefile
+# driving "spatch" in git.git, in particular if we invoke:
+#
+#	make
+#	# See "spatchCache.cacheWhenStderr" for why "--very-quiet" is
+#	# used
+#	make coccicheck SPATCH_FLAGS=--very-quiet
+#
+# We can with COMPUTE_HEADER_DEPENDENCIES (auto-detected as true with
+# "gcc" and "clang") write e.g. a .depend/grep.o.d for grep.c, when we
+# compile grep.o.
+#
+# The .depend/grep.o.d will have the full header dependency tree of
+# grep.c, and we can thus cache the output of "spatch" by:
+#
+#	1. Hashing all of those files
+#	2. Hashing our source file, and the *.cocci rule we're
+#	   applying
+#	3. Running spatch, if suggests no changes (by far the common
+#	   case) we invoke "spatchCache.getCmd" and
+#	   "spatchCache.setCmd" with a hash SHA-256 to ask "does this
+#	   ID have no changes" or "say that ID had no changes>
+#	4. If no "spatchCache.{set,get}Cmd" is specified we'll use
+#	   "redis-cli" and maintain a SET called "spatch-cache". Set
+#	   appropriate redis memory policies to keep it from growing
+#	   out of control.
+#
+# This along with the general incremental "make" support for
+# "contrib/coccinelle" makes it viable to (re-)run coccicheck
+# e.g. when merging integration branches.
+#
+# Note that the "--very-quiet" flag is currently critical. The cache
+# will refuse to cache anything that has output on STDERR (which might
+# be errors from spatch), but see spatchCache.cacheWhenStderr below.
+#
+# The STDERR (and exit code) could in principle be cached (as with
+# ccache), but then the simple structure in the Redis cache would need
+# to change, so just supply "--very-quiet" for now.
+#
+# To use this, simply set SPATCH to
+# contrib/coccinelle/spatchcache. Then optionally set:
+#
+#	[spatchCache]
+#		# Optional: path to a custom spatch
+#		spatch = ~/g/coccicheck/spatch.opt
+#
+# As well as this trace config (debug implies trace):
+#
+#		cacheWhenStderr = true
+#		trace = false
+#		debug = false
+#
+# The ".depend/grep.o.d" can also be customized, as a string that will
+# be eval'd, it has access to a "$dirname" and "$basename":
+#
+#	[spatchCache]
+#		dependFormat = "$dirname/.depend/${basename%.c}.o.d"
+#
+# Setting "trace" to "true" allows for seeing when we have a cache HIT
+# or MISS. To debug whether the cache is working do that, and run e.g.:
+#
+#	redis-cli FLUSHALL
+#	<make && make coccicheck, as above>
+#	grep -hore HIT -e MISS -e SET -e NOCACHE -e CANTCACHE .build/contrib/coccinelle | sort | uniq -c
+#	    600 CANTCACHE
+#	   7365 MISS
+#	   7365 SET
+#
+# A subsequent "make cocciclean && make coccicheck" should then have
+# all "HIT"'s and "CANTCACHE"'s.
+#
+# The "spatchCache.cacheWhenStderr" option is critical when using
+# spatchCache.{trace,debug} to debug whether something is set in the
+# cache, as we'll write to the spatch logs in .build/* we'd otherwise
+# always emit a NOCACHE.
+#
+# Reading the config can make the command much slower, to work around
+# this the config can be set in the environment, with environment
+# variable name corresponding to the config key. "default" can be used
+# to use whatever's the script default, e.g. setting
+# spatchCache.cacheWhenStderr=true and deferring to the defaults for
+# the rest is:
+#
+#	export GIT_CONTRIB_SPATCHCACHE_DEBUG=default
+#	export GIT_CONTRIB_SPATCHCACHE_TRACE=default
+#	export GIT_CONTRIB_SPATCHCACHE_CACHEWHENSTDERR=true
+#	export GIT_CONTRIB_SPATCHCACHE_SPATCH=default
+#	export GIT_CONTRIB_SPATCHCACHE_DEPENDFORMAT=default
+#	export GIT_CONTRIB_SPATCHCACHE_SETCMD=default
+#	export GIT_CONTRIB_SPATCHCACHE_GETCMD=default
+
+set -e
+
+env_or_config () {
+	env="$1"
+	shift
+	if test "$env" = "default"
+	then
+		# Avoid expensive "git config" invocation
+		return
+	elif test -n "$env"
+	then
+		echo "$env"
+	else
+		git config $@ || :
+	fi
+}
+
+## Our own configuration & options
+debug=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_DEBUG" --bool "spatchCache.debug")
+if test "$debug" != "true"
+then
+	debug=
+fi
+if test -n "$debug"
+then
+	set -x
+fi
+
+trace=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_TRACE" --bool "spatchCache.trace")
+if test "$trace" != "true"
+then
+	trace=
+fi
+if test -n "$debug"
+then
+	# debug implies trace
+	trace=true
+fi
+
+cacheWhenStderr=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_CACHEWHENSTDERR" --bool "spatchCache.cacheWhenStderr")
+if test "$cacheWhenStderr" != "true"
+then
+	cacheWhenStderr=
+fi
+
+trace_it () {
+	if test -z "$trace"
+	then
+		return
+	fi
+	echo "$@" >&2
+}
+
+spatch=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_SPATCH" --path "spatchCache.spatch")
+if test -n "$spatch"
+then
+	if test -n "$debug"
+	then
+		trace_it "custom spatchCache.spatch='$spatch'"
+	fi
+else
+	spatch=spatch
+fi
+
+dependFormat='$dirname/.depend/${basename%.c}.o.d'
+dependFormatCfg=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_DEPENDFORMAT" "spatchCache.dependFormat")
+if test -n "$dependFormatCfg"
+then
+	dependFormat="$dependFormatCfg"
+fi
+
+set=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_SETCMD" "spatchCache.setCmd")
+get=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_GETCMD" "spatchCache.getCmd")
+
+## Parse spatch()-like command-line for caching info
+arg_sp=
+arg_file=
+args="$@"
+spatch_opts() {
+	while test $# != 0
+	do
+		arg_file="$1"
+		case "$1" in
+		--sp-file)
+			arg_sp="$2"
+			;;
+		esac
+		shift
+	done
+}
+spatch_opts "$@"
+if ! test -f "$arg_file"
+then
+	arg_file=
+fi
+
+hash_for_cache() {
+	# Parameters that should affect the cache
+	echo "args=$args"
+	echo "config spatchCache.spatch=$spatch"
+	echo "config spatchCache.debug=$debug"
+	echo "config spatchCache.trace=$trace"
+	echo "config spatchCache.cacheWhenStderr=$cacheWhenStderr"
+	echo
+
+	# Our target file and its dependencies
+	git hash-object "$1" "$2" $(grep -E -o '^[^:]+:$' "$3" | tr -d ':')
+}
+
+# Sanity checks
+if ! test -f "$arg_sp" && ! test -f "$arg_file"
+then
+	echo $0: no idea how to cache "$@" >&2
+	exit 128
+fi
+
+# Main logic
+dirname=$(dirname "$arg_file")
+basename=$(basename "$arg_file")
+eval "dep=$dependFormat"
+
+if ! test -f "$dep"
+then
+	trace_it "$0: CANTCACHE have no '$dep' for '$arg_file'!"
+	exec "$spatch" "$@"
+fi
+
+if test -n "$debug"
+then
+	trace_it "$0: The full cache input for '$arg_sp' '$arg_file' '$dep'"
+	hash_for_cache "$arg_sp" "$arg_file" "$dep" >&2
+fi
+sum=$(hash_for_cache "$arg_sp" "$arg_file" "$dep" | git hash-object --stdin)
+
+trace_it "$0: processing '$arg_file' with '$arg_sp' rule, and got hash '$sum' for it + '$dep'"
+
+getret=
+if test -z "$get"
+then
+	if test $(redis-cli SISMEMBER spatch-cache "$sum") = 1
+	then
+		getret=0
+	else
+		getret=1
+	fi
+else
+	$set "$sum"
+	getret=$?
+fi
+
+if test "$getret" = 0
+then
+	trace_it "$0: HIT for '$arg_file' with '$arg_sp'"
+	exit 0
+else
+	trace_it "$0: MISS: for '$arg_file' with '$arg_sp'"
+fi
+
+out="$(mktemp)"
+err="$(mktemp)"
+
+set +e
+"$spatch" "$@" >"$out" 2>>"$err"
+ret=$?
+cat "$out"
+cat "$err" >&2
+set -e
+
+nocache=
+if test $ret != 0
+then
+	nocache="exited non-zero: $ret"
+elif test -s "$out"
+then
+	nocache="had patch output"
+elif test -z "$cacheWhenStderr" && test -s "$err"
+then
+	nocache="had stderr (use --very-quiet or spatchCache.cacheWhenStderr=true?)"
+fi
+
+if test -n "$nocache"
+then
+	trace_it "$0: NOCACHE ($nocache): for '$arg_file' with '$arg_sp'"
+	exit "$ret"
+fi
+
+trace_it "$0: SET: for '$arg_file' with '$arg_sp'"
+
+setret=
+if test -z "$set"
+then
+	if test $(redis-cli SADD spatch-cache "$sum") = 1
+	then
+		setret=0
+	else
+		setret=1
+	fi
+else
+	"$set" "$sum"
+	setret=$?
+fi
+
+if test "$setret" != 0
+then
+	echo "FAILED to set '$sum' in cache!" >&2
+	exit 128
+fi
+
+exit "$ret"
-- 
2.38.0.1280.g8136eb6fab2

