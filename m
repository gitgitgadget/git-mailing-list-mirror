From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/12] t4200 (rerere): modernize style
Date: Thu, 5 Aug 2010 06:25:34 -0500
Message-ID: <20100805112534.GK13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:27:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgybR-0004da-Sf
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759048Ab0HEL1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 07:27:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47851 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab0HEL1D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:27:03 -0400
Received: by iwn33 with SMTP id 33so92243iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zpGpYRm4/ud6l9kkExrw5OpTFiKSZpyp/dbXQbeCUmg=;
        b=CXTypzcphjTs/QGku4iENmwzlZp40FWOE/c+6HXLG87wSkRx46rI7B5zYlSTSZCgNM
         eKyVHXdIoztCiEIGTWHrsjtrL2kCZP4FL6DnqkZ2Th7rgBr1XGKu7M/aApCgQQPOe5Ey
         7mr2JK0UMOXCUVyZKdUzJ14Zi7WcVE/SCHERg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cMXyjUZoccUzasDGBXQPhwLQOxCvG+M3Ss3GcJwJKWFNTw69RvguN+qOY69HUrIfC4
         IbHrYnhNpZgmZo/CqwNn37lSVOne2Hgm4c3WNygSmItmCRZ2JJTSkzjsmNV/vAQW1TwR
         YDcfji89kLtU8T4atbJtawEtrNVle8IQkm2y4=
Received: by 10.231.174.206 with SMTP id u14mr12162537ibz.103.1281007622716;
        Thu, 05 Aug 2010 04:27:02 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 34sm56918ibi.12.2010.08.05.04.27.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:27:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100805110822.GB13779@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152641>

Guard all test code with test_expect_success to make the
script easier to follow.  While at it, pick some other nits:

 - use test_tick (more than we have to, to be realistic);

 - 'single quotes' and \escaped HERE documents where possible
   simplify review for escaping problems;

 - omit whitespace after >redirection operators for
   consistency with other tests;

 - use "update-index --refresh" instead of testing that
   "ls-files -u" output is empty, since the former produces
   nicer output on failure;

 - compare to expected nonempty "ls-files -u" output instead
   of counting lines when it is expected to be nonempty.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4200-rerere.sh |  303 +++++++++++++++++++++++++++++++----------------------
 1 files changed, 179 insertions(+), 124 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 70856d0..3ed4d1a 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -4,237 +4,292 @@
 #
 
 test_description='git rerere
+
+! [fifth] version1
+ ! [first] first
+  ! [fourth] version1
+   ! [master] initial
+    ! [second] prefer first over second
+     ! [third] version2
+------
+     + [third] version2
++      [fifth] version1
+  +    [fourth] version1
++ +  + [third^] third
+    -  [second] prefer first over second
+ +  +  [first] first
+    +  [second^] second
+++++++ [master] initial
 '
 
 . ./test-lib.sh
 
-test_expect_success 'setup' "
-	cat > a1 <<- EOF &&
+test_expect_success 'setup' '
+	cat >a1 <<-\EOF &&
 	Some title
 	==========
-	Whether 'tis nobler in the mind to suffer
+	Whether '\''tis nobler in the mind to suffer
 	The slings and arrows of outrageous fortune,
 	Or to take arms against a sea of troubles,
 	And by opposing end them? To die: to sleep;
 	No more; and by a sleep to say we end
 	The heart-ache and the thousand natural shocks
-	That flesh is heir to, 'tis a consummation
-	Devoutly to be wish'd.
+	That flesh is heir to, '\''tis a consummation
+	Devoutly to be wish'\''d.
 	EOF
 
 	git add a1 &&
+	test_tick &&
 	git commit -q -a -m initial &&
 
-	git checkout -b first &&
-	cat >> a1 <<- EOF &&
+	cat >>a1 <<-\EOF &&
 	Some title
 	==========
 	To die, to sleep;
-	To sleep: perchance to dream: ay, there's the rub;
+	To sleep: perchance to dream: ay, there'\''s the rub;
 	For in that sleep of death what dreams may come
 	When we have shuffled off this mortal coil,
-	Must give us pause: there's the respect
+	Must give us pause: there'\''s the respect
 	That makes calamity of so long life;
 	EOF
+
+	git checkout -b first &&
+	test_tick &&
 	git commit -q -a -m first &&
 
 	git checkout -b second master &&
 	git show first:a1 |
-	sed -e 's/To die, t/To die! T/' -e 's/Some title/Some Title/' > a1 &&
-	echo '* END *' >>a1 &&
+	sed -e "s/To die, t/To die! T/" -e "s/Some title/Some Title/" >a1 &&
+	echo "* END *" >>a1 &&
+	test_tick &&
 	git commit -q -a -m second
-"
+'
 
 test_expect_success 'nothing recorded without rerere' '
-	(rm -rf .git/rr-cache; git config rerere.enabled false) &&
+	rm -rf .git/rr-cache &&
+	git config rerere.enabled false &&
 	test_must_fail git merge first &&
 	! test -d .git/rr-cache
 '
 
-# activate rerere, old style
-test_expect_success 'conflicting merge' '
+test_expect_success 'activate rerere, old style (conflicting merge)' '
 	git reset --hard &&
 	mkdir .git/rr-cache &&
-	git config --unset rerere.enabled &&
-	test_must_fail git merge first
-'
+	test_might_fail git config --unset rerere.enabled &&
+	test_must_fail git merge first &&
 
-sha1=$(perl -pe 's/	.*//' .git/MERGE_RR)
-rr=.git/rr-cache/$sha1
-test_expect_success 'recorded preimage' "grep ^=======$ $rr/preimage"
+	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
+	rr=.git/rr-cache/$sha1 &&
+	grep "^=======\$" $rr/preimage &&
+	! test -f $rr/postimage &&
+	! test -f $rr/thisimage
+'
 
 test_expect_success 'rerere.enabled works, too' '
 	rm -rf .git/rr-cache &&
 	git config rerere.enabled true &&
 	git reset --hard &&
 	test_must_fail git merge first &&
+
+	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
+	rr=.git/rr-cache/$sha1 &&
 	grep ^=======$ $rr/preimage
 '
 
-test_expect_success 'no postimage or thisimage yet' \
-	"test ! -f $rr/postimage -a ! -f $rr/thisimage"
+test_expect_success 'set up rr-cache' '
+	rm -rf .git/rr-cache &&
+	git config rerere.enabled true &&
+	git reset --hard &&
+	test_must_fail git merge first &&
+	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
+	rr=.git/rr-cache/$sha1
+'
 
-test_expect_success 'preimage has right number of lines' '
+test_expect_success 'rr-cache looks sane' '
+	# no postimage or thisimage yet
+	! test -f $rr/postimage &&
+	! test -f $rr/thisimage &&
 
+	# preimage has right number of lines
 	cnt=$(sed -ne "/^<<<<<<</,/^>>>>>>>/p" $rr/preimage | wc -l) &&
+	echo $cnt &&
 	test $cnt = 13
-
 '
 
-git show first:a1 > a1
-
-cat > expect << EOF
---- a/a1
-+++ b/a1
-@@ -1,4 +1,4 @@
--Some Title
-+Some title
- ==========
- Whether 'tis nobler in the mind to suffer
- The slings and arrows of outrageous fortune,
-@@ -8,21 +8,11 @@
- The heart-ache and the thousand natural shocks
- That flesh is heir to, 'tis a consummation
- Devoutly to be wish'd.
--<<<<<<<
--Some Title
--==========
--To die! To sleep;
--=======
- Some title
- ==========
- To die, to sleep;
-->>>>>>>
- To sleep: perchance to dream: ay, there's the rub;
- For in that sleep of death what dreams may come
- When we have shuffled off this mortal coil,
- Must give us pause: there's the respect
- That makes calamity of so long life;
--<<<<<<<
--=======
--* END *
-->>>>>>>
-EOF
-git rerere diff > out
-
-test_expect_success 'rerere diff' 'test_cmp expect out'
-
-cat > expect << EOF
-a1
-EOF
-
-git rerere status > out
+test_expect_success 'rerere diff' '
+	git show first:a1 >a1 &&
+	cat >expect <<-\EOF &&
+	--- a/a1
+	+++ b/a1
+	@@ -1,4 +1,4 @@
+	-Some Title
+	+Some title
+	 ==========
+	 Whether '\''tis nobler in the mind to suffer
+	 The slings and arrows of outrageous fortune,
+	@@ -8,21 +8,11 @@
+	 The heart-ache and the thousand natural shocks
+	 That flesh is heir to, '\''tis a consummation
+	 Devoutly to be wish'\''d.
+	-<<<<<<<
+	-Some Title
+	-==========
+	-To die! To sleep;
+	-=======
+	 Some title
+	 ==========
+	 To die, to sleep;
+	->>>>>>>
+	 To sleep: perchance to dream: ay, there'\''s the rub;
+	 For in that sleep of death what dreams may come
+	 When we have shuffled off this mortal coil,
+	 Must give us pause: there'\''s the respect
+	 That makes calamity of so long life;
+	-<<<<<<<
+	-=======
+	-* END *
+	->>>>>>>
+	EOF
+	git rerere diff >out &&
+	test_cmp expect out
+'
 
-test_expect_success 'rerere status' 'test_cmp expect out'
+test_expect_success 'rerere status' '
+	echo a1 >expect &&
+	git rerere status >out &&
+	test_cmp expect out
+'
 
-test_expect_success 'commit succeeds' \
-	"git commit -q -a -m 'prefer first over second'"
+test_expect_success 'first postimage wins' '
+	git show first:a1 | sed "s/To die: t/To die! T/" >expect &&
 
-test_expect_success 'recorded postimage' "test -f $rr/postimage"
+	git commit -q -a -m "prefer first over second" &&
+	test -f $rr/postimage &&
 
-test_expect_success 'another conflicting merge' '
 	git checkout -b third master &&
-	git show second^:a1 | sed "s/To die: t/To die! T/" > a1 &&
+	git show second^:a1 | sed "s/To die: t/To die! T/" >a1 &&
 	git commit -q -a -m third &&
-	test_must_fail git pull . first
-'
-
-git show first:a1 | sed 's/To die: t/To die! T/' > expect
-test_expect_success 'rerere kicked in' "! grep ^=======$ a1"
-
-test_expect_success 'rerere prefers first change' 'test_cmp a1 expect'
-
-rm $rr/postimage
-echo "$sha1	a1" | perl -pe 'y/\012/\000/' > .git/MERGE_RR
-
-test_expect_success 'rerere clear' 'git rerere clear'
-
-test_expect_success 'clear removed the directory' "test ! -d $rr"
 
-mkdir $rr
-echo Hello > $rr/preimage
-echo World > $rr/postimage
-
-sha2=4000000000000000000000000000000000000000
-rr2=.git/rr-cache/$sha2
-mkdir $rr2
-echo Hello > $rr2/preimage
+	test_must_fail git pull . first &&
+	# rerere kicked in
+	! grep "^=======\$" a1 &&
+	test_cmp expect a1
+'
 
-almost_15_days_ago=$((60-15*86400))
-just_over_15_days_ago=$((-1-15*86400))
-almost_60_days_ago=$((60-60*86400))
-just_over_60_days_ago=$((-1-60*86400))
+test_expect_success 'rerere clear' '
+	rm $rr/postimage &&
+	echo "$sha1	a1" | perl -pe "y/\012/\000/" >.git/MERGE_RR &&
+	git rerere clear &&
+	! test -d $rr
+'
 
-test-chmtime =$almost_60_days_ago $rr/preimage
-test-chmtime =$almost_15_days_ago $rr2/preimage
+test_expect_success 'set up for garbage collection tests' '
+	mkdir -p $rr &&
+	echo Hello >$rr/preimage &&
+	echo World >$rr/postimage &&
 
-test_expect_success 'garbage collection (part1)' 'git rerere gc'
+	sha2=4000000000000000000000000000000000000000 &&
+	rr2=.git/rr-cache/$sha2 &&
+	mkdir $rr2 &&
+	echo Hello >$rr2/preimage &&
 
-test_expect_success 'young records still live' \
-	"test -f $rr/preimage && test -f $rr2/preimage"
+	almost_15_days_ago=$((60-15*86400)) &&
+	just_over_15_days_ago=$((-1-15*86400)) &&
+	almost_60_days_ago=$((60-60*86400)) &&
+	just_over_60_days_ago=$((-1-60*86400)) &&
 
-test-chmtime =$just_over_60_days_ago $rr/preimage
-test-chmtime =$just_over_15_days_ago $rr2/preimage
+	test-chmtime =$almost_60_days_ago $rr/preimage &&
+	test-chmtime =$almost_15_days_ago $rr2/preimage
+'
 
-test_expect_success 'garbage collection (part2)' 'git rerere gc'
+test_expect_success 'garbage collection preserves young records' '
+	git rerere gc &&
+	test -f $rr/preimage &&
+	test -f $rr2/preimage
+'
 
-test_expect_success 'old records rest in peace' \
-	"test ! -f $rr/preimage && test ! -f $rr2/preimage"
+test_expect_success 'old records rest in peace' '
+	test-chmtime =$just_over_60_days_ago $rr/preimage &&
+	test-chmtime =$just_over_15_days_ago $rr2/preimage &&
+	git rerere gc &&
+	! test -f $rr/preimage &&
+	! test -f $rr2/preimage
+'
 
-test_expect_success 'file2 added differently in two branches' '
+test_expect_success 'setup: file2 added differently in two branches' '
 	git reset --hard &&
+
 	git checkout -b fourth &&
-	echo Hallo > file2 &&
+	echo Hallo >file2 &&
 	git add file2 &&
+	test_tick &&
 	git commit -m version1 &&
+
 	git checkout third &&
-	echo Bello > file2 &&
+	echo Bello >file2 &&
 	git add file2 &&
+	test_tick &&
 	git commit -m version2 &&
+
 	test_must_fail git merge fourth &&
-	echo Cello > file2 &&
+	echo Cello >file2 &&
 	git add file2 &&
 	git commit -m resolution
 '
 
 test_expect_success 'resolution was recorded properly' '
+	echo Cello >expected &&
+
 	git reset --hard HEAD~2 &&
 	git checkout -b fifth &&
-	echo Hallo > file3 &&
+
+	echo Hallo >file3 &&
 	git add file3 &&
+	test_tick &&
 	git commit -m version1 &&
+
 	git checkout third &&
-	echo Bello > file3 &&
+	echo Bello >file3 &&
 	git add file3 &&
+	test_tick &&
 	git commit -m version2 &&
 	git tag version2 &&
+
 	test_must_fail git merge fifth &&
-	test Cello = "$(cat file3)" &&
-	test 0 != $(git ls-files -u | wc -l)
+	test_cmp expected file3 &&
+	test_must_fail git update-index --refresh
 '
 
 test_expect_success 'rerere.autoupdate' '
-	git config rerere.autoupdate true
+	git config rerere.autoupdate true &&
 	git reset --hard &&
 	git checkout version2 &&
 	test_must_fail git merge fifth &&
-	test 0 = $(git ls-files -u | wc -l)
+	git update-index --refresh
 '
 
 test_expect_success 'merge --rerere-autoupdate' '
-	git config --unset rerere.autoupdate
+	test_might_fail git config --unset rerere.autoupdate &&
 	git reset --hard &&
 	git checkout version2 &&
 	test_must_fail git merge --rerere-autoupdate fifth &&
-	test 0 = $(git ls-files -u | wc -l)
+	git update-index --refresh
 '
 
 test_expect_success 'merge --no-rerere-autoupdate' '
-	git config rerere.autoupdate true
+	headblob=$(git rev-parse version2:file3) &&
+	mergeblob=$(git rev-parse fifth:file3) &&
+	cat >expected <<-EOF &&
+	100644 $headblob 2	file3
+	100644 $mergeblob 3	file3
+	EOF
+
+	git config rerere.autoupdate true &&
 	git reset --hard &&
 	git checkout version2 &&
 	test_must_fail git merge --no-rerere-autoupdate fifth &&
-	test 2 = $(git ls-files -u | wc -l)
+	git ls-files -u >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
1.7.2.1.544.ga752d.dirty
