From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] Make test script annotate-tests.sh handle missing authors
Date: Fri, 15 Oct 2010 22:50:15 -0700
Message-ID: <1287208215-91901-1-git-send-email-kevin@sb.org>
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 16 07:50:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6zfS-0007dW-2G
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 07:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab0JPFuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 01:50:32 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:53214 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab0JPFuc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 01:50:32 -0400
Received: by pxi16 with SMTP id 16so223246pxi.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 22:50:31 -0700 (PDT)
Received: by 10.142.238.5 with SMTP id l5mr1380418wfh.337.1287208231743;
        Fri, 15 Oct 2010 22:50:31 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm10789058wfg.8.2010.10.15.22.50.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 22:50:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.186.gc0af9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159152>

Initialize the %count hash to contain all the expected authors already.
This allows the script to print an error if an expected author was omitted
entirely from the blame/annotate output.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
I discovered this omission when trying to write a test for a change to
git-blame that I will be submitting shortly. Without this change, if an
author never showed up in the blame output, it would errneously consider
that to be ok. It still ignores authors that were never specified as
expected in the first place, but I wasn't so sure that was an error.

Also, I'm not a Perl programmer, so it's possible there's a better idiom
for this sort of thing.

 t/annotate-tests.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 396b965..4e37a66 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -9,6 +9,9 @@ check_count () {
 	cat .result | perl -e '
 		my %expect = (@ARGV);
 		my %count = ();
+		while (my ($author, $count) = each %expect) {
+			$count{$author} = 0;
+		}
 		while (<STDIN>) {
 			if (/^[0-9a-f]+\t\(([^\t]+)\t/) {
 				my $author = $1;
-- 
1.7.3.1.186.gc0af9.dirty
