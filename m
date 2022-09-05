Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2ABC6FA86
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiIEI3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbiIEI2s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:28:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD46A4D81B
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w5so10255393wrn.12
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bhMvlTZwja2kEJlAQjkKIDEqcR95xGopeCehxQ8Vpuw=;
        b=p3qvDWcUiOQUzcjdY2IfwlPbAV+1VGqgvUiyc58F/4NCLOkMziNVDOGCbaROuUTrg+
         3aIDC4bAYDanK7U6IOy5RvA5fW/I2EeouAb7vySEDEW8WNLmuN05smmsLaHasRa8MyNJ
         NF9VzdrSzz4ThlqLc82W6jibj/hkm2DyJdlf2q6AugwJ2PLsTDOEjwnTdTkSiQzw5CT7
         SABdzl0q5JLg090379Gj4jbEzdmWyfk7ZDpEjgkbXxVAd9Dph+0qFLo71u8bSM5wSvJi
         Ibjfv0cOXvimpSH+2V6wx0YIJE1V5wLawixCKjlYp4O7RhuuTOlD/w6OGEgjzc2vD6Lx
         ISag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bhMvlTZwja2kEJlAQjkKIDEqcR95xGopeCehxQ8Vpuw=;
        b=vX1bG6mXNTPzf7PEeto7em9TgnwszG3AfK50iPiRN7EpEqIwMaR1EvBFxHq/2SqEGJ
         Wo5nt/VNNA8TuUtSaWT0wWGvh2wFETpoOSxMEn4tgoD+NOYPfbP/uGWhJCOdFpBveTru
         Faa0iaLnWDp7WBCUsYlFH8rsQo/EHCE55MOgOmV/aQJVjDkGIriTV9hiVLog0NHuh5Ws
         3K6b9DzzI74I75KxGnHp1atE/Ebis7YHs6OTc6B2NQrwxdQHDdbrH6dQz2kU5C55wG+9
         3T37Odas4lxBUKAmrJS68oUrFylv5haICfJI9qiOdSIMcjs9Fm7gYUpXhTH2Dk41mJho
         iAjA==
X-Gm-Message-State: ACgBeo0gYeiC/L32xAMorJqhhCUOnbaDjRCiZOVdLMWZJ5nGzP8vyZS6
        l3EZ+LxWU8BmzYDJcAUMHr6J7f5HTKhDsQ==
X-Google-Smtp-Source: AA6agR5G6liQl9cAtn12vTqSGPha27EcTjkkij47n2Ipw/ST8UCQg0+pOJeW7wvaPrj1LVIduugIEg==
X-Received: by 2002:a5d:64ee:0:b0:226:db9b:e381 with SMTP id g14-20020a5d64ee000000b00226db9be381mr20576631wri.52.1662366445171;
        Mon, 05 Sep 2022 01:27:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 34/34] tests: start asserting that *.txt SYNOPSIS matches -h output
Date:   Mon,  5 Sep 2022 10:26:45 +0200
Message-Id: <patch-34.34-c15c1422055-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
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
 Documentation/CodingGuidelines |   3 +-
 t/t0450-txt-doc-vs-help.sh     | 179 +++++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100755 t/t0450-txt-doc-vs-help.sh

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 0d959f8c96b..a60393df04a 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -634,7 +634,8 @@ Writing Documentation:
 
  A few commented examples follow to provide reference when writing or
  modifying command usage strings and synopsis sections in the manual
- pages:
+ pages. The two should match, see t/t0450-txt-doc-vs-help.sh for
+ (partial) regression testing.
 
  Placeholders are spelled in lowercase and enclosed in angle brackets:
    <file>
diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
new file mode 100755
index 00000000000..8af845bcd46
--- /dev/null
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -0,0 +1,179 @@
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
+test_expect_success 'setup: list of txt v.s. help' '
+	cat >list <<-\EOF
+	add
+	am
+	apply
+	archive
+	bisect
+	blame
+	branch
+	check-ref-format
+	checkout
+	checkout-index
+	clone
+	column
+	config
+	credential
+	credential-cache
+	credential-store
+	fast-export
+	fast-import
+	fetch-pack
+	fmt-merge-msg
+	for-each-ref
+	format-patch
+	fsck-objects
+	fsmonitor--daemon
+	gc
+	grep
+	index-pack
+	init-db
+	log
+	ls-files
+	ls-tree
+	mailinfo
+	mailsplit
+	maintenance
+	merge
+	merge-file
+	merge-index
+	merge-one-file
+	multi-pack-index
+	name-rev
+	notes
+	pack-objects
+	push
+	range-diff
+	rebase
+	remote
+	remote-ext
+	remote-fd
+	repack
+	reset
+	restore
+	rev-parse
+	show
+	stage
+	switch
+	update-index
+	update-ref
+	whatchanged
+	EOF
+'
+
+test_expect_success 'setup: list of txt v.s. help is sorted' '
+	sort -u list >list.sorted &&
+	if ! test_cmp list list.sorted
+	then
+		BUG "please keep the command list sorted"
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
+			p
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
+	txt="$(builtin_to_txt "$builtin")" &&
+	preq="$(echo BUILTIN_TXT_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
+
+	if test -f "$txt"
+	then
+		test_set_prereq "$preq"
+	fi &&
+
+	result=
+	if grep -q "^$builtin$" list
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
-- 
2.37.3.1425.g73df845bcb2

