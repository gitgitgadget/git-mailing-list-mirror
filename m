From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2 5/5] t6300 (for-each-ref): modernize style
Date: Fri,  2 Mar 2012 18:15:37 -0800
Message-ID: <1330740942-25130-6-git-send-email-tmgrennan@gmail.com>
References: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 03:17:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3eX2-00026b-O5
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 03:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169Ab2CCCQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 21:16:37 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48188 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab2CCCQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 21:16:08 -0500
Received: by mail-vx0-f174.google.com with SMTP id p1so2024061vcq.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 18:16:07 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.30.98 as permitted sender) client-ip=10.52.30.98;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.30.98 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.30.98])
        by 10.52.30.98 with SMTP id r2mr20604190vdh.8.1330740967659 (num_hops = 1);
        Fri, 02 Mar 2012 18:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=aGuok9MPrJdi9jey7zPyJp4TmmkGtW9vCZE+BU2e9U4=;
        b=mt3vKRkzXvdKd75Y+0nDkpJO0ppO9vPdmNwEWpot0xsQwsum9/Pzk7EgAZ4vpASbBA
         YZi6xuvEVqy/BECK09ZoJJZ1ue2pt5Vt2flIr3g2fMnce7WIpUs5VXewunnhkk1tPNop
         T19JKs5ISDikt/DAWxMVmA+6Npw0zZYLXmi3Lgz9HABFw/9zGabIVKiftshX3XK4/ETZ
         fSK+pBbRw2675SIo9tK1CLowDIN/JjTTUxS3VCDuyYCRqCGZPxiLRs2PfMidiOXiCnlP
         id8slsm7scv+hk3SRY7OC7wzng6UUSqb+qVBGOtZJxrjduWhuL9PGlbEDh5ymJp50NQg
         IlTA==
Received: by 10.52.30.98 with SMTP id r2mr17623801vdh.8.1330740967598;
        Fri, 02 Mar 2012 18:16:07 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id e10sm11763981vdj.21.2012.03.02.18.16.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 18:16:06 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192087>

- Guard setup with test_expect_success
- Unwound one loop to stay within the test_expect_success guard

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 t/t6300-for-each-ref.sh |  186 +++++++++++++++++++++++------------------------
 1 files changed, 92 insertions(+), 94 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 1721784..ebba7d1 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -138,12 +138,13 @@ test_expect_success 'Check invalid format specifiers are errors' '
 	test_must_fail git for-each-ref --format="%(authordate:INVALID)" refs/heads
 '
 
-cat >expected <<\EOF
-'refs/heads/master' 'Mon Jul 3 17:18:43 2006 +0200' 'Mon Jul 3 17:18:44 2006 +0200'
-'refs/tags/testtag' 'Mon Jul 3 17:18:45 2006 +0200'
-EOF
-
 test_expect_success 'Check unformatted date fields output' '
+	'"
+	cat >expected <<-EOF &&
+		'refs/heads/master' 'Mon Jul 3 17:18:43 2006 +0200' 'Mon Jul 3 17:18:44 2006 +0200'
+		'refs/tags/testtag' 'Mon Jul 3 17:18:45 2006 +0200'
+	EOF
+	"'
 	(git for-each-ref --shell --format="%(refname) %(committerdate) %(authordate)" refs/heads &&
 	git for-each-ref --shell --format="%(refname) %(taggerdate)" refs/tags) >actual &&
 	test_cmp expected actual
@@ -171,84 +172,85 @@ test_expect_success 'Check format "relative" date fields output' '
 	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual
 '
 
-cat >expected <<\EOF
-'refs/heads/master' '2006-07-03' '2006-07-03'
-'refs/tags/testtag' '2006-07-03'
-EOF
-
 test_expect_success 'Check format "short" date fields output' '
+	'"
+	cat >expected <<-EOF
+		'refs/heads/master' '2006-07-03' '2006-07-03'
+		'refs/tags/testtag' '2006-07-03'
+	EOF
+	"'
 	f=short &&
 	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
 	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
 	test_cmp expected actual
 '
 
-cat >expected <<\EOF
-'refs/heads/master' 'Mon Jul 3 15:18:43 2006' 'Mon Jul 3 15:18:44 2006'
-'refs/tags/testtag' 'Mon Jul 3 15:18:45 2006'
-EOF
-
 test_expect_success 'Check format "local" date fields output' '
-	f=local &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
+	'"
+	cat >expected <<-EOF
+		'refs/heads/master' 'Mon Jul 3 15:18:43 2006' 'Mon Jul 3 15:18:44 2006'
+		'refs/tags/testtag' 'Mon Jul 3 15:18:45 2006'
+	EOF
+	"'
+	(git for-each-ref --shell --format="%(refname) %(committerdate:local) %(authordate:local)" refs/heads &&
+	 git for-each-ref --shell --format="%(refname) %(taggerdate:local)" refs/tags) >actual &&
 	test_cmp expected actual
 '
 
-cat >expected <<\EOF
-'refs/heads/master' '2006-07-03 17:18:43 +0200' '2006-07-03 17:18:44 +0200'
-'refs/tags/testtag' '2006-07-03 17:18:45 +0200'
-EOF
-
 test_expect_success 'Check format "iso8601" date fields output' '
+	'"
+	cat >expected <<-EOF
+		'refs/heads/master' '2006-07-03 17:18:43 +0200' '2006-07-03 17:18:44 +0200'
+		'refs/tags/testtag' '2006-07-03 17:18:45 +0200'
+	EOF
+	"'
 	f=iso8601 &&
 	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
 	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
 	test_cmp expected actual
 '
 
-cat >expected <<\EOF
-'refs/heads/master' 'Mon, 3 Jul 2006 17:18:43 +0200' 'Mon, 3 Jul 2006 17:18:44 +0200'
-'refs/tags/testtag' 'Mon, 3 Jul 2006 17:18:45 +0200'
-EOF
-
 test_expect_success 'Check format "rfc2822" date fields output' '
+	'"
+	cat >expected <<-EOF
+		'refs/heads/master' 'Mon, 3 Jul 2006 17:18:43 +0200' 'Mon, 3 Jul 2006 17:18:44 +0200'
+		'refs/tags/testtag' 'Mon, 3 Jul 2006 17:18:45 +0200'
+	EOF
+	"'
 	f=rfc2822 &&
 	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
 	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
 	test_cmp expected actual
 '
 
-cat >expected <<\EOF
-refs/heads/master
-refs/remotes/origin/master
-refs/tags/testtag
-EOF
-
 test_expect_success 'Verify ascending sort' '
+	cat >expected <<-EOF
+		refs/heads/master
+		refs/remotes/origin/master
+		refs/tags/testtag
+	EOF
 	git for-each-ref --format="%(refname)" --sort=refname >actual &&
 	test_cmp expected actual
 '
 
-
-cat >expected <<\EOF
-refs/tags/testtag
-refs/remotes/origin/master
-refs/heads/master
-EOF
-
 test_expect_success 'Verify descending sort' '
+	cat >expected <<-EOF
+		refs/tags/testtag
+		refs/remotes/origin/master
+		refs/heads/master
+	EOF
 	git for-each-ref --format="%(refname)" --sort=-refname >actual &&
 	test_cmp expected actual
 '
 
-cat >expected <<\EOF
-'refs/heads/master'
-'refs/remotes/origin/master'
-'refs/tags/testtag'
-EOF
-
 test_expect_success 'Quoting style: shell' '
+	'"
+	cat >expected <<-EOF
+		'refs/heads/master'
+		'refs/remotes/origin/master'
+		'refs/tags/testtag'
+	EOF
+	"'
 	git for-each-ref --shell --format="%(refname)" >actual &&
 	test_cmp expected actual
 '
@@ -263,52 +265,51 @@ test_expect_success 'Quoting style: python' '
 	test_cmp expected actual
 '
 
-cat >expected <<\EOF
-"refs/heads/master"
-"refs/remotes/origin/master"
-"refs/tags/testtag"
-EOF
-
 test_expect_success 'Quoting style: tcl' '
+	cat >expected <<-EOF
+		"refs/heads/master"
+		"refs/remotes/origin/master"
+		"refs/tags/testtag"
+	EOF
 	git for-each-ref --tcl --format="%(refname)" >actual &&
 	test_cmp expected actual
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
-master
-testtag
-EOF
-
+test_expect_success 'more than one quoting styles' '
+	cat >expected <<-EOF
+		error: more than one quoting style?
+	EOF
+	git for-each-ref --perl --shell 2>&1 | head -n 1 >actual &&
+	test_cmp expected actual &&
+	git for-each-ref -s --python 2>&1 | head -n 1 >actual &&
+	test_cmp expected actual &&
+	git for-each-ref --python --tcl 2>&1 | head -n 1 >actual &&
+	test_cmp expected actual &&
+	git for-each-ref --tcl --perl 2>&1 | head -n 1 >actual &&
+	test_cmp expected actual
+'
 test_expect_success 'Check short refname format' '
+	cat >expected <<-EOF
+		master
+		testtag
+	EOF
 	(git for-each-ref --format="%(refname:short)" refs/heads &&
 	git for-each-ref --format="%(refname:short)" refs/tags) >actual &&
 	test_cmp expected actual
 '
 
-cat >expected <<EOF
-origin/master
-EOF
-
 test_expect_success 'Check short upstream format' '
+	cat >expected <<-EOF
+		origin/master
+	EOF
 	git for-each-ref --format="%(upstream:short)" refs/heads >actual &&
 	test_cmp expected actual
 '
 
-cat >expected <<EOF
-67a36f1
-EOF
-
 test_expect_success 'Check short objectname format' '
+	cat >expected <<-EOF
+		67a36f1
+	EOF
 	git for-each-ref --format="%(objectname:short)" refs/heads >actual &&
 	test_cmp expected actual
 '
@@ -317,12 +318,11 @@ test_expect_success 'Check for invalid refname format' '
 	test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
 
-cat >expected <<\EOF
-heads/master
-tags/master
-EOF
-
 test_expect_success 'Check ambiguous head and tag refs (strict)' '
+	cat >expected <<-EOF
+		heads/master
+		tags/master
+	EOF
 	git config --bool core.warnambiguousrefs true &&
 	git checkout -b newtag &&
 	echo "Using $datestamp" > one &&
@@ -334,23 +334,21 @@ test_expect_success 'Check ambiguous head and tag refs (strict)' '
 	test_cmp expected actual
 '
 
-cat >expected <<\EOF
-heads/master
-master
-EOF
-
 test_expect_success 'Check ambiguous head and tag refs (loose)' '
+	cat >expected <<-EOF
+		heads/master
+		master
+	EOF
 	git config --bool core.warnambiguousrefs false &&
 	git for-each-ref --format "%(refname:short)" refs/heads/master refs/tags/master >actual &&
 	test_cmp expected actual
 '
 
-cat >expected <<\EOF
-heads/ambiguous
-ambiguous
-EOF
-
 test_expect_success 'Check ambiguous head and tag refs II (loose)' '
+	cat >expected <<-EOF
+		heads/ambiguous
+		ambiguous
+	EOF
 	git checkout master &&
 	git tag ambiguous testtag^0 &&
 	git branch ambiguous testtag^0 &&
@@ -369,7 +367,7 @@ test_expect_success 'an unusual tag with an incomplete line' '
 '
 
 test_expect_success 'create tag with subject and body content' '
-	cat >>msg <<-\EOF &&
+	cat >msg <<-\EOF &&
 		the subject line
 
 		first body line
@@ -417,9 +415,9 @@ test_expect_success GPG 'create signed tags' '
 	git tag -s -m "" signed-empty &&
 	git tag -s -m "subject line" signed-short &&
 	cat >msg <<-\EOF &&
-	subject line
+		subject line
 
-	body contents
+		body contents
 	EOF
 	git tag -s -F msg signed-long
 '
-- 
1.7.8
