From: =?iso-8859-2?Q?Jan_Pe=B9ta?= <jan.pesta@certicon.cz>
Subject: [PATCH] In partial SVN merges, the ranges contains additional character "*"
Date: Wed, 6 Mar 2013 22:35:46 +0100
Message-ID: <000001ce1ab2$903fbc40$b0bf34c0$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 06 22:36:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDM0X-0000sP-Do
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 22:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab3CFVfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 16:35:51 -0500
Received: from service.certicon.cz ([90.183.112.10]:3201 "EHLO
	service.certicon.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab3CFVfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 16:35:50 -0500
Received: from miami (ip-89-103-253-128.net.upcbroadband.cz [89.103.253.128])
	(Authenticated sender: pesta)
	by service.certicon.cz (Postfix) with ESMTPSA id 9BE091707F1;
	Wed,  6 Mar 2013 22:35:46 +0100 (CET)
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac4aso/S9Wa3tSsySJmguUw9x7M8iQ==
Content-Language: cs
X-certicon-MailScanner-Information: Please contact our ICT for more information
X-MailScanner-ID: 9BE091707F1.3D7DF
X-certicon-MailScanner: Found to be clean
X-certicon-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-0.2, required 5.1, autolearn=disabled, ALL_TRUSTED -1.00,
	BAYES_50 0.80)
X-certicon-MailScanner-From: jan.pesta@certicon.cz
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217551>

See http://www.open.collab.net/community/subversion/articles/merge-info.html
Extract:
The range r30430:30435 that was added to 1.5.x in this merge has a '*'
suffix for 1.5.x\www.
This '*' is the marker for a non-inheritable mergeinfo range.
The '*' means that only the path on which the mergeinfo is explicitly set
has had this range merged into it.

Signed-off-by: Jan Pesta <jan.pesta@certicon.cz>
---
 perl/Git/SVN.pm | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 0ebc68a..74d49bb 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1493,6 +1493,11 @@ sub lookup_svn_merge {
 	my @merged_commit_ranges;
 	# find the tip
 	for my $range ( @ranges ) {
+		if ($range =~ /[*]$/) {
+			warn "W:Ignoring partial merge in svn:mergeinfo "
+				."dirprop: $source:$range\n";
+			next;
+		}
 		my ($bottom, $top) = split "-", $range;
 		$top ||= $bottom;
 		my $bottom_commit = $gs->find_rev_after( $bottom, 1, $top );
-- 
1.8.1.msysgit.1
