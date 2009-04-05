From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] send-email: fix nasty bug in ask() function
Date: Sat,  4 Apr 2009 23:23:21 -0400
Message-ID: <1238901801-47109-1-git-send-email-jaysoffian@gmail.com>
References: <449c10960904041002s22124b74k8440af216b1de9ee@mail.gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Bruce Stephens <bruce.stephens@isode.com>,
	Dan McGee <dpmcgee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 05:25:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqIyp-0001yK-DM
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 05:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845AbZDEDXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 23:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756802AbZDEDXd
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 23:23:33 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:30639 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbZDEDXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 23:23:32 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1935815qwh.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 20:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/G+Zw0u4EVLe6vgZJHDmvYXEKijHZIWV4Aeu1oZsNDI=;
        b=CouO2KI6ViNuRk1kgOid4qX9ZuOpj2ofziINZ38tAg3C4Lfm5+soDg9q6/fgzzHOrV
         Vvl8PlWAsbf583elNzOST61YZ9P20+DUvmagDdzlkT+qRdJiup4M86IF78XQenDjACfz
         o0hHe41XiW7gAVQaaaWpcIO0ACXexhWSquD9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Loa1omr+2K4ufiL9AoyTMpDYIAM6EAY1nZyfz+8gtpKPBGCFICYkRx42g9masCgSwf
         U+krYL4S2lyLyy/hZ+Vz3MWObhBQDgKH6zTtxSKYN27YBSvQPoun/qL2ZXWiTriuz65b
         i9hnZsjvjmv415XRgvki2WtJakvS4SfDYSOgE=
Received: by 10.224.11.9 with SMTP id r9mr2692797qar.215.1238901809878;
        Sat, 04 Apr 2009 20:23:29 -0700 (PDT)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 4sm455594qwe.5.2009.04.04.20.23.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 20:23:29 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.405.g6d8cc4
In-Reply-To: <449c10960904041002s22124b74k8440af216b1de9ee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115625>

Commit 6e18251 (send-email: refactor and ensure prompting doesn't loop
forever) introduced an ask function, which unfortunately had a nasty
bug. This caused it not to accept anything but the default reply to the
"Who should the emails appear to be from?" prompt, and nothing but
ctrl-d to the "Who should the emails be sent to?" and "Message-ID to be
used as In-Reply-To for the first email?" prompts.

This commit corrects the issues and adds a test to confirm the fix.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
On Sat, Apr 4, 2009 at 1:02 PM, Dan McGee <dpmcgee@gmail.com> wrote:
> I'm guessing this is related to commit
> 6e1825186bd052fc1f77b7c8c9a31fbb9a67d90c but I haven't bisected yet.
> Having to hit enter 10 times ad the Message-ID prompt seemed a bit odd
> to me. Has anyone else seen this behavior?
>
> dmcgee@galway ~/projects/git (working)
> $ git send-email 000*
> 0001-git-repack-use-non-dashed-update-server-info.patch
> 0002-pack-objects-report-actual-number-of-threads-to-be.patch
> Who should the emails appear to be from? [Dan McGee <dpmcgee@gmail.com>]
> Emails will be sent from: Dan McGee <dpmcgee@gmail.com>
> Message-ID to be used as In-Reply-To for the first email?
> Message-ID to be used as In-Reply-To for the first email?

I really apologize for this breakage. This patch should fix the issue.
I'm quite surprised that there wasn't already a test for the prompting,
but shame on me for not double-checking before refactoring.

I'm also super confused why the issue is occuring. You can see from the
patch below that by default the ask() function attempted to match the
user's input against the empty regex //, which should match anything:

$ perl -e 'use strict; my $resp="something"; my $re=""; print "true\n" if $resp =~ /$re/'
true
$ perl -e 'use strict; my $resp=""; my $re=""; print "true\n" if $resp =~ /$re/'
true

Any yet while my demonstration above works as I expect, for some reason
what is basically the same code (AFAICT) in send-email does not match. I
thought I knew my perl fairly well, but maybe some perl guru can see
what's going wrong.

 git-send-email.perl   |    4 ++--
 t/t9001-send-email.sh |   13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6bbdfec..172b53c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -608,7 +608,7 @@ EOT
 
 sub ask {
 	my ($prompt, %arg) = @_;
-	my $valid_re = $arg{valid_re} || ""; # "" matches anything
+	my $valid_re = $arg{valid_re};
 	my $default = $arg{default};
 	my $resp;
 	my $i = 0;
@@ -624,7 +624,7 @@ sub ask {
 		if ($resp eq '' and defined $default) {
 			return $default;
 		}
-		if ($resp =~ /$valid_re/) {
+		if (!defined $valid_re or $resp =~ /$valid_re/) {
 			return $resp;
 		}
 	}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 192b97b..3c90c4f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -130,6 +130,19 @@ test_expect_success 'Show all headers' '
 	test_cmp expected-show-all-headers actual-show-all-headers
 '
 
+test_expect_success 'Prompting works' '
+	clean_fake_sendmail &&
+	(echo "Example <from@example.com>"
+	 echo "to@example.com"
+	 echo ""
+	) | GIT_SEND_EMAIL_NOTTY=1 git send-email \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches \
+		2>errors &&
+		grep "^From: Example <from@example.com>$" msgtxt1 &&
+		grep "^To: to@example.com$" msgtxt1
+'
+
 z8=zzzzzzzz
 z64=$z8$z8$z8$z8$z8$z8$z8$z8
 z512=$z64$z64$z64$z64$z64$z64$z64$z64
-- 
1.6.2.2.405.g6d8cc4
