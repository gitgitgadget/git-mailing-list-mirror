From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [HACK] t/test-lib.sh HACK: Add -s/--show-hack to test suite.
Date: Sun, 13 Jul 2008 13:09:05 +0200
Message-ID: <20080713110904.GG22323@leksak.fem-net>
References: <1215375751-30853-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807062241040.7342@eeepc-johanness> <20080707140841.GB6726@leksak.fem-net> <alpine.DEB.1.00.0807071540310.18205@racer> <20080712222212.GC22323@leksak.fem-net> <alpine.DEB.1.00.0807130222320.2995@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 13 13:10:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHzT3-0006zO-Jd
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 13:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbYGMLJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 07:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbYGMLJP
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 07:09:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:56326 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752008AbYGMLJN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 07:09:13 -0400
Received: (qmail invoked by alias); 13 Jul 2008 11:09:11 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp004) with SMTP; 13 Jul 2008 13:09:11 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/kQ2RSYhPka5rlRFcUY4/SzpDN1ztvVVJku1qgIc
	W1sxe3mxUC5xJq
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHzRx-0008Ak-3b; Sun, 13 Jul 2008 13:09:05 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807130222320.2995@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88296>

Hi,

Johannes Schindelin wrote:
[...]
> 
> Please clarify,
> Dscho

Ok, I add an example and show you what my output is using sh -x and my
hack. Perhaps you can point me to something that wents wrong.

First I make t4150 fail:

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index bc98260..07e626a 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -69,6 +69,7 @@ test_expect_success setup '
 	echo hello >file &&
 	git add file &&
 	test_tick &&
+	! : &&
 	git commit -m first &&
 	git tag first &&
 	echo world >>file &&

Now:

-------------
$ ./t4150-am.sh -s
Initialized empty Git repository in /home/sbeyer/src/git/t/trash directory/.git/
* expecting success:
        echo hello >file &&
        git add file &&
        test_tick &&
        ! : &&
        git commit -m first &&
        git tag first &&
        echo world >>file &&
        git add file &&
        test_tick &&
        git commit -s -F msg &&
        git tag second &&
        git format-patch --stdout first >patch1 &&
        sed -n -e "3,\$p" msg >file &&
        git add file &&
        test_tick &&
        git commit -m third &&
        git format-patch --stdout first >patch2 &&
        git checkout -b lorem &&
        sed -n -e "11,\$p" msg >file &&
        head -n 9 msg >>file &&
        test_tick &&
        git commit -a -m "moved stuff" &&
        echo goodbye >another &&
        git add another &&
        test_tick &&
        git commit -m "added another file" &&
        git format-patch --stdout master >lorem-move.patch

Testing:

        echo hello >file

-------
Testing:
        git add file

-------
Testing:
        test_tick

-------
Testing:
        ! :

* FAIL 1: setup

                echo hello >file &&
                git add file &&
                test_tick &&
                ! : &&
                git commit -m first &&
                git tag first &&
                echo world >>file &&
                git add file &&
                test_tick &&
                git commit -s -F msg &&
                git tag second &&
                git format-patch --stdout first >patch1 &&
                sed -n -e "3,\$p" msg >file &&
                git add file &&
                test_tick &&
                git commit -m third &&
                git format-patch --stdout first >patch2 &&
                git checkout -b lorem &&
                sed -n -e "11,\$p" msg >file &&
                head -n 9 msg >>file &&
                test_tick &&
                git commit -a -m "moved stuff" &&
                echo goodbye >another &&
                git add another &&
                test_tick &&
                git commit -m "added another file" &&
                git format-patch --stdout master >lorem-move.patch

-------------


And now sh -x:

-------------
$ sh --version
GNU bash, version 3.2.39(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2007 Free Software Foundation, Inc.
$ # no big differences using dash or zsh
$ sh -x ./t4150-am.sh -i
+ test_description='git am running'
+ . ./test-lib.sh
++ ORIGINAL_TERM=xterm
++ LANG=C
++ LC_ALL=C
++ PAGER=cat
++ TZ=UTC
++ TERM=dumb
++ export LANG LC_ALL PAGER TERM TZ
++ EDITOR=:
++ VISUAL=:
++ unset GIT_EDITOR
++ unset AUTHOR_DATE
++ unset AUTHOR_EMAIL
++ unset AUTHOR_NAME
++ unset COMMIT_AUTHOR_EMAIL
++ unset COMMIT_AUTHOR_NAME
++ unset EMAIL
++ unset GIT_ALTERNATE_OBJECT_DIRECTORIES
++ unset GIT_AUTHOR_DATE
++ GIT_AUTHOR_EMAIL=author@example.com
++ GIT_AUTHOR_NAME='A U Thor'
++ unset GIT_COMMITTER_DATE
++ GIT_COMMITTER_EMAIL=committer@example.com
++ GIT_COMMITTER_NAME='C O Mitter'
++ unset GIT_DIFF_OPTS
++ unset GIT_DIR
++ unset GIT_WORK_TREE
++ unset GIT_EXTERNAL_DIFF
++ unset GIT_INDEX_FILE
++ unset GIT_OBJECT_DIRECTORY
++ unset GIT_CEILING_DIRECTORIES
++ unset SHA1_FILE_DIRECTORIES
++ unset SHA1_FILE_DIRECTORY
++ GIT_MERGE_VERBOSITY=5
++ export GIT_MERGE_VERBOSITY
++ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
++ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
++ export EDITOR VISUAL
++ GIT_TEST_CMP='diff -u'
++ unset CDPATH
++ case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
+++ echo
+++ tr '[A-Z]' '[a-z]'
++ '[' xxterm '!=' xdumb ']'
++ TERM=xterm
++ export TERM
++ '[' -t 1 ']'
++ tput bold
++ tput setaf 1
++ tput sgr0
++ color=t
++ test 1 -ne 0
++ case "$1" in
++ immediate=t
++ shift
++ test 0 -ne 0
++ test -n t
++ test 'git am running' '!=' ''
++ test '' = t
++ exec
++ test '' = t
++ exec
++ test_failure=0
++ test_count=0
++ test_fixed=0
++ test_broken=0
++ test_success=0
++ trap die exit
+++ pwd
++ TEST_DIRECTORY=/home/sbeyer/src/git/t
++ PATH=/home/sbeyer/src/git/t/..:/home/sbeyer/bin/:/usr/local/bin:/usr/bin:/bin:/usr/games
+++ pwd
++ GIT_EXEC_PATH=/home/sbeyer/src/git/t/..
+++ pwd
++ GIT_TEMPLATE_DIR=/home/sbeyer/src/git/t/../templates/blt
++ unset GIT_CONFIG
++ unset GIT_CONFIG_LOCAL
++ GIT_CONFIG_NOSYSTEM=1
++ GIT_CONFIG_NOGLOBAL=1
++ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
+++ pwd
+++ pwd
++ GITPERLLIB=/home/sbeyer/src/git/t/../perl/blib/lib:/home/sbeyer/src/git/t/../perl/blib/arch/auto/Git
++ export GITPERLLIB
++ test -d ../templates/blt
++ test -x ../test-chmtime
++ . ../GIT-BUILD-OPTIONS
+++ SHELL_PATH=/bin/sh
++ test='trash directory'
++ rm -fr 'trash directory'
++ test_create_repo 'trash directory'
++ test 1 = 1
+++ pwd
++ owd=/home/sbeyer/src/git/t
++ repo='trash directory'
++ mkdir 'trash directory'
++ cd 'trash directory'
++ /home/sbeyer/src/git/t/../git init --template=/home/sbeyer/src/git/t/../templates/blt/
++ mv .git/hooks .git/hooks-disabled
++ cd /home/sbeyer/src/git/t
++ cd -P 'trash directory'
+++ expr ././t4150-am.sh : '.*/\(t[0-9]*\)-[^/]*$'
++ this_test=t4150
+ cat
+ cat
+ cat
+ echo 'Signed-off-by: C O Mitter <committer@example.com>'
+ test_expect_success setup '
	echo hello >file &&
	git add file &&
	test_tick &&
	! : &&
	git commit -m first &&
	git tag first &&
	echo world >>file &&
	git add file &&
	test_tick &&
	git commit -s -F msg &&
	git tag second &&
	git format-patch --stdout first >patch1 &&
	sed -n -e "3,\$p" msg >file &&
	git add file &&
	test_tick &&
	git commit -m third &&
	git format-patch --stdout first >patch2	&&
	git checkout -b lorem &&
	sed -n -e "11,\$p" msg >file &&
	head -n 9 msg >>file &&
	test_tick &&
	git commit -a -m "moved stuff" &&
	echo goodbye >another &&
	git add another &&
	test_tick &&
	git commit -m "added another file" &&
	git format-patch --stdout master >lorem-move.patch
'
+ test 2 = 2
+ test_skip setup '
	echo hello >file &&
	git add file &&
	test_tick &&
	! : &&
	git commit -m first &&
	git tag first &&
	echo world >>file &&
	git add file &&
	test_tick &&
	git commit -s -F msg &&
	git tag second &&
	git format-patch --stdout first >patch1 &&
	sed -n -e "3,\$p" msg >file &&
	git add file &&
	test_tick &&
	git commit -m third &&
	git format-patch --stdout first >patch2	&&
	git checkout -b lorem &&
	sed -n -e "11,\$p" msg >file &&
	head -n 9 msg >>file &&
	test_tick &&
	git commit -a -m "moved stuff" &&
	echo goodbye >another &&
	git add another &&
	test_tick &&
	git commit -m "added another file" &&
	git format-patch --stdout master >lorem-move.patch
'
++ expr ././t4150-am.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4150
++ expr 0 + 1
+ this_test=t4150.1
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success: 
	echo hello >file &&
	git add file &&
	test_tick &&
	! : &&
	git commit -m first &&
	git tag first &&
	echo world >>file &&
	git add file &&
	test_tick &&
	git commit -s -F msg &&
	git tag second &&
	git format-patch --stdout first >patch1 &&
	sed -n -e "3,\$p" msg >file &&
	git add file &&
	test_tick &&
	git commit -m third &&
	git format-patch --stdout first >patch2	&&
	git checkout -b lorem &&
	sed -n -e "11,\$p" msg >file &&
	head -n 9 msg >>file &&
	test_tick &&
	git commit -a -m "moved stuff" &&
	echo goodbye >another &&
	git add another &&
	test_tick &&
	git commit -m "added another file" &&
	git format-patch --stdout master >lorem-move.patch
'
+ say_color info 'expecting success: 
	echo hello >file &&
	git add file &&
	test_tick &&
	! : &&
	git commit -m first &&
	git tag first &&
	echo world >>file &&
	git add file &&
	test_tick &&
	git commit -s -F msg &&
	git tag second &&
	git format-patch --stdout first >patch1 &&
	sed -n -e "3,\$p" msg >file &&
	git add file &&
	test_tick &&
	git commit -m third &&
	git format-patch --stdout first >patch2	&&
	git checkout -b lorem &&
	sed -n -e "11,\$p" msg >file &&
	head -n 9 msg >>file &&
	test_tick &&
	git commit -a -m "moved stuff" &&
	echo goodbye >another &&
	git add another &&
	test_tick &&
	git commit -m "added another file" &&
	git format-patch --stdout master >lorem-move.patch
'
+ TERM=xterm
+ export TERM
+ case "$1" in
+ tput setaf 3
+ shift
+ echo '* expecting success: 
	echo hello >file &&
	git add file &&
	test_tick &&
	! : &&
	git commit -m first &&
	git tag first &&
	echo world >>file &&
	git add file &&
	test_tick &&
	git commit -s -F msg &&
	git tag second &&
	git format-patch --stdout first >patch1 &&
	sed -n -e "3,\$p" msg >file &&
	git add file &&
	test_tick &&
	git commit -m third &&
	git format-patch --stdout first >patch2	&&
	git checkout -b lorem &&
	sed -n -e "11,\$p" msg >file &&
	head -n 9 msg >>file &&
	test_tick &&
	git commit -a -m "moved stuff" &&
	echo goodbye >another &&
	git add another &&
	test_tick &&
	git commit -m "added another file" &&
	git format-patch --stdout master >lorem-move.patch
'
+ tput sgr0
+ test_run_ '
	echo hello >file &&
	git add file &&
	test_tick &&
	! : &&
	git commit -m first &&
	git tag first &&
	echo world >>file &&
	git add file &&
	test_tick &&
	git commit -s -F msg &&
	git tag second &&
	git format-patch --stdout first >patch1 &&
	sed -n -e "3,\$p" msg >file &&
	git add file &&
	test_tick &&
	git commit -m third &&
	git format-patch --stdout first >patch2	&&
	git checkout -b lorem &&
	sed -n -e "11,\$p" msg >file &&
	head -n 9 msg >>file &&
	test_tick &&
	git commit -a -m "moved stuff" &&
	echo goodbye >another &&
	git add another &&
	test_tick &&
	git commit -m "added another file" &&
	git format-patch --stdout master >lorem-move.patch
'
+ eval '
	echo hello >file &&
	git add file &&
	test_tick &&
	! : &&
	git commit -m first &&
	git tag first &&
	echo world >>file &&
	git add file &&
	test_tick &&
	git commit -s -F msg &&
	git tag second &&
	git format-patch --stdout first >patch1 &&
	sed -n -e "3,\$p" msg >file &&
	git add file &&
	test_tick &&
	git commit -m third &&
	git format-patch --stdout first >patch2	&&
	git checkout -b lorem &&
	sed -n -e "11,\$p" msg >file &&
	head -n 9 msg >>file &&
	test_tick &&
	git commit -a -m "moved stuff" &&
	echo goodbye >another &&
	git add another &&
	test_tick &&
	git commit -m "added another file" &&
	git format-patch --stdout master >lorem-move.patch
'
+ eval_ret=1
+ return 0
+ '[' 0 = 0 -a 1 = 0 ']'
+ test_failure_ setup '
	echo hello >file &&
	git add file &&
	test_tick &&
	! : &&
	git commit -m first &&
	git tag first &&
	echo world >>file &&
	git add file &&
	test_tick &&
	git commit -s -F msg &&
	git tag second &&
	git format-patch --stdout first >patch1 &&
	sed -n -e "3,\$p" msg >file &&
	git add file &&
	test_tick &&
	git commit -m third &&
	git format-patch --stdout first >patch2	&&
	git checkout -b lorem &&
	sed -n -e "11,\$p" msg >file &&
	head -n 9 msg >>file &&
	test_tick &&
	git commit -a -m "moved stuff" &&
	echo goodbye >another &&
	git add another &&
	test_tick &&
	git commit -m "added another file" &&
	git format-patch --stdout master >lorem-move.patch
'
++ expr 0 + 1
+ test_count=1
++ expr 0 + 1
+ test_failure=1
+ say_color error 'FAIL 1: setup'
+ TERM=xterm
+ export TERM
+ case "$1" in
+ tput bold
+ tput setaf 1
+ shift
+ echo '* FAIL 1: setup'
+ tput sgr0
+ shift
+ echo '
	echo hello >file &&
	git add file &&
	test_tick &&
	! : &&
	git commit -m first &&
	git tag first &&
	echo world >>file &&
	git add file &&
	test_tick &&
	git commit -s -F msg &&
	git tag second &&
	git format-patch --stdout first >patch1 &&
	sed -n -e "3,\$p" msg >file &&
	git add file &&
	test_tick &&
	git commit -m third &&
	git format-patch --stdout first >patch2	&&
	git checkout -b lorem &&
	sed -n -e "11,\$p" msg >file &&
	head -n 9 msg >>file &&
	test_tick &&
	git commit -a -m "moved stuff" &&
	echo goodbye >another &&
	git add another &&
	test_tick &&
	git commit -m "added another file" &&
	git format-patch --stdout master >lorem-move.patch
'
+ sed -e 's/^/	/'
+ test t = ''
+ trap - exit
+ exit 1
-------------

I want to see that the test failed at "! :" and I can't see that
on this output.

But perhaps I just have to reconfigure something, so that it will show me.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
