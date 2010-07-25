From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/1] git svn: remove extraneous newline from log output
Date: Sun, 25 Jul 2010 08:13:44 +0000
Message-ID: <20100725081344.GB22373@dcvr.yhbt.net>
References: <20100423134611.GA3440@merkur.sol.de> <20100426132710.GA9930@progeny.tock> <20100427112656.GB16323@merkur.sol.de> <20100725023114.GB18606@burratino> <20100725081057.GA22373@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jens Seidel <jensseidel@users.sf.net>
X-From: git-owner@vger.kernel.org Sun Jul 25 10:13:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcwLH-0004dE-J4
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 10:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab0GYINq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 04:13:46 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53305 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab0GYINp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 04:13:45 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC2DF1F503;
	Sun, 25 Jul 2010 08:13:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100725081057.GA22373@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151710>

This is to match the output of "svn log", which does not
add an extra newline before the next log entry.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

The following are pushed to the master git svn repo at
git://git.bogomips.org/git-svn   Let me know if everything looks
alright and I'll ask Junio to pull.

	Eric Wong (1):
	      git svn: remove extraneous newline from log output

	Jens Seidel (1):
	      git-svn: tweak log format to match "svn log" output

 git-svn.perl           |    3 +++
 t/t9116-git-svn-log.sh |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 5252722..f9b7711 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5743,6 +5743,9 @@ sub cmd_show_log {
 			push @{$c->{stat}}, $_;
 			$stat = undef;
 		} elsif (/^${esc_color}    (git-svn-id:.+)$/o) {
+			if (@{$c->{l}} && $c->{l}->[-1] eq "\n") {
+				pop @{$c->{l}};
+			}
 			($c->{url}, $c->{r}, undef) = ::extract_metadata($1);
 		} elsif (s/^${esc_color}    //o) {
 			push @{$c->{l}}, $_;
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 4394fb2..586f64b 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -49,7 +49,7 @@ test_expect_success 'setup repository and import' '
 	fi
 	'
 
-test_expect_failure 'log matches svn log' '
+test_expect_success 'log matches svn log' '
 	git reset --hard a &&
 	(
 		cd checkout &&
@@ -59,7 +59,7 @@ test_expect_failure 'log matches svn log' '
 	test_cmp expected actual
 	'
 
-test_expect_failure NONCLOCALE 'log matches svn log, original locale' '
+test_expect_success NONCLOCALE 'log matches svn log, original locale' '
 	(
 		LC_ALL=$ORIGINAL_LANG &&
 		(
-- 
Eric Wong
