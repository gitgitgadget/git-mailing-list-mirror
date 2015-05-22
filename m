From: Allen Hubbe <allenbh@gmail.com>
Subject: [PATCH v2] send-email: Add simple email aliases format
Date: Thu, 21 May 2015 20:16:00 -0400
Message-ID: <4b56f6ab3c14aff7752804d11917b1f330f55f40.1432252898.git.allenbh@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Allen Hubbe <allenbh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 02:16:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvada-0008MD-PR
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 02:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbbEVAQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 20:16:27 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34455 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbbEVAQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 20:16:25 -0400
Received: by ykft189 with SMTP id t189so1143080ykf.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 17:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=r7SiLGRFOeCZ0RxPwm1+AJnjXNRYogzhWTPy/C1yQDk=;
        b=dVojlTpQ0S8WZS+6W3ndtXrp7OOGF8PlFOI6YH5F5ZA54TM/1koOwFcFi8htTuJAxa
         pyHAXkQ4bw6CQJMWjR3lrTJkPQKszXo0/4JDQ8RJQDgXor8Mv9BxbckR4jDiM08auJHq
         G33YGldtYw5jFzHNgTHMBIRL3uI1boQ9rNIl+vWBIuivOjyBwwiYePt9UmicGoRoTG62
         ECl2BtyNyfqoV6VPBDpoT+CFEvvsAkLpT47obYhEwSyayzRO3H7VTWRWUds2shsllQae
         huqlhzT//A1rqH2w0ZqwsC9aH1NA3V5s/CsuKs17KUmxpg8HaPSBP3z699JdR5lJ91hS
         NPpA==
X-Received: by 10.236.223.73 with SMTP id u69mr5371775yhp.114.1432253784950;
        Thu, 21 May 2015 17:16:24 -0700 (PDT)
Received: from localhost.localdomain (cpe-65-190-128-155.nc.res.rr.com. [65.190.128.155])
        by mx.google.com with ESMTPSA id 49sm376155yhq.28.2015.05.21.17.16.23
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 21 May 2015 17:16:23 -0700 (PDT)
X-Mailer: git-send-email 2.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269674>

This format is more simple than the other alias file formats, so it may
be preferred by some users.  The format is as follows.

<alias>: <address|alias>[, <address|alias>...]

Aliases are specified one per line.  There is no line splitting.

Example:
	alice: Alice W Land <awol@example.com>
	bob: Robert Bobbyton <bob@example.com>
	chloe: chloe@example.com
	abgroup: alice, bob
	bcgrp: bob, chloe, Other <o@example.com>

Signed-off-by: Allen Hubbe <allenbh@gmail.com>
---

Notes:
    The v1 of this patch had the following subject line:
    git-send-email.perl: Add sendmail aliases support
    
    This v2 renames this email alias format to simple, because the syntax
    that is actually supported by the parser differs from the format used by
    sendmail.  Now, there is no mention of sendmail in the name of the
    format, the documentation, or the commit message.
    
    This v2 also adds a test case to t/t9001-send-email.sh, and updates the
    list of alias file types in Documentation/git-send-email.txt.

 Documentation/git-send-email.txt |  2 +-
 git-send-email.perl              |  6 +++++-
 t/t9001-send-email.sh            | 24 ++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 804554609def..99583c4f8969 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -383,7 +383,7 @@ sendemail.aliasesFile::
 
 sendemail.aliasFileType::
 	Format of the file(s) specified in sendemail.aliasesFile. Must be
-	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
+	one of 'mutt', 'mailrc', 'pine', 'elm', 'gnus', or 'simple'.
 
 sendemail.multiEdit::
 	If true (default), a single editor instance will be spawned to edit
diff --git a/git-send-email.perl b/git-send-email.perl
index e1e9b1460ced..25d72e8db8bf 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -515,7 +515,11 @@ my %parse_alias = (
 			       $aliases{$alias} = [ split_addrs($addr) ];
 			  }
 		      } },
-
+	simple => sub { my $fh = shift; while (<$fh>) {
+		if (/^\s*(\S+)\s*:\s*(.+)$/) {
+			my ($alias, $addr) = ($1, $2);
+			$aliases{$alias} = [ split_addrs($addr) ];
+		}}},
 	gnus => sub { my $fh = shift; while (<$fh>) {
 		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
 			$aliases{$1} = [ $2 ];
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 7be14a4e37f7..bbb73cdf8bec 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1548,6 +1548,30 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 		2>errors >out &&
 	grep "^!someone@example\.org!$" commandline1
 '
+test_expect_success $PREREQ 'sendemail.aliasfiletype=simple' '
+	clean_fake_sendmail && rm -fr outdir &&
+	git format-patch -1 -o outdir &&
+	{
+		echo "alice: Alice W Land <awol@example.com>"
+		echo "bob: Robert Bobbyton <bob@example.com>"
+		echo "chloe: chloe@example.com"
+		echo "abgroup: alice, bob"
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
 
 do_xmailer_test () {
 	expected=$1 params=$2 &&
-- 
2.3.4
