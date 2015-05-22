From: Allen Hubbe <allenbh@gmail.com>
Subject: [PATCH v4] send-email: Add simple email aliases format
Date: Thu, 21 May 2015 23:40:59 -0400
Message-ID: <9f88da801466c83331d02262855e8bef4164e5eb.1432266004.git.allenbh@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Allen Hubbe <allenbh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 05:41:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvdpf-00014R-9m
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 05:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756AbbEVDlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 23:41:07 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36383 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754514AbbEVDlG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 23:41:06 -0400
Received: by yked142 with SMTP id d142so2364674yke.3
        for <git@vger.kernel.org>; Thu, 21 May 2015 20:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xx/VYexeKL3ddoO9jwfjYnlegrYJQpBX7D/VcahT1VI=;
        b=oLO6+9GeblpOzw1Tw/Qk4Hi91TsABxq/Fx8sUHZ26GLmpSOGoHjTsRmvvLGG2M8IoJ
         Q/yb/Srkxk1A2w2+qfltqGoSimdV1tWhRpzsrQkPb6gFx1DrBBG4LJs63uby8c3ValUk
         +Mx12kZGHNgvporzdOcPCd+Q/84EbrEVDmfcpILtWQP4Pado8mJlXeSgTizbMQ/0brQ/
         gXZbfwbB+gscbHioBSD69KfcFxF62uKvHowowqTkX61g20TghTwJMPVrzgd6MLAl45jg
         0r13fzTx1La+08e+f7UQn0OuH8o/BlWOBZg359HwFqK0sSyrO8ZTNJ8bqiySifKgzJ4p
         UJqQ==
X-Received: by 10.236.109.4 with SMTP id r4mr6015983yhg.60.1432266065177;
        Thu, 21 May 2015 20:41:05 -0700 (PDT)
Received: from localhost.localdomain (cpe-65-190-128-155.nc.res.rr.com. [65.190.128.155])
        by mx.google.com with ESMTPSA id 46sm735037yhu.32.2015.05.21.20.41.03
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 21 May 2015 20:41:04 -0700 (PDT)
X-Mailer: git-send-email 2.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269687>

This format is more simple than the other alias file formats, so it may
be preferred by some users.  The format is as follows.

	<alias>: <address|alias>[, <address|alias>...]

Aliases are specified one per line.  There is no line splitting.
Anything on a line after and including a `#` symbol is considered a
comment, and is ignored.  Blank lines are ignored.

Example of the 'simple' format:

	alice: Alice W Land <awol@example.com>
	bob: Robert Bobbyton <bob@example.com>
	# this is a comment
	   # this is also a comment
	chloe: chloe@example.com
	abgroup: alice, bob # comment after an alias
	bcgrp: bob, chloe, Other <o@example.com>

Signed-off-by: Allen Hubbe <allenbh@gmail.com>
---

Notes:
    Note, v3 was sent in error.  This v4 presents changes since v2.
    
    This v4 extends the syntax to allow blank lines, and comments.  The test
    case is extended with comments added to alias file input.
    
    The Documentation/git-send-email.txt is updated with a description of
    the simple format.  A note is added for the other formats, directing
    readers to check the documentation of the email clients for a
    description.

 Documentation/git-send-email.txt | 24 +++++++++++++++++++++++-
 git-send-email.perl              |  8 +++++++-
 t/t9001-send-email.sh            | 27 +++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 804554609def..38ade31e0c28 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -383,7 +383,29 @@ sendemail.aliasesFile::
 
 sendemail.aliasFileType::
 	Format of the file(s) specified in sendemail.aliasesFile. Must be
-	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
+	one of 'simple', 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
++
+If the format is 'simple', then the alias file format is described below.
+Descriptions of the other file formats to the following formats can be found in
+the documentation of the email program of the same name.
++
+This 'simple' format is is as follows.
++
+	<alias>: <address|alias>[, <address|alias>...]
++
+Aliases are specified one per line.  There is no line splitting.  Anything on a
+line after and including a `#` symbol is considered a comment, and is ignored.
+Blank lines are ignored.
++
+Example of the 'simple' format:
++
+	alice: Alice W Land <awol@example.com>
+	bob: Robert Bobbyton <bob@example.com>
+	# this is a comment
+	   # this is also a comment
+	chloe: chloe@example.com
+	abgroup: alice, bob # comment after an alias
+	bcgrp: bob, chloe, Other <o@example.com>
 
 sendemail.multiEdit::
 	If true (default), a single editor instance will be spawned to edit
diff --git a/git-send-email.perl b/git-send-email.perl
index e1e9b1460ced..716c2bc9479a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -515,7 +515,13 @@ my %parse_alias = (
 			       $aliases{$alias} = [ split_addrs($addr) ];
 			  }
 		      } },
-
+	simple => sub { my $fh = shift; while (<$fh>) {
+		s/#.*$//;
+		next if /^\s*$/;
+		if (/^\s*(\S+)\s*:\s*(.+)$/) {
+			my ($alias, $addr) = ($1, $2);
+			$aliases{$alias} = [ split_addrs($addr) ];
+		}}},
 	gnus => sub { my $fh = shift; while (<$fh>) {
 		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
 			$aliases{$1} = [ $2 ];
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 7be14a4e37f7..12c1a0c76f1d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1549,6 +1549,33 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 	grep "^!someone@example\.org!$" commandline1
 '
 
+test_expect_success $PREREQ 'sendemail.aliasfiletype=simple' '
+	clean_fake_sendmail && rm -fr outdir &&
+	git format-patch -1 -o outdir &&
+	{
+		echo "alice: Alice W Land <awol@example.com>"
+		echo "bob: Robert Bobbyton <bob@example.com>"
+		echo "# this is a comment"
+		echo "   # this is also a comment"
+		echo "chloe: chloe@example.com"
+		echo "abgroup: alice, bob # comment after an alias"
+		echo "bcgrp: bob, chloe, Other <o@example.com>"
+	} >~/.tmp-email-aliases &&
+	git config --replace-all sendemail.aliasesfile \
+		"$(pwd)/.tmp-email-aliases" &&
+	git config sendemail.aliasfiletype simple &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=alice --to=bcgrp \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		outdir/0001-*.patch \
+		2>errors >out &&
+	grep "^!awol@example\.com!$" commandline1 &&
+	grep "^!bob@example\.com!$" commandline1 &&
+	grep "^!chloe@example\.com!$" commandline1 &&
+	grep "^!o@example\.com!$" commandline1
+'
+
 do_xmailer_test () {
 	expected=$1 params=$2 &&
 	git format-patch -1 &&
-- 
2.3.4
