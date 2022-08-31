Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578ADECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiHaU6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiHaU6P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:58:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09253F2410
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:14 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id az27so19804225wrb.6
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bx45SRo/L19bzgeqWcj1onO/DutGAnmIgp6nsnVuDrU=;
        b=H8GWyaqxXaRc69tQQC22iAVANLPLmBDBL2MK2RTfvY6MqSupAl929me/l311AXwFjc
         Kx9f8oKKCUbTmLSyIdsCK6DFEPbrIdNMgdJ9tjlEZOmh4pagFSHgUTUGzb4a6ll+mMfW
         wZSSfjuQVQx6OSAgMtkb9EUwHWxszByq8tmURgbo8NYR4LXeTGX+TXCNenfHZspmZmTo
         Mi6394DFvitLRyqJBb92Gsxgauv2h8CM/Jy8uvo1TNZAKzCIM4dtYqHviEDTKLxHOfvn
         loWItASDFk5/RZNpxjtHsKWmWuNwD1PsKZ98zftrsmV8lSY5R74hgKGM9PyUpt1fXpjO
         tQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bx45SRo/L19bzgeqWcj1onO/DutGAnmIgp6nsnVuDrU=;
        b=6xJYkCwGQyG6JQNNh9T+960zF4umiWCBglggOsmVmwgnacO7eJg0jMD2xe7GPapqkM
         N2RHNd0lw7MLpGBAtTh0Dmih17VMWCt2+Dwce85E9y7wjUq6PWZG5BaF2tpDJ012UohH
         mx3BV/0K9vAAc/dTgVwu6MsSQJn3GrNldm7zidRcpt8CwrxO7fMLMETqXDA4LyfT5wmT
         52LZFzCd3jJRp3yfO1yctDsWcOBNFR9ZOOVQw18fhehjhzmUfT0hhNa+f/G/ZbVMpvBz
         KWPusOJqsbFTXchNhn86Y7m2pGhkGHiLJWt5MgaQtuLcNZyYgx+UqvBbY8tCGsW3RuXs
         IriQ==
X-Gm-Message-State: ACgBeo1rGFUSKykEFD3s9ntorao+zo3/fy3hOFcz0t/79GQeHj6AXkf8
        3UjUeva/hHdjErJTdh8+9SUhtW0zkb9rtQ==
X-Google-Smtp-Source: AA6agR6DAaBiBsc5Cdi7TxhJFEcXdgxuvUEBjbhYjtbZLHkANPE+fKrnB+bzQEtDBN6KdSqvgZ/xew==
X-Received: by 2002:a5d:460a:0:b0:225:86c6:6e1 with SMTP id t10-20020a5d460a000000b0022586c606e1mr12834253wrq.117.1661979492066;
        Wed, 31 Aug 2022 13:58:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b002253af82fa7sm15766955wrr.9.2022.08.31.13.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:58:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 9/9] spatchcache: add a ccache-alike for "spatch"
Date:   Wed, 31 Aug 2022 22:57:56 +0200
Message-Id: <patch-v2-9.9-2b978676a56-20220831T205130Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
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
 contrib/coccinelle/spatchcache | 234 +++++++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)
 create mode 100755 contrib/coccinelle/spatchcache

diff --git a/contrib/coccinelle/spatchcache b/contrib/coccinelle/spatchcache
new file mode 100755
index 00000000000..f0b7b24e0ae
--- /dev/null
+++ b/contrib/coccinelle/spatchcache
@@ -0,0 +1,234 @@
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
+# be errors from spatch). The STDERR (and exit code) could in
+# principle be cached (as with ccache), but then the simple structure
+# in the Redis cache would need to change, so just supply
+# "--very-quiet" for now.
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
+#		trace = false
+#		debug = false
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
+	echo "spatch=$spatch"
+	echo "args=$args"
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
+d=$(dirname "$arg_file")
+b=$(basename "$arg_file")
+bwoext="${b%.c}"
+dep="$d/.depend/$bwoext.o.d"
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
+"$spatch" "$@" >"$out" 2>"$err"
+ret=$?
+set -e
+
+if test $ret = 0 && ! test -s "$out" && ! test  -s "$err"
+then
+	rm -f "$out" "$err"
+
+	trace_it "$0: SET: for '$arg_file' with '$arg_sp'"
+
+	setret=
+	if test -z "$set"
+	then
+		if test $(redis-cli SADD spatch-cache "$sum") = 1
+		then
+			setret=0
+		else
+			setret=1
+		fi
+	else
+		"$set" "$sum"
+		setret=$?
+	fi
+
+	if test "$setret" != 0
+	then
+		echo "FAILED to set '$sum' in cache!" >&2
+		exit 128
+	fi
+else
+	trace_it "$0: NOCACHE (have changes): for '$arg_file' with '$arg_sp'"
+	cat "$out"
+	cat "$err" >&2
+	rm -f "$out" "$err"
+	exit "$ret"
+fi
+rm -f "$out" "$err"
-- 
2.37.3.1420.g76f8a3d556c

