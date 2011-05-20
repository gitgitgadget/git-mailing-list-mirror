From: Bernt Hansen <bernt@norang.ca>
Subject: [PATCHv2 maint] git-svn: Fix git svn log --show-commit
Date: Fri, 20 May 2011 07:48:26 -0400
Message-ID: <1305892106-4584-1-git-send-email-bernt@norang.ca>
References: <3dd919897d4a5eca34f421457cc8da461574ee78.1305890184.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 13:48:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNOCL-00034j-In
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 13:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935653Ab1ETLst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 07:48:49 -0400
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:40887 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935453Ab1ETLsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 07:48:45 -0400
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <bernt@norang.ca>)
	id 1QNOCB-0005uQ-KB; Fri, 20 May 2011 11:48:43 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18jpx/anUB72gnOq+AWxAvY
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=localhost.localdomain; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from localhost.localdomain (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p4KBmegs000775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 May 2011 07:48:41 -0400
Received: from localhost.localdomain (gollum [127.0.0.1])
	by localhost.localdomain (8.14.3/8.14.3/Debian-9.4) with ESMTP id p4KBmeHt004625;
	Fri, 20 May 2011 07:48:40 -0400
Received: (from bernt@localhost)
	by localhost.localdomain (8.14.3/8.14.3/Submit) id p4KBmduh004624;
	Fri, 20 May 2011 07:48:39 -0400
X-Mailer: git-send-email 1.7.5.2.316.g687f
In-Reply-To: <3dd919897d4a5eca34f421457cc8da461574ee78.1305890184.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174056>

From: Michael J Gruber <git@drmicha.warpmail.net>

From: Michael J Gruber <git@drmicha.warpmail.net>

git svn log --show-commit had no tests and, consequently, no attention
by the author of

b1b4755 (git-log: put space after commit mark, 2011-03-10)

who kept git svn log working only without --show-commit.

Introduce a test and fix it.

Reported-by: Bernt Hansen <bernt@norang.ca>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Tested-by: Bernt Hansen <bernt@norang.ca>
---
This patch works for me.  Thanks!

 git-svn.perl           |    2 +-
 t/t9116-git-svn-log.sh |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0fd2fd2..28d037f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5766,7 +5766,7 @@ sub cmd_show_log {
 	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
 	while (<$log>) {
 		if (/^${esc_color}commit (- )?($::sha1_short)/o) {
-			my $cmt = $1;
+			my $cmt = $2;
 			if ($c && cmt_showable($c) && $c->{r} != $r_last) {
 				$r_last = $c->{r};
 				process_commit($c, $r_min, $r_max, \@k) or
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 5d477e4..cf4c052 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -60,6 +60,21 @@ test_expect_success 'test ascending revision range' "
 	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
 	"
 
+test_expect_success 'test ascending revision range with --show-commit' "
+	git reset --hard trunk &&
+	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
+	"
+
+test_expect_success 'test ascending revision range with --show-commit (sha1)' "
+	git svn find-rev r1 >expected-range-r1-r2-r4-sha1 &&
+	git svn find-rev r2 >>expected-range-r1-r2-r4-sha1 &&
+	git svn find-rev r4 >>expected-range-r1-r2-r4-sha1 &&
+	git reset --hard trunk &&
+	git svn log --show-commit -r 1:4 | grep '^r[0-9]' | cut -d'|' -f2 >out &&
+	git rev-parse \$(cat out) >actual &&
+	test_cmp expected-range-r1-r2-r4-sha1 actual
+	"
+
 printf 'r4 \nr2 \nr1 \n' > expected-range-r4-r2-r1
 
 test_expect_success 'test descending revision range' "
-- 
1.7.5.2.316.g687f
