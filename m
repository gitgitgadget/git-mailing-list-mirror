From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Move git send-email cover letter temporary file to $GIT_DIR
Date: Sat, 22 Dec 2007 01:43:22 +0100
Message-ID: <1198284202-20666-1-git-send-email-hendeby@isy.liu.se>
References: <7vhcic9e17.fsf@gitster.siamese.dyndns.org>
Cc: luciano@eurotux.com, git@vger.kernel.org,
	Gustaf Hendeby <hendeby@isy.liu.se>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 22 01:43:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5sSz-0000Yy-6M
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 01:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbXLVAn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 19:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbXLVAnZ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 19:43:25 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:57279 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbXLVAnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 19:43:25 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id D382225A9B;
	Sat, 22 Dec 2007 01:43:23 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 02958-07; Sat, 22 Dec 2007 01:43:23 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 1A3FB25A9A;
	Sat, 22 Dec 2007 01:43:23 +0100 (MET)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id EE7B21779C; Sat, 22 Dec 2007 01:43:22 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc1.16.gc817f
In-Reply-To: <7vhcic9e17.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69113>

git send-email with the --compose option now puts its temporary file
in $GIT_DIR instead of the current working directory.  The file should
be removed on exit, still it is nice not to mess around in the working
directory if not necessary.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---
 git-send-email.perl |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e47994a..c4eae9d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -150,9 +150,6 @@ my $auth;
 sub unique_email_list(@);
 sub cleanup_compose_files();
 
-# Constants (essentially)
-my $compose_filename = ".msg.$$";
-
 # Variables we fill in automatically, or via prompting:
 my (@to,@cc,@initial_cc,@bcclist,@xh,
 	$initial_reply_to,$initial_subject,@files,$author,$sender,$compose,$time);
@@ -170,6 +167,11 @@ if ($@) {
 	$term = new FakeTerm "$@: going non-interactive";
 }
 
+# Constants (essentially)
+my $compose_filename = $repo->command(qw/rev-parse --git-dir/);
+chomp($compose_filename);
+$compose_filename =  $compose_filename . "/.msg.$$";
+
 # Behavior modification variables
 my ($quiet, $dry_run) = (0, 0);
 
-- 
1.5.4.rc1.16.gc817f
