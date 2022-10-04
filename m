Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BEBC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiJDN0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiJDNZC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:25:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588BE3A6
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w18so12579577wro.7
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWeahKb6R8SWjOuJoi4LkW2p+TzZD+qdlUrf+eJCjOk=;
        b=hHr00XRn0RaohVbHRoQvpgIApmmT6odKMq+dnEGZM18rWiUlSOh5CqgqKDrMem6j0y
         Vah6IIiEMYLbupEhl3Kdr6irR65/kRVXYnupesHKPzGWJpGBmKVrt7QtJ0cRYaEIn/ZV
         ZtsS2Rw1jWuyE9ijwVmqxC1XB4cuyDr0t7wL7AcyXjxPtaDIu+vSDwsxx/DdMOs2OVGG
         xwO43gaa1OL+DYUokzEoV58tmsFqIOIGSmiu4aqqMx1NxdYf0sMLQSJouPAON607nRD7
         bn5X6DSpadHVXCP/ozyH5iPPErXrZjLEpB31kxIR3VF9Gh/7yx/z5A1bCMJ1pUmKNeHz
         XG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWeahKb6R8SWjOuJoi4LkW2p+TzZD+qdlUrf+eJCjOk=;
        b=aNMCwAg6dJrn/lpkYp1C+4oxN8nZyQKb50oCTTQLuH8socq20LNjSx1IksA7w76Zmb
         BklShIPZ+oy7YIAOcLsKLGRGtJemVQJS93IBYsgg9T8OD7Rn5jSyGQKtqo7WQtt2SzvT
         0rvlR0yZ17vsVuenkdJqN3eix7d1uffcQ3CKOBe8bQNWuK2fLTcxNh6g1jN7sSLpPQDW
         Iqbw+Spl7zsD6yamtNCQv+ax1vXDfpind30MfCz7Hj3uejsu0mp0eTLjSRO2VRVLoi8B
         0zyUSK9RhI3xoLmO409rN0UV3B/pdMIqRXk2YkyUf1/fiTuIRZx5KPz/6JkNrot0v4aw
         tLHg==
X-Gm-Message-State: ACrzQf0B/50nAsiB0KfBErFAbfe2zU3A9fMHFvGeY96nyJtzdkdlYGsC
        /e3sdRsJVQ1KyhcTBZpb545GRRL2LbKWWQ==
X-Google-Smtp-Source: AMsMyM5a7SxyJLVTWzLV9fu+8kANmktgLsMU3MYow3Hu3zLY4x9ThwbhkG/gjUM/L+ZSZNFQHxGUvw==
X-Received: by 2002:a5d:47a6:0:b0:22a:3764:cdfa with SMTP id 6-20020a5d47a6000000b0022a3764cdfamr16206537wrb.547.1664889873235;
        Tue, 04 Oct 2022 06:24:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 33/34] tests: start asserting that *.txt SYNOPSIS matches -h output
Date:   Tue,  4 Oct 2022 15:23:47 +0200
Message-Id: <patch-v4-33.34-a2abf7a1161-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's been a lot of incremental effort to make the SYNOPSIS output
in our documentation consistent with the -h output,
e.g. cbe485298bf (git reflog [expire|delete]: make -h output
consistent with SYNOPSIS, 2022-03-17) is one recent example, but that
effort has been an uphill battle due to the lack of regression
testing.

This adds such regression testing, we can parse out the SYNOPSIS
output with "sed", and it turns out it's relatively easy to normalize
it and the "-h" output to match on another.

We now ensure that we won't have regressions when it comes to the list
of commands in "expect_help_to_match_txt" below, and in subsequent
commits we'll make more of them consistent.

The naïve parser here gets quite a few things wrong, but it doesn't
need to be perfect, just good enough that we can compare /some/ of
this help output. There's no cases where the output would match except
for the parser's stupidity, it's all cases of e.g. comparing the *.txt
to non-parse_options() output.

Since that output is wildly different than the *.txt anyway let's
leave this for now, we can fix the parser some other time, or it won't
become necessary as we'll e.g. convert more things to using
parse_options().

Having a special-case for "merge-tree"'s 1f0c3a29da3 (merge-tree:
implement real merges, 2022-06-18) is a bit ugly, but preferred to
blessing that " (deprecated)" pattern for other commands. We'd
probably want to add some other way of marking deprecated commands in
the SYNOPSIS syntax. Syntactically 1f0c3a29da3's way of doing it is
indistinguishable from the command taking an optional literal
"deprecated" string as an argument.

Some of the issues that are left:

 * "git show -h", "git whatchanged -h" and "git reflog --oneline -h"
   all showing "git log" and "git show" usage output. I.e. the
   "builtin_log_usage" in builtin/log.c doesn't take into account what
   command we're running.

 * Commands which implement subcommands such as like
   "multi-pack-index", "notes", "remote" etc. having their subcommands
   in a very different order in the *.txt and *.c. Fixing it would
   require some verbose diffs, so it's been left alone for now.

 * Commands such as "format-patch" have a very long argument list in
   the *.txt, but just "[<options>]" in the *.c.

   What to do about these has been left out of this series, except to
   the extent that preceding commits changed "[<options>]" (or
   equivalent) to the list of options in cases where that list of
   options was tiny, or we clearly meant to exhaustively list the
   options in both *.txt and *.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0450-txt-doc-vs-help.sh  | 69 ++++++++++++++++++++++++++++++++++++-
 t/t0450/txt-help-mismatches | 58 +++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 t/t0450/txt-help-mismatches

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index efd00cfc51a..8fd20b6dba6 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
-test_description='assert (unbuilt) Documentation/*.txt and -h output'
+test_description='assert (unbuilt) Documentation/*.txt and -h output
+
+Run this with --debug to see a summary of where we still fail to make
+the two versions consistent with one another.'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
@@ -9,6 +12,14 @@ test_expect_success 'setup: list of builtins' '
 	git --list-cmds=builtins >builtins
 '
 
+test_expect_success 'list of txt and help mismatches is sorted' '
+	sort -u "$TEST_DIRECTORY"/t0450/txt-help-mismatches >expect &&
+	if ! test_cmp expect "$TEST_DIRECTORY"/t0450/txt-help-mismatches
+	then
+		BUG "please keep the list of txt and help mismatches sorted"
+	fi
+'
+
 help_to_synopsis () {
 	builtin="$1" &&
 	out_dir="out/$builtin" &&
@@ -49,6 +60,9 @@ txt_to_synopsis () {
 			/^$/d;
 			/^\[verse\]$/d;
 
+			s/{litdd}/--/g;
+			s/'\''\(git[ a-z-]*\)'\''/\1/g;
+
 			p;
 		}' \
 		<"$b2t" >"$out" &&
@@ -61,6 +75,15 @@ check_dashed_labels () {
 
 HT="	"
 
+align_after_nl () {
+	builtin="$1" &&
+	len=$(printf "git %s " "$builtin" | wc -c) &&
+	pad=$(printf "%${len}s" "") &&
+
+	sed "s/^[ $HT][ $HT]*/$pad/"
+}
+
+test_debug '>failing'
 while read builtin
 do
 	# -h output assertions
@@ -85,6 +108,50 @@ do
 	test_expect_success "$preq" "$builtin *.txt SYNOPSIS has dashed labels" '
 		check_dashed_labels "$(txt_to_synopsis "$builtin")"
 	'
+
+	# *.txt output consistency assertions
+	result=
+	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/txt-help-mismatches
+	then
+		result=failure
+	else
+		result=success
+	fi &&
+	test_expect_$result "$preq" "$builtin -h output and SYNOPSIS agree" '
+		t2s="$(txt_to_synopsis "$builtin")" &&
+		if test "$builtin" = "merge-tree"
+		then
+			test_when_finished "rm -f t2s.new" &&
+			sed -e '\''s/ (deprecated)$//g'\'' <"$t2s" >t2s.new
+			t2s=t2s.new
+		fi &&
+		h2s="$(help_to_synopsis "$builtin")" &&
+
+		# The *.txt and -h use different spacing for the
+		# alignment of continued usage output, normalize it.
+		align_after_nl "$builtin" <"$t2s" >txt &&
+		align_after_nl "$builtin" <"$h2s" >help &&
+		test_cmp txt help
+	'
+
+	if test_have_prereq "$preq" && test -e txt && test -e help
+	then
+		test_debug '
+			if test_cmp txt help >cmp 2>/dev/null
+			then
+				echo "=== DONE: $builtin ==="
+			else
+				echo "=== TODO: $builtin ===" &&
+				cat cmp
+			fi >>failing
+		'
+
+		# Not in test_expect_success in case --run is being
+		# used with --debug
+		rm -f txt help tmp 2>/dev/null
+	fi
 done <builtins
 
+test_debug 'say "$(cat failing)"'
+
 test_done
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
new file mode 100644
index 00000000000..a0777acd667
--- /dev/null
+++ b/t/t0450/txt-help-mismatches
@@ -0,0 +1,58 @@
+add
+am
+apply
+archive
+bisect
+blame
+branch
+check-ref-format
+checkout
+checkout-index
+clone
+column
+config
+credential
+credential-cache
+credential-store
+fast-export
+fast-import
+fetch-pack
+fmt-merge-msg
+for-each-ref
+format-patch
+fsck-objects
+fsmonitor--daemon
+gc
+grep
+index-pack
+init-db
+log
+ls-files
+ls-tree
+mailinfo
+mailsplit
+maintenance
+merge
+merge-file
+merge-index
+merge-one-file
+multi-pack-index
+name-rev
+notes
+pack-objects
+push
+range-diff
+rebase
+remote
+remote-ext
+remote-fd
+repack
+reset
+restore
+rev-parse
+show
+stage
+switch
+update-index
+update-ref
+whatchanged
-- 
2.38.0.rc2.935.g6b421ae1592

