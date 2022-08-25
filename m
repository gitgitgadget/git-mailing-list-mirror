Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABA2C64990
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 14:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242217AbiHYOgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 10:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242109AbiHYOgc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 10:36:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C6FABD48
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 07:36:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k9so24906973wri.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Pus+R7DGKkj2ltQJo3J9Ko2zdcKTe7fI3iSNnQXvMWY=;
        b=imIFiQAi+dQTweNDarM9Z5FcW1IwifJjSIq7Hg6O3zJdxCJvBmaJZOH5bB3MLvemRr
         Jik7YkgJ0UQ557FJBLo+94zkeII0iFf157QQIafAV4/8gjiqloMRGtmt9lwvvPmu1wGU
         qlpv1Y5sDllCexMTTsV4qnBGJYgb0MIWRITzYwKg5lZEP8+tGQqtWuPTioVPy8a9gsl7
         pKyngA1rZkqPHz9z/iw+8dXWPooWBNQBh1+VQD8XUu+OJfh96P3GWV+yO0pL1LsM5P5v
         1ig9KDWOtk60877/NswBOTTMmICO+eLN2Gn3c4LGbe7/2YMgyfoZP1To0mpUEQ+FaFdN
         f0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Pus+R7DGKkj2ltQJo3J9Ko2zdcKTe7fI3iSNnQXvMWY=;
        b=qTJHsjb6GAK9w5LdBuQb27uUMX5/Id0QagTHuAPLFSKyFJjstqfjr7KjuTyPawUkwX
         f1T+1BxU3suBHDDhkpPzjhVaBcMGVGGGnTEE+Tg+lNv68rbWRbJqulz5bIqUPuP+I4sM
         hQWjzM2rviZI7/xcQhU51EHgq99PIzN86neBIg2avBQ4ySvYkfgotnQ/5K4jqVdYql4U
         fwUsR7R1VM5sFz71hLaS0g4ttGu6kGkCIJ9XNWVXZ5u9hzlFqfk5mky/1uFm5JGxbepY
         h9T2boQYC+R7T9HIZbDGtsk9Hkjc+ty0JxscrHXaEEKyeaeH8YJhrqthuJpozG4MFOMg
         kY4A==
X-Gm-Message-State: ACgBeo0Vk+IzPjQh0tCRQ2m6oB7scUh8lm/fl5T35y9tJQtXKuxqoMub
        f3qK/pkyZs74/2s+Q0uUq0hXqQ9pzDu3lw==
X-Google-Smtp-Source: AA6agR6Um+VyUbbeP27nOXznvsCiN0sRK3ogecEnnnWQKmT1ldlNPJxGuQY448q/ByA8R+3rkZb83w==
X-Received: by 2002:a05:6000:11c8:b0:225:3316:6957 with SMTP id i8-20020a05600011c800b0022533166957mr2503632wrx.218.1661438185793;
        Thu, 25 Aug 2022 07:36:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m27-20020a056000181b00b0022549ac786asm14418027wrh.47.2022.08.25.07.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 07:36:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] spatchcache: add a ccache-alike for "spatch"
Date:   Thu, 25 Aug 2022 16:36:17 +0200
Message-Id: <patch-5.5-ce4734e5d79-20220825T141212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a rather trivial "spatchcache", with this running e.g.:

	make clean
	make contrib/coccinelle/free.cocci.patch

Is cut down from ~20s to ~3s on my system (and much of it is fixable
shell overhead). This uses "redis" as a cache by default, but it's
configurable. See the embedded documentation.

This is *not* like ccache in that we won't cache failed spatch
invocations, or those where spatch suggests changes for us. Those
cases are so rare that I didn't think it was worth the bother, by far
the most common case is that it has no suggested changes.

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
 contrib/coccinelle/spatchcache | 217 +++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)
 create mode 100755 contrib/coccinelle/spatchcache

diff --git a/contrib/coccinelle/spatchcache b/contrib/coccinelle/spatchcache
new file mode 100755
index 00000000000..f4f44700cfc
--- /dev/null
+++ b/contrib/coccinelle/spatchcache
@@ -0,0 +1,217 @@
+#!/bin/sh
+#
+# spatchcache: a poor-man's "ccache"-alike for "spatch" in git.git
+#
+# This caching command relies on the peculiarities of the Makefile
+# driving "spatch" in git.git, in particular if we invoke:
+#
+#	make
+#	make coccicheck
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
+# To use this, simply set SPATCH to
+# contrib/coccinelle/spatchcache. Then optionally set:
+#
+#	[spatchCache]
+#		# path to a custom spatch
+#		spatch = ~/g/coccicheck/spatch.opt
+#
+# As well as this trace config (debug implies trace):
+#
+#		trace = false
+#		debug = false
+#
+# Setting "trace" to "true" allows for seeing when we have a cache HIT
+# or MISS.
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
+	trace_it "$0: have no '$dep' for '$arg_file', can't cache!"
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
+	trace_it "$0: NO CACHE (have changes): for '$arg_file' with '$arg_sp'"
+	cat "$out"
+	cat "$err" >&2
+	rm -f "$out" "$err"
+	exit "$ret"
+fi
+rm -f "$out" "$err"
-- 
2.37.2.1279.g64dec4e13cf

