From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] rebase: convert revert to squash on autosquash
Date: Thu, 7 Apr 2016 18:12:56 +0300
Message-ID: <1460041965-31526-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 17:13:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoBcK-0006L8-LI
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 17:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673AbcDGPNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 11:13:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36057 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756608AbcDGPM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 11:12:59 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9A5C80B20
	for <git@vger.kernel.org>; Thu,  7 Apr 2016 15:12:58 +0000 (UTC)
Received: from redhat.com (vpn1-7-7.ams2.redhat.com [10.36.7.7])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u37FCu59032256
	for <git@vger.kernel.org>; Thu, 7 Apr 2016 11:12:57 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290915>

Reverts can typically be treated like squash.  Eliminating both the
original commit and the revert would be even nicer, but this seems a bit
harder to implement.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 git-rebase--interactive.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6a766ca..6fc1935 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -777,7 +777,7 @@ rearrange_squash () {
 	do
 		test -z "${format}" || message=$(git log -n 1 --format="%s" ${sha1})
 		case "$message" in
-		"squash! "*|"fixup! "*|"ack! "*)
+		"squash! "*|"fixup! "*|"ack! "*|"Revert \""*)
 			action="${message%%!*}"
 			rest=$message
 			prefix=
@@ -789,6 +789,12 @@ rearrange_squash () {
 					prefix="$prefix${rest%%!*},"
 					rest="${rest#*! }"
 					;;
+				"Revert \""*\")
+					action="squash"
+					prefix="Revert,"
+					rest="${rest#Revert \"}"
+					rest="${rest%%\"}"
+					;;
 				*)
 					break
 					;;
-- 
MST
