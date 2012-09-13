From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 6/6] rev-list/log: document logic with several limiting options
Date: Thu, 13 Sep 2012 16:04:44 +0200
Message-ID: <49f89f65cd39306655a9b382a1244e34fb90fff1.1347544259.git.git@drmicha.warpmail.net>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 16:05:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCA2c-00073N-St
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 16:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870Ab2IMOE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 10:04:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42933 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755677Ab2IMOEz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 10:04:55 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 15CFF20B1E;
	Thu, 13 Sep 2012 10:04:55 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 13 Sep 2012 10:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=r4
	KJEigMgw3PGDJOU/OGd4hlTLg=; b=UrIHvJRGlCrhyYyzJHto98sdyEI30lt087
	HCUnKnFwH7I/gzPX10J39CKKrpbU6V5A0JTwFBTwGSIKnrzCw3r8vddEnuOeF+Ar
	tPeB8+kzLMZeVuzJ3lqFZHaKxKwypgXV4lQ+0NKiRYyXF+l9uxJTzrrtPGCwOzhi
	mLzpMjomA=
X-Sasl-enc: kwTKJ7B3dlIMMosTzE4VAIFYiSvW2uA3qSodNr1RbARl 1347545094
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AB01D483800;
	Thu, 13 Sep 2012 10:04:54 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.463.gbd9d638
In-Reply-To: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347544259.git.git@drmicha.warpmail.net>
References: <cover.1347544259.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205377>

The current behavior is probably as useful as it is confusing. In any
case it is going to stay. So, document it.

This does not take into account the issue of 'log --all-match
--author=me --grep=foo --grep=bar' not honoring '--all-match' because it
is hopefully a corner case (and, even more hopefully, fixed some time
soon).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/rev-list-options.txt | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5436eba..b2dbfb5 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -6,6 +6,19 @@ special notations explained in the description, additional commit
 limiting may be applied. Note that they are applied before commit
 ordering and formatting options, such as '--reverse'.
 
+Different options are ANDed: '--author=bar --grep=foo'
+limits to commits which match both conditions.
+
+Several occurences of the '--grep' option are ORed: '--grep=foo --grep=bar'
+limits to commits matching any of these conditions.
+(If '--all-match' is given, the conditions are ANDed.)
+
+Several occurences of the '--author' and '--committer' options are ORed
+(because there can be only one each per commit).
+
+For all other options, only the last occurence of the same option is
+taken into account: '-n 5 -3' is '-3' and '-n 3 -n 5' is '-n 5'.
+
 --
 
 -n 'number'::
@@ -47,7 +60,7 @@ endif::git-rev-list[]
 
 --all-match::
 	Limit the commits output to ones that match all given --grep,
-	--author and --committer instead of ones that match at least one.
+	instead of ones that match at least one.
 
 -i::
 --regexp-ignore-case::
-- 
1.7.12.463.gbd9d638
