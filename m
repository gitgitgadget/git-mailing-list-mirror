Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F54C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiI3SMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiI3SLX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:11:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDEBC1E9C
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:10:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o5so3415247wms.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iUo6K7tIFzhqzRZOz6KZH8fjxc1telr0QE5uIa0Eq0U=;
        b=QIZDTCVPI4RYWXiFhasVnWnFv1d5blGswfAnIAST0MfCsNWWdHWhtwDN+ooRCA86mh
         eD1Fc5E+ugzV+55nfoF1K43gbvXMB47gh6fWWIrB+7KuHLFxS5zOfSGHUUtpLks9fkD2
         mb7DrsYWWfVqbiJ2vCeKpODOewQJnY+giagHZtWta9aq0BXI6m4X7Ci8huDPNxz+QpBO
         oRxYI4m0JBETRm0iJwyUQuTK0TScVGshEuVlgYpKb0fIRwHIWLIMxCAp5NZhtEfcs4GP
         7MY8OtPR1765LDX7p6y/iHLMVm6Q4IlAxI2PqsqGNZX0BBULHSjkClEJR2BhLz8I66c6
         7noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iUo6K7tIFzhqzRZOz6KZH8fjxc1telr0QE5uIa0Eq0U=;
        b=U2lGOWKLgW/Upi1ZbyjkHL0/ExsBTQpMMoLbu3yH4MhFQyCTS53461mxeErTSR5HwQ
         LEuTnoKxHmjiGwp9mBbpgzxliAg2iA5hwe707avqUJcvP1jlO8wp9L0WBDi9ld74dAM8
         gdVhEEasYCxRpHOG8mwx8V7z7ziMUj6wguHV69ic8GKISSjIcAJ0y7inCEXfAG1w+dg1
         NOaKRHE+g3VxmOVcFtmveiGP8lxdkWVeHCZ0X2cDA0fyuiEheI4TealF9LCkKs65Ret6
         8tLx4X2g5lTfxUOaLQVWkrcq1I1G6h67JPN+xq8EU7cKkKOoX4iIxWSXstM25GPHIEER
         xgxw==
X-Gm-Message-State: ACrzQf2XR1PgWGYulzxLVwIbzcC59NZrmKiAWmVCUdsOcJEHhCYkIAdW
        If06WtnJGnpHVfAMqnCXT1eBSyANTv5z+A==
X-Google-Smtp-Source: AMsMyM5obD3St+hcUQmd7c0buXurhVA+Ydm9QFntgLFLmd6Lw4l5MBlF/37y2M3U0MJb5VR7ESI9Iw==
X-Received: by 2002:a7b:c858:0:b0:3b5:7315:3c0d with SMTP id c24-20020a7bc858000000b003b573153c0dmr6652671wml.38.1664561405526;
        Fri, 30 Sep 2022 11:10:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:10:02 -0700 (PDT)
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
Subject: [PATCH v3 35/36] tests: start asserting that *.txt SYNOPSIS matches -h output
Date:   Fri, 30 Sep 2022 20:07:58 +0200
Message-Id: <patch-v3-35.36-22da68abce3-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
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
output with "sed", and is turns out it's relatively easy to normalize
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

 * Likewise "git stage -h" shows "git add" usage, but should be aware
   of what command it's running. The same for "annotate" and "blame".

 * Commands which implement subcommands such as like
   "multi-pack-index", "notes", "remote" etc. having their subcommands
   in a very different order in the *.txt and *.c. Fixing it would
   require some verbose diffs, so it's been left alone for onw.

 * Commands such as "format-patch" have a very long argument list in
   the *.txt, but just "[<options>]" in the *.c.

   What to do about these has been left out of this series, except to
   the extent that preceding commits changed "[<options>]" (or
   equivalent) to the list of options in cases where that list of
   options was tiny, or we clearly meant to exhaustively list the
   options in both *.txt and *.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0450-txt-doc-vs-help.sh  | 121 ++++++++++++++++++++++++++++++++++++
 t/t0450/txt-help-mismatches |  58 +++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100755 t/t0450-txt-doc-vs-help.sh
 create mode 100644 t/t0450/txt-help-mismatches

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
new file mode 100755
index 00000000000..6a710b07408
--- /dev/null
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -0,0 +1,121 @@
+#!/bin/sh
+
+test_description='compare (unbuilt) Documentation/*.txt to -h output
+
+Run this with --debug to see a summary of where we still fail to make
+the two versions consistent with one another.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup: list of builtins' '
+	git --list-cmds=builtins >builtins
+'
+
+test_expect_success 'list of txt and help mismatches is sorted' '
+	sort -u "$TEST_DIRECTORY"/t0450/txt-help-mismatches >expect &&
+	if ! test_cmp expect "$TEST_DIRECTORY"/t0450/txt-help-mismatches
+	then
+		BUG "please keep the list of txt and help mismatches sorted"
+	fi
+'
+
+builtin_to_synopsis () {
+	builtin="$1" &&
+	test_when_finished "rm -f out" &&
+	test_expect_code 129 git $builtin -h >out 2>&1 &&
+	sed -n \
+		-e '1,/^$/ {
+			/^$/d;
+			s/^usage: //;
+			s/^ *or: //;
+			p;
+		}' <out
+}
+
+builtin_to_txt () {
+	echo "$GIT_BUILD_DIR/Documentation/git-$1.txt"
+}
+
+txt_synopsis () {
+	sed -n \
+		-e '/^\[verse\]$/,/^$/ {
+			/^$/d;
+			/^\[verse\]$/d;
+			s/{litdd}/--/g;
+
+			s/'\''\(git[ a-z-]*\)'\''/\1/g;
+			p;
+		}' \
+		<"$1"
+}
+
+HT="	"
+align_after_nl () {
+	builtin="$1" &&
+	len=$(printf "git %s " "$builtin" | wc -c) &&
+	pad=$(printf "%${len}s" "") &&
+
+	sed "s/^[ $HT][ $HT]*/$pad/"
+}
+
+test_debug '>failing'
+while read builtin
+do
+	test_expect_success "$builtin -h output has no \t" '
+		builtin_to_synopsis "$builtin" >help.raw &&
+		! grep "$HT" help.raw
+	'
+
+	txt="$(builtin_to_txt "$builtin")" &&
+	preq="$(echo BUILTIN_TXT_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
+
+	if test -f "$txt"
+	then
+		test_set_prereq "$preq"
+	fi &&
+
+	result=
+	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/txt-help-mismatches
+	then
+		result=failure
+	else
+		result=success
+	fi &&
+
+	test_expect_$result "$preq" "$builtin -h output and SYNOPSIS agree" '
+		txt_synopsis "$txt" >txt.raw &&
+		if test "$builtin" = "merge-tree"
+		then
+			sed -e '\''s/ (deprecated)$//g'\'' <txt.raw >txt.raw.new &&
+			mv txt.raw.new txt.raw
+		fi &&
+		builtin_to_synopsis "$builtin" >help.raw &&
+
+		# The *.txt and -h use different spacing for the
+		# alignment of continued usage output, normalize it.
+		align_after_nl "$builtin" <txt.raw >txt &&
+		align_after_nl "$builtin" <help.raw >help &&
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
+done <builtins
+
+test_debug 'say "$(cat failing)"'
+
+test_done
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

