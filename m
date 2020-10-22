Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3AAC2D0A3
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 03:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39339222E9
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 03:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqUTG9XO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895246AbgJVDBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 23:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895233AbgJVDBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 23:01:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAB9C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 20:01:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i1so152602wro.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 20:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I9uyIINsn13PJ40er3PxqhOjXG/ZoNU7c4ZMaMtTGGk=;
        b=ZqUTG9XOavyE0K9yoapFp+tJ3PxjqhCwCRvuK1KmhwdvicQjmjbnHaGq3eYbBgFsVC
         UWLWmQRvTvj+UtWPNLt3EuzuIm5ZKQakDOxeTXIZiNH6Cn7m4bfHQ3UnfGKMbOfmS/NX
         kZatqBhtDH/VdDapntrSIglyn9eFAMUZB8EYe5UoecyredxKCO9l264lwhbhwVpM2xqA
         OfpZXLKMnxKpSPZSwIoPZT7HxAhLCI69goAV72sT/cBHzm6H8x9b08J3SjFH1RZjahZa
         mdkSlXKPhZx539WlhLT6HMvELeg0LIEOoCjnZuVK0P72TO5Yz5dMuj3OJLPsZaUwyOLu
         X5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I9uyIINsn13PJ40er3PxqhOjXG/ZoNU7c4ZMaMtTGGk=;
        b=PuwB2NSN0vc4RXP4eGRYsS8dcyh2qmatiqdZhO25ZyD/Tl9EDS6GEEs4+QoDka7dJ7
         aUDi5jez6IzN34G/c7AIlQuDYjs6t8sVzQSFS6sk8iRzWoDbiFsR2WK/7eV6COHtl7Hm
         zoWtbX6YmfGFo8dj7GBMxlU112wIunQrFSSb8rzwIxYU7QCM+VHgE4sYVPV0Vtce3/7A
         /fK1XKBRSZU8aguC4R+Zcj+/VCe15KL15JoPErbVyXj5L5PGYVTkzt3e7cWzW/jGGuTd
         xE0proTiT0u6Hw48hHf66rBjRfTzv28v52k0waXhcUuuZyZPGub/agyn/Tf8Z5hEAXkx
         8IwA==
X-Gm-Message-State: AOAM530jEDe37qcAN+mLMjsKiEypFAHTfg+Og3UT5XqeZwl3O5IFC60K
        Y5ntiISCM09yIJrN7iddyTmK0qb3wsI=
X-Google-Smtp-Source: ABdhPJx/+mhKMQDIkW7vrSM8DCZfoOz8kKp6VeKj9+cjo3NwsJATHJDavGKf53PeRLjVLELH1EQDKA==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr315804wrw.18.1603335681169;
        Wed, 21 Oct 2020 20:01:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t19sm707150wmi.26.2020.10.21.20.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 20:01:20 -0700 (PDT)
Message-Id: <pull.576.v4.git.1603335680.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
References: <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Oct 2020 03:01:17 +0000
Subject: [PATCH v4 0/2] ref-filter: handle CRLF at end-of-line more gracefully
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3 :

 * removed lib-crlf-messages.sh and the changes to the existing test
   scripts, and instead added a new test script : t3920-crlf-messages.sh,
   and adjusted the commit message of 1/2 (which was 2/3 in v3) accordingly.
 * tweaked the code and the test script to be in line with the C and shell
   coding guidelines, following comments by Junio and Eric
 * made the generation of the crlf-* refs and helper files in the test
   script more readable and automated, as suggested by Eric.

Notes: 

 1. I was really unsure about which number to choose for the new script, so
    I chose one available at the end of section 3 ("the other basic commands
    " according to t/README), so I'll change that if we come up with a
    better number.
 2. the automated range-diff generated by Gitgitgadget (at the end of the
    cover) will be mostly useless because of the refactoring of the test
    library into a test script. So I'm including a few (manually edited)
    blob diffs (git diff v3:file v4:other-file) below to make reviewing
    easier.


----------------------------------------------------------------------------

$ git diff pr-576/phil-blain/fix-branch-verbose-crlf-v3:t/lib-crlf-messages.sh HEAD:t/t3920-crlf-messages.sh
diff --git a/t/lib-crlf-messages.sh b/t/t3920-crlf-messages.sh
old mode 100644
new mode 100755
index 10a2b57280..7a13d6b38a
--- a/t/lib-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -1,16 +1,17 @@
-# Setup refs with commit and tag messages containing CRLF
+#!/bin/sh
+
+test_description='Test ref-filter and pretty APIs for commit and tag messages using CRLF'
+. ./test-lib.sh

 LIB_CRLF_BRANCHES=""

 create_crlf_ref () {
-    message="$1" &&
-    subject="$2" &&
-    body="$3" &&
-    branch="$4" &&
-    printf "${message}" >.crlf-message-${branch}.txt &&
-    printf "${subject}" >.crlf-subject-${branch}.txt &&
-    printf "${body}" >.crlf-body-${branch}.txt &&
-    LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}"
+    branch="$1" &&
+    cat >.crlf-orig-$branch.txt &&
+    cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
+    grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | tr -d '\n' >.crlf-subject-$branch.txt &&
+    grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true &&
+    LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}" &&
     test_tick &&
     hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&
     git branch ${branch} ${hash} &&
@@ -18,73 +19,108 @@ create_crlf_ref () {
 }

 create_crlf_refs () {
-    message="Subject first line\r\n\r\nBody first line\r\nBody second line\r\n" &&
-    body="Body first line\r\nBody second line\r\n" &&
-    subject="Subject first line" &&
-    branch="crlf" &&
-    create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
-    message="Subject first line\r\n\r\n\r\nBody first line\r\nBody second line\r\n" &&
-    branch="crlf-empty-lines-after-subject" &&
-    create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
-    message="Subject first line\r\nSubject second line\r\n\r\nBody first line\r\nBody second line\r\n" &&
-    subject="Subject first line Subject second line" &&
-    branch="crlf-two-line-subject" &&
-    create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
-    message="Subject first line\r\nSubject second line" &&
-    subject="Subject first line Subject second line" &&
-    body="" &&
-    branch="crlf-two-line-subject-no-body" &&
-    create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
-    message="Subject first line\r\nSubject second line\r\n" &&
-    branch="crlf-two-line-subject-no-body-trailing-newline" &&
-    create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
-    message="Subject first line\r\nSubject second line\r\n\r" &&
-    branch="crlf-two-line-subject-no-body-trailing-newline2" &&
-    create_crlf_ref "${message}" "${subject}" "${body}" "${branch}"
+    create_crlf_ref crlf <<-\EOF &&
+    Subject first line
+
+    Body first line
+    Body second line
+    EOF
+    create_crlf_ref crlf-empty-lines-after-subject <<-\EOF &&
+    Subject first line
+
+
+    Body first line
+    Body second line
+    EOF
+    create_crlf_ref crlf-two-line-subject <<-\EOF &&
+    Subject first line
+    Subject second line
+
+    Body first line
+    Body second line
+    EOF
+    create_crlf_ref crlf-two-line-subject-no-body <<-\EOF &&
+    Subject first line
+    Subject second line
+    EOF
+    create_crlf_ref crlf-two-line-subject-no-body-trailing-newline <<-\EOF
+    Subject first line
+    Subject second line
+
+    EOF
-test_create_crlf_refs () {
-    test_expect_success 'setup refs with CRLF commit messages' '
-        create_crlf_refs
-    '
-}
-
-cleanup_crlf_refs () {
-    for branch in ${LIB_CRLF_BRANCHES}; do
-        git branch -D ${branch} &&
-        git tag -d tag-${branch} &&
-        rm .crlf-message-${branch}.txt &&
-        rm .crlf-subject-${branch}.txt &&
-        rm .crlf-body-${branch}.txt
-    done
-}

-test_cleanup_crlf_refs () {
-    test_expect_success 'cleanup refs with CRLF commit messages' '
-        cleanup_crlf_refs
-    '
 }



 test_crlf_subject_body_and_contents() {
     command_and_args="$@" &&
     command=$1 &&
-    if [ ${command} = "branch" ] || [ ${command} = "for-each-ref" ] || [ ${command} = "tag" ]; then
+    if test ${command} = "branch" || test ${command} = "for-each-ref" || test ${command} = "tag"
+    then
         atoms="(contents:subject) (contents:body) (contents)"
-    elif [ ${command} = "log" ] || [ ${command} = "show" ]; then
+    elif test ${command} = "log" || test ${command} = "show"
+    then
         atoms="s b B"
     fi &&
     files="subject body message" &&
-    while  [ -n "${atoms}" ]; do
+    while test -n "${atoms}"
+    do
         set ${atoms} && atom=$1 && shift && atoms="$*" &&
         set ${files} &&    file=$1 && shift && files="$*" &&
-        test_expect_success "${command}: --format='%${atom}' works with CRLF input" "
+        test_expect_success "${command}: --format='%${atom}' works with messages using CRLF" "
             rm -f expect &&
-            for ref in ${LIB_CRLF_BRANCHES}; do
+            for ref in ${LIB_CRLF_BRANCHES}
+            do
                 cat .crlf-${file}-\"\${ref}\".txt >>expect &&
                 printf \"\n\" >>expect
             done &&
             git $command_and_args --format=\"%${atom}\" >actual &&
             test_cmp expect actual
         "
     done
 }
+
+
+test_expect_success 'Setup refs with commit and tag messages using CRLF' '
+    test_commit inital &&
+    create_crlf_refs
+'
+

git diff pr-576/phil-blain/fix-branch-verbose-crlf-v3:t/t3203-branch-output.sh HEAD:t/t3920-crlf-messages.sh 
diff --git a/t/t3203-branch-output.sh b/t/t3920-crlf-messages.sh
index c06eca774f..7a13d6b38a 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3920-crlf-messages.sh
@@ -1,111 +1,97 @@
 #!/bin/sh

-test_expect_success 'git branch -v works with CRLF input' '
-       cat >expect <<-EOF &&
-         two
-         one
-         Subject first line
-         Subject first line
-         Subject first line Subject second line
-         Subject first line Subject second line
-         Subject first line Subject second line
-         Subject first line Subject second line
-       EOF
+test_expect_success 'branch: --verbose works with messages using CRLF' '
+       rm -f expect &&
+       for branch in $LIB_CRLF_BRANCHES
+       do
+               printf "  " >>expect &&
+               cat .crlf-subject-${branch}.txt >>expect &&
+               printf "\n" >>expect
+       done &&
        git branch -v >tmp &&
        # Remove first two columns, and the line for the currently checked out branch
        current=$(git branch --show-current) &&

$ git diff pr-576/phil-blain/fix-branch-verbose-crlf-v3:t/t4202-log.sh HEAD:t/t3920-crlf-messages.sh
diff --git a/t/t4202-log.sh b/t/t3920-crlf-messages.sh
index d4942a6f92..7a13d6b38a 100755
--- a/t/t4202-log.sh
+++ b/t/t3920-crlf-messages.sh
@@ -1,1930 +1,126 @@
-test_expect_success 'oneline with CRLF messages' '
-       for branch in $LIB_CLRF_BRANCHES; do
+test_expect_success 'log: --oneline works with messages using CRLF' '
+       for branch in $LIB_CRLF_BRANCHES
+       do
                cat .crlf-subject-${branch}.txt >expect &&
+               printf "\n" >>expect &&
                git log --oneline -1 ${branch} >tmp-branch &&
                git log --oneline -1 tag-${branch} >tmp-tag &&
-               awk "{print \$NF}" <tmp-branch >actual-branch &&
-               awk "{print \$NF}" <tmp-tag >actual-tag &&
+               cut -d" " -f2- <tmp-branch >actual-branch &&
+               cut -d" " -f2- <tmp-tag >actual-tag &&
                test_cmp expect actual-branch &&
                test_cmp expect actual-tag
        done 
 '


----------------------------------------------------------------------------

The ref-filter code does not correctly handle commit or tag messages that
use CRLF as the line terminator. Such messages can be created with the
--cleanup=verbatim option of git commit and git tag, or by using git
commit-tree directly.

The function find_subpos in ref-filter.c looks for two consecutive '\n' to
find the end of the subject line, a sequence which is absent in messages
using CRLF. This results in the whole message being parsed as the subject
line (%(contents:subject)), and the body of the message (%(contents:body))
being empty.

Moreover, in copy_subject, '\n' is replaced by space, but '\r' is untouched.

This bug is a regression for git branch --verbose, which bisects down to
949af06 (branch: use ref-filter printing APIs, 2017-01-10).

The first patch fixes the bug in ref-filter.c and adds a test script to
check that the ref-filter and pretty APIs deal correctly with CRLF messages.

The second patch adds tests that check the behaviour of git log andgit show 
in the presence of CRLF in messages, to prevent futur regressions.

Philippe Blain (2):
  ref-filter: handle CRLF at end-of-line more gracefully
  log, show: add tests for messages containing CRLF

 ref-filter.c             |  36 ++++++-----
 t/t3920-crlf-messages.sh | 126 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+), 14 deletions(-)
 create mode 100755 t/t3920-crlf-messages.sh


base-commit: a5fa49ff0a8f3252c6bff49f92b85e7683868f8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-576%2Fphil-blain%2Ffix-branch-verbose-crlf-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-576/phil-blain/fix-branch-verbose-crlf-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/576

Range-diff vs v3:

 1:  f17d182c3b < -:  ---------- t: add lib-crlf-messages.sh for messages containing CRLF
 2:  11d044a4f7 ! 1:  03b2d7d78a ref-filter: handle CRLF at end-of-line more gracefully
     @@ Metadata
       ## Commit message ##
          ref-filter: handle CRLF at end-of-line more gracefully
      
     -    The ref-filter code does not correctly handle commit or tag messages that
     -    use CRLF as the line terminator. Such messages can be created with the
     -    `--verbatim` option of `git commit` and `git tag`, or by using `git
     -    commit-tree` directly.
     +    The ref-filter code does not correctly handle commit or tag messages
     +    that use CRLF as the line terminator. Such messages can be created with
     +    the `--cleanup=verbatim` option of `git commit` and `git tag`, or by
     +    using `git commit-tree` directly.
      
          The function `find_subpos` in ref-filter.c looks for two consecutive
          LFs to find the end of the subject line, a sequence which is absent in
          messages using CRLF. This results in the whole message being parsed as
          the subject line (`%(contents:subject)`), and the body of the message
     -    (`%(contents:body)`)  being empty.
     +    (`%(contents:body)`) being empty.
      
          Moreover, in `copy_subject`, which wants to return the subject as a
          single line, '\n' is replaced by space, but '\r' is
     @@ Commit message
          Fix this bug in ref-filter by hardening the logic in `copy_subject` and
          `find_subpos` to correctly parse messages containing CRLF.
      
     -    Add tests for `branch`, `tag` and `for-each-ref` using
     -    lib-crlf-messages.sh.
     -
     -    The 'make commits' test at the beginning of t3203-branch-output.sh does
     -    not use `test_tick` and thus the commit hashes are not reproducible. For
     -    simplicity, use `test_commit` to create the commits, as the content and
     -    name of the files created in this setup test are irrelevant to the rest
     -    of the test script.
     -
     -    Use `test_cleanup_crlf_refs` in t3203-branch-output.sh and t7004-tag.sh
     -    to avoid having to modify the expected output in later tests.
     +    Add a new test script, 't3920-crlf-messages.sh', to test the behaviour
     +    of commands using either the ref-filter or the pretty APIs with messages
     +    using CRLF line endings. The function `test_crlf_subject_body_and_contents`
     +    can be used to test that the `--format` option of `branch`, `tag`,
     +    `for-each-ref`, `log` and `show` correctly displays the subject, body
     +    and raw content of commit and tag messages using CRLF. Test the
     +    output of `branch`, `tag` and `for-each-ref` with such commits.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## ref-filter.c ##
     @@ ref-filter.c: static const char *copy_email(const char *buf, struct used_atom *a
       static char *copy_subject(const char *buf, unsigned long len)
       {
      -	char *r = xmemdupz(buf, len);
     --	int i;
      +	struct strbuf sb = STRBUF_INIT;
     + 	int i;
       
      -	for (i = 0; i < len; i++)
      -		if (r[i] == '\n')
      -			r[i] = ' ';
     -+	for (int i = 0; i < len; i++) {
     ++	for (i = 0; i < len; i++) {
      +		if (buf[i] == '\r' && i + 1 < len && buf[i + 1] == '\n')
      +			continue; /* ignore CR in CRLF */
       
     @@ ref-filter.c: static void find_subpos(const char *buf,
       	*sublen = buf - *sub;
       	/* drop trailing newline, if present */
      -	if (*sublen && (*sub)[*sublen - 1] == '\n')
     -+	while (*sublen && ((*sub)[*sublen - 1] == '\n' || (*sub)[*sublen - 1] == '\r'))
     ++	while (*sublen && ((*sub)[*sublen - 1] == '\n' ||
     ++			   (*sub)[*sublen - 1] == '\r'))
       		*sublen -= 1;
       
       	/* skip any empty lines */
     @@ ref-filter.c: static void find_subpos(const char *buf,
       	*body = buf;
       	*bodylen = strlen(buf);
      
     - ## t/t3203-branch-output.sh ##
     + ## t/t3920-crlf-messages.sh (new) ##
      @@
     - test_description='git branch display tests'
     - . ./test-lib.sh
     - . "$TEST_DIRECTORY"/lib-terminal.sh
     -+. "$TEST_DIRECTORY"/lib-crlf-messages.sh
     - 
     - test_expect_success 'make commits' '
     --	echo content >file &&
     --	git add file &&
     --	git commit -m one &&
     --	echo content >>file &&
     --	git commit -a -m two
     -+	test_commit one &&
     -+	test_commit two
     - '
     - 
     - test_expect_success 'make branches' '
     -@@ t/t3203-branch-output.sh: test_expect_success 'git branch --ignore-case --list -v pattern shows branch sum
     - 	awk "{print \$NF}" <tmp >actual &&
     - 	test_cmp expect actual
     - '
     -+test_create_crlf_refs
     -+
     -+test_expect_success 'git branch -v works with CRLF input' '
     -+	cat >expect <<-EOF &&
     -+	  two
     -+	  one
     -+	  Subject first line
     -+	  Subject first line
     -+	  Subject first line Subject second line
     -+	  Subject first line Subject second line
     -+	  Subject first line Subject second line
     -+	  Subject first line Subject second line
     ++#!/bin/sh
     ++
     ++test_description='Test ref-filter and pretty APIs for commit and tag messages using CRLF'
     ++. ./test-lib.sh
     ++
     ++LIB_CRLF_BRANCHES=""
     ++
     ++create_crlf_ref () {
     ++	branch="$1" &&
     ++	cat >.crlf-orig-$branch.txt &&
     ++	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
     ++	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | tr -d '\n' >.crlf-subject-$branch.txt &&
     ++	grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true &&
     ++	LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}" &&
     ++	test_tick &&
     ++	hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&
     ++	git branch ${branch} ${hash} &&
     ++	git tag tag-${branch} ${branch} -F .crlf-message-${branch}.txt --cleanup=verbatim
     ++}
     ++
     ++create_crlf_refs () {
     ++	create_crlf_ref crlf <<-\EOF &&
     ++	Subject first line
     ++
     ++	Body first line
     ++	Body second line
      +	EOF
     ++	create_crlf_ref crlf-empty-lines-after-subject <<-\EOF &&
     ++	Subject first line
     ++
     ++
     ++	Body first line
     ++	Body second line
     ++	EOF
     ++	create_crlf_ref crlf-two-line-subject <<-\EOF &&
     ++	Subject first line
     ++	Subject second line
     ++
     ++	Body first line
     ++	Body second line
     ++	EOF
     ++	create_crlf_ref crlf-two-line-subject-no-body <<-\EOF &&
     ++	Subject first line
     ++	Subject second line
     ++	EOF
     ++	create_crlf_ref crlf-two-line-subject-no-body-trailing-newline <<-\EOF
     ++	Subject first line
     ++	Subject second line
     ++
     ++	EOF
     ++}
     ++
     ++test_crlf_subject_body_and_contents() {
     ++	command_and_args="$@" &&
     ++	command=$1 &&
     ++	if test ${command} = "branch" || test ${command} = "for-each-ref" || test ${command} = "tag"
     ++	then
     ++		atoms="(contents:subject) (contents:body) (contents)"
     ++	elif test ${command} = "log" || test ${command} = "show"
     ++	then
     ++		atoms="s b B"
     ++	fi &&
     ++	files="subject body message" &&
     ++	while test -n "${atoms}"
     ++	do
     ++		set ${atoms} && atom=$1 && shift && atoms="$*" &&
     ++		set ${files} &&	file=$1 && shift && files="$*" &&
     ++		test_expect_success "${command}: --format='%${atom}' works with messages using CRLF" "
     ++			rm -f expect &&
     ++			for ref in ${LIB_CRLF_BRANCHES}
     ++			do
     ++				cat .crlf-${file}-\"\${ref}\".txt >>expect &&
     ++				printf \"\n\" >>expect
     ++			done &&
     ++			git $command_and_args --format=\"%${atom}\" >actual &&
     ++			test_cmp expect actual
     ++		"
     ++	done
     ++}
     ++
     ++
     ++test_expect_success 'Setup refs with commit and tag messages using CRLF' '
     ++	test_commit inital &&
     ++	create_crlf_refs
     ++'
     ++
     ++test_expect_success 'branch: --verbose works with messages using CRLF' '
     ++	rm -f expect &&
     ++	for branch in $LIB_CRLF_BRANCHES
     ++	do
     ++		printf "  " >>expect &&
     ++		cat .crlf-subject-${branch}.txt >>expect &&
     ++		printf "\n" >>expect
     ++	done &&
      +	git branch -v >tmp &&
      +	# Remove first two columns, and the line for the currently checked out branch
      +	current=$(git branch --show-current) &&
     @@ t/t3203-branch-output.sh: test_expect_success 'git branch --ignore-case --list -
      +
      +test_crlf_subject_body_and_contents branch --list crlf*
      +
     -+test_cleanup_crlf_refs
     - 
     - test_expect_success 'git branch -v pattern does not show branch summaries' '
     - 	test_must_fail git branch -v branch*
     -
     - ## t/t6300-for-each-ref.sh ##
     -@@ t/t6300-for-each-ref.sh: test_description='for-each-ref test'
     - . ./test-lib.sh
     - . "$TEST_DIRECTORY"/lib-gpg.sh
     - . "$TEST_DIRECTORY"/lib-terminal.sh
     -+. "$TEST_DIRECTORY"/lib-crlf-messages.sh
     - 
     - # Mon Jul 3 23:18:43 2006 +0000
     - datestamp=1151968723
     -@@ t/t6300-for-each-ref.sh: test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
     - 	test_cmp expect actual
     - '
     - 
     -+test_create_crlf_refs
     -+
     -+test_crlf_subject_body_and_contents for-each-ref refs/heads/crlf*
     -+
     - test_done
     -
     - ## t/t7004-tag.sh ##
     -@@ t/t7004-tag.sh: Tests for operations with tags.'
     - . ./test-lib.sh
     - . "$TEST_DIRECTORY"/lib-gpg.sh
     - . "$TEST_DIRECTORY"/lib-terminal.sh
     -+. "$TEST_DIRECTORY"/lib-crlf-messages.sh
     - 
     - # creating and listing lightweight tags:
     - 
     -@@ t/t7004-tag.sh: test_expect_success '--format should list tags as per format given' '
     - 	test_cmp expect actual
     - '
     - 
     -+test_create_crlf_refs
     -+
      +test_crlf_subject_body_and_contents tag --list tag-crlf*
      +
     -+test_cleanup_crlf_refs
     ++test_crlf_subject_body_and_contents for-each-ref refs/heads/crlf*
      +
     - test_expect_success "set up color tests" '
     - 	echo "<RED>v1.0<RESET>" >expect.color &&
     - 	echo "v1.0" >expect.bare &&
     ++test_done
 3:  59957d1391 ! 2:  75a87887be log, show: add tests for messages containing CRLF
     @@ Commit message
          such messages, to prevent futur regressions if these commands are
          refactored to use the ref-filter API.
      
     -    To prevent having to modify expected output in further tests, use
     -    'test_cleanup_crlf_refs' in t4202 to clean-up after the added tests.
     -
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
     - ## t/t4202-log.sh ##
     -@@ t/t4202-log.sh: test_description='git log'
     - . "$TEST_DIRECTORY/lib-gpg.sh"
     - . "$TEST_DIRECTORY/lib-terminal.sh"
     - . "$TEST_DIRECTORY/lib-log-graph.sh"
     -+. "$TEST_DIRECTORY/lib-crlf-messages.sh"
     + ## t/t3920-crlf-messages.sh ##
     +@@ t/t3920-crlf-messages.sh: test_crlf_subject_body_and_contents tag --list tag-crlf*
       
     - test_cmp_graph () {
     - 	lib_test_cmp_graph --format=%s "$@"
     -@@ t/t4202-log.sh: test_expect_success 'oneline' '
     - 	test_cmp expect actual
     - '
     + test_crlf_subject_body_and_contents for-each-ref refs/heads/crlf*
       
     -+test_create_crlf_refs
     -+
     -+test_expect_success 'oneline with CRLF messages' '
     -+	for branch in $LIB_CLRF_BRANCHES; do
     ++test_expect_success 'log: --oneline works with messages using CRLF' '
     ++	for branch in $LIB_CRLF_BRANCHES
     ++	do
      +		cat .crlf-subject-${branch}.txt >expect &&
     ++		printf "\n" >>expect &&
      +		git log --oneline -1 ${branch} >tmp-branch &&
      +		git log --oneline -1 tag-${branch} >tmp-tag &&
     -+		awk "{print \$NF}" <tmp-branch >actual-branch &&
     -+		awk "{print \$NF}" <tmp-tag >actual-tag &&
     ++		cut -d" " -f2- <tmp-branch >actual-branch &&
     ++		cut -d" " -f2- <tmp-tag >actual-tag &&
      +		test_cmp expect actual-branch &&
      +		test_cmp expect actual-tag
      +	done
      +'
     -+test_crlf_subject_body_and_contents log --all --reverse --grep Subject
      +
     -+test_cleanup_crlf_refs
     -+
     - test_expect_success 'diff-filter=A' '
     - 
     - 	git log --no-renames --pretty="format:%s" --diff-filter=A HEAD > actual &&
     -
     - ## t/t7007-show.sh ##
     -@@
     - test_description='git show'
     - 
     - . ./test-lib.sh
     -+. "$TEST_DIRECTORY/lib-crlf-messages.sh"
     - 
     - test_expect_success setup '
     - 	echo hello world >foo &&
     -@@ t/t7007-show.sh: test_expect_success 'show --graph is forbidden' '
     -   test_must_fail git show --graph HEAD
     - '
     - 
     -+test_create_crlf_refs
     ++test_crlf_subject_body_and_contents log --all --reverse --grep Subject
      +
      +test_crlf_subject_body_and_contents show $LIB_CRLF_BRANCHES
      +

-- 
gitgitgadget
