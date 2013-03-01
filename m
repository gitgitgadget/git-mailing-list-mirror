From: =?iso-8859-2?Q?Jan_Pe=B9ta?= <jan.pesta@certicon.cz>
Subject: [PATCH] In inproperly merges, the ranges contains additional character "*"
Date: Fri, 1 Mar 2013 14:33:07 +0100
Message-ID: <002101ce1681$4f261090$ed7231b0$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "'Matthieu Moy'" <Matthieu.Moy@grenoble-inp.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 01 14:33:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBQ5f-0000gm-UC
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 14:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845Ab3CANdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 08:33:09 -0500
Received: from service.certicon.cz ([90.183.112.10]:3044 "EHLO
	service.certicon.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab3CANdI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 08:33:08 -0500
Received: from miami (c-006.certicon.cz [90.183.112.6])
	(Authenticated sender: pesta)
	by service.certicon.cz (Postfix) with ESMTPSA id B89101707EA;
	Fri,  1 Mar 2013 14:33:01 +0100 (CET)
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac4WgU7S7LOQciCWShCt4NM+PWDQgA==
Content-Language: cs
X-certicon-MailScanner-Information: Please contact our ICT for more information
X-MailScanner-ID: B89101707EA.0DF27
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217276>

In inproperly merges, the ranges contains additional character "*".

See http://www.open.collab.net/community/subversion/articles/merge-info.html
Extract:
The range r30430:30435 that was added to 1.5.x in this merge has a '*'
suffix for 1.5.x\www.
This '*' is the marker for a non-inheritable mergeinfo range.
The '*' means that only the path on which the mergeinfo is explicitly set
has had this range merged into it.

Signed-off-by: Jan Pesta <jan.pesta@certicon.cz>
---
 perl/Git/SVN.pm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 0ebc68a..6bd18e9 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1493,6 +1493,7 @@ sub lookup_svn_merge {
 	my @merged_commit_ranges;
 	# find the tip
 	for my $range ( @ranges ) {
+		$range =~ s/[*]$//;
 		my ($bottom, $top) = split "-", $range;
 		$top ||= $bottom;
 		my $bottom_commit = $gs->find_rev_after( $bottom, 1, $top );
-- 
1.8.1.msysgit.1
