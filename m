From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 1/6] glossary: fix overoptimistic automatic linking of defined terms
Date: Sat, 10 Mar 2007 23:35:26 -0500
Message-ID: <11735877321525-git-send-email-bfields@citi.umich.edu>
References: <7vr6s42xgm.fsf@assigned-by-dhcp.cox.net> <11735877311383-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 05:35:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQFmY-0000iw-9q
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 05:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933055AbXCKEfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 23:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933100AbXCKEfk
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 23:35:40 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50372
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933055AbXCKEfj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 23:35:39 -0500
Received: from pad.fieldses.org (pad.fieldses.org [127.0.0.1])
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l2B4ZWHf022221;
	Sat, 10 Mar 2007 23:35:32 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l2B4ZWim022220;
	Sat, 10 Mar 2007 23:35:32 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <11735877311383-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41905>

From: J. Bruce Fields <bfields@citi.umich.edu>

The script sort_glossary.pl turns each use of "term" into a link to the
definition of "term".  To avoid mangling links like

	gitlink:git-term[1]

it doesn't replace any occurence of "term" preceded by "link:git-".
This fails for gitlink:git-symbolic-ref[1] when substituting for "ref".

So instead just refuse to replace anything preceded by a "-".
That could result in missing some opportunities, but that's a less
annoying error.

Actually I find the automatic substitution a little distracting; some
day maybe we should just run it once and commit the result, so it can
be hand-tuned.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/sort_glossary.pl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/sort_glossary.pl b/Documentation/sort_glossary.pl
index e0bc552..05dc7b2 100644
--- a/Documentation/sort_glossary.pl
+++ b/Documentation/sort_glossary.pl
@@ -48,7 +48,7 @@ This list is sorted alphabetically:
 ';
 
 @keys=sort {uc($a) cmp uc($b)} keys %terms;
-$pattern='(\b(?<!link:git-)'.join('\b|\b(?<!link:git-)',reverse @keys).'\b)';
+$pattern='(\b(?<!link:git-)'.join('\b|\b(?<!-)',reverse @keys).'\b)';
 foreach $key (@keys) {
 	$terms{$key}=~s/$pattern/sprintf "<<ref_".no_spaces($1).",$1>>";/eg;
 	print '[[ref_'.no_spaces($key).']]'.$key."::\n"
-- 
1.5.0.gb75812-dirty
