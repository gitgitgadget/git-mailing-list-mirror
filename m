Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AEBB1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeDPWlo (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:41:44 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34297 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDPWl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:41:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id d19so30266902wre.1
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZ8heRHiUlCRSQcYkpjudZdrylf+8jmy/LlcJ3IOsQM=;
        b=G2VIY6mmn1ikWmBPt/XrzI8990CeximEie45A2/zHBMcBTZDxpEJuekLzqEtsL/yzd
         vpwOkH3YjX7GBOzH02OVrrw3Rc2LVdWXm/dHveo+msCVJ14KU5zyZTSZBpnnC39Df+0Q
         aoRG1FOOs+hI+jS7aP8mXIz94ODUdeYPoDo1ugTZyHKf8Ve3tDqtahigWdL2IRdtNwkl
         DiHArFbVSe135kwnr4EDy9pel3Rdn7HbURsGOE9JYmZr7OQ3cPkBj0vbx5yxIzcWVrCn
         DeCZlSxTmBz5jrMrMdTHbbey4vOEKIw9VLpv1FjPB8Los6T9OrAT8cVP96pkMQrmggLR
         5y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZ8heRHiUlCRSQcYkpjudZdrylf+8jmy/LlcJ3IOsQM=;
        b=KkASr1Mff3yidldfqurNYVODBDoFmzQIKiL3wg1VEX2d+FDs+A5qk8plbB+mFfQtVj
         dSC5TNyQPobalq27XXVIM863Sa9jpzdAFzFRUvN2nlrAKo+EJt4pfBWJYivdWvO5giK7
         zUCtqPNHS5BtVZelbUdccAFfA1ZvCMboW78z5npE0haFiOiv3NT3M763LJea7M44bwIz
         xT0Pw0aYmenaOOJcVXllNWNGBRvX1xNa6O85cjvLp90x0atSBWaBp2tVb22eF8mWqulb
         wLJtYMyRHPP6eTqyuo8jjZU49VdkMx2IBlO2XUpRddgpVeu1VTg6hzfAFFA11tTVX32c
         2IQQ==
X-Gm-Message-State: ALQs6tDRvdqcvNvhciQckAdNvTAK1XgmVpNgj8rPIq60eOe+Z3lUObts
        ZHbxIvXdRps1EtYoL+mmdEk67w==
X-Google-Smtp-Source: AIpwx49u3EsmIncEDGa37GMdIN6Zxi9bRR2g8sy5b4nf2htAvZgf0P5DHg2H/P0FQbhB8s18xDcklQ==
X-Received: by 10.28.13.205 with SMTP id 196mr63929wmn.73.1523918485958;
        Mon, 16 Apr 2018 15:41:25 -0700 (PDT)
Received: from localhost.localdomain (x590d89db.dyn.telefonica.de. [89.13.137.219])
        by smtp.gmail.com with ESMTPSA id p128sm14977788wmd.45.2018.04.16.15.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 15:41:25 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 05/11] completion: improve handling quoted paths on the command line
Date:   Tue, 17 Apr 2018 00:41:09 +0200
Message-Id: <20180416224113.16993-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <20180416224113.16993-1-szeder.dev@gmail.com>
References: <20180318012618.32691-1-szeder.dev@gmail.com>
 <20180416224113.16993-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our git-aware path completion doesn't work when it has to complete a
word already containing quoted and/or backslash-escaped characters on
the command line.  The root cause of the issue is that completion
functions see all words on the command line verbatim, i.e. including
all backslash, single and double quote characters that the shell would
eventually remove when executing the finished command.  These
quoting/escaping characters cause different issues depending on which
path component of the word to be completed contains them:

  - The quoting/escaping is in the prefix path component(s).

    Let's suppose we have a directory called 'New Dir', containing two
    untracked files 'file.c' and 'file.o', and we have a gitignore
    rule ignoring object files.  In this case all of these:

      git add New\ Dir/<TAB>
      git add "New Dir/<TAB>
      git add 'New Dir/<TAB>

    should uniquely complete 'file.c' right away, but Bash offers both
    'file.c' and 'file.o' instead.  The reason for this behavior is
    that our completion script uses the prefix directory name like
    'git -C "New\ Dir/" ls-files ...", i.e. with the backslash inside
    double quotes.  Git then tries to enter a directory called
    'New\ Dir', which (most likely) fails because such a directory
    doesn't exists.  As a result our completion script doesn't list
    any files, leaves the COMPREPLY array empty, which in turn causes
    Bash to fall back to its simple filename completion and lists all
    files in that directory, i.e. both 'file.c' and 'file.o'.

  - The quoting/escaping is in the path component to be completed.

    Let's suppose we have two untracked files 'New File.c' and
    'New File.o', and we have a gitignore rule ignoring object files.
    In this case all of these:

      git add New\ Fi<TAB>
      git add "New Fi<TAB>
      git add 'New Fi<TAB>

    should uniquely complete 'New File.c' right away, but Bash offers
    both 'New File.c' and 'New File.o' instead.  The reason for this
    behavior is that our completion script uses this 'New\ Fi' or
    '"New Fi' etc. word to filter matching paths, and of course none
    of the potential filenames will match because of the included
    backslash or double quote.  The end result is the same as above:
    the completion script doesn't list any files, Bash falls back to
    its filename completion, which then lists the matching object file
    as well.

Add the new helper function __git_dequote() [1], which removes (most
of[2]) the quoting and escaping from the word it gets as argument.  To
minimize the overhead of calling this function, store its result in
the variable $dequoted_word, supposed to be declared local in the
caller; simply printing the result would require a command
substitution imposing the overhead of fork()ing a subshell.  Use this
function in __git_complete_index_file() to dequote the current word,
i.e. the path, to be completed, to avoid the above described
quoting-related issues, thereby fixing two of the failing quoted path
completion tests.

[1] The bash-completion project already has a dequote() function,
    which I hoped I could borrow to deal with this, but unfortunately
    it doesn't work quite well for this purpose (perhaps that's why
    even the bash-completion project only rarely uses it).  The main
    issue is that their dequote() is implemented as:

      eval printf %s "$1" 2> /dev/null

    where $1 would contain the word to be completed.  While it's a
    short and sweet one-liner, the use of 'eval' requires that $1 is a
    syntactically valid string, which is not the case when quoting the
    path like 'git add "New Dir/<TAB>'.  This causes 'eval' to fail,
    because it can't find the matching closing double quote, and the
    function returns nothing.  The result is totally broken behavior,
    as if the current word were empty, and the completion script would
    then list all files from the current directory.  This is why one
    of the quoted path completion tests specifically checks the
    completion of a path with an opening but without a corresponding
    closing double quote character.  Furthermore, the 'eval' performs
    all kinds of expansions, which may or may not be desired; I think
    it's the latter.  Finally, using this function would require a
    command substitution.

[2] Bash understands the $'string' quoting as well, which "expands to
    'string', with backslash-escaped characters replaced as specified
    by the ANSI C standard" (quoted from Bash manpage).  Since shell
    metacharacters, field separators, globbing, etc. can all be easily
    entered using standard shell escaping or quoting, this type of
    quoting comes in handly when dealing with control characters that
    are otherwise difficult both to "type" and to see on the command
    line.  Because of this difficulty I would assume that people do
    avoid pathnames with such control characters anyway, so I didn't
    bother implementing it.  This function is already way too long as
    it is.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Notes:
    What if someone on Windows were to use backslash as directory
    separator during path completion?  E.g. 'git add new-dir\subdir\<TAB>'
    Did that happen to work in the past?  Does this patch break it?

 contrib/completion/git-completion.bash | 76 ++++++++++++++++++++++++--
 t/t9902-completion.sh                  | 46 +++++++++++++++-
 2 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7072555960..ae6127155e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -92,6 +92,70 @@ __git ()
 		${__git_dir:+--git-dir="$__git_dir"} "$@" 2>/dev/null
 }
 
+# Removes backslash escaping, single quotes and double quotes from a word,
+# stores the result in the variable $dequoted_word.
+# 1: The word to dequote.
+__git_dequote ()
+{
+	local rest="$1" len ch
+
+	dequoted_word=""
+
+	while test -n "$rest"; do
+		len=${#dequoted_word}
+		dequoted_word="$dequoted_word${rest%%[\\\'\"]*}"
+		rest="${rest:$((${#dequoted_word}-$len))}"
+
+		case "${rest:0:1}" in
+		\\)
+			ch="${rest:1:1}"
+			case "$ch" in
+			$'\n')
+				;;
+			*)
+				dequoted_word="$dequoted_word$ch"
+				;;
+			esac
+			rest="${rest:2}"
+			;;
+		\')
+			rest="${rest:1}"
+			len=${#dequoted_word}
+			dequoted_word="$dequoted_word${rest%%\'*}"
+			rest="${rest:$((${#dequoted_word}-$len+1))}"
+			;;
+		\")
+			rest="${rest:1}"
+			while test -n "$rest" ; do
+				len=${#dequoted_word}
+				dequoted_word="$dequoted_word${rest%%[\\\"]*}"
+				rest="${rest:$((${#dequoted_word}-$len))}"
+				case "${rest:0:1}" in
+				\\)
+					ch="${rest:1:1}"
+					case "$ch" in
+					\"|\\|\$|\`)
+						dequoted_word="$dequoted_word$ch"
+						;;
+					$'\n')
+						;;
+					*)
+						dequoted_word="$dequoted_word\\$ch"
+						;;
+					esac
+					rest="${rest:2}"
+					;;
+				\")
+					rest="${rest:1}"
+					break
+					;;
+				esac
+			done
+			;;
+		esac
+	done
+}
+
 # The following function is based on code from:
 #
 #   bash_completion - programmable completion functions for bash 3.2+
@@ -404,13 +468,17 @@ __git_index_files ()
 # The exception is --committable, which finds the files appropriate commit.
 __git_complete_index_file ()
 {
-	local pfx="" cur_="$cur"
+	local dequoted_word pfx="" cur_
 
-	case "$cur_" in
+	__git_dequote "$cur"
+
+	case "$dequoted_word" in
 	?*/*)
-		pfx="${cur_%/*}/"
-		cur_="${cur_##*/}"
+		pfx="${dequoted_word%/*}/"
+		cur_="${dequoted_word##*/}"
 		;;
+	*)
+		cur_="$dequoted_word"
 	esac
 
 	__gitcomp_file "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a4f2c03b93..6856b263f8 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -400,6 +400,46 @@ test_expect_success '__gitdir - remote as argument' '
 	test_cmp expected "$actual"
 '
 
+
+test_expect_success '__git_dequote - plain unquoted word' '
+	__git_dequote unquoted-word &&
+	verbose test unquoted-word = "$dequoted_word"
+'
+
+# input:    b\a\c\k\'\\\"s\l\a\s\h\es
+# expected: back'\"slashes
+test_expect_success '__git_dequote - backslash escaped' '
+	__git_dequote "b\a\c\k\\'\''\\\\\\\"s\l\a\s\h\es" &&
+	verbose test "back'\''\\\"slashes" = "$dequoted_word"
+'
+
+# input:    sin'gle\' '"quo'ted
+# expected: single\ "quoted
+test_expect_success '__git_dequote - single quoted' '
+	__git_dequote "'"sin'gle\\\\' '\\\"quo'ted"'" &&
+	verbose test '\''single\ "quoted'\'' = "$dequoted_word"
+'
+
+# input:    dou"ble\\" "\"\quot"ed
+# expected: double\ "\quoted
+test_expect_success '__git_dequote - double quoted' '
+	__git_dequote '\''dou"ble\\" "\"\quot"ed'\'' &&
+	verbose test '\''double\ "\quoted'\'' = "$dequoted_word"
+'
+
+# input: 'open single quote
+test_expect_success '__git_dequote - open single quote' '
+	__git_dequote "'\''open single quote" &&
+	verbose test "open single quote" = "$dequoted_word"
+'
+
+# input: "open double quote
+test_expect_success '__git_dequote - open double quote' '
+	__git_dequote "\"open double quote" &&
+	verbose test "open double quote" = "$dequoted_word"
+'
+
+
 test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
 	sed -e "s/Z$//g" >expected <<-EOF &&
 	with-trailing-space Z
@@ -1437,7 +1477,7 @@ _git_test_path_comp ()
 	__git_complete_index_file --others
 }
 
-test_expect_failure 'complete files - escaped characters on cmdline' '
+test_expect_success 'complete files - escaped characters on cmdline' '
 	test_when_finished "rm -rf \"New|Dir\"" &&
 	mkdir "New|Dir" &&
 	>"New|Dir/New&File.c" &&
@@ -1453,11 +1493,13 @@ test_expect_failure 'complete files - escaped characters on cmdline' '
 			"New|Dir/New&File.c"
 '
 
-test_expect_failure 'complete files - quoted characters on cmdline' '
+test_expect_success 'complete files - quoted characters on cmdline' '
 	test_when_finished "rm -r \"New(Dir\"" &&
 	mkdir "New(Dir" &&
 	>"New(Dir/New)File.c" &&
 
+	# Testing with an opening but without a corresponding closing
+	# double quote is important.
 	test_completion "git test-path-comp \"New(D" "New(Dir" &&
 	test_completion "git test-path-comp \"New(Dir/New)F" \
 			"New(Dir/New)File.c"
-- 
2.17.0.366.gbe216a3084

