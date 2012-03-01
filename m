From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCH-w 101/105] t6300 (for-each-ref): modernize style
Date: Wed, 29 Feb 2012 17:45:22 -0800
Message-ID: <1330566326-26075-7-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 02:46:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2v61-00046e-KO
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 02:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030537Ab2CABqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 20:46:04 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64394 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030316Ab2CABqB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 20:46:01 -0500
Received: by mail-vx0-f174.google.com with SMTP id p1so74233vcq.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 17:46:01 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.67.203 as permitted sender) client-ip=10.52.67.203;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.67.203 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.67.203])
        by 10.52.67.203 with SMTP id p11mr4249532vdt.13.1330566361602 (num_hops = 1);
        Wed, 29 Feb 2012 17:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=uKWEZveQau9SODJe8Lledru8SlZDbV0Z4WFQF5zZPsI=;
        b=TVLZFyxA6WRSxdXOIPrmBOCuiwHha2YLBnEjLyv6XJhthz8Je4qZxZA5fRkjfoO9+L
         nV8KtpxNR75K/XBSoEKdq4K1ZuDjl3K7Iq/vrFAF/KgXEX1/UG+yhRDV7LdoFvp8KLnQ
         jiT+1JTsTy8FuCzsGvW55qhDh3VWyGLo9Bvuk=
Received: by 10.52.67.203 with SMTP id p11mr3631376vdt.13.1330566361555;
        Wed, 29 Feb 2012 17:46:01 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id n14sm502335vdj.22.2012.02.29.17.45.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 17:46:00 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120223002215.GE2410@tgrennan-laptop>
References: <20120223002215.GE2410@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191875>

- Guard setup with test_expect_success
- Single-quoted, tab prefaced test blocks of < 80 cols
- Redirect unwanted output

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 t/t6300-for-each-ref.sh |  296 +++++++++++++++++++++++++----------------------
 1 files changed, 157 insertions(+), 139 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 1721784..12916b2 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -5,9 +5,17 @@
 
 test_description='for-each-ref test'
 
+if ! test -r test-lib.sh ; then
+	(cd ${0%/*} && ./${0##*/} $@)
+	exit $?
+fi
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
+quiet () { "$@" >/dev/null; }
+silent () { "$@" >/dev/null 2>&1; }
+
 # Mon Jul 3 15:18:43 2006 +0000
 datestamp=1151939923
 setdate_and_increment () {
@@ -22,9 +30,9 @@ test_expect_success 'Create sample commit with known timestamp' '
 	setdate_and_increment &&
 	echo "Using $datestamp" > one &&
 	git add one &&
-	git commit -m "Initial" &&
+	git commit -q -m "Initial" &&
 	setdate_and_increment &&
-	git tag -a -m "Tagging at $datestamp" testtag
+	quiet git tag -a -m "Tagging at $datestamp" testtag
 '
 
 test_expect_success 'Create upstream config' '
@@ -115,261 +123,270 @@ test_atom tag contents 'Tagging at 1151939927
 '
 
 test_expect_success 'Check invalid atoms names are errors' '
-	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
+	silent test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
 
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
-	git for-each-ref --format="%(authordate)" refs/heads &&
-	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
-	git for-each-ref --format="%(authordate) %(authordate:default)" refs/heads &&
-	git for-each-ref --format="%(authordate:default) %(authordate:default)" refs/heads
+	f1="%(authordate)" &&
+	f2="%(authordate:default) %(authordate)" &&
+	f3="%(authordate) %(authordate:default)" &&
+	f4="%(authordate:default) %(authordate:default)"
+	quiet git for-each-ref --format="$f1" refs/heads &&
+	quiet git for-each-ref --format="$f2" refs/heads &&
+	quiet git for-each-ref --format="$f3" refs/heads &&
+	quiet git for-each-ref --format="$f4" refs/heads
 '
 
 test_expect_success 'Check valid format specifiers for date fields' '
-	git for-each-ref --format="%(authordate:default)" refs/heads &&
-	git for-each-ref --format="%(authordate:relative)" refs/heads &&
-	git for-each-ref --format="%(authordate:short)" refs/heads &&
-	git for-each-ref --format="%(authordate:local)" refs/heads &&
-	git for-each-ref --format="%(authordate:iso8601)" refs/heads &&
-	git for-each-ref --format="%(authordate:rfc2822)" refs/heads
+	quiet git for-each-ref --format="%(authordate:default)" refs/heads &&
+	quiet git for-each-ref --format="%(authordate:relative)" refs/heads &&
+	quiet git for-each-ref --format="%(authordate:short)" refs/heads &&
+	quiet git for-each-ref --format="%(authordate:local)" refs/heads &&
+	quiet git for-each-ref --format="%(authordate:iso8601)" refs/heads &&
+	quiet git for-each-ref --format="%(authordate:rfc2822)" refs/heads
 '
 
 test_expect_success 'Check invalid format specifiers are errors' '
-	test_must_fail git for-each-ref --format="%(authordate:INVALID)" refs/heads
+	h="%(authordate:INVALID)" &&
+	silent test_must_fail git for-each-ref --format="$h" refs/heads
 '
 
-cat >expected <<\EOF
+test_expect_success 'Check unformatted date fields output' '
+	'"
+	cat >expect <<-EOF &&
 'refs/heads/master' 'Mon Jul 3 17:18:43 2006 +0200' 'Mon Jul 3 17:18:44 2006 +0200'
 'refs/tags/testtag' 'Mon Jul 3 17:18:45 2006 +0200'
 EOF
-
-test_expect_success 'Check unformatted date fields output' '
-	(git for-each-ref --shell --format="%(refname) %(committerdate) %(authordate)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate)" refs/tags) >actual &&
-	test_cmp expected actual
+	"'
+	h="%(refname) %(committerdate) %(authordate)" &&
+	t="%(refname) %(taggerdate)" &&
+	(git for-each-ref --shell --format="$h" refs/heads &&
+	 git for-each-ref --shell --format="$t" refs/tags) |
+		test_cmp expect -
 '
 
 test_expect_success 'Check format "default" formatted date fields output' '
-	f=default &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	test_cmp expected actual
+	h="%(refname) %(committerdate:default) %(authordate:default)" &&
+	t="%(refname) %(taggerdate:default)" &&
+	(git for-each-ref --shell --format="$h" refs/heads &&
+	 git for-each-ref --shell --format="$t" refs/tags) |
+		test_cmp expect -
 '
 
-# Don't know how to do relative check because I can't know when this script
-# is going to be run and can't fake the current time to git, and hence can't
-# provide expected output.  Instead, I'll just make sure that "relative"
-# doesn't exit in error
-#
-#cat >expected <<\EOF
-#
-#EOF
-#
 test_expect_success 'Check format "relative" date fields output' '
-	f=relative &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual
+	'"
+	# Don't know how to do relative check because I can't know when this
+	# script is going to be run and can't fake the current time to git,
+	# and hence can't provide expected output.  Instead, I'll just make
+	# sure that 'relative' doesn't exit in error
+	"'
+	h="%(refname) %(committerdate:relative) %(authordate:relative)" &&
+	t="%(refname) %(taggerdate:relative)" &&
+	quiet git for-each-ref --shell --format="$h" refs/heads &&
+	quiet git for-each-ref --shell --format="$t" refs/tags
 '
 
-cat >expected <<\EOF
+test_expect_success 'Check format "short" date fields output' '
+	'"
+	cat >expect <<-EOF
 'refs/heads/master' '2006-07-03' '2006-07-03'
 'refs/tags/testtag' '2006-07-03'
 EOF
-
-test_expect_success 'Check format "short" date fields output' '
-	f=short &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	test_cmp expected actual
+	"'
+	h="%(refname) %(committerdate:short) %(authordate:short)" &&
+	t="%(refname) %(taggerdate:short)" &&
+	(git for-each-ref --shell --format="$h" refs/heads &&
+	 git for-each-ref --shell --format="$t" refs/tags) |
+		test_cmp expect -
 '
 
-cat >expected <<\EOF
+test_expect_success 'Check format "local" date fields output' '
+	'"
+	cat >expect <<-EOF
 'refs/heads/master' 'Mon Jul 3 15:18:43 2006' 'Mon Jul 3 15:18:44 2006'
 'refs/tags/testtag' 'Mon Jul 3 15:18:45 2006'
 EOF
-
-test_expect_success 'Check format "local" date fields output' '
-	f=local &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	test_cmp expected actual
+	"'
+	h="%(refname) %(committerdate:local) %(authordate:local)" &&
+	t="%(refname) %(taggerdate:local)" &&
+	(git for-each-ref --shell --format="$h" refs/heads &&
+	 git for-each-ref --shell --format="$t" refs/tags) |
+		test_cmp expect -
 '
 
-cat >expected <<\EOF
+test_expect_success 'Check format "iso8601" date fields output' '
+	'"
+	cat >expect <<-EOF
 'refs/heads/master' '2006-07-03 17:18:43 +0200' '2006-07-03 17:18:44 +0200'
 'refs/tags/testtag' '2006-07-03 17:18:45 +0200'
 EOF
-
-test_expect_success 'Check format "iso8601" date fields output' '
-	f=iso8601 &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	test_cmp expected actual
+	"'
+	h="%(refname) %(committerdate:iso8601) %(authordate:iso8601)" &&
+	t="%(refname) %(taggerdate:iso8601)" &&
+	(git for-each-ref --shell --format="$h" refs/heads &&
+	 git for-each-ref --shell --format="$t" refs/tags) |
+		test_cmp expect -
 '
 
-cat >expected <<\EOF
+test_expect_success 'Check format "rfc2822" date fields output' '
+	'"
+	cat >expect <<-EOF
 'refs/heads/master' 'Mon, 3 Jul 2006 17:18:43 +0200' 'Mon, 3 Jul 2006 17:18:44 +0200'
 'refs/tags/testtag' 'Mon, 3 Jul 2006 17:18:45 +0200'
 EOF
-
-test_expect_success 'Check format "rfc2822" date fields output' '
-	f=rfc2822 &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	test_cmp expected actual
+	"'
+	h="%(refname) %(committerdate:rfc2822) %(authordate:rfc2822)" &&
+	t="%(refname) %(taggerdate:rfc2822)" &&
+	(git for-each-ref --shell --format="$h" refs/heads &&
+	 git for-each-ref --shell --format="$t" refs/tags) |
+		test_cmp expect -
 '
 
-cat >expected <<\EOF
+test_expect_success 'Verify ascending sort' '
+	cat >expect <<-EOF
 refs/heads/master
 refs/remotes/origin/master
 refs/tags/testtag
 EOF
-
-test_expect_success 'Verify ascending sort' '
-	git for-each-ref --format="%(refname)" --sort=refname >actual &&
-	test_cmp expected actual
+	git for-each-ref --format="%(refname)" --sort=refname |
+		test_cmp expect -
 '
 
-
-cat >expected <<\EOF
+test_expect_success 'Verify descending sort' '
+	cat >expect <<-EOF
 refs/tags/testtag
 refs/remotes/origin/master
 refs/heads/master
 EOF
-
-test_expect_success 'Verify descending sort' '
-	git for-each-ref --format="%(refname)" --sort=-refname >actual &&
-	test_cmp expected actual
+	git for-each-ref --format="%(refname)" --sort=-refname |
+		test_cmp expect -
 '
 
-cat >expected <<\EOF
+test_expect_success 'Quoting style: shell' '
+	'"
+	cat >expect <<-EOF
 'refs/heads/master'
 'refs/remotes/origin/master'
 'refs/tags/testtag'
 EOF
-
-test_expect_success 'Quoting style: shell' '
-	git for-each-ref --shell --format="%(refname)" >actual &&
-	test_cmp expected actual
+	"'
+	git for-each-ref --shell --format="%(refname)" |
+		test_cmp expect -
 '
 
 test_expect_success 'Quoting style: perl' '
-	git for-each-ref --perl --format="%(refname)" >actual &&
-	test_cmp expected actual
+	git for-each-ref --perl --format="%(refname)" |
+		test_cmp expect -
 '
 
 test_expect_success 'Quoting style: python' '
-	git for-each-ref --python --format="%(refname)" >actual &&
-	test_cmp expected actual
+	git for-each-ref --python --format="%(refname)" |
+		test_cmp expect -
 '
 
-cat >expected <<\EOF
+test_expect_success 'Quoting style: tcl' '
+	cat >expect <<-EOF
 "refs/heads/master"
 "refs/remotes/origin/master"
 "refs/tags/testtag"
 EOF
-
-test_expect_success 'Quoting style: tcl' '
-	git for-each-ref --tcl --format="%(refname)" >actual &&
-	test_cmp expected actual
+	git for-each-ref --tcl --format="%(refname)" |
+		test_cmp expect -
 '
 
-for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
-	test_expect_success "more than one quoting style: $i" "
-		git for-each-ref $i 2>&1 | (read line &&
-		case \$line in
-		\"error: more than one quoting style\"*) : happy;;
-		*) false
-		esac)
-	"
-done
-
-cat >expected <<\EOF
+test_expect_success 'more than one quoting styles' '
+	cat >expect <<-EOF
+		error: more than one quoting style?
+	EOF
+	git for-each-ref --perl --shell 2>&1 | head -n 1 |
+		test_cmp expect - &&
+	git for-each-ref -s --python 2>&1 | head -n 1 |
+		test_cmp expect - &&
+	git for-each-ref --python --tcl 2>&1 | head -n 1 |
+		test_cmp expect - &&
+	git for-each-ref --tcl --perl 2>&1 | head -n 1 |
+		test_cmp expect -
+'
+test_expect_success 'Check short refname format' '
+	cat >expect <<-EOF
 master
 testtag
 EOF
-
-test_expect_success 'Check short refname format' '
-	(git for-each-ref --format="%(refname:short)" refs/heads &&
-	git for-each-ref --format="%(refname:short)" refs/tags) >actual &&
-	test_cmp expected actual
+	git for-each-ref --format="%(refname:short)" refs/heads refs/tags |
+		test_cmp expect -
 '
 
-cat >expected <<EOF
+test_expect_success 'Check short upstream format' '
+	cat >expect <<-EOF
 origin/master
 EOF
-
-test_expect_success 'Check short upstream format' '
-	git for-each-ref --format="%(upstream:short)" refs/heads >actual &&
-	test_cmp expected actual
+	git for-each-ref --format="%(upstream:short)" refs/heads |
+		test_cmp expect -
 '
 
-cat >expected <<EOF
+test_expect_success 'Check short objectname format' '
+	cat >expect <<-EOF
 67a36f1
 EOF
-
-test_expect_success 'Check short objectname format' '
-	git for-each-ref --format="%(objectname:short)" refs/heads >actual &&
-	test_cmp expected actual
+	git for-each-ref --format="%(objectname:short)" refs/heads |
+		test_cmp expect -
 '
 
 test_expect_success 'Check for invalid refname format' '
-	test_must_fail git for-each-ref --format="%(refname:INVALID)"
+	silent test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
 
-cat >expected <<\EOF
+test_expect_success 'Check ambiguous head and tag refs (strict)' '
+	cat >expect <<-EOF
 heads/master
 tags/master
 EOF
-
-test_expect_success 'Check ambiguous head and tag refs (strict)' '
 	git config --bool core.warnambiguousrefs true &&
-	git checkout -b newtag &&
+	git checkout -q -b newtag &&
 	echo "Using $datestamp" > one &&
 	git add one &&
-	git commit -m "Branch" &&
+	git commit -q -m "Branch" &&
 	setdate_and_increment &&
-	git tag -m "Tagging at $datestamp" master &&
-	git for-each-ref --format "%(refname:short)" refs/heads/master refs/tags/master >actual &&
-	test_cmp expected actual
+	quiet git tag -m "Tagging at $datestamp" master &&
+	f="%(refname:short)" &&
+	git for-each-ref --format "$f" refs/heads/master refs/tags/master |
+		test_cmp expect -
 '
 
-cat >expected <<\EOF
+test_expect_success 'Check ambiguous head and tag refs (loose)' '
+	cat >expect <<-EOF
 heads/master
 master
 EOF
-
-test_expect_success 'Check ambiguous head and tag refs (loose)' '
 	git config --bool core.warnambiguousrefs false &&
-	git for-each-ref --format "%(refname:short)" refs/heads/master refs/tags/master >actual &&
-	test_cmp expected actual
+	f="%(refname:short)" &&
+	git for-each-ref --format "$f" refs/heads/master refs/tags/master |
+		test_cmp expect -
 '
 
-cat >expected <<\EOF
+test_expect_success 'Check ambiguous head and tag refs II (loose)' '
+	cat >expect <<-EOF
 heads/ambiguous
 ambiguous
 EOF
-
-test_expect_success 'Check ambiguous head and tag refs II (loose)' '
-	git checkout master &&
+	git checkout -q master &&
 	git tag ambiguous testtag^0 &&
 	git branch ambiguous testtag^0 &&
-	git for-each-ref --format "%(refname:short)" refs/heads/ambiguous refs/tags/ambiguous >actual &&
-	test_cmp expected actual
+	f="%(refname:short)" &&
+	git for-each-ref --format "$f" refs/heads/ambiguous refs/tags/ambiguous |
+		test_cmp expect -
 '
 
 test_expect_success 'an unusual tag with an incomplete line' '
-
 	git tag -m "bogo" bogo &&
 	bogo=$(git cat-file tag bogo) &&
 	bogo=$(printf "%s" "$bogo" | git mktag) &&
 	git tag -f bogo "$bogo" &&
 	git for-each-ref --format "%(body)" refs/tags/bogo
-
 '
 
 test_expect_success 'create tag with subject and body content' '
-	cat >>msg <<-\EOF &&
+	cat >msg <<-\EOF &&
 		the subject line
 
 		first body line
@@ -395,8 +412,9 @@ test_expect_success 'create tag with multiline subject' '
 		first body line
 		second body line
 	EOF
-	git tag -F msg multiline
+	quiet git tag -F msg multiline
 '
+
 test_atom refs/tags/multiline subject 'first subject line second subject line'
 test_atom refs/tags/multiline contents:subject 'first subject line second subject line'
 test_atom refs/tags/multiline body 'first body line
-- 
1.7.8
