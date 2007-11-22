From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 1/4] Suppress spurious linefeeds in git-add--interactive
Date: Thu, 22 Nov 2007 01:02:50 +0100
Message-ID: <1195689773-28601-2-git-send-email-win@wincent.com>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com>
 <1195689773-28601-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 01:03:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuzXd-0004QM-Ck
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 01:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbXKVADU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 19:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbXKVADT
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 19:03:19 -0500
Received: from wincent.com ([72.3.236.74]:56119 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993AbXKVADT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 19:03:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAM02s0U030459;
	Wed, 21 Nov 2007 18:02:57 -0600
X-Mailer: git-send-email 1.5.3.6.862.g369c8
In-Reply-To: <1195689773-28601-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65716>

Eliminate the spurious linefeed echoed to the terminal when passing an
untracked or unchanged file as a parameter to git-add--interactive.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-add--interactive.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8f21c03..95e537c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -336,6 +336,7 @@ sub add_untracked_cmd {
 sub parse_diff {
 	my ($path) = @_;
 	my @diff = run_cmd_pipe(qw(git diff-files -p --), $path);
+	return undef if ($#diff == -1);
 	my (@hunk) = { TEXT => [] };
 
 	for (@diff) {
@@ -571,6 +572,7 @@ sub patch_update_file {
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
+	return unless $head;
 	for (@{$head->{TEXT}}) {
 		print;
 	}
-- 
1.5.3.6.867.g539b6-dirty
