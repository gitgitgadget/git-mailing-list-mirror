Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0500EC352A3
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1A520848
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZK5m6Xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgBNBxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:53:54 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:34264 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgBNBxx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:53:53 -0500
Received: by mail-pj1-f74.google.com with SMTP id v8so576410pju.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=+dzDgGZbDVEFd+OcXRP36TNy+80YEw9kOpkTsdIfX2I=;
        b=lZK5m6XaypM3T321nzyjp+qnuYOZlm8fvwVENln4caKIVen5VrqioHAitnz0+e5Dyc
         gSFjQ6CT5UQoOQJwN0ivbvw8lRjKW6BDhGQqdXjxo21xnFYHscKMK/tzyK0rfRQ6xBZF
         huqBLcyBrCm9F+NPIH5nCT4fBj+YNYANXojGmeYQO48FSzyatuEoyl/NwrCC1Gc7LazW
         UkLDnPFcgJ6lfx7DIC9rz43GGI4ScI+pXDFz1fOm3CHzNx9EEvQGJ4yOAwNwonDv7PUH
         mXGxdaFeHvQuBtcqOqUGiOAtf4gFpSJQw+pZG7xWzqrBnKbXqJd6GDCCKbIpJgAvID+p
         42Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=+dzDgGZbDVEFd+OcXRP36TNy+80YEw9kOpkTsdIfX2I=;
        b=UG9fuYv3tQkk39x5Au7HLB2S8/rLS7DJzh5NF31R2LddcbLsFvKiJC9AmkS5WFq/2J
         Izoj8lIcRGviXjyXMYW2e8q26TyM3xFP+zjaBToCYu9mkV61I3aMVvALVQs83AYMQb+4
         TplS4UhmCxBm+ZaHdrZlAGg/xS1ELKOf84TkrDAv//u6aP2Puk7nQJ4WBoEhUD+FKQYS
         3Se7RsxgTBldGG8Iw+NB5VSd7zVJOX7dtzRmUcUfTzM30YPBXq0oKMx7uZ/EjNCf88Yc
         i9yZIBmx5Xv2j0RSSzzSO3QD3joqGLyLiGq0/1CJXtmH5z/JxL33Aa3lEHTaR4HGqxTv
         OusA==
X-Gm-Message-State: APjAAAW8L2P97Y7pK6jnoaWbjPPGTr7DlX9uBQi1FItjjjU8oEB5mhpj
        C73TVaQ/iThTDc10OMfQ1em37wWD5QDrA7XJKj21yQ33XZ2tJjHvaiY+kVHc6iHpcifd2rb6d7j
        QFiGV9G8SrbDGyJ8wsiAHmMX9wL27+CIZOPXWJlaa4GjwY0PncT1nVo0JOMeUrLNVox6rdy+fNg
        ==
X-Google-Smtp-Source: APXvYqzEFFBVeJ5N8DKfG4CFOiJEKg1UVQacV/vYt7LXz2UaE90XCM4z6z6mzoNWDjbcwsmBNZecs+mDjF+psTrwtL8=
X-Received: by 2002:a63:e545:: with SMTP id z5mr849527pgj.209.1581645231497;
 Thu, 13 Feb 2020 17:53:51 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:28 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 00/15] add git-bugreport tool
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Martin=20=C3=85gren?=" <martin.agren@gmail.com>,
        Aaron Schrab <aaron@schrab.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "=?UTF-8?q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset is based on mr/show-config-scope, which looks close to
ready for 'next'.

Since v6:

 - Applied Danh's suggestion[1] (with modifications recommended by Eric and
   Junio downthread)
 - Fixed a missed end-of-macro in the Asciidoctor config which was
   pointed out most recently by SZEDER[2]
 - Fixed generate-bugreport-safelist-config.sh to be more friendly to
   BSD-derived 'sed' and to capture trailing ' ' when extra whitespace is
   present(patch 9/15). This now uses POSIX character classes and {}
   notation instead of + and has been tested on OSX; I'd love to hear if
   it's still not working correctly.
 - Applied Junio's patch[3] to make GIT_TEST_GETTEXT_POISON happy and to
   make the tests more idiomatic.
 - Stop globbing into variables, start making the output directory if it
   doesn't exist before[4]
 - Add an entry in 'command-list.txt'[5]. I sure wish someone had
   explained how to do this somewhere in a tutorial about writing new
   commands ;)
 - Added a test to ensure that git-bugreport runs gracefully in a
   non-repo directory.
 - Added nongit_ok flags to relevant pieces of info to ensure the above
   test passes.

[1] https://lore.kernel.org/git/20200206013533.GA3993@danh.dev
[2] https://lore.kernel.org/git/20200207153042.GI2868@szeder.dev
[3] https://lore.kernel.org/git/xmqq36bfvfwr.fsf@gitster-ct.c.googlers.com
[4] https://lore.kernel.org/git/20200207141802.GE2868@szeder.dev
[5] https://lore.kernel.org/git/20200207145409.GG2868@szeder.dev


Emily Shaffer (15):
  help: move list_config_help to builtin/help
  help: add shell-path to --build-options
  bugreport: add tool to generate debugging info
  bugreport: gather git version and build info
  bugreport: add uname info
  bugreport: add compiler info
  bugreport: add git-remote-https version
  bugreport: include user interactive shell
  bugreport: generate config safelist based on docs
  bugreport: add config values from safelist
  bugreport: collect list of populated hooks
  bugreport: count loose objects
  bugreport: add packed object summary
  bugreport: list contents of $OBJDIR/info
  bugreport: summarize contents of alternates file

 .gitignore                              |   3 +
 Documentation/asciidoc.conf             |   9 +
 Documentation/asciidoctor-extensions.rb |   7 +
 Documentation/config/sendemail.txt      |  56 ++--
 Documentation/git-bugreport.txt         |  55 ++++
 Makefile                                |  27 +-
 bugreport.c                             | 418 ++++++++++++++++++++++++
 builtin/help.c                          |  86 +++++
 command-list.txt                        |   1 +
 compat/compiler.h                       |  24 ++
 generate-bugreport-config-safelist.sh   |  18 +
 generate-cmdlist.sh                     |  19 --
 generate-configlist.sh                  |  21 ++
 help.c                                  | 132 ++------
 help.h                                  |   2 +-
 object-store.h                          |   6 +
 packfile.c                              |   3 +-
 remote-curl.c                           |   8 +
 t/t0091-bugreport.sh                    |  55 ++++
 19 files changed, 794 insertions(+), 156 deletions(-)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100644 compat/compiler.h
 create mode 100755 generate-bugreport-config-safelist.sh
 create mode 100755 generate-configlist.sh
 create mode 100755 t/t0091-bugreport.sh

v6 to v7 range-diff:

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 382bd8f6f4..03c80af0e5 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -37,6 +37,8 @@ module Git
           output = output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
         end
         output
+      end
+    end
 
     class AnnotateProcessor < Asciidoctor::Extensions::InlineMacroProcessor
       def process(parent, target, attrs)
diff --git a/bugreport.c b/bugreport.c
index 9d4d5c8e6f..3bc8cb3579 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -368,6 +368,15 @@ int cmd_main(int argc, const char **argv)
 	if (!stat(report_path.buf, &statbuf))
 		die("'%s' already exists", report_path.buf);
 
+	switch (safe_create_leading_directories(report_path.buf)) {
+	case SCLD_OK:
+	case SCLD_EXISTS:
+		break;
+	default:
+		die(_("could not create leading directories for '%s'"),
+		    report_path.buf);
+	}
+
 	get_bug_template(&buffer);
 
 	get_header(&buffer, "System Info");
diff --git a/command-list.txt b/command-list.txt
index 2087894655..185e5e3f05 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -54,6 +54,7 @@ git-archive                             mainporcelain
 git-bisect                              mainporcelain           info
 git-blame                               ancillaryinterrogators          complete
 git-branch                              mainporcelain           history
+git-bugreport                           ancillaryinterrogators
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
diff --git a/generate-bugreport-config-safelist.sh b/generate-bugreport-config-safelist.sh
index 17d92a91c5..2794a8ae77 100755
--- a/generate-bugreport-config-safelist.sh
+++ b/generate-bugreport-config-safelist.sh
@@ -10,7 +10,8 @@ EOF
 # cat all regular files in Documentation/config
 find Documentation/config -type f -exec cat {} \; |
 # print the command name which matches the annotate-bugreport macro
-sed -n 's/^\(.*\) \+annotate:bugreport\[include\].* ::$/  "\1",/p' | sort
+sed -n 's/^\([^[:blank:]]*\)[[:blank:]]\{1,\}annotate:bugreport\[include\].* ::$/  "\1",/p' \
+	| sort
 
 cat <<EOF
 };
diff --git a/generate-configlist.sh b/generate-configlist.sh
index eca6a00c30..8692fe5cf4 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -10,10 +10,7 @@ EOF
 	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
 	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
 	sort |
-	while read line
-	do
-		echo "	\"$line\","
-	done
+	sed 's/^.*$/	"&",/'
 	cat <<EOF
 	NULL,
 };
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index 451badff0c..6585a2d144 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -8,9 +8,12 @@ test_description='git bugreport'
 # information there; we can make sure all our headers were followed by some
 # information to check if the command was successful.
 HEADER_PATTERN="^\[.*\]$"
-check_all_headers_populated() {
-	while read -r line; do
-		if test "$(grep "$HEADER_PATTERN" "$line")"; then
+
+check_all_headers_populated () {
+	while read -r line
+	do
+		if test "$(grep "$HEADER_PATTERN" "$line")"
+		then
 			echo "$line"
 			read -r nextline
 			if test -z "$nextline"; then
@@ -21,29 +24,32 @@ check_all_headers_populated() {
 }
 
 test_expect_success 'creates a report with content in the right places' '
-	git bugreport &&
-	REPORT="$(ls git-bugreport-*)" &&
-	check_all_headers_populated <$REPORT &&
-	rm $REPORT
+	git bugreport -s check-headers &&
+	check_all_headers_populated <git-bugreport-check-headers.txt &&
+	test_when_finished rm git-bugreport-check-headers.txt
 '
 
 test_expect_success 'dies if file with same name as report already exists' '
-	touch git-bugreport-duplicate.txt &&
+	>>git-bugreport-duplicate.txt &&
 	test_must_fail git bugreport --suffix duplicate &&
-	rm git-bugreport-duplicate.txt
+	test_when_finished rm git-bugreport-duplicate.txt
 '
 
 test_expect_success '--output-directory puts the report in the provided dir' '
-	mkdir foo/ &&
 	git bugreport -o foo/ &&
 	test_path_is_file foo/git-bugreport-* &&
-	rm -fr foo/
+	test_when_finished rm -fr foo/
 '
 
 test_expect_success 'incorrect arguments abort with usage' '
 	test_must_fail git bugreport --false 2>output &&
-	grep usage output &&
+	test_i18ngrep usage output &&
 	test_path_is_missing git-bugreport-*
 '
 
+test_expect_success 'runs outside of a git dir' '
+	nongit git bugreport &&
+	test_when_finished rm non-repo/git-bugreport-*
+'
+
 test_done

-- 
2.25.0.265.gbab2e86ba0-goog

