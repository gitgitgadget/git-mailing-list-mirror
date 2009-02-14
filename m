From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 3/3] send-email: --suppress-cc improvements
Date: Fri, 13 Feb 2009 22:51:31 -0500
Message-ID: <1234583491-61260-4-git-send-email-jaysoffian@gmail.com>
References: <1234583491-61260-1-git-send-email-jaysoffian@gmail.com>
 <1234583491-61260-2-git-send-email-jaysoffian@gmail.com>
 <1234583491-61260-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, gitster@pobox.com,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 05:00:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYBhH-0000US-9i
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 05:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbZBND6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 22:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbZBND6j
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 22:58:39 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:44051 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbZBND6i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 22:58:38 -0500
Received: by gxk22 with SMTP id 22so1460787gxk.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 19:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=81p768A93Jhv25UiaaKhDvvH8qoR9vY9y5g1RoOr218=;
        b=yIZ/Uc+wbVa9y4Q6DNjGZTQYDV7sGWeyn+8fdloSFZFL8MQH46M7oTBMaFqySRmz2y
         5vMMhAlk19rpBGOkUw57BhmSPI5L23aCwcLGC28zmzB8NmGOHoBqqh0Qqv1bzFeCR18Z
         URyD2mKh4UDB9QVD4BojnVTjv+fT+1Q+fSHhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iO6LxvQm3QtxU4C52XWlqkVfXmr/nve9Ff8bU3pJlDoezE9TjyZXXma23kzLCM2/yS
         I9Y386vkXGVE0J19oH0FWsUWmcfhkLw6PZNvvRE1LywMBAKzhH5B3l3vb7m1Z5dXKW43
         hdHBT7arGpKPohVAvXq/k3JoJFiEXeTGhCtYM=
Received: by 10.150.201.17 with SMTP id y17mr2729507ybf.116.1234583501388;
        Fri, 13 Feb 2009 19:51:41 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id n29sm5101083elf.10.2009.02.13.19.51.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 19:51:40 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.238.g0c1fe
In-Reply-To: <1234583491-61260-3-git-send-email-jaysoffian@gmail.com>
In-Reply-To: <200902140032.19922.trast@student.ethz.ch>
References: <200902140032.19922.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109818>

From: Jay Soffian <jaysoffian@gmail.com>

Commit 656482830ddc4a4e2af132fabb118a25190439c2 added the --suppress-cc
option. However, it made --suppress-cc=sob suppress both SOB lines and
body Cc lines (but not header Cc lines), which seems contrary to how
it is named.

After this commit, 'sob' suppresses only SOB lines and --suppress-cc
takes two additional values:

 * 'body' suppresses both SOB and body Cc lines (i.e. what 'sob'
    used to do).

 * 'bodycc' suppresses body Cc lines, but not header Cc lines.

For backwards compatibility, --no-signed-off-by-cc, acts like 'body'.

Also update the documentation and add a few tests.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---

Okay, so --suppress=cc=sob now acts differently. I can hear the
backwards compatibility objection. I disagree. It will only effect a
user who does --suppress-cc=sob AND sends out a patch that has Cc: in
the message body (commit message). And If I'm not the first user to have
sent such a message earlier today, I'll bet I'm not much more than the
10th. 

OTOH, --suppress-cc=sob was obviously misnamed in the first place, and I
was confused by having send-email pick up the Cc in the body.

So I think it's worth the small risk of changing what --suppress-cc=sob
does. And as a benefit, we now offer two new values for --suppress-cc,
and for really-old-timers that are probably using --no-signed-of-by-cc,
that says the same.

j.

 Documentation/git-send-email.txt |   14 +++++++-----
 git-send-email.perl              |   40 +++++++++++++++++++++++--------------
 t/t9001-send-email.sh            |   38 ++++++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ff4aeff..d6af035 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -166,12 +166,14 @@ Automating
 	Specify an additional category of recipients to suppress the
 	auto-cc of.  'self' will avoid including the sender, 'author' will
 	avoid including the patch author, 'cc' will avoid including anyone
-	mentioned in Cc lines in the patch, 'sob' will avoid including
-	anyone mentioned in Signed-off-by lines, and 'cccmd' will avoid
-	running the --cc-cmd.  'all' will suppress all auto cc values.
-	Default is the value of 'sendemail.suppresscc' configuration value;
-	if that is unspecified, default to 'self' if --suppress-from is
-	specified, as well as 'sob' if --no-signed-off-cc is specified.
+	mentioned in Cc lines in the patch header, 'ccbody' will avoid
+	including anyone mentioned in Cc lines in the patch body (commit
+	message), 'sob' will avoid including anyone mentioned in Signed-off-by
+	lines, and 'cccmd' will avoid running the --cc-cmd. 'body' is
+	equivalent to 'sob' + 'ccbody'. 'all' will suppress all auto cc
+	values.  Default is the value of 'sendemail.suppresscc' configuration
+	value; if that is unspecified, default to 'self' if --suppress-from is
+	specified, as well as 'body' if --no-signed-off-cc is specified.
 
 --[no-]suppress-from::
 	If this is set, do not add the From: address to the cc: list.
diff --git a/git-send-email.perl b/git-send-email.perl
index 2a3e3e8..2282287 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -68,7 +68,7 @@ git send-email [options] <file | directory | rev-list options >
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-    --suppress-cc           <str>  * author, self, sob, cccmd, all.
+    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
     --[no-]signed-off-by-cc        * Send to Cc: and Signed-off-by:
                                      addresses. Default on.
     --[no-]suppress-from           * Send to self. Default off.
@@ -319,21 +319,28 @@ my(%suppress_cc);
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
 }
 
+if ($suppress_cc{'sob'} && $suppress_cc{'bodycc'}) {
+	$suppress_cc{'body'} = 1;
+}
+
 # If explicit old-style ones are specified, they trump --suppress-cc.
 $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
-$suppress_cc{'sob'} = !$signed_off_by_cc if defined $signed_off_by_cc;
+# For backwards compatibility, old-style --signed-off-by-cc suppresses
+# SOB and body Cc lines, whereas --supress-cc=sob suppresses just the SOB
+# line, but not the body Cc.
+$suppress_cc{'body'} = !$signed_off_by_cc if defined $signed_off_by_cc;
 
 # Debugging, print out the suppressions.
 if (0) {
@@ -1005,17 +1012,20 @@ foreach my $t (@files) {
 		}
 	}
 	# Now parse the message body
-	while(<F>) {
-		$message .=  $_;
-		if (/^(Signed-off-by|Cc): (.*)$/i) {
-			next if ($suppress_cc{'sob'});
-			chomp;
-			my $c = $2;
-			chomp $c;
-			next if ($c eq $sender and $suppress_cc{'self'});
-			push @cc, $c;
-			printf("(sob) Adding cc: %s from line '%s'\n",
-				$c, $_) unless $quiet;
+	unless ($suppress_cc{'body'}) {
+		while(<F>) {
+			$message .=  $_;
+			if (/^(Signed-off-by|Cc): (.*)$/i) {
+				chomp;
+				my ($what, $c) = ($1, $2);
+				chomp $c;
+				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
+				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
+				next if ($c eq $sender and $suppress_cc{'self'});
+				push @cc, $c;
+				printf("(body) Adding cc: %s from line '%s'\n",
+					$c, $_) unless $quiet;
+			}
 		}
 	}
 	close F;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index da54835..d7766f9 100755
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
@@ -195,6 +196,7 @@ test_expect_success 'sendemail.cc set' '
 	git config sendemail.cc cc@example.com &&
 	git send-email \
 		--dry-run \
+		--suppress-cc=sob \
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
 		--smtp-server relay.example.com \
@@ -230,6 +232,38 @@ test_expect_success 'sendemail.cc unset' '
 	git config --unset sendemail.cc &&
 	git send-email \
 		--dry-run \
+		--suppress-cc=sob \
+		--from="Example <from@example.com>" \
+		--to=to@example.com \
+		--smtp-server relay.example.com \
+		$patches |
+	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
+		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
+		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
+		>actual-show-all-headers &&
+	test_cmp expected-show-all-headers actual-show-all-headers
+'
+
+cat >expected-show-all-headers <<\EOF
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
+	git send-email \
+		--dry-run \
+		--suppress-cc=all \
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
 		--smtp-server relay.example.com \
-- 
1.6.2.rc0.235.g1319
