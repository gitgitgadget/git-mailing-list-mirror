From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/7] test: modernize funny-names test style
Date: Mon, 12 Mar 2012 23:59:52 -0500
Message-ID: <20120313045952.GC12550@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120313045100.GA12474@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 06:00:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7JqI-0003Zx-Da
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 06:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757941Ab2CMFAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 01:00:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52840 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab2CMFAG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 01:00:06 -0400
Received: by yhmm54 with SMTP id m54so139991yhm.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 22:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hSc3vIYgFDboR/IjS+k30sC6F1d40hrIrWJwbzeo7tw=;
        b=03+0+TuELXd6zJETYaaNNCSh7xw+XqI3YvZuMCvb433ldtVk5XEJOOUZAB4td1CFLC
         WNbpVpmOpxojXZOvdM5ExJu1kGx9DMKieOroaqHgoEa63lkNa71hUiB1dPCS/owxdHjp
         trS8H4hiZZht6a15QoKQbhhrQ2ASM9TsMeSJ5iYoDFEd40YP/hVUF6OLr/BtubI4iDzu
         KuLoTUDbN/2Il7HHoQSm8BKW86vNwcREiZm+2q6x6sQntHMbZ/JsdhDu7HnkJD9Qo9UB
         Q4P7OIOl1EgQBq4PNasW/IIR52kjrz01UkN1zcUOfGDDkdHNX6l4ul5dTrss6Z1sl4SH
         1kEw==
Received: by 10.182.86.197 with SMTP id r5mr10345758obz.7.1331614805646;
        Mon, 12 Mar 2012 22:00:05 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id v10sm21894084obb.4.2012.03.12.22.00.04
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 22:00:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120313045100.GA12474@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192974>

This is one of the early tests, so it uses a style that by modern
standards can be hard to read.  Tweak it to:

 - clearly declare what assertion each test is designed to check

 - mark tests that create state later tests will depend on with the
   word "setup" so people writing or running tests know the others
   can be skipped or reordered safely

 - put commands that populate a file with expected output inside
   the corresponding test stanza, so it is easier to see by eye
   where each test begins and ends

 - instead of pipelines, use commands that read and write a
   temporary file, so bugs causing commands to segfault or produce
   the wrong exit status can be caught.

More cosmetic changes:

 - put the opening quote starting each test on the same line as the
   test_expect_* invocation, and indent the commands in each test
   with a single tab

 - end the test early if the underlying filesystem cannot
   accomodate the filenames we use, instead of marking all tests
   with the same TABS_IN_FILENAMES prerequisite.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3300-funny-names.sh |  347 +++++++++++++++++++++++++-----------------------
 1 file changed, 180 insertions(+), 167 deletions(-)

diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 9114893b..c53c9f65 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -15,191 +15,204 @@ p0='no-funny'
 p1='tabs	," (dq) and spaces'
 p2='just space'
 
-cat >"$p0" <<\EOF
-1. A quick brown fox jumps over the lazy cat, oops dog.
-2. A quick brown fox jumps over the lazy cat, oops dog.
-3. A quick brown fox jumps over the lazy cat, oops dog.
-EOF
+test_expect_success 'setup' '
+	cat >"$p0" <<-\EOF &&
+	1. A quick brown fox jumps over the lazy cat, oops dog.
+	2. A quick brown fox jumps over the lazy cat, oops dog.
+	3. A quick brown fox jumps over the lazy cat, oops dog.
+	EOF
 
-cat 2>/dev/null >"$p1" "$p0"
-echo 'Foo Bar Baz' >"$p2"
+	{ cat "$p0" >"$p1" || :; } &&
+	{ echo "Foo Bar Baz" >"$p2" || :; } &&
 
-if test -f "$p1" && cmp "$p0" "$p1"
+	if test -f "$p1" && cmp "$p0" "$p1"
+	then
+		test_set_prereq TABS_IN_FILENAMES
+	fi
+'
+
+if ! test_have_prereq TABS_IN_FILENAMES
 then
-    test_set_prereq TABS_IN_FILENAMES
-else
 	# since FAT/NTFS does not allow tabs in filenames, skip this test
-	say 'Your filesystem does not allow tabs in filenames'
+	skip_all='Your filesystem does not allow tabs in filenames'
+	test_done
 fi
 
-test_expect_success TABS_IN_FILENAMES 'setup expect' "
-echo 'just space
-no-funny' >expected
-"
+test_expect_success 'setup: populate index and tree' '
+	git update-index --add "$p0" "$p2" &&
+	t0=$(git write-tree)
+'
 
-test_expect_success TABS_IN_FILENAMES 'git ls-files no-funny' \
-	'git update-index --add "$p0" "$p2" &&
+test_expect_success 'ls-files prints space in filename verbatim' '
+	printf "%s\n" "just space" no-funny >expected &&
 	git ls-files >current &&
-	test_cmp expected current'
-
-test_expect_success TABS_IN_FILENAMES 'setup expect' '
-t0=`git write-tree` &&
-echo "$t0" >t0 &&
+	test_cmp expected current
+'
 
-cat > expected <<\EOF
-just space
-no-funny
-"tabs\t,\" (dq) and spaces"
-EOF
+test_expect_success 'setup: add funny filename' '
+	git update-index --add "$p1" &&
+	t1=$(git write-tree)
 '
 
-test_expect_success TABS_IN_FILENAMES 'git ls-files with-funny' \
-	'git update-index --add "$p1" &&
+test_expect_success 'ls-files quotes funny filename' '
+	cat >expected <<-\EOF &&
+	just space
+	no-funny
+	"tabs\t,\" (dq) and spaces"
+	EOF
 	git ls-files >current &&
-	test_cmp expected current'
-
-test_expect_success TABS_IN_FILENAMES 'setup expect' "
-echo 'just space
-no-funny
-tabs	,\" (dq) and spaces' >expected
-"
-
-test_expect_success TABS_IN_FILENAMES 'git ls-files -z with-funny' \
-	'git ls-files -z | perl -pe y/\\000/\\012/ >current &&
-	test_cmp expected current'
-
-test_expect_success TABS_IN_FILENAMES 'setup expect' '
-t1=`git write-tree` &&
-echo "$t1" >t1 &&
-
-cat > expected <<\EOF
-just space
-no-funny
-"tabs\t,\" (dq) and spaces"
-EOF
-'
-
-test_expect_success TABS_IN_FILENAMES 'git ls-tree with funny' \
-	'git ls-tree -r $t1 | sed -e "s/^[^	]*	//" >current &&
-	 test_cmp expected current'
-
-test_expect_success TABS_IN_FILENAMES 'setup expect' '
-cat > expected <<\EOF
-A	"tabs\t,\" (dq) and spaces"
-EOF
-'
-
-test_expect_success TABS_IN_FILENAMES 'git diff-index with-funny' \
-	'git diff-index --name-status $t0 >current &&
-	test_cmp expected current'
-
-test_expect_success TABS_IN_FILENAMES 'git diff-tree with-funny' \
-	'git diff-tree --name-status $t0 $t1 >current &&
-	test_cmp expected current'
-
-test_expect_success TABS_IN_FILENAMES 'setup expect' "
-echo 'A
-tabs	,\" (dq) and spaces' >expected
-"
-
-test_expect_success TABS_IN_FILENAMES 'git diff-index -z with-funny' \
-	'git diff-index -z --name-status $t0 | perl -pe y/\\000/\\012/ >current &&
-	test_cmp expected current'
-
-test_expect_success TABS_IN_FILENAMES 'git diff-tree -z with-funny' \
-	'git diff-tree -z --name-status $t0 $t1 | perl -pe y/\\000/\\012/ >current &&
-	test_cmp expected current'
-
-test_expect_success TABS_IN_FILENAMES 'setup expect' '
-cat > expected <<\EOF
-CNUM	no-funny	"tabs\t,\" (dq) and spaces"
-EOF
-'
-
-test_expect_success TABS_IN_FILENAMES 'git diff-tree -C with-funny' \
-	'git diff-tree -C --find-copies-harder --name-status \
-		$t0 $t1 | sed -e 's/^C[0-9]*/CNUM/' >current &&
-	test_cmp expected current'
-
-test_expect_success TABS_IN_FILENAMES 'setup expect' '
-cat > expected <<\EOF
-RNUM	no-funny	"tabs\t,\" (dq) and spaces"
-EOF
-'
-
-test_expect_success TABS_IN_FILENAMES 'git diff-tree delete with-funny' \
-	'git update-index --force-remove "$p0" &&
-	git diff-index -M --name-status \
-		$t0 | sed -e 's/^R[0-9]*/RNUM/' >current &&
-	test_cmp expected current'
-
-test_expect_success TABS_IN_FILENAMES 'setup expect' '
-cat > expected <<\EOF
-diff --git a/no-funny "b/tabs\t,\" (dq) and spaces"
-similarity index NUM%
-rename from no-funny
-rename to "tabs\t,\" (dq) and spaces"
-EOF
-'
-
-test_expect_success TABS_IN_FILENAMES 'git diff-tree delete with-funny' \
-	'git diff-index -M -p $t0 |
-	 sed -e "s/index [0-9]*%/index NUM%/" >current &&
-	 test_cmp expected current'
-
-test_expect_success TABS_IN_FILENAMES 'setup expect' '
-chmod +x "$p1" &&
-cat > expected <<\EOF
-diff --git a/no-funny "b/tabs\t,\" (dq) and spaces"
-old mode 100644
-new mode 100755
-similarity index NUM%
-rename from no-funny
-rename to "tabs\t,\" (dq) and spaces"
-EOF
-'
-
-test_expect_success TABS_IN_FILENAMES 'git diff-tree delete with-funny' \
-	'git diff-index -M -p $t0 |
-	 sed -e "s/index [0-9]*%/index NUM%/" >current &&
-	 test_cmp expected current'
+	test_cmp expected current
+'
+
+test_expect_success 'ls-files -z does not quote funny filename' '
+	cat >expected <<-\EOF &&
+	just space
+	no-funny
+	tabs	," (dq) and spaces
+	EOF
+	git ls-files -z >ls-files.z &&
+	perl -pe "y/\000/\012/" <ls-files.z >current &&
+	test_cmp expected current
+'
+
+test_expect_success 'ls-tree quotes funny filename' '
+	cat >expected <<-\EOF &&
+	just space
+	no-funny
+	"tabs\t,\" (dq) and spaces"
+	EOF
+	git ls-tree -r $t1 >ls-tree &&
+	sed -e "s/^[^	]*	//" <ls-tree >current &&
+	test_cmp expected current
+'
 
-test_expect_success TABS_IN_FILENAMES 'setup expect' '
-cat >expected <<\EOF
- "tabs\t,\" (dq) and spaces"
- 1 file changed, 0 insertions(+), 0 deletions(-)
-EOF
-'
-
-test_expect_success TABS_IN_FILENAMES 'diffstat for rename with funny chars' \
-	'git diff-index -M -p $t0 |
-	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-	 test_i18ncmp expected current'
+test_expect_success 'diff-index --name-status quotes funny filename' '
+	cat >expected <<-\EOF &&
+	A	"tabs\t,\" (dq) and spaces"
+	EOF
+	git diff-index --name-status $t0 >current &&
+	test_cmp expected current
+'
+
+test_expect_success 'diff-tree --name-status quotes funny filename' '
+	cat >expected <<-\EOF &&
+	A	"tabs\t,\" (dq) and spaces"
+	EOF
+	git diff-tree --name-status $t0 $t1 >current &&
+	test_cmp expected current
+'
+
+test_expect_success 'diff-index -z does not quote funny filename' '
+	cat >expected <<-\EOF &&
+	A
+	tabs	," (dq) and spaces
+	EOF
+	git diff-index -z --name-status $t0 >diff-index.z &&
+	perl -pe "y/\000/\012/" <diff-index.z >current &&
+	test_cmp expected current
+'
+
+test_expect_success 'diff-tree -z does not quote funny filename' '
+	cat >expected <<-\EOF &&
+	A
+	tabs	," (dq) and spaces
+	EOF
+	git diff-tree -z --name-status $t0 $t1 >diff-tree.z &&
+	perl -pe y/\\000/\\012/ <diff-tree.z >current &&
+	test_cmp expected current
+'
+
+test_expect_success 'diff-tree --find-copies-harder quotes funny filename' '
+	cat >expected <<-\EOF &&
+	CNUM	no-funny	"tabs\t,\" (dq) and spaces"
+	EOF
+	git diff-tree -C --find-copies-harder --name-status $t0 $t1 >out &&
+	sed -e "s/^C[0-9]*/CNUM/" <out >current &&
+	test_cmp expected current
+'
+
+test_expect_success 'setup: remove unfunny index entry' '
+	git update-index --force-remove "$p0"
+'
+
+test_expect_success 'diff-tree -M quotes funny filename' '
+	cat >expected <<-\EOF &&
+	RNUM	no-funny	"tabs\t,\" (dq) and spaces"
+	EOF
+	git diff-index -M --name-status $t0 >out &&
+	sed -e "s/^R[0-9]*/RNUM/" <out >current &&
+	test_cmp expected current
+'
+
+test_expect_success 'diff-index -M -p quotes funny filename' '
+	cat >expected <<-\EOF &&
+	diff --git a/no-funny "b/tabs\t,\" (dq) and spaces"
+	similarity index NUM%
+	rename from no-funny
+	rename to "tabs\t,\" (dq) and spaces"
+	EOF
+	git diff-index -M -p $t0 >diff &&
+	sed -e "s/index [0-9]*%/index NUM%/" <diff >current &&
+	test_cmp expected current
+'
+
+test_expect_success 'setup: mode change' '
+	chmod +x "$p1"
+'
+
+test_expect_success 'diff-index -M -p with mode change quotes funny filename' '
+	cat >expected <<-\EOF &&
+	diff --git a/no-funny "b/tabs\t,\" (dq) and spaces"
+	old mode 100644
+	new mode 100755
+	similarity index NUM%
+	rename from no-funny
+	rename to "tabs\t,\" (dq) and spaces"
+	EOF
+	git diff-index -M -p $t0 >diff &&
+	sed -e "s/index [0-9]*%/index NUM%/" <diff >current &&
+	test_cmp expected current
+'
+
+test_expect_success 'diffstat for rename quotes funny filename' '
+	cat >expected <<-\EOF &&
+	 "tabs\t,\" (dq) and spaces"
+	 1 file changed, 0 insertions(+), 0 deletions(-)
+	EOF
+	git diff-index -M -p $t0 >diff &&
+	git apply --stat <diff >diffstat &&
+	sed -e "s/|.*//" -e "s/ *\$//" <diffstat >current &&
+	test_i18ncmp expected current
+'
 
-test_expect_success TABS_IN_FILENAMES 'numstat for rename with funny chars' \
-	'cat >expected <<-\EOF &&
+test_expect_success 'numstat for rename quotes funny filename' '
+	cat >expected <<-\EOF &&
 	0	0	"tabs\t,\" (dq) and spaces"
 	EOF
-	 git diff-index -M -p $t0 >diff &&
-	 git apply --numstat <diff >current &&
-	 test_cmp expected current'
-
-test_expect_success TABS_IN_FILENAMES 'setup expect' '
-cat > expected <<\EOF
-0	3	no-funny
-3	0	"tabs\t,\" (dq) and spaces"
-EOF
+	git diff-index -M -p $t0 >diff &&
+	git apply --numstat <diff >current &&
+	test_cmp expected current
 '
 
-test_expect_success TABS_IN_FILENAMES 'numstat without -M for funny rename' \
-	'git diff-index -p $t0 |
-	 git apply --numstat >current &&
-	 test_cmp expected current'
+test_expect_success 'numstat without -M quotes funny filename' '
+	cat >expected <<-\EOF &&
+	0	3	no-funny
+	3	0	"tabs\t,\" (dq) and spaces"
+	EOF
+	git diff-index -p $t0 >diff &&
+	git apply --numstat <diff >current &&
+	test_cmp expected current
+'
 
-test_expect_success TABS_IN_FILENAMES 'numstat for non-git funny rename diff' \
-	'git diff-index -p $t0 |
-	 sed -ne "/^[-+@]/p" |
-	 git apply --numstat >current &&
-	 test_cmp expected current'
+test_expect_success 'numstat for non-git rename diff quotes funny filename' '
+	cat >expected <<-\EOF &&
+	0	3	no-funny
+	3	0	"tabs\t,\" (dq) and spaces"
+	EOF
+	git diff-index -p $t0 >git-diff &&
+	sed -ne "/^[-+@]/p" <git-diff >diff &&
+	git apply --numstat <diff >current &&
+	test_cmp expected current
+'
 
 test_done
-- 
1.7.9.2
