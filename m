From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Add infrastructure for translating Git with
 gettext
Date: Sun, 13 Jun 2010 22:00:11 -0700
Message-ID: <7vd3vucip0.fsf@alter.siamese.dyndns.org>
References: <20100607131930.GA30673@unpythonic.net>
 <1275945796-15973-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 07:01:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO1nC-0007yB-WD
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 07:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188Ab0FNFAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 01:00:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab0FNFAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 01:00:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBAC7BC44C;
	Mon, 14 Jun 2010 01:00:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H8lE+7KhQgAyW3mzQLeuRiPZcHA=; b=mGxlLx
	nECyUNE/gF6KRzNYGdXWWPzcxtQfSkkfgCiN117FsHS9XEuQRCZlX6gZfwhLSvGc
	1D0qm6x4xSgOWIpahaOVr584nHUNTWUHx4VEWSRdcHZrzjBdgqQPTI53AkvUAzOu
	9+7g0RuuHzWTxpBreZvjMfcXyaGAfVqfPl9aA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u+zcWzSvxPnnWt88C/V4Vg+Nnqg4hBbx
	Ntbijkc0hboI0oGNdFbUkDEFHzcyJwNkHlIsEZBOXtkUxefUguVrMWRswxBIl+gL
	69v6rjF2G5pUg08D5HlTD0woyo6GJ0/mhhoKJ6onGJD6wJLKUwTxoBKgrgvD2vx2
	3pas+FiJoIk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B9CDDBC44A;
	Mon, 14 Jun 2010 01:00:20 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1055BC449; Mon, 14 Jun
 2010 01:00:12 -0400 (EDT)
In-Reply-To: <1275945796-15973-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\,  7 Jun
 2010 21\:23\:16 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BB9F3C44-7771-11DF-B9A9-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149068>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/t/t0200-gettext.sh b/t/t0200-gettext.sh
> new file mode 100755
> index 0000000..b54e062
> --- /dev/null
> +++ b/t/t0200-gettext.sh
> @@ -0,0 +1,126 @@
> ...
> +test_expect_success 'sanity: No gettext("") data for fantasy locale' '
> +    LANGUAGE=3Dis LC_ALL=3Dtlh_TLH.UTF-8 gettext "" > real-locale &&
> +    test_expect_failure test -s real-locale
> +'
> +
> +test_expect_success 'sanity: Some gettext("") data for real locale' '
> +    LANGUAGE=3Dis LC_ALL=3Dis_IS.UTF-8 gettext "" > fantasy-locale &&
> +    test -s fantasy-locale
> +'

I am getting an empty output in the fantasy-locale file here.

Besides, the tests above look somewhat wrong.  "test_expect_failure" is a
top-level construct and the 11th test should read like this instead:

    test_expect_success 'sanity: No gettext("") data for fantasy locale' =
'
        LANGUAGE=3Dis LC_ALL=3Dtlh_TLH.UTF-8 gettext "" >fantasy-locale &=
&
        ! test -s fantasy-locale
    '

The test label reads "fantasy" but the test files were named "real"; they
should be consistent.  Also notice that I fixed the redirection style,
too, but that is a minor point.

The full error log up to the first failure on my system is shown below...


--=-=-=
Content-Disposition: inline; filename=1
Content-Description: error log \"sh -x t0200-gettext.sh -i -v\"

+ test_description='Gettext support for Git'
+ . ./test-lib.sh
++ case "$GIT_TEST_TEE_STARTED, $* " in
++ ORIGINAL_TERM=screen
++ LANG=C
++ LC_ALL=C
++ LANGUAGE=C
++ PAGER=cat
++ TZ=UTC
++ TERM=dumb
++ export LANG LC_ALL PAGER TERM TZ
++ EDITOR=:
++ unset VISUAL
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
++ unset GIT_NOTES_REF
++ unset GIT_NOTES_DISPLAY_REF
++ unset GIT_NOTES_REWRITE_REF
++ unset GIT_NOTES_REWRITE_MODE
++ GIT_MERGE_VERBOSITY=5
++ export GIT_MERGE_VERBOSITY
++ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
++ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
++ export EDITOR
++ GIT_TEST_CMP='diff -u'
++ unset CDPATH
++ unset GREP_OPTIONS
++ case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
+++ echo
+++ tr '[A-Z]' '[a-z]'
++ _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
++ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
++ '[' xscreen '!=' xdumb ']'
++ TERM=screen
++ export TERM
++ '[' -t 1 ']'
++ test 2 -ne 0
++ case "$1" in
++ immediate=t
++ shift
++ test 1 -ne 0
++ case "$1" in
++ verbose=t
++ shift
++ test 0 -ne 0
++ test -n ''
++ test 'Gettext support for Git' '!=' ''
++ test '' = t
++ exec
++ test t = t
++ exec
++ test_failure=0
++ test_count=0
++ test_fixed=0
++ test_broken=0
++ test_success=0
++ GIT_EXIT_OK=
++ trap die EXIT
++ satisfied=' '
+++ pwd
++ TEST_DIRECTORY=/srv/project/git/git.build/t
++ test -n ''
++ test -n ''
++ git_bin_dir=/srv/project/git/git.build/t/../bin-wrappers
++ test -x /srv/project/git/git.build/t/../bin-wrappers/git
++ PATH=/srv/project/git/git.build/t/../bin-wrappers:/home/junio/g/Debian-5.0.4-x86_64/git-active/bin:/home/junio/bin/Debian-5.0.4-x86_64:/home/junio/bin/common:/usr/local/bin:/sbin:/usr/sbin:/usr/bin:/bin:/usr/games
++ GIT_EXEC_PATH=/srv/project/git/git.build/t/..
++ test -n ''
+++ pwd
++ GIT_TEMPLATE_DIR=/srv/project/git/git.build/t/../templates/blt
++ unset GIT_CONFIG
++ GIT_CONFIG_NOSYSTEM=1
++ GIT_CONFIG_NOGLOBAL=1
++ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
++ . ../GIT-BUILD-OPTIONS
+++ SHELL_PATH=/bin/sh
+++ PERL_PATH=/usr/bin/perl
+++ TAR=tar
+++ NO_CURL=
+++ NO_PERL=
+++ NO_PYTHON=
+++ NO_GETTEXT=
+++ pwd
+++ pwd
++ GITPERLLIB=/srv/project/git/git.build/t/../perl/blib/lib:/srv/project/git/git.build/t/../perl/blib/arch/auto/Git
++ export GITPERLLIB
++ test -d ../templates/blt
++ test -z ''
++ test -z ''
+++ pwd
++ GITPYTHONLIB=/srv/project/git/git.build/t/../git_remote_helpers/build/lib
++ export GITPYTHONLIB
++ test -d ../git_remote_helpers/build
++ test -x ../test-chmtime
+++ basename t0200-gettext.sh .sh
++ test='trash directory.t0200-gettext'
++ test -n ''
++ case "$test" in
++ TRASH_DIRECTORY='/srv/project/git/git.build/t/trash directory.t0200-gettext'
++ test '!' -z ''
++ remove_trash='/srv/project/git/git.build/t/trash directory.t0200-gettext'
++ rm -fr 'trash directory.t0200-gettext'
++ test_create_repo 'trash directory.t0200-gettext'
++ test 1 = 1
+++ pwd
++ owd=/srv/project/git/git.build/t
++ repo='trash directory.t0200-gettext'
++ mkdir -p 'trash directory.t0200-gettext'
++ cd 'trash directory.t0200-gettext'
++ /srv/project/git/git.build/t/../git-init --template=/srv/project/git/git.build/t/../templates/blt/
Initialized empty Git repository in /srv/project/git/git.build/t/trash directory.t0200-gettext/.git/
++ mv .git/hooks .git/hooks-disabled
++ cd /srv/project/git/git.build/t
++ cd -P 'trash directory.t0200-gettext'
++ this_test=t0200-gettext.sh
++ this_test=t0200
++ case $(uname -s) in
+++ uname -s
++ test_set_prereq POSIXPERM
++ satisfied=' POSIXPERM '
++ test_set_prereq BSLASHPSPEC
++ satisfied=' POSIXPERM BSLASHPSPEC '
++ test_set_prereq EXECKEEPSPID
++ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID '
++ test -z ''
++ test_set_prereq PERL
++ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID PERL '
++ test -z ''
++ test_set_prereq PYTHON
++ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID PERL PYTHON '
++ test -z ''
++ test_set_prereq GETTEXT
++ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID PERL PYTHON GETTEXT '
++ ln -s x y
++ test -h y
++ test_set_prereq SYMLINKS
++ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID PERL PYTHON GETTEXT SYMLINKS '
++ rm -f y
+ GIT_TEXTDOMAINDIR=/srv/project/git/git.build/t/../share/locale
+ GIT_PO_PATH=/srv/project/git/git.build/t/../po
+ export GIT_TEXTDOMAINDIR GIT_PO_PATH
+ . /srv/project/git/git.build/t/../git-sh-i18n
++ . gettext.sh
+++ test 'X\t' = 'X\t'
+++ echo=echo
+++ test -z ''
+++ case "$0" in
++ test 0 -eq 0
++ test -z ''
++ TEXTDOMAIN=git
++ export TEXTDOMAIN
++ '[' -z /srv/project/git/git.build/t/../share/locale ']'
++ TEXTDOMAINDIR=/srv/project/git/git.build/t/../share/locale
++ export TEXTDOMAINDIR
+ test_expect_success 'sanity: $TEXTDOMAIN is git' '
    test $TEXTDOMAIN = "git"
'
+ test 2 = 3
+ prereq=
+ test 2 = 2
+ test_skip 'sanity: $TEXTDOMAIN is git' '
    test $TEXTDOMAIN = "git"
'
+ test_count=1
+ to_skip=
+ test -z ''
+ test -n ''
+ case "$to_skip" in
+ false
+ say 'expecting success: 
    test $TEXTDOMAIN = "git"
'
+ say_color info 'expecting success: 
    test $TEXTDOMAIN = "git"
'
+ test -z info
+ shift
+ echo '* expecting success: 
    test $TEXTDOMAIN = "git"
'
* expecting success: 
    test $TEXTDOMAIN = "git"

+ test_run_ '
    test $TEXTDOMAIN = "git"
'
+ test_cleanup=:
+ eval '
    test $TEXTDOMAIN = "git"
'
++ test git = git
+ eval_ret=0
+ eval :
++ :
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'sanity: $TEXTDOMAIN is git'
+ test_success=1
+ say_color '' '  ok 1: sanity: $TEXTDOMAIN is git'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 1: sanity: $TEXTDOMAIN is git'
*   ok 1: sanity: $TEXTDOMAIN is git
+ echo ''

+ test_have_prereq GETTEXT
+ case $satisfied in
+ : yes, have it
+ test_expect_success 'sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=YesPlease' '
    test -d "$TEXTDOMAINDIR" &&
    test "$TEXTDOMAINDIR" = "$GIT_TEXTDOMAINDIR"
'
+ test 2 = 3
+ prereq=
+ test 2 = 2
+ test_skip 'sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=YesPlease' '
    test -d "$TEXTDOMAINDIR" &&
    test "$TEXTDOMAINDIR" = "$GIT_TEXTDOMAINDIR"
'
+ test_count=2
+ to_skip=
+ test -z ''
+ test -n ''
+ case "$to_skip" in
+ false
+ say 'expecting success: 
    test -d "$TEXTDOMAINDIR" &&
    test "$TEXTDOMAINDIR" = "$GIT_TEXTDOMAINDIR"
'
+ say_color info 'expecting success: 
    test -d "$TEXTDOMAINDIR" &&
    test "$TEXTDOMAINDIR" = "$GIT_TEXTDOMAINDIR"
'
+ test -z info
+ shift
+ echo '* expecting success: 
    test -d "$TEXTDOMAINDIR" &&
    test "$TEXTDOMAINDIR" = "$GIT_TEXTDOMAINDIR"
'
* expecting success: 
    test -d "$TEXTDOMAINDIR" &&
    test "$TEXTDOMAINDIR" = "$GIT_TEXTDOMAINDIR"

+ test_run_ '
    test -d "$TEXTDOMAINDIR" &&
    test "$TEXTDOMAINDIR" = "$GIT_TEXTDOMAINDIR"
'
+ test_cleanup=:
+ eval '
    test -d "$TEXTDOMAINDIR" &&
    test "$TEXTDOMAINDIR" = "$GIT_TEXTDOMAINDIR"
'
++ test -d /srv/project/git/git.build/t/../share/locale
++ test /srv/project/git/git.build/t/../share/locale = /srv/project/git/git.build/t/../share/locale
+ eval_ret=0
+ eval :
++ :
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=YesPlease'
+ test_success=2
+ say_color '' '  ok 2: sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=YesPlease'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 2: sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=YesPlease'
*   ok 2: sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=YesPlease
+ echo ''

+ test_expect_success 'sanity: Icelandic locale was compiled' '
    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
'
+ test 2 = 3
+ prereq=
+ test 2 = 2
+ test_skip 'sanity: Icelandic locale was compiled' '
    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
'
+ test_count=3
+ to_skip=
+ test -z ''
+ test -n ''
+ case "$to_skip" in
+ false
+ say 'expecting success: 
    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
'
+ say_color info 'expecting success: 
    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
'
+ test -z info
+ shift
+ echo '* expecting success: 
    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
'
* expecting success: 
    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"

+ test_run_ '
    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
'
+ test_cleanup=:
+ eval '
    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
'
++ test -f /srv/project/git/git.build/t/../share/locale/is/LC_MESSAGES/git.mo
+ eval_ret=0
+ eval :
++ :
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'sanity: Icelandic locale was compiled'
+ test_success=3
+ say_color '' '  ok 3: sanity: Icelandic locale was compiled'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 3: sanity: Icelandic locale was compiled'
*   ok 3: sanity: Icelandic locale was compiled
+ echo ''

+ test_expect_success 'xgettext: Perl _() strings are not extracted' '
    test_expect_failure grep "A Perl string xgettext will not get" "$GIT_PO_PATH"/is.po
'
+ test 2 = 3
+ prereq=
+ test 2 = 2
+ test_skip 'xgettext: Perl _() strings are not extracted' '
    test_expect_failure grep "A Perl string xgettext will not get" "$GIT_PO_PATH"/is.po
'
+ test_count=4
+ to_skip=
+ test -z ''
+ test -n ''
+ case "$to_skip" in
+ false
+ say 'expecting success: 
    test_expect_failure grep "A Perl string xgettext will not get" "$GIT_PO_PATH"/is.po
'
+ say_color info 'expecting success: 
    test_expect_failure grep "A Perl string xgettext will not get" "$GIT_PO_PATH"/is.po
'
+ test -z info
+ shift
+ echo '* expecting success: 
    test_expect_failure grep "A Perl string xgettext will not get" "$GIT_PO_PATH"/is.po
'
* expecting success: 
    test_expect_failure grep "A Perl string xgettext will not get" "$GIT_PO_PATH"/is.po

+ test_run_ '
    test_expect_failure grep "A Perl string xgettext will not get" "$GIT_PO_PATH"/is.po
'
+ test_cleanup=:
+ eval '
    test_expect_failure grep "A Perl string xgettext will not get" "$GIT_PO_PATH"/is.po
'
++ test_expect_failure grep 'A Perl string xgettext will not get' /srv/project/git/git.build/t/../po/is.po
++ test 3 = 3
++ prereq=grep
++ shift
++ test 2 = 2
++ test_skip 'A Perl string xgettext will not get' /srv/project/git/git.build/t/../po/is.po
++ test_count=5
++ to_skip=
++ test -z ''
++ test -n grep
++ test_have_prereq grep
++ case $satisfied in
++ : nope
++ to_skip=t
++ case "$to_skip" in
++ say_color skip 'skipping test: A Perl string xgettext will not get' /srv/project/git/git.build/t/../po/is.po
++ test -z skip
++ shift
++ echo '* skipping test: A Perl string xgettext will not get /srv/project/git/git.build/t/../po/is.po'
* skipping test: A Perl string xgettext will not get /srv/project/git/git.build/t/../po/is.po
++ say_color skip 'skip 5: A Perl string xgettext will not get'
++ test -z skip
++ shift
++ echo '* skip 5: A Perl string xgettext will not get'
* skip 5: A Perl string xgettext will not get
++ : true
++ echo ''

+ eval_ret=0
+ eval :
++ :
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'xgettext: Perl _() strings are not extracted'
+ test_success=4
+ say_color '' '  ok 5: xgettext: Perl _() strings are not extracted'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 5: xgettext: Perl _() strings are not extracted'
*   ok 5: xgettext: Perl _() strings are not extracted
+ echo ''

+ test_expect_success 'xgettext: Comment extraction with --add-comments' '
    grep "TRANSLATORS: This is a test" "$TEST_DIRECTORY"/t0200/* | wc -l > expect &&
    grep "TRANSLATORS: This is a test" "$GIT_PO_PATH"/is.po  | wc -l > actual &&
    test_cmp expect actual
'
+ test 2 = 3
+ prereq=
+ test 2 = 2
+ test_skip 'xgettext: Comment extraction with --add-comments' '
    grep "TRANSLATORS: This is a test" "$TEST_DIRECTORY"/t0200/* | wc -l > expect &&
    grep "TRANSLATORS: This is a test" "$GIT_PO_PATH"/is.po  | wc -l > actual &&
    test_cmp expect actual
'
+ test_count=6
+ to_skip=
+ test -z ''
+ test -n ''
+ case "$to_skip" in
+ false
+ say 'expecting success: 
    grep "TRANSLATORS: This is a test" "$TEST_DIRECTORY"/t0200/* | wc -l > expect &&
    grep "TRANSLATORS: This is a test" "$GIT_PO_PATH"/is.po  | wc -l > actual &&
    test_cmp expect actual
'
+ say_color info 'expecting success: 
    grep "TRANSLATORS: This is a test" "$TEST_DIRECTORY"/t0200/* | wc -l > expect &&
    grep "TRANSLATORS: This is a test" "$GIT_PO_PATH"/is.po  | wc -l > actual &&
    test_cmp expect actual
'
+ test -z info
+ shift
+ echo '* expecting success: 
    grep "TRANSLATORS: This is a test" "$TEST_DIRECTORY"/t0200/* | wc -l > expect &&
    grep "TRANSLATORS: This is a test" "$GIT_PO_PATH"/is.po  | wc -l > actual &&
    test_cmp expect actual
'
* expecting success: 
    grep "TRANSLATORS: This is a test" "$TEST_DIRECTORY"/t0200/* | wc -l > expect &&
    grep "TRANSLATORS: This is a test" "$GIT_PO_PATH"/is.po  | wc -l > actual &&
    test_cmp expect actual

+ test_run_ '
    grep "TRANSLATORS: This is a test" "$TEST_DIRECTORY"/t0200/* | wc -l > expect &&
    grep "TRANSLATORS: This is a test" "$GIT_PO_PATH"/is.po  | wc -l > actual &&
    test_cmp expect actual
'
+ test_cleanup=:
+ eval '
    grep "TRANSLATORS: This is a test" "$TEST_DIRECTORY"/t0200/* | wc -l > expect &&
    grep "TRANSLATORS: This is a test" "$GIT_PO_PATH"/is.po  | wc -l > actual &&
    test_cmp expect actual
'
++ wc -l
++ grep 'TRANSLATORS: This is a test' /srv/project/git/git.build/t/t0200/test.c /srv/project/git/git.build/t/t0200/test.perl /srv/project/git/git.build/t/t0200/test.sh
++ grep 'TRANSLATORS: This is a test' /srv/project/git/git.build/t/../po/is.po
++ wc -l
++ test_cmp expect actual
++ diff -u expect actual
+ eval_ret=0
+ eval :
++ :
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'xgettext: Comment extraction with --add-comments'
+ test_success=5
+ say_color '' '  ok 6: xgettext: Comment extraction with --add-comments'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 6: xgettext: Comment extraction with --add-comments'
*   ok 6: xgettext: Comment extraction with --add-comments
+ echo ''

+ test_expect_success 'xgettext: Comment extraction with --add-comments stops at statements' '
    test_expect_failure grep "This is a phony" "$GIT_PO_PATH"/is.po &&
    test_expect_failure grep "the above comment" "$GIT_PO_PATH"/is.po
'
+ test 2 = 3
+ prereq=
+ test 2 = 2
+ test_skip 'xgettext: Comment extraction with --add-comments stops at statements' '
    test_expect_failure grep "This is a phony" "$GIT_PO_PATH"/is.po &&
    test_expect_failure grep "the above comment" "$GIT_PO_PATH"/is.po
'
+ test_count=7
+ to_skip=
+ test -z ''
+ test -n ''
+ case "$to_skip" in
+ false
+ say 'expecting success: 
    test_expect_failure grep "This is a phony" "$GIT_PO_PATH"/is.po &&
    test_expect_failure grep "the above comment" "$GIT_PO_PATH"/is.po
'
+ say_color info 'expecting success: 
    test_expect_failure grep "This is a phony" "$GIT_PO_PATH"/is.po &&
    test_expect_failure grep "the above comment" "$GIT_PO_PATH"/is.po
'
+ test -z info
+ shift
+ echo '* expecting success: 
    test_expect_failure grep "This is a phony" "$GIT_PO_PATH"/is.po &&
    test_expect_failure grep "the above comment" "$GIT_PO_PATH"/is.po
'
* expecting success: 
    test_expect_failure grep "This is a phony" "$GIT_PO_PATH"/is.po &&
    test_expect_failure grep "the above comment" "$GIT_PO_PATH"/is.po

+ test_run_ '
    test_expect_failure grep "This is a phony" "$GIT_PO_PATH"/is.po &&
    test_expect_failure grep "the above comment" "$GIT_PO_PATH"/is.po
'
+ test_cleanup=:
+ eval '
    test_expect_failure grep "This is a phony" "$GIT_PO_PATH"/is.po &&
    test_expect_failure grep "the above comment" "$GIT_PO_PATH"/is.po
'
++ test_expect_failure grep 'This is a phony' /srv/project/git/git.build/t/../po/is.po
++ test 3 = 3
++ prereq=grep
++ shift
++ test 2 = 2
++ test_skip 'This is a phony' /srv/project/git/git.build/t/../po/is.po
++ test_count=8
++ to_skip=
++ test -z ''
++ test -n grep
++ test_have_prereq grep
++ case $satisfied in
++ : nope
++ to_skip=t
++ case "$to_skip" in
++ say_color skip 'skipping test: This is a phony' /srv/project/git/git.build/t/../po/is.po
++ test -z skip
++ shift
++ echo '* skipping test: This is a phony /srv/project/git/git.build/t/../po/is.po'
* skipping test: This is a phony /srv/project/git/git.build/t/../po/is.po
++ say_color skip 'skip 8: This is a phony'
++ test -z skip
++ shift
++ echo '* skip 8: This is a phony'
* skip 8: This is a phony
++ : true
++ echo ''

++ test_expect_failure grep 'the above comment' /srv/project/git/git.build/t/../po/is.po
++ test 3 = 3
++ prereq=grep
++ shift
++ test 2 = 2
++ test_skip 'the above comment' /srv/project/git/git.build/t/../po/is.po
++ test_count=9
++ to_skip=
++ test -z ''
++ test -n grep
++ test_have_prereq grep
++ case $satisfied in
++ : nope
++ to_skip=t
++ case "$to_skip" in
++ say_color skip 'skipping test: the above comment' /srv/project/git/git.build/t/../po/is.po
++ test -z skip
++ shift
++ echo '* skipping test: the above comment /srv/project/git/git.build/t/../po/is.po'
* skipping test: the above comment /srv/project/git/git.build/t/../po/is.po
++ say_color skip 'skip 9: the above comment'
++ test -z skip
++ shift
++ echo '* skip 9: the above comment'
* skip 9: the above comment
++ : true
++ echo ''

+ eval_ret=0
+ eval :
++ :
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'xgettext: Comment extraction with --add-comments stops at statements'
+ test_success=6
+ say_color '' '  ok 9: xgettext: Comment extraction with --add-comments stops at statements'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 9: xgettext: Comment extraction with --add-comments stops at statements'
*   ok 9: xgettext: Comment extraction with --add-comments stops at statements
+ echo ''

+ test_have_prereq GETTEXT
+ case $satisfied in
+ : yes, have it
+ test_expect_success 'sanity: No gettext("") data for fantasy locale' '
    LANGUAGE=is LC_ALL=tlh_TLH.UTF-8 gettext "" > real-locale &&
    test_expect_failure test -s real-locale
'
+ test 2 = 3
+ prereq=
+ test 2 = 2
+ test_skip 'sanity: No gettext("") data for fantasy locale' '
    LANGUAGE=is LC_ALL=tlh_TLH.UTF-8 gettext "" > real-locale &&
    test_expect_failure test -s real-locale
'
+ test_count=10
+ to_skip=
+ test -z ''
+ test -n ''
+ case "$to_skip" in
+ false
+ say 'expecting success: 
    LANGUAGE=is LC_ALL=tlh_TLH.UTF-8 gettext "" > real-locale &&
    test_expect_failure test -s real-locale
'
+ say_color info 'expecting success: 
    LANGUAGE=is LC_ALL=tlh_TLH.UTF-8 gettext "" > real-locale &&
    test_expect_failure test -s real-locale
'
+ test -z info
+ shift
+ echo '* expecting success: 
    LANGUAGE=is LC_ALL=tlh_TLH.UTF-8 gettext "" > real-locale &&
    test_expect_failure test -s real-locale
'
* expecting success: 
    LANGUAGE=is LC_ALL=tlh_TLH.UTF-8 gettext "" > real-locale &&
    test_expect_failure test -s real-locale

+ test_run_ '
    LANGUAGE=is LC_ALL=tlh_TLH.UTF-8 gettext "" > real-locale &&
    test_expect_failure test -s real-locale
'
+ test_cleanup=:
+ eval '
    LANGUAGE=is LC_ALL=tlh_TLH.UTF-8 gettext "" > real-locale &&
    test_expect_failure test -s real-locale
'
++ LANGUAGE=is
++ LC_ALL=tlh_TLH.UTF-8
++ gettext ''
++ test_expect_failure test -s real-locale
++ test 3 = 3
++ prereq=test
++ shift
++ test 2 = 2
++ test_skip -s real-locale
++ test_count=11
++ to_skip=
++ test -z ''
++ test -n test
++ test_have_prereq test
++ case $satisfied in
++ : nope
++ to_skip=t
++ case "$to_skip" in
++ say_color skip 'skipping test: -s' real-locale
++ test -z skip
++ shift
++ echo '* skipping test: -s real-locale'
* skipping test: -s real-locale
++ say_color skip 'skip 11: -s'
++ test -z skip
++ shift
++ echo '* skip 11: -s'
* skip 11: -s
++ : true
++ echo ''

+ eval_ret=0
+ eval :
++ :
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'sanity: No gettext("") data for fantasy locale'
+ test_success=7
+ say_color '' '  ok 11: sanity: No gettext("") data for fantasy locale'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 11: sanity: No gettext("") data for fantasy locale'
*   ok 11: sanity: No gettext("") data for fantasy locale
+ echo ''

+ test_expect_success 'sanity: Some gettext("") data for real locale' '
    LANGUAGE=is LC_ALL=is_IS.UTF-8 gettext "" > fantasy-locale &&
    test -s fantasy-locale
'
+ test 2 = 3
+ prereq=
+ test 2 = 2
+ test_skip 'sanity: Some gettext("") data for real locale' '
    LANGUAGE=is LC_ALL=is_IS.UTF-8 gettext "" > fantasy-locale &&
    test -s fantasy-locale
'
+ test_count=12
+ to_skip=
+ test -z ''
+ test -n ''
+ case "$to_skip" in
+ false
+ say 'expecting success: 
    LANGUAGE=is LC_ALL=is_IS.UTF-8 gettext "" > fantasy-locale &&
    test -s fantasy-locale
'
+ say_color info 'expecting success: 
    LANGUAGE=is LC_ALL=is_IS.UTF-8 gettext "" > fantasy-locale &&
    test -s fantasy-locale
'
+ test -z info
+ shift
+ echo '* expecting success: 
    LANGUAGE=is LC_ALL=is_IS.UTF-8 gettext "" > fantasy-locale &&
    test -s fantasy-locale
'
* expecting success: 
    LANGUAGE=is LC_ALL=is_IS.UTF-8 gettext "" > fantasy-locale &&
    test -s fantasy-locale

+ test_run_ '
    LANGUAGE=is LC_ALL=is_IS.UTF-8 gettext "" > fantasy-locale &&
    test -s fantasy-locale
'
+ test_cleanup=:
+ eval '
    LANGUAGE=is LC_ALL=is_IS.UTF-8 gettext "" > fantasy-locale &&
    test -s fantasy-locale
'
++ LANGUAGE=is
++ LC_ALL=is_IS.UTF-8
++ gettext ''
++ test -s fantasy-locale
+ eval_ret=1
+ eval :
++ :
+ return 0
+ '[' 0 = 0 -a 1 = 0 ']'
+ test_failure_ 'sanity: Some gettext("") data for real locale' '
    LANGUAGE=is LC_ALL=is_IS.UTF-8 gettext "" > fantasy-locale &&
    test -s fantasy-locale
'
+ test_failure=1
+ say_color error 'FAIL 12: sanity: Some gettext("") data for real locale'
+ test -z error
+ shift
+ echo '* FAIL 12: sanity: Some gettext("") data for real locale'
* FAIL 12: sanity: Some gettext("") data for real locale
+ shift
+ echo '
    LANGUAGE=is LC_ALL=is_IS.UTF-8 gettext "" > fantasy-locale &&
    test -s fantasy-locale
'
+ sed -e 's/^/	/'
	
	    LANGUAGE=is LC_ALL=is_IS.UTF-8 gettext "" > fantasy-locale &&
	    test -s fantasy-locale
	
+ test t = ''
+ GIT_EXIT_OK=t
+ exit 1
+ die
+ code=1
+ test -n t
+ exit 1

--=-=-=--
