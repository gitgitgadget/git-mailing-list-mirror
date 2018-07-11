Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF231F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 06:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeGKGuu (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 02:50:50 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42184 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeGKGus (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 02:50:48 -0400
Received: by mail-io0-f194.google.com with SMTP id r24-v6so22631343ioh.9
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K6Kb7D+bMeVDF0R43Md4HeBfxYGeM1Ko78Xq4nJyvIk=;
        b=XR7L/1Oi3TSi8A2sWcm/LKXQRf+F6JQsynqAq+g1ZW9GcFOcNlKf4ySnbLMs6zgxx5
         frnPxFdKcvdaUMcRVbalcXW/3jtXaLrsg9AIWlRl23MbDi7G/pzU+kW5TV8HnfyIKB7y
         k8x2Efy6aE0lv0j7YIy+PQFutRPTV+BuOq9DQbSElp2K9w2sYJLJWaU43xTD9Zvl1Kyg
         y2FdeoDJRnGNImCtaAFy+hPWYwJ2+sHfZxcm5hQLkYkdPrPeKCgDU4yBlaCgtF5saT5i
         A32WNp2aTPO/Jji7e4Erh27utsHELz5ntHuBu7naOeSLUGuMQoSpTbBZpEfguKHC78eM
         CoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=K6Kb7D+bMeVDF0R43Md4HeBfxYGeM1Ko78Xq4nJyvIk=;
        b=HLcgiHimGKwEusGmNL3ZPPEGQyhQyWJWV2fKQV271OEAFNZoSGVrAM2QrWPDKKmcoi
         er6q0C9dBNyRJxtb4/T24ZoXBSPy7y0cu5ac8qA7i8t9B/m9oBcyoszca2+Gsgso86/5
         qXfcE2INijIdHkLJ91vKqb6RO5Fya9zNFbZVMIt8NulhbXIiBY+skxHgw4E7PHql08CT
         ghReGihgp1dyyKC10ybjllmmrK4aod2GVm2vPjuTxd4Ow5EVXNpFb9zFpsMWoR92Qvnu
         6VBBlYmp3PXDo8e8hA6dUP/rj3+GtMyaMYnVRobY0XZjtiX6l015n02zo6vIT5w/XAl0
         3zDQ==
X-Gm-Message-State: APt69E0Z4QSgQNQrjmMVAlKuYAfPlm9FYTPtVPcnec9qw/48NkhUnp8/
        ieUlLsNuuAflO2cFh34Zp9K8qA==
X-Google-Smtp-Source: AAOMgpfzf9une5toA7OQbGK5A1+iE2YohZL44LKeegxZmUWxsSC/NMUWFK0IEAytp7O40q8yddd/Dw==
X-Received: by 2002:a6b:33ce:: with SMTP id z197-v6mr24984682ioz.112.1531291682558;
        Tue, 10 Jul 2018 23:48:02 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id b143-v6sm11308298ioe.66.2018.07.10.23.48.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:48:01 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken &&-chains in subshells
Date:   Wed, 11 Jul 2018 02:46:33 -0400
Message-Id: <20180711064642.6933-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180711064642.6933-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --chain-lint option detects broken &&-chains by forcing the test to
exit early (as the very first step) with a sentinel value. If that
sentinel is the test's overall exit code, then the &&-chain is intact;
if not, then the chain is broken. Unfortunately, this detection does not
extend to &&-chains within subshells even when the subshell itself is
properly linked into the outer &&-chain.

Address this shortcoming by feeding the body of the test to a
lightweight "linter" which can peer inside subshells and identify broken
&&-chains by pure textual inspection. Although the linter does not
actually parse shell scripts, it has enough knowledge of shell syntax to
reliably deal with formatting style variations (as evolved over the
years) and to avoid being fooled by non-shell content (such as inside
here-docs and multi-line strings). It recognizes modern subshell
formatting:

    statement1 &&
    (
        statement2 &&
        statement3
    ) &&
    statement4

as well as old-style:

    statement1 &&
    (statement2 &&
     statement3) &&
    statement4

Heuristics are employed to properly identify the extent of a subshell
formatted in the old-style since a number of legitimate constructs may
superficially appear to close the subshell even though they don't. For
example, it understands that neither "x=$(command)" nor "case $x in *)"
end a subshell, despite the ")" at the end of line.

Due to limitations of the tool used ('sed') and its inherent
line-by-line processing, only subshells one level deep are handled, as
well as one-liner subshells one level below that. Subshells deeper than
that or multi-line subshells at level two are passed through as-is, thus
&&-chains in their bodies are not checked.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed | 346 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh   |   3 +-
 2 files changed, 348 insertions(+), 1 deletion(-)
 create mode 100644 t/chainlint.sed

diff --git a/t/chainlint.sed b/t/chainlint.sed
new file mode 100644
index 0000000000..a0de8a3882
--- /dev/null
+++ b/t/chainlint.sed
@@ -0,0 +1,346 @@
+#------------------------------------------------------------------------------
+# Detect broken &&-chains in tests.
+#
+# At present, only &&-chains in subshells are examined by this linter;
+# top-level &&-chains are instead checked directly by the test framework. Like
+# the top-level &&-chain linter, the subshell linter (intentionally) does not
+# check &&-chains within {...} blocks.
+#
+# Checking for &&-chain breakage is done line-by-line by pure textual
+# inspection.
+#
+# Incomplete lines (those ending with "\") are stitched together with following
+# lines to simplify processing, particularly of "one-liner" statements.
+# Top-level here-docs are swallowed to avoid false positives within the
+# here-doc body, although the statement to which the here-doc is attached is
+# retained.
+#
+# Heuristics are used to detect end-of-subshell when the closing ")" is cuddled
+# with the final subshell statement on the same line:
+#
+#    (cd foo &&
+#        bar)
+#
+# in order to avoid misinterpreting the ")" in constructs such as "x=$(...)"
+# and "case $x in *)" as ending the subshell.
+#
+# Lines missing a final "&&" are flagged with "?!AMP?!", and lines which chain
+# commands with ";" internally rather than "&&" are flagged "?!SEMI?!". A line
+# may be flagged for both violations.
+#
+# Detection of a missing &&-link in a multi-line subshell is complicated by the
+# fact that the last statement before the closing ")" must not end with "&&".
+# Since processing is line-by-line, it is not known whether a missing "&&" is
+# legitimate or not until the _next_ line is seen. To accommodate this, within
+# multi-line subshells, each line is stored in sed's "hold" area until after
+# the next line is seen and processed. If the next line is a stand-alone ")",
+# then a missing "&&" on the previous line is legitimate; otherwise a missing
+# "&&" is a break in the &&-chain.
+#
+#    (
+#         cd foo &&
+#         bar
+#    )
+#
+# In practical terms, when "bar" is encountered, it is flagged with "?!AMP?!",
+# but when the stand-alone ")" line is seen which closes the subshell, the
+# "?!AMP?!" violation is removed from the "bar" line (retrieved from the "hold"
+# area) since the final statement of a subshell must not end with "&&". The
+# final line of a subshell may still break the &&-chain by using ";" internally
+# to chain commands together rather than "&&", so "?!SEMI?!" is never removed
+# from a line (even though "?!AMP?!" might be).
+#
+# Care is taken to recognize the last _statement_ of a multi-line subshell, not
+# necessarily the last textual _line_ within the subshell, since &&-chaining
+# applies to statements, not to lines. Consequently, blank lines, comment
+# lines, and here-docs are swallowed (but not the command to which the here-doc
+# is attached), leaving the last statement in the "hold" area, not the last
+# line, thus simplifying &&-link checking.
+#
+# The final statement before "done" in for- and while-loops, and before "elif",
+# "else", and "fi" in if-then-else likewise must not end with "&&", thus
+# receives similar treatment.
+#
+# To facilitate regression testing (and manual debugging), a ">" annotation is
+# applied to the line containing ")" which closes a subshell, ">>" to a line
+# closing a nested subshell, and ">>>" to a line closing both at once. This
+# makes it easy to detect whether the heuristics correctly identify
+# end-of-subshell.
+#------------------------------------------------------------------------------
+
+# incomplete line -- slurp up next line
+:squash
+/\\$/ {
+      N
+      s/\\\n//
+      bsquash
+}
+
+# here-doc -- swallow it to avoid false hits within its body (but keep the
+# command to which it was attached)
+/<<[ 	]*[-\\]*EOF[ 	]*/ {
+	s/[ 	]*<<[ 	]*[-\\]*EOF//
+	h
+	:hereslurp
+	N
+	s/.*\n//
+	/^[ 	]*EOF[ 	]*$/!bhereslurp
+	x
+}
+
+# one-liner "(...) &&"
+/^[ 	]*!*[ 	]*(..*)[ 	]*&&[ 	]*$/boneline
+
+# same as above but without trailing "&&"
+/^[ 	]*!*[ 	]*(..*)[ 	]*$/boneline
+
+# one-liner "(...) >x" (or "2>x" or "<x" or "|x" or "&"
+/^[ 	]*!*[ 	]*(..*)[ 	]*[0-9]*[<>|&]/boneline
+
+# multi-line "(...\n...)"
+/^[ 	]*(/bsubshell
+
+# innocuous line -- print it and advance to next line
+b
+
+# found one-liner "(...)" -- mark suspect if it uses ";" internally rather than
+# "&&" (but not ";" in a string)
+:oneline
+/;/{
+	/"[^"]*;[^"]*"/!s/^/?!SEMI?!/
+}
+b
+
+:subshell
+# bare "(" line?
+/^[ 	]*([	]*$/ {
+	# stash for later printing
+	h
+	bnextline
+}
+# "(..." line -- split off and stash "(", then process "..." as its own line
+x
+s/.*/(/
+x
+s/(//
+bslurp
+
+:nextline
+N
+s/.*\n//
+
+:slurp
+# incomplete line "...\"
+/\\$/bincomplete
+# multi-line quoted string "...\n..."
+/^[^"]*"[^"]*$/bdqstring
+# multi-line quoted string '...\n...' (but not contraction in string "it's so")
+/^[^']*'[^']*$/{
+	/"[^'"]*'[^'"]*"/!bsqstring
+}
+# here-doc -- swallow it
+/<<[ 	]*[-\\]*EOF/bheredoc
+/<<[ 	]*[-\\]*EOT/bheredoc
+/<<[ 	]*[-\\]*INPUT_END/bheredoc
+# comment or empty line -- discard since final non-comment, non-empty line
+# before closing ")", "done", "elsif", "else", or "fi" will need to be
+# re-visited to drop "suspect" marking since final line of those constructs
+# legitimately lacks "&&", so "suspect" mark must be removed
+/^[ 	]*#/bnextline
+/^[ 	]*$/bnextline
+# in-line comment -- strip it (but not "#" in a string, Bash ${#...} array
+# length, or Perforce "//depot/path#42" revision in filespec)
+/[ 	]#/{
+	/"[^"]*#[^"]*"/!s/[ 	]#.*$//
+}
+# one-liner "case ... esac"
+/^[ 	]*case[ 	]*..*esac/bcheckchain
+# multi-line "case ... esac"
+/^[ 	]*case[ 	]..*[ 	]in/bcase
+# multi-line "for ... done" or "while ... done"
+/^[ 	]*for[ 	]..*[ 	]in/bcontinue
+/^[ 	]*while[ 	]/bcontinue
+/^[ 	]*do[ 	]/bcontinue
+/^[ 	]*do[ 	]*$/bcontinue
+/;[ 	]*do/bcontinue
+/^[ 	]*done[ 	]*&&[ 	]*$/bdone
+/^[ 	]*done[ 	]*$/bdone
+/^[ 	]*done[ 	]*[<>|]/bdone
+/^[ 	]*done[ 	]*)/bdone
+/||[ 	]*exit[ 	]/bcontinue
+/||[ 	]*exit[ 	]*$/bcontinue
+# multi-line "if...elsif...else...fi"
+/^[ 	]*if[ 	]/bcontinue
+/^[ 	]*then[ 	]/bcontinue
+/^[ 	]*then[ 	]*$/bcontinue
+/;[ 	]*then/bcontinue
+/^[ 	]*elif[ 	]/belse
+/^[ 	]*elif[ 	]*$/belse
+/^[ 	]*else[ 	]/belse
+/^[ 	]*else[ 	]*$/belse
+/^[ 	]*fi[ 	]*&&[ 	]*$/bdone
+/^[ 	]*fi[ 	]*$/bdone
+/^[ 	]*fi[ 	]*[<>|]/bdone
+/^[ 	]*fi[ 	]*)/bdone
+# nested one-liner "(...) &&"
+/^[ 	]*(.*)[ 	]*&&[ 	]*$/bcheckchain
+# nested one-liner "(...)"
+/^[ 	]*(.*)[ 	]*$/bcheckchain
+# nested one-liner "(...) >x" (or "2>x" or "<x" or "|x")
+/^[ 	]*(.*)[ 	]*[0-9]*[<>|]/bcheckchain
+# nested multi-line "(...\n...)"
+/^[ 	]*(/bnest
+# multi-line "{...\n...}"
+/^[ 	]*{/bblock
+# closing ")" on own line -- exit subshell
+/^[ 	]*)/bclosesolo
+# "$((...))" -- arithmetic expansion; not closing ")"
+/\$(([^)][^)]*))[^)]*$/bcheckchain
+# "$(...)" -- command substitution; not closing ")"
+/\$([^)][^)]*)[^)]*$/bcheckchain
+# multi-line "$(...\n...)" -- command substitution; treat as nested subshell
+/\$([ 	     ]*$/bnest
+# "=(...)" -- Bash array assignment; not closing ")"
+/=(/bcheckchain
+# closing "...) &&"
+/)[ 	]*&&[ 	]*$/bclose
+# closing "...)"
+/)[ 	]*$/bclose
+# closing "...) >x" (or "2>x" or "<x" or "|x")
+/)[ 	]*[<>|]/bclose
+:checkchain
+# mark suspect if line uses ";" internally rather than "&&" (but not ";" in a
+# string and not ";;" in one-liner "case...esac")
+/;/{
+	/;;/!{
+		/"[^"]*;[^"]*"/!s/^/?!SEMI?!/
+	}
+}
+# line ends with pipe "...|" -- valid; not missing "&&"
+/|[ 	]*$/bcontinue
+# missing end-of-line "&&" -- mark suspect
+/&&[ 	]*$/!s/^/?!AMP?!/
+:continue
+# retrieve and print previous line
+x
+n
+bslurp
+
+# found incomplete line "...\" -- slurp up next line
+:incomplete
+N
+s/\\\n//
+bslurp
+
+# found multi-line double-quoted string "...\n..." -- slurp until end of string
+:dqstring
+s/"//g
+N
+s/\n//
+/"/!bdqstring
+bcheckchain
+
+# found multi-line single-quoted string '...\n...' -- slurp until end of string
+:sqstring
+s/'//g
+N
+s/\n//
+/'/!bsqstring
+bcheckchain
+
+# found here-doc -- swallow it to avoid false hits within its body (but keep
+# the command to which it was attached); take care to handle here-docs nested
+# within here-docs by only recognizing closing tag matching outer here-doc
+# opening tag
+:heredoc
+/EOF/{ s/[ 	]*<<[ 	]*[-\\]*EOF//; s/^/EOF/; }
+/EOT/{ s/[ 	]*<<[ 	]*[-\\]*EOT//; s/^/EOT/; }
+/INPUT_END/{ s/[ 	]*<<[ 	]*[-\\]*INPUT_END//; s/^/INPUT_END/; }
+:hereslurpsub
+N
+/^EOF.*\n[ 	]*EOF[ 	]*$/bhereclose
+/^EOT.*\n[ 	]*EOT[ 	]*$/bhereclose
+/^INPUT_END.*\n[ 	]*INPUT_END[ 	]*$/bhereclose
+bhereslurpsub
+:hereclose
+s/^EOF//
+s/^EOT//
+s/^INPUT_END//
+s/\n.*$//
+bcheckchain
+
+# found "case ... in" -- pass through untouched
+:case
+x
+n
+/^[ 	]*esac/bslurp
+bcase
+
+# found "else" or "elif" -- drop "suspect" from final line before "else" since
+# that line legitimately lacks "&&"
+:else
+x
+s/?!AMP?!//
+x
+bcontinue
+
+# found "done" closing for-loop or while-loop, or "fi" closing if-then -- drop
+# "suspect" from final contained line since that line legitimately lacks "&&"
+:done
+x
+s/?!AMP?!//
+x
+# is 'done' or 'fi' cuddled with ")" to close subshell?
+/done.*)/bclose
+/fi.*)/bclose
+bcheckchain
+
+# found nested multi-line "(...\n...)" -- pass through untouched
+:nest
+x
+:nestslurp
+n
+# closing ")" on own line -- stop nested slurp
+/^[ 	]*)/bnestclose
+# comment -- not closing ")" if in comment
+/^[ 	]*#/bnestcontinue
+# "$((...))" -- arithmetic expansion; not closing ")"
+/\$(([^)][^)]*))[^)]*$/bnestcontinue
+# "$(...)" -- command substitution; not closing ")"
+/\$([^)][^)]*)[^)]*$/bnestcontinue
+# closing "...)" -- stop nested slurp
+/)/bnestclose
+:nestcontinue
+x
+bnestslurp
+:nestclose
+s/^/>>/
+# is it "))" which closes nested and parent subshells?
+/)[ 	]*)/bslurp
+bcheckchain
+
+# found multi-line "{...\n...}" block -- pass through untouched
+:block
+x
+n
+# closing "}" -- stop block slurp
+/}/bcheckchain
+bblock
+
+# found closing ")" on own line -- drop "suspect" from final line of subshell
+# since that line legitimately lacks "&&" and exit subshell loop
+:closesolo
+x
+s/?!AMP?!//
+p
+x
+s/^/>/
+b
+
+# found closing "...)" -- exit subshell loop
+:close
+x
+p
+x
+s/^/>/
+b
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 28315706be..78f7097746 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -675,7 +675,8 @@ test_run_ () {
 		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
-		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
+		if $(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!') ||
+			test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
 		then
 			error "bug in the test script: broken &&-chain or run-away HERE-DOC: $1"
 		fi
-- 
2.18.0.203.gfac676dfb9

