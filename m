From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] rebase: convert revert to squash on autosquash
Date: Wed, 22 Oct 2014 09:57:14 +0300
Message-ID: <1413961009-23466-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 08:53:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgpnj-0000Mv-CP
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 08:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbaJVGxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 02:53:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10031 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbaJVGxi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 02:53:38 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s9M6rcCP004075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 22 Oct 2014 02:53:38 -0400
Received: from redhat.com (ovpn-116-33.ams2.redhat.com [10.36.116.33])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s9M6rb6D007373
	for <git@vger.kernel.org>; Wed, 22 Oct 2014 02:53:37 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reverts can typically be treated like squash.  Eliminating both the
original commit and the revert would be even nicer, but this seems a bit
harder to implement.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 git-rebase--interactive.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 86edac7..a82bbdf 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -745,7 +745,7 @@ rearrange_squash () {
 	while read -r pick sha1 message
 	do
 		case "$message" in
-		"squash! "*|"fixup! "*|"ack! "*)
+		"squash! "*|"fixup! "*|"ack! "*|"Revert \""*)
 			action="${message%%!*}"
 			rest=$message
 			prefix=
@@ -757,6 +757,12 @@ rearrange_squash () {
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
