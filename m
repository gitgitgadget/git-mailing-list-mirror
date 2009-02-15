From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2 3/3] send-email: --suppress-cc improvements
Date: Sat, 14 Feb 2009 23:32:15 -0500
Message-ID: <1234672335-54321-4-git-send-email-jaysoffian@gmail.com>
References: <1234672335-54321-1-git-send-email-jaysoffian@gmail.com>
 <1234672335-54321-2-git-send-email-jaysoffian@gmail.com>
 <1234672335-54321-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 05:35:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYYjA-0007tT-QA
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 05:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbZBOEc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 23:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbZBOEc4
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 23:32:56 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:14333 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbZBOEcx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 23:32:53 -0500
Received: by yw-out-2324.google.com with SMTP id 5so820192ywh.1
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 20:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=z4GGJxdBLmd7DdbzvJPHnlsBg9H8IPOnQaQQsVqo2ZA=;
        b=wKtfAVa/qRG2hcQeiA3V2e83rTZHXHpQcwmt8w9oLNAzru3eVIdawWC78/NzMkJpXS
         IWFfHUfuVsi6k15SwXXHd53Sd6i/GgZKiknsyivgFl97B0z/N/cbTd/ttQ7vIhfxNNvf
         KNYEhG070zCJAX+n9EPuLU2JqbdFBrD8TbnXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QXx70alYNbbM9jEK8ye/Qs8Nh3tPp0+Cv2qEhgCL6nKIBQVWysJfqCc0HXZpLL+wH7
         mYzaMGh8VXZtmvC8fvpC5XF4irYFD0xoGe608WF5zWnJ81O4i6HwCS6dctScwj6dcMAR
         +tecUgwr9E+xPvjY7qoi9cPtByowmKa5PkmyQ=
Received: by 10.100.125.9 with SMTP id x9mr453095anc.65.1234672371967;
        Sat, 14 Feb 2009 20:32:51 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c23sm6418352ana.52.2009.02.14.20.32.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Feb 2009 20:32:51 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.250.g3b7b7
In-Reply-To: <1234672335-54321-3-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109959>

Since 6564828 (git-send-email: Generalize auto-cc recipient
mechanism., 2007-12-25) we can suppress automatic Cc generation
separately for each of the possible address sources.  However,
--suppress-cc=sob suppressed both SOB lines and body (but not header)
Cc lines, contrary to the name.

Change --suppress-cc=sob to mean only SOB lines, and add separate
choices 'bodycc' (body Cc lines) and 'body' (both 'sob' and 'bodycc').
The option --no-signed-off-by-cc now acts like --suppress-cc=sob,
which is not backwards compatible but matches the name of the option.

Also update the documentation and add a few tests.

Original patch by me. Revised by Thomas Rast, who contributed the
documentation and test updates.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Changes from v1:

I incorporated Thomas's changes, which were per your suggestions.
Thomas, thank you for the contribution.

I also agreed that self is special, and --suppress-cc=cc should keep
self in a header Cc. The user can always use --suppress-cc=self in
addition to --suppress-cc=cc if they want. For consistency, I made
--suppress-cc={ccbody,sob} keep self as well. I updated the
documentation to clarify this.

j.

 Documentation/git-send-email.txt |   27 +++++--
 git-send-email.perl              |   28 +++++--
 t/t9001-send-email.sh            |  150 +++++++++++++++++++++++++++++++++-----
 3 files changed, 169 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ff4aeff..164d149 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -164,14 +164,25 @@ Automating
 
 --suppress-cc::
 	Specify an additional category of recipients to suppress the
-	auto-cc of.  'self' will avoid including the sender, 'author' will
-	avoid including the patch author, 'cc' will avoid including anyone
-	mentioned in Cc lines in the patch, 'sob' will avoid including
-	anyone mentioned in Signed-off-by lines, and 'cccmd' will avoid
-	running the --cc-cmd.  'all' will suppress all auto cc values.
-	Default is the value of 'sendemail.suppresscc' configuration value;
-	if that is unspecified, default to 'self' if --suppress-from is
-	specified, as well as 'sob' if --no-signed-off-cc is specified.
+	auto-cc of:
++
+--
+- 'author' will avoid including the patch author
+- 'self' will avoid including the sender
+- 'cc' will avoid including anyone mentioned in Cc lines in the patch header
+  except for self (use 'self' for that).
+- 'ccbody' will avoid including anyone mentioned in Cc lines in the
+  patch body (commit message) except for self (use 'self' for that).
+- 'sob' will avoid including anyone mentioned in Signed-off-by lines except
+   for self (use 'self' for that).
+- 'cccmd' will avoid running the --cc-cmd.
+- 'body' is equivalent to 'sob' + 'ccbody'
+- 'all' will suppress all auto cc values.
+--
++
+Default is the value of 'sendemail.suppresscc' configuration value; if
+that is unspecified, default to 'self' if --suppress-from is
+specified, as well as 'body' if --no-signed-off-cc is specified.
 
 --[no-]suppress-from::
 	If this is set, do not add the From: address to the cc: list.
diff --git a/git-send-email.perl b/git-send-email.perl
index a6efd1f..54e7617 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -68,9 +68,8 @@ git send-email [options] <file | directory | rev-list options >
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-    --suppress-cc           <str>  * author, self, sob, cccmd, all.
-    --[no-]signed-off-by-cc        * Send to Cc: and Signed-off-by:
-                                     addresses. Default on.
+    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
+    --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
     --[no-]suppress-from           * Send to self. Default off.
     --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default on.
     --[no-]thread                  * Use In-Reply-To: field. Default on.
@@ -325,13 +324,13 @@ my(%suppress_cc);
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
 		die "Unknown --suppress-cc field: '$entry'\n"
-			unless $entry =~ /^(all|cccmd|cc|author|self|sob)$/;
+			unless $entry =~ /^(all|cccmd|cc|author|self|sob|body|bodycc)$/;
 		$suppress_cc{$entry} = 1;
 	}
 }
 
 if ($suppress_cc{'all'}) {
-	foreach my $entry (qw (ccmd cc author self sob)) {
+	foreach my $entry (qw (ccmd cc author self sob body bodycc)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'all'};
@@ -341,6 +340,13 @@ if ($suppress_cc{'all'}) {
 $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
 $suppress_cc{'sob'} = !$signed_off_by_cc if defined $signed_off_by_cc;
 
+if ($suppress_cc{'body'}) {
+	foreach my $entry (qw (sob bodycc)) {
+		$suppress_cc{$entry} = 1;
+	}
+	delete $suppress_cc{'body'};
+}
+
 # Debugging, print out the suppressions.
 if (0) {
 	print "suppressions:\n";
@@ -1020,13 +1026,17 @@ foreach my $t (@files) {
 	while(<F>) {
 		$message .=  $_;
 		if (/^(Signed-off-by|Cc): (.*)$/i) {
-			next if ($suppress_cc{'sob'});
 			chomp;
-			my $c = $2;
+			my ($what, $c) = ($1, $2);
 			chomp $c;
-			next if ($c eq $sender and $suppress_cc{'self'});
+			if ($c eq $sender) {
+				next if ($suppress_cc{'self'});
+			} else {
+				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
+				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
+			}
 			push @cc, $c;
-			printf("(sob) Adding cc: %s from line '%s'\n",
+			printf("(body) Adding cc: %s from line '%s'\n",
 				$c, $_) unless $quiet;
 		}
 	}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 63ab88b..4df4f96 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -32,11 +32,11 @@ clean_fake_sendmail() {
 }
 
 test_expect_success 'Extract patches' '
-    patches=`git format-patch --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1`
+    patches=`git format-patch -s --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1`
 '
 
 test_expect_success 'Send patches' '
-     git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
+     git send-email --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
 '
 
 cat >expected <<\EOF
@@ -74,6 +74,7 @@ EOF
 test_expect_success 'Show all headers' '
 	git send-email \
 		--dry-run \
+		--suppress-cc=sob \
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
 		--cc=cc@example.com \
@@ -193,7 +194,7 @@ test_expect_success 'second message is patch' '
 	grep "Subject:.*Second" msgtxt2
 '
 
-cat >expected-show-all-headers <<\EOF
+cat >expected-suppress-sob <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
@@ -213,10 +214,10 @@ X-Mailer: X-MAILER-STRING
 Result: OK
 EOF
 
-test_expect_success 'sendemail.cc set' '
-	git config sendemail.cc cc@example.com &&
+test_suppression () {
 	git send-email \
 		--dry-run \
+		--suppress-cc=$1 \
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
 		--smtp-server relay.example.com \
@@ -224,11 +225,16 @@ test_expect_success 'sendemail.cc set' '
 	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
 		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
 		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
-		>actual-show-all-headers &&
-	test_cmp expected-show-all-headers actual-show-all-headers
+		>actual-suppress-$1 &&
+	test_cmp expected-suppress-$1 actual-suppress-$1
+}
+
+test_expect_success 'sendemail.cc set' '
+	git config sendemail.cc cc@example.com &&
+	test_suppression sob
 '
 
-cat >expected-show-all-headers <<\EOF
+cat >expected-suppress-sob <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
@@ -250,17 +256,123 @@ EOF
 
 test_expect_success 'sendemail.cc unset' '
 	git config --unset sendemail.cc &&
-	git send-email \
-		--dry-run \
-		--from="Example <from@example.com>" \
-		--to=to@example.com \
-		--smtp-server relay.example.com \
-		$patches |
-	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
-		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
-		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
-		>actual-show-all-headers &&
-	test_cmp expected-show-all-headers actual-show-all-headers
+	test_suppression sob
+'
+
+cat >expected-suppress-all <<\EOF
+0001-Second.patch
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success '--suppress-cc=all' '
+	test_suppression all
+'
+
+cat >expected-suppress-body <<\EOF
+0001-Second.patch
+(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
+(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>,<author@example.com>,<one@example.com>,<two@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Cc: A <author@example.com>, One <one@example.com>, two@example.com
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success '--suppress-cc=body' '
+	test_suppression body
+'
+
+cat >expected-suppress-sob <<\EOF
+0001-Second.patch
+(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
+(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>,<author@example.com>,<one@example.com>,<two@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Cc: A <author@example.com>, One <one@example.com>, two@example.com
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success '--suppress-cc=sob' '
+	test_suppression sob
+'
+
+cat >expected-suppress-bodycc <<\EOF
+0001-Second.patch
+(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
+(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+(body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>,<author@example.com>,<one@example.com>,<two@example.com>,<committer@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Cc: A <author@example.com>, One <one@example.com>, two@example.com, C O Mitter <committer@example.com>
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success '--suppress-cc=bodycc' '
+	test_suppression bodycc
+'
+
+cat >expected-suppress-cc <<\EOF
+0001-Second.patch
+(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+(body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>,<author@example.com>,<committer@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Cc: A <author@example.com>, C O Mitter <committer@example.com>
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success '--suppress-cc=cc' '
+	test_suppression cc
 '
 
 test_expect_success '--compose adds MIME for utf8 body' '
-- 
1.6.2.rc0.251.g344d
