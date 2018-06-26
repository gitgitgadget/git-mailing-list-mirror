Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33DEC1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932164AbeFZHbZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:31:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33413 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbeFZHbW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:22 -0400
Received: by mail-it0-f68.google.com with SMTP id k17-v6so14531300ita.0
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4iwr04s1Xy+LwzThoXcLKcKuAMJ1sGdujpx8RgbpqHM=;
        b=OouDI4s8HUkOQ9TeQ1PPlTEW4nr7eyQ7jk3rjZKVooSUuf3elFN2dXOvVfm9wd01/E
         XY8l+Ssp3qqMUL/BSloIXX+BdqrGSJ+RPZbo4gIA2+MmY3G4eifNcyrha6E3zbb3DZbm
         dqlv6sbOo9DbAZ4FDWugNMSYfoo8KZl5BoO0a0x7arh1uHdyIwSKpxDeOZzrxOtHQ8Ni
         BacNJOkigDMRK6gykGMFGFhUiNCg8Qu//95AeaWTfft6qr545OxbbcoSrDhTQ53XzXNf
         JleBmmqSMhix+3t6CnTnI74mpdTnE6DR7INr7VDfRFitWbxyz3SRNGshd10MZkRRxeKN
         jh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4iwr04s1Xy+LwzThoXcLKcKuAMJ1sGdujpx8RgbpqHM=;
        b=pBH2dw15gzkz7z+KihHGIolFGx9rBAYy/uTCGdVb8zZAhwaKESvbYxHQi3OlcPJOYk
         VdSrF/8QHe230c1NrjQBoFX9IfNcJTYLx20LNcHO4xhBrTgQAYebUWU2oCHv9v08V31e
         6TiAbOAEAAChbTx0v7k3eUivSdg4rvTXI6cKx/91yaF1Gmp/f8cn5TWlaAsfQy3ZSmIf
         iF0c/R08es3nj32Z961xHuBWAqHsZZWuRVzK7XTnFhVyPgI69O4GbXZC5KxXaqzPT9qa
         a5pGXctvsy9TPSJe98brlcZIspeTe8QynQia8kLZuVa7wCZrn2wfYvVwCNqDFtKZcTa0
         xg1Q==
X-Gm-Message-State: APt69E1hL8r0dALlXscTZIIjOIDHehnQ4jfZNAXqXmK1YaBfOcoIN5aB
        5oqUqcQwRghj73DothoOYR99GA==
X-Google-Smtp-Source: AAOMgpdp7SXrM7hp8StHiEd9W1vPpJehYCQ9LZQopZdwSpJvtCMWq7B63lMVAneEzbSvIF9V77FMvg==
X-Received: by 2002:a02:9914:: with SMTP id r20-v6mr288761jaj.144.1529998279583;
        Tue, 26 Jun 2018 00:31:19 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:19 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken &&-chains in subshells
Date:   Tue, 26 Jun 2018 03:30:01 -0400
Message-Id: <20180626073001.6555-30-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
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

Address this shortcoming by eliminating the subshell during the
"linting" phase and incorporating its body directly into the surrounding
&&-chain. To keep this transformation cheap, no attempt is made at
properly parsing shell code. Instead, the manipulations are purely
textual. For example:

    statement1 &&
    (
        statement2 &&
        statement3
    ) &&
    statement4

is transformed to:

    statement1 &&
        statement2 &&
        statement3 &&
    statement4

Notice how "statement3" gains the "&&" which dwelt originally on the
closing ") &&" line. Since this manipulation is purely textual (in fact,
line-by-line), special care is taken to ensure that the "&&" is moved to
the final _statement_ before the closing ")", not necessarily the final
_line_ of text within the subshell. For example, with a here-doc, the
"&&" needs to be added to the opening "<<EOF" line, not to the "EOF"
line which closes it.

In addition to modern subshell formatting shown above, old-style
formatting is also recognized:

    statement1 &&
    (statement2 &&
     statement3) &&
    statement4

Heuristics are employed to properly identify the extent of a subshell
formatted in the old-style since a number of legitimate constructs may
superficially appear to close the subshell even though they don't. For
instance, the ")" in "x=$(command) &&" and "case $x in *)" is specially
recognized to avoid being falsely considered the end of a subshell.

Due to the complexities of line-by-line detection (and limitations of
the tool, 'sed'), only subshells one level deep are handled, as well as
one-liner subshells one level below that. Subshells deeper than that or
multi-line subshells at level two are passed through as-is, thus
&&-chains in their bodies are not checked.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/test-lib.sh | 245 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 244 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 28315706be..ade5066fff 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -664,6 +664,248 @@ test_eval_ () {
 	return $test_eval_ret_
 }
 
+test_subshell_sed_='
+# incomplete line -- slurp up next line
+/[^\\]\\$/ {
+      N
+      s/\\\n//
+}
+
+# here-doc -- swallow it to avoid false hits within its body (but keep the
+# command to which it was attached)
+/<<[ 	]*[-\\]*EOF[ 	]*&&[ 	]*$/ {
+	s/<<[ 	]*[-\\]*EOF//
+	h
+	:hereslurp
+	N
+	s/.*\n//
+	/^[ 	]*EOF[ 	]*$/!bhereslurp
+	x
+	}
+
+# one-liner "(... || git ...)" or "(... || test ...)" -- short-hand for
+# "if ... then : else ...", so leave untouched; contrast with "(... || true)"
+# which ought to be replaced with "test_might_fail ..." to avoid breaking
+# &&-chain
+/^[ 	]*(..*||[ 	]*git[ 	]..*)[ 	]*&&[ 	]*$/b
+/^[ 	]*(..*||[ 	]*git[ 	]..*)[ 	]*$/b
+/^[ 	]*(..*||[ 	]*test..*)[ 	]*&&[ 	]*$/b
+/^[ 	]*(..*||[ 	]*test..*)[ 	]*$/b
+
+# one-liner "(... &) &&" backgrounder -- needs to remain in subshell to avoid
+# becoming syntactically invalid "... & &&"
+/^[ 	]*(..*&[ 	]*)[ 	]*&&[ 	]*$/b
+
+# one-liner "(...) &&" -- strip "(" and ")"
+/^[ 	]*(..*)[ 	]*&&[ 	]*$/ {
+	s/(//
+	s/)[ 	]*&&[ 	]*$/ \&\&/
+	b
+}
+
+# same as above but without trailing "&&"
+/^[ 	]*(..*)[ 	]*$/ {
+	s/(//
+	s/)[ 	]*$//
+	b
+}
+
+# one-liner "(...) >x" (or "2>x" or "<x" or "|x" or "&" -- strip "(" and ")"
+/^[ 	]*(..*)[ 	]*[0-9]*[<>|&]/ {
+	s/(//
+	s/)[ 	]*\([0-9]*[<>|&]\)/\1/
+	b
+}
+
+# multi-line "(..." -- strip "(" and pass-thru enclosed lines until ")"
+/^[ 	]*(/ {
+	# strip "(" and stash for later printing
+	s/(//
+	h
+
+	:discard
+	N
+	s/.*\n//
+
+	# loop: slurp enclosed lines
+	:slurp
+	# end-of-file
+	$beof
+	# incomplete line
+	/[^\\]\\$/bincomplete
+	# here-doc
+	/<<[ 	]*[-\\]*EOF/bheredoc
+	# comment or empty line -- discard since closing ") &&" will need to
+	# add "&&" to final non-comment, non-empty subshell line
+	/^[ 	]*#/bdiscard
+	/^[ 	]*$/bdiscard
+	# one-liner "case ... esac"
+	/^[ 	]*case[ 	]*..*esac/bpassthru
+	# multi-line "case ... esac"
+	/^[ 	]*case[ 	]..*[ 	]in/bcase
+	# nested one-liner "(...) &&"
+	/^[ 	]*(.*)[ 	]*&&[ 	]*$/boneline
+	# nested one-liner "(...)"
+	/^[ 	]*(.*)[ 	]*$/boneline
+	# nested one-liner "(...) >x" (or "2>x" or "<x" or "|x")
+	/^[ 	]*(.*)[ 	]*[0-9]*[<>|]/bonelineredir
+	# nested multi-line "(...\n...)"
+	/^[ 	]*(/bnest
+	# closing ") &&" on own line
+	/^[ 	]*)[ 	]*&&[ 	]*$/bcloseamp
+	# closing ")" on own line
+	/^[ 	]*)[ 	]*$/bclose
+	# closing ") >x" (or "2>x" or "<x" or "|x") on own line
+	/^[ 	]*)[ 	]*[0-9]*[<>|]/bcloseredir
+	# "$((...))" -- not closing ")"
+	/\$(([^)][^)]*))[^)]*$/bpassthru
+	# "$(...)" -- not closing ")"
+	/\$([^)][^)]*)[^)]*$/bpassthru
+	# "=(...)" -- Bash array assignment; not closing ")"
+	/=(/bpassthru
+	# closing "...) &&"
+	/)[ 	]*&&[ 	]*$/bcloseampx
+	# closing "...)"
+	/)[ 	]*$/bclosex
+	# closing "...) >x" (or "2>x" or "<x" or "|x")
+	/)[ 	]*[<>|]/bcloseredirx
+	:passthru
+	# retrieve and print previous line
+	x
+	n
+	bslurp
+
+	# end-of-file -- must be closing "...)" line or empty line; if empty,
+	# strip ")" from previous line, else strip ")" from this line
+	:eof
+	/^[ 	]*$/bempty
+	x
+	p
+	:empty
+	x
+	/)[ 	]*[<>|]/s/[<>|]..*$//
+	s/)[ 	]*$//
+	b
+
+	# found "...\" -- slurp up next line
+	:incomplete
+	N
+	s/\\\n//
+	bslurp
+
+	# found here-doc inside subshell: when a subshell ends, we append
+	# "&&" to the final subshell line to chain it with lines outside the
+	# subshell, however, we cannot append "&&" to the ending EOF of a
+	# here-doc since "&&" belongs on the "<<EOF" opening line, so just
+	# discard the here-doc altogether (but keep the command to which it
+	# was attached)
+	:heredoc
+	s/<<[ 	]*[-\\]*EOF//
+	x
+	p
+	:hereslurpsub
+	N
+	s/.*\n//
+	/^[ 	]*EOF[ 	]*$/bdiscard
+	bhereslurpsub
+
+	# found "case ... in" -- pass-thru untouched to avoid "...)" arms
+	# being misidentified as subshell closing ")"
+	:case
+	x
+	p
+	x
+	:caseslurp
+	n
+	/^[ 	]*esac/besac
+	bcaseslurp
+	:esac
+	x
+	bdiscard
+
+	# found one-liner "(...) &&" or "(...)" -- strip "(" and ")"
+	:oneline
+	s/(//
+	s/)[ 	]*\(&&\)*[ 	]*$/ \1/
+	bpassthru
+
+	# found one-liner "(...) >x" (or "2>x" or "<x" or "|x") -- strip
+	# "(" and ")"
+	:onelineredir
+	s/(//
+	s/)[ 	]*\([0-9]*[<>|]\)/\1/
+	bpassthru
+
+	# found nested multi-line "(...\n...)" -- pass-thru untouched
+	:nest
+	x
+	p
+	x
+	:nslurp
+	n
+	# closing ")" on own line -- stop nested slurp
+	/^[ 	]*)/bnclose
+	# "$((...))" -- not closing ")"
+	/\$(([^)][^)]*))[^)]*$/bnslurp
+	# "$(...)" -- not closing ")"
+	/\$([^)][^)]*)[^)]*$/bnslurp
+	# closing "...)" -- stop nested slurp
+	/)/bnclose
+	bnslurp
+	:nclose
+	# stash ")" (or ") &&", etc.) line for later printing and drop
+	# leftover gunk from hold area
+	x
+	bdiscard
+
+	# found ") &&" -- drop ") &&" and add "&&" to final subshell line
+	:closeamp
+	x
+	s/$/ \&\&/
+	b
+
+	# found ")" -- drop it and print final subshell line
+	:close
+	x
+	b
+
+	# found ") >x" (or "2>x" or "<x" or "|x" or "|") -- replace ")" with
+	# ":" to keep ")|\n" syntactically valid, and add "&&" to final
+	# subshell line
+	:closeredir
+	x
+	s/$/ \&\&/
+	p
+	x
+	s/)/:/
+	b
+
+	# found "...) &&" -- drop ")" but keep "..."
+	:closeampx
+	x
+	p
+	x
+	s/)[ 	]*&&[ 	]*$/ \&\&/
+	b
+
+	# found "...)" -- drop ")" but keep "..."
+	:closex
+	x
+	p
+	x
+	s/)[ 	]*$//
+	b
+
+	# found "...) >x" (or "2>x" or "<x" or "|x") -- drop ")" but keep "..."
+	:closeredirx
+	x
+	p
+	x
+	s/)[ 	]*\([<>|]\)/ \&\& : \1/
+	b
+}
+'
+
 test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
@@ -675,7 +917,8 @@ test_run_ () {
 		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
-		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
+		test_linter=$(printf '%s\n' "$1" | sed -e "$test_subshell_sed_")
+		if test "OK-117" != "$(test_eval_ "(exit 117) && ${test_linter}${LF}${LF}echo OK-\$?" 3>&1)"
 		then
 			error "bug in the test script: broken &&-chain or run-away HERE-DOC: $1"
 		fi
-- 
2.18.0.419.gfe4b301394

