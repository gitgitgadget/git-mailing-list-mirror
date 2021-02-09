Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E59EC433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D81D864E3C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhBIW71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhBIW1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:27:43 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27092C03C064
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:42:27 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o10so2516491wmc.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xlGXz/J0teIzXoNPQlE9mNebzlOCyRuLG7mxD9PC10Q=;
        b=iCd5CmEkh7L7KqsNksOkjEpGUHWGd5ubjPcNlW6mt0vbMp2av7bw0rrWImidSVZ4HZ
         RbpyHcjiKtAq13o3vsc/Ez51s9DQT9YltUcCF0A55+vkgraMvGjxEHUEnXV9PDoUuwPj
         jqAHT/8UKh9eCNy5KSdhSMQW99qN96j2SQuxuS1mIIeXmYp/VQ+ffjRrb2lVM8ObY2pj
         vXO8ecVJwgjGHVMsx5AR7w2SlSfbU1gtuvzOPOS2JVjUL8z/nSh05lHFnAGCpIq6vlN4
         IuPIjYp5lFOJB3yRh7tcGj31qUiPebdo8Tx5V85ZgAPpSQu0Tgaa5VspBjVghJ5PHRb+
         avjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xlGXz/J0teIzXoNPQlE9mNebzlOCyRuLG7mxD9PC10Q=;
        b=GjtM8LK9FGSws0t3jMnnoZ3gD4RPa5ABKmm9ZjaI66S9cS1yY+L5JkxBJB2VARrbEQ
         Hu41iE0XJ89EKwGt/kTQiTy50pQPH9b419JHYv/BpkOUSgl80mRTolhJqm4YqiuaAiFT
         9URuaoVkVXrCjiteW+aaNc1lCRTam983dfc7FAJdhNlWC/734impt4zksAI+6qlKG97d
         hLiWPNwhbcUF89n58LYH2iUJn2Vtoc86KzyXvvfBLwYaoU2Dp9dvvW3c9CbAr3b1xcjh
         GNFj1z8pmirt74X2JdcmbLo/iPUZjgpD6excrlk7bQwlW/MOmwNh9yeODLgu+pZKFtLD
         kH/g==
X-Gm-Message-State: AOAM5336fev6HupAYVfodDoE2lVRQfNk96Ez1EZsBnio+UkEkZISlexy
        gti/dZphD2p2aQhCfq5a+RJFS9/K75iCDA==
X-Google-Smtp-Source: ABdhPJwSuZauhMv4QX2rMjT+YCKuGSWfwbcv+EJKAeIxrpychoiPfmb7SP/WFRXAM/i0/JrhwrQKkg==
X-Received: by 2002:a05:600c:4fc2:: with SMTP id o2mr115634wmq.90.1612906945216;
        Tue, 09 Feb 2021 13:42:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m205sm38710wmf.40.2021.02.09.13.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:42:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/12] test-lib-functions: split out {debug,path,text} helpers
Date:   Tue,  9 Feb 2021 22:41:59 +0100
Message-Id: <20210209214159.22815-13-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split out the debug, path and text miscellaneous helpers into their
own files. The "test -[efsd]" etc. helpers were not all in one place
in test-lib-functions.sh, I think moving them into their own file
makes it easier to follow the code.

The same goes for the miscellaneous text munging helpers, and the
debug code that was early in the file.

As viewing this commit with diff.colorMoved=true will show there's no
functional changes here. The only added/removed lines are comments and
whitespace. The rest is all moving of existing code into new files.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh       | 267 +---------------------------------
 t/test-lib-functions/debug.sh |  99 +++++++++++++
 t/test-lib-functions/path.sh  | 137 +++++++++++++++++
 t/test-lib-functions/text.sh  |  33 +++++
 4 files changed, 275 insertions(+), 261 deletions(-)
 create mode 100644 t/test-lib-functions/debug.sh
 create mode 100644 t/test-lib-functions/path.sh
 create mode 100644 t/test-lib-functions/text.sh

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8ec06eb67a0..a21ba83d83c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -16,6 +16,12 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see http://www.gnu.org/licenses/ .
 
+# Include sub-libraries of test-lib-functions.sh, split out for
+# readability.
+. "$TEST_DIRECTORY/test-lib-functions/debug.sh"
+. "$TEST_DIRECTORY/test-lib-functions/path.sh"
+. "$TEST_DIRECTORY/test-lib-functions/text.sh"
+
 # The semantics of the editor variables are that of invoking
 # sh -c "$EDITOR \"$@\"" files ...
 #
@@ -79,37 +85,7 @@ test_decode_color () {
 	'
 }
 
-lf_to_nul () {
-	perl -pe 'y/\012/\000/'
-}
-
-nul_to_q () {
-	perl -pe 'y/\000/Q/'
-}
-
-q_to_nul () {
-	perl -pe 'y/Q/\000/'
-}
-
-q_to_cr () {
-	tr Q '\015'
-}
-
-q_to_tab () {
-	tr Q '\011'
-}
-
-qz_to_tab_space () {
-	tr QZ '\011\040'
-}
-
-append_cr () {
-	sed -e 's/$/Q/' | tr Q '\015'
-}
 
-remove_cr () {
-	tr '\015' Q | sed -e 's/Q$//'
-}
 
 # In some bourne shell implementations, the "unset" builtin returns
 # nonzero status when a variable to be unset was not set in the first
@@ -134,38 +110,6 @@ test_tick () {
 	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }
 
-# Stop execution and start a shell. This is useful for debugging tests.
-#
-# Be sure to remove all invocations of this command before submitting.
-
-test_pause () {
-	"$SHELL_PATH" <&6 >&5 2>&7
-}
-
-# Wrap git with a debugger. Adding this to a command can make it easier
-# to understand what is going on in a failing test.
-#
-# Examples:
-#     debug git checkout master
-#     debug --debugger=nemiver git $ARGS
-#     debug -d "valgrind --tool=memcheck --track-origins=yes" git $ARGS
-debug () {
-	case "$1" in
-	-d)
-		GIT_DEBUGGER="$2" &&
-		shift 2
-		;;
-	--debugger=*)
-		GIT_DEBUGGER="${1#*=}" &&
-		shift 1
-		;;
-	*)
-		GIT_DEBUGGER=1
-		;;
-	esac &&
-	GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
-}
-
 # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]
 #   -C <dir>:
 #	Run all git commands in directory <dir>
@@ -369,25 +313,6 @@ test_commit_bulk () {
 
 }
 
-# This function helps systems where core.filemode=false is set.
-# Use it instead of plain 'chmod +x' to set or unset the executable bit
-# of a file in the working directory and add it to the index.
-
-test_chmod () {
-	chmod "$@" &&
-	git update-index --add "--chmod=$@"
-}
-
-# Get the modebits from a file or directory, ignoring the setgid bit (g+s).
-# This bit is inherited by subdirectories at their creation. So we remove it
-# from the returning string to prevent callers from having to worry about the
-# state of the bit in the test directory.
-#
-test_modebits () {
-	ls -ld "$1" | sed -e 's|^\(..........\).*|\1|' \
-			  -e 's|^\(......\)S|\1-|' -e 's|^\(......\)s|\1x|'
-}
-
 # Unset a configuration variable, but don't fail if it doesn't exist.
 test_unconfig () {
 	config_dir=
@@ -716,99 +641,6 @@ test_external_without_stderr () {
 	fi
 }
 
-# debugging-friendly alternatives to "test [-f|-d|-e]"
-# The commands test the existence or non-existence of $1
-test_path_is_file () {
-	test "$#" -ne 1 && BUG "1 param"
-	if ! test -f "$1"
-	then
-		echo "File $1 doesn't exist"
-		false
-	fi
-}
-
-test_path_is_dir () {
-	test "$#" -ne 1 && BUG "1 param"
-	if ! test -d "$1"
-	then
-		echo "Directory $1 doesn't exist"
-		false
-	fi
-}
-
-test_path_exists () {
-	test "$#" -ne 1 && BUG "1 param"
-	if ! test -e "$1"
-	then
-		echo "Path $1 doesn't exist"
-		false
-	fi
-}
-
-# Check if the directory exists and is empty as expected, barf otherwise.
-test_dir_is_empty () {
-	test "$#" -ne 1 && BUG "1 param"
-	test_path_is_dir "$1" &&
-	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
-	then
-		echo "Directory '$1' is not empty, it contains:"
-		ls -la "$1"
-		return 1
-	fi
-}
-
-# Check if the file exists and has a size greater than zero
-test_file_not_empty () {
-	test "$#" = 2 && BUG "2 param"
-	if ! test -s "$1"
-	then
-		echo "'$1' is not a non-empty file."
-		false
-	fi
-}
-
-test_path_is_missing () {
-	test "$#" -ne 1 && BUG "1 param"
-	if test -e "$1"
-	then
-		echo "Path exists:"
-		ls -ld "$1"
-		if test $# -ge 1
-		then
-			echo "$*"
-		fi
-		false
-	fi
-}
-
-# test_line_count checks that a file has the number of lines it
-# ought to. For example:
-#
-#	test_expect_success 'produce exactly one line of output' '
-#		do something >output &&
-#		test_line_count = 1 output
-#	'
-#
-# is like "test $(wc -l <output) = 1" except that it passes the
-# output through when the number of lines is wrong.
-
-test_line_count () {
-	if test $# != 3
-	then
-		BUG "not 3 parameters to test_line_count"
-	elif ! test $(wc -l <"$3") "$1" "$2"
-	then
-		echo "test_line_count: line count for $3 !$1 $2"
-		cat "$3"
-		return 1
-	fi
-}
-
-test_file_size () {
-	test "$#" -ne 1 && BUG "1 param"
-	test-tool path-utils file-size "$1"
-}
-
 # Returns success if a comma separated string of keywords ($1) contains a
 # given keyword ($2).
 # Examples:
@@ -1074,20 +906,6 @@ verbose () {
 	return 1
 }
 
-# Check if the file expected to be empty is indeed empty, and barfs
-# otherwise.
-
-test_must_be_empty () {
-	test "$#" -ne 1 && BUG "1 param"
-	test_path_is_file "$1" &&
-	if test -s "$1"
-	then
-		echo "'$1' is not empty, it contains:"
-		cat "$1"
-		return 1
-	fi
-}
-
 # Tests that its two parameters refer to the same revision, or if '!' is
 # provided first, that its other two parameters refer to different
 # revisions.
@@ -1411,21 +1229,6 @@ test_match_signal () {
 	return 1
 }
 
-# Read up to "$1" bytes (or to EOF) from stdin and write them to stdout.
-test_copy_bytes () {
-	perl -e '
-		my $len = $ARGV[1];
-		while ($len > 0) {
-			my $s;
-			my $nread = sysread(STDIN, $s, $len);
-			die "cannot read: $!" unless defined($nread);
-			last unless $nread;
-			print $s;
-			$len -= $nread;
-		}
-	' - "$1"
-}
-
 # run "$@" inside a non-git directory
 nongit () {
 	test -d non-repo ||
@@ -1440,54 +1243,6 @@ nongit () {
 	)
 } 7>&2 2>&4
 
-# convert function arguments or stdin (if not arguments given) to pktline
-# representation. If multiple arguments are given, they are separated by
-# whitespace and put in a single packet. Note that data containing NULs must be
-# given on stdin, and that empty input becomes an empty packet, not a flush
-# packet (for that you can just print 0000 yourself).
-packetize () {
-	if test $# -gt 0
-	then
-		packet="$*"
-		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
-	else
-		perl -e '
-			my $packet = do { local $/; <STDIN> };
-			printf "%04x%s", 4 + length($packet), $packet;
-		'
-	fi
-}
-
-# Parse the input as a series of pktlines, writing the result to stdout.
-# Sideband markers are removed automatically, and the output is routed to
-# stderr if appropriate.
-#
-# NUL bytes are converted to "\\0" for ease of parsing with text tools.
-depacketize () {
-	perl -e '
-		while (read(STDIN, $len, 4) == 4) {
-			if ($len eq "0000") {
-				print "FLUSH\n";
-			} else {
-				read(STDIN, $buf, hex($len) - 4);
-				$buf =~ s/\0/\\0/g;
-				if ($buf =~ s/^[\x2\x3]//) {
-					print STDERR $buf;
-				} else {
-					$buf =~ s/^\x1//;
-					print $buf;
-				}
-			}
-		}
-	'
-}
-
-# Converts base-16 data into base-8. The output is given as a sequence of
-# escaped octals, suitable for consumption by 'printf'.
-hex2oct () {
-	perl -ne 'printf "\\%03o", hex for /../g'
-}
-
 # Set the hash algorithm in use to $1.  Only useful when testing the testsuite.
 test_set_hash () {
 	test_hash_algo="$1"
@@ -1611,16 +1366,6 @@ test_set_port () {
 	eval $var=$port
 }
 
-# Tests for the hidden file attribute on Windows
-test_path_is_hidden () {
-	test_have_prereq MINGW ||
-	BUG "test_path_is_hidden can only be used on Windows"
-
-	# Use the output of `attrib`, ignore the absolute path
-	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
-	return 1
-}
-
 # Check that the given command was invoked as part of the
 # trace2-format trace on stdin.
 #
diff --git a/t/test-lib-functions/debug.sh b/t/test-lib-functions/debug.sh
new file mode 100644
index 00000000000..4393bf82f02
--- /dev/null
+++ b/t/test-lib-functions/debug.sh
@@ -0,0 +1,99 @@
+# Included by test-lib.sh via test-lib-functions.sh
+#
+# Text munging functions, e.g. wrappers for perl, tr, sed
+# etc. one-liners.
+
+lf_to_nul () {
+	perl -pe 'y/\012/\000/'
+}
+
+nul_to_q () {
+	perl -pe 'y/\000/Q/'
+}
+
+q_to_nul () {
+	perl -pe 'y/Q/\000/'
+}
+
+q_to_cr () {
+	tr Q '\015'
+}
+
+q_to_tab () {
+	tr Q '\011'
+}
+
+qz_to_tab_space () {
+	tr QZ '\011\040'
+}
+
+append_cr () {
+	sed -e 's/$/Q/' | tr Q '\015'
+}
+
+remove_cr () {
+	tr '\015' Q | sed -e 's/Q$//'
+}
+
+# Converts base-16 data into base-8. The output is given as a sequence of
+# escaped octals, suitable for consumption by 'printf'.
+hex2oct () {
+	perl -ne 'printf "\\%03o", hex for /../g'
+}
+
+# convert function arguments or stdin (if not arguments given) to pktline
+# representation. If multiple arguments are given, they are separated by
+# whitespace and put in a single packet. Note that data containing NULs must be
+# given on stdin, and that empty input becomes an empty packet, not a flush
+# packet (for that you can just print 0000 yourself).
+packetize () {
+	if test $# -gt 0
+	then
+		packet="$*"
+		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
+	else
+		perl -e '
+			my $packet = do { local $/; <STDIN> };
+			printf "%04x%s", 4 + length($packet), $packet;
+		'
+	fi
+}
+
+# Parse the input as a series of pktlines, writing the result to stdout.
+# Sideband markers are removed automatically, and the output is routed to
+# stderr if appropriate.
+#
+# NUL bytes are converted to "\\0" for ease of parsing with text tools.
+depacketize () {
+	perl -e '
+		while (read(STDIN, $len, 4) == 4) {
+			if ($len eq "0000") {
+				print "FLUSH\n";
+			} else {
+				read(STDIN, $buf, hex($len) - 4);
+				$buf =~ s/\0/\\0/g;
+				if ($buf =~ s/^[\x2\x3]//) {
+					print STDERR $buf;
+				} else {
+					$buf =~ s/^\x1//;
+					print $buf;
+				}
+			}
+		}
+	'
+}
+
+# Read up to "$1" bytes (or to EOF) from stdin and write them to stdout.
+test_copy_bytes () {
+	perl -e '
+		my $len = $ARGV[1];
+		while ($len > 0) {
+			my $s;
+			my $nread = sysread(STDIN, $s, $len);
+			die "cannot read: $!" unless defined($nread);
+			last unless $nread;
+			print $s;
+			$len -= $nread;
+		}
+	' - "$1"
+}
diff --git a/t/test-lib-functions/path.sh b/t/test-lib-functions/path.sh
new file mode 100644
index 00000000000..af1dd140c27
--- /dev/null
+++ b/t/test-lib-functions/path.sh
@@ -0,0 +1,137 @@
+# Included by test-lib.sh via test-lib-functions.sh
+#
+# File functions, e.g. wrappers for "test [-e|-s|-f|...]", "wc -l"
+# etc.
+
+# ... test -f
+test_path_is_file () {
+	test "$#" -ne 1 && BUG "1 param"
+	if ! test -f "$1"
+	then
+		echo "File $1 doesn't exist"
+		false
+	fi
+}
+
+# ... test -d
+test_path_is_dir () {
+	test "$#" -ne 1 && BUG "1 param"
+	if ! test -d "$1"
+	then
+		echo "Directory $1 doesn't exist"
+		false
+	fi
+}
+
+# test -d && is_empty()
+test_dir_is_empty () {
+	test "$#" -ne 1 && BUG "1 param"
+	test_path_is_dir "$1" &&
+	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
+	then
+		echo "Directory '$1' is not empty, it contains:"
+		ls -la "$1"
+		return 1
+	fi
+}
+
+# ... test -e
+test_path_exists () {
+	test "$#" -ne 1 && BUG "1 param"
+	if ! test -e "$1"
+	then
+		echo "Path $1 doesn't exist"
+		false
+	fi
+}
+
+# ... ! test -e
+test_path_is_missing () {
+	test "$#" -ne 1 && BUG "1 param"
+	if test -e "$1"
+	then
+		echo "Path exists:"
+		ls -ld "$1"
+		if test $# -ge 1
+		then
+			echo "$*"
+		fi
+		false
+	fi
+}
+
+# ... test -s
+test_must_be_empty () {
+	test "$#" -ne 1 && BUG "1 param"
+	test_path_is_file "$1" &&
+	if test -s "$1"
+	then
+		echo "'$1' is not empty, it contains:"
+		cat "$1"
+		return 1
+	fi
+}
+
+# ... ! test -s
+test_file_not_empty () {
+	test "$#" = 2 && BUG "2 param"
+	if ! test -s "$1"
+	then
+		echo "'$1' is not a non-empty file."
+		false
+	fi
+}
+
+test_file_size () {
+	test "$#" -ne 1 && BUG "1 param"
+	test-tool path-utils file-size "$1"
+}
+
+# This function helps systems where core.filemode=false is set.
+# Use it instead of plain 'chmod +x' to set or unset the executable bit
+# of a file in the working directory and add it to the index.
+test_chmod () {
+	chmod "$@" &&
+	git update-index --add "--chmod=$@"
+}
+
+# Get the modebits from a file or directory, ignoring the setgid bit (g+s).
+# This bit is inherited by subdirectories at their creation. So we remove it
+# from the returning string to prevent callers from having to worry about the
+# state of the bit in the test directory.
+test_modebits () {
+	ls -ld "$1" | sed -e 's|^\(..........\).*|\1|' \
+			  -e 's|^\(......\)S|\1-|' -e 's|^\(......\)s|\1x|'
+}
+
+# test_line_count checks that a file has the number of lines it
+# ought to. For example:
+#
+#	test_expect_success 'produce exactly one line of output' '
+#		do something >output &&
+#		test_line_count = 1 output
+#	'
+#
+# is like "test $(wc -l <output) = 1" except that it passes the
+# output through when the number of lines is wrong.
+test_line_count () {
+	if test $# != 3
+	then
+		BUG "not 3 parameters to test_line_count"
+	elif ! test $(wc -l <"$3") "$1" "$2"
+	then
+		echo "test_line_count: line count for $3 !$1 $2"
+		cat "$3"
+		return 1
+	fi
+}
+
+# Tests for the hidden file attribute on Windows
+test_path_is_hidden () {
+	test_have_prereq MINGW ||
+	BUG "test_path_is_hidden can only be used on Windows"
+
+	# Use the output of `attrib`, ignore the absolute path
+	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
+	return 1
+}
diff --git a/t/test-lib-functions/text.sh b/t/test-lib-functions/text.sh
new file mode 100644
index 00000000000..e5f438ffd31
--- /dev/null
+++ b/t/test-lib-functions/text.sh
@@ -0,0 +1,33 @@
+# Included by test-lib.sh via test-lib-functions.sh
+#
+# Debugging functions, not intended to be present in submitted
+# patches. Be sure to remove their use before submitting.
+
+# Stop execution and start a shell.
+test_pause () {
+	"$SHELL_PATH" <&6 >&5 2>&7
+}
+
+# Wrap git with a debugger. Adding this to a command can make it easier
+# to understand what is going on in a failing test.
+#
+# Examples:
+#     debug git checkout master
+#     debug --debugger=nemiver git $ARGS
+#     debug -d "valgrind --tool=memcheck --track-origins=yes" git $ARGS
+debug () {
+	case "$1" in
+	-d)
+		GIT_DEBUGGER="$2" &&
+		shift 2
+		;;
+	--debugger=*)
+		GIT_DEBUGGER="${1#*=}" &&
+		shift 1
+		;;
+	*)
+		GIT_DEBUGGER=1
+		;;
+	esac &&
+	GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
+}
-- 
2.30.0.284.gd98b1dd5eaa7

