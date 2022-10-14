Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369ABC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiJNPcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiJNPb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:31:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CAE188132
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id e18so3307050wmq.3
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rip9TeiOFqEr2uDlzarNPVqeDi4tOTTXJOg/3PaLDTQ=;
        b=MJgVd2CuSzruncy6TMCg7fvgVZN42/Mwun1jPHLEGIDWP+E3b/o8V34hI+2sZNiOlS
         ghnnFWPrUwP9/nmlfpGojIwaH/slzpktTgocVj4qWSuZO+NsHDS3dqoolPpyN0ERSCO9
         0Gkosus8Yhy9e5yEQ6UJ/nfNEHCEBAIul0kdcn7lV2lsWpsZKcZu0zCIUoLbkEwYnZex
         Veef6zkti+tTefE7keWMl3iKN58fMRiZ0teBOdcskzYXk3AEVxweWDxwfrg47DIJnM7c
         pTvec+Vc5JFMvKLx8fcqRD/+I62Llr3u0qMHItzSXh6ySf4oBoHRrvVcCg76aLsxyVjl
         uw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rip9TeiOFqEr2uDlzarNPVqeDi4tOTTXJOg/3PaLDTQ=;
        b=ADH18/g9YsPH8IU070A6ddw85wfe49+hKuZCgVud7edTpAH5VwrXTQxyvoEuhYj2g5
         HE0TP7wiUfQLPkSGiXpXVJdNewp+Mm2p8h+2v/zFroJEwz1StEjMYoIWZP64lHe49U4Z
         VJqE7YqEdHT+NWfRU9NHr1nrkSd6Pm7LZg2g25Lpa9KlO/K/CDeMpQG7+wGS8rMycN2D
         WnbB3/819KMDrapuXwaIyHhK5pznBtyO3d31H7OLkQL3wq3BdAiDGulOaPQ3fX35hdPl
         Fc/Rb00Zy8+xK6y8R+4a05ykZddbDT7Es/7q7GuhEm6m/30sno5IDwMIHHfJKJm5O5A8
         tj6g==
X-Gm-Message-State: ACrzQf1NRcF7F9oYd80DiOmQ94I6qlZKTx+X1HsHgk/1IQHwPpR7jysy
        RBRMB+S/RG1YD8jjdJq9Y5EzWWLxFTvHlQ==
X-Google-Smtp-Source: AMsMyM5I8AHJMnoQ+x7UvxYXmHQ29rLZy6usWGH5IwWUfZ9ylTPpD8Gzw6dyOstg9GHkUeH4Sc6hPg==
X-Received: by 2002:a1c:ed11:0:b0:3b4:d3e1:bec with SMTP id l17-20020a1ced11000000b003b4d3e10becmr4053192wmh.196.1665761507347;
        Fri, 14 Oct 2022 08:31:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003b47ff307e1sm2219053wmb.31.2022.10.14.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:31:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/11] spatchcache: add a ccache-alike for "spatch"
Date:   Fri, 14 Oct 2022 17:31:27 +0200
Message-Id: <patch-v3-11.11-f7ca3f9c9af-20221014T152553Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com> <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
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
 contrib/coccinelle/spatchcache | 272 +++++++++++++++++++++++++++++++++
 1 file changed, 272 insertions(+)
 create mode 100755 contrib/coccinelle/spatchcache

diff --git a/contrib/coccinelle/spatchcache b/contrib/coccinelle/spatchcache
new file mode 100755
index 00000000000..7ec0dfcb1e4
--- /dev/null
+++ b/contrib/coccinelle/spatchcache
@@ -0,0 +1,272 @@
+#!/bin/sh
+#
+# spatchcache: a poor-man's "ccache"-alike for "spatch" in git.git
+#
+# This caching command relies on the peculiarities of the Makefile
+# driving "spatch" in git.git, in particular if we invoke:
+#
+#	make
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
+
+set -e
+
+## Our own configuration & options
+debug=$(git config --bool "spatchCache.debug")
+if test "$debug" != "true"
+then
+	debug=
+fi
+if test -n "$debug"
+then
+	set -x
+fi
+
+trace=$(git config --bool "spatchCache.trace")
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
+cacheWhenStderr=$(git config --bool "spatchCache.cacheWhenStderr")
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
+spatch=$(git config --path "spatchCache.spatch" || :)
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
+dependFormatCfg=$(git config "spatchCache.dependFormat" || :)
+if test -n "$dependFormatCfg"
+then
+	dependFormat="$dependFormatCfg"
+fi
+
+set=$(git config spatchCache.setCmd || :)
+get=$(git config spatchCache.getCmd || :)
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
2.38.0.1092.g8c0298861b0

