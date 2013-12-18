From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCHv2] gitk: Replace "next" and "prev" buttons with down and up arrows.
Date: Wed, 18 Dec 2013 11:04:13 -0500
Message-ID: <1387382653-8385-1-git-send-email-marcnarc@xiplink.com>
References: <20131008193618.GE9464@google.com>
Cc: git@vger.kernel.org,
	"Lucas Sandery [three am design]" <lucas@threeamdesign.com.au>,
	Paul Mackerras <paulus@samba.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 17:03:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtJbE-0006sU-DK
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 17:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab3LRQDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 11:03:48 -0500
Received: from IP-192-252-130-194.static.fibrenoire.ca ([192.252.130.194]:9707
	"EHLO cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754021Ab3LRQDr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Dec 2013 11:03:47 -0500
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id E0636600C4;
	Wed, 18 Dec 2013 11:03:45 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.2.g49768e2
In-Reply-To: <20131008193618.GE9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239452>

Users often find that "next" and "prev" do the opposite of what they
expect.  For example, "next" moves to the next match down the list, but
that is almost always backwards in time.  Replacing the text with arrows
makes it clear where the buttons will take the user.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

Finally got around to drawing some up and down arrows.

		M.

 gitk | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 33c3a6c..abd2ef3 100755
--- a/gitk
+++ b/gitk
@@ -2263,9 +2263,35 @@ proc makewindow {} {
 
     # build up the bottom bar of upper window
     ${NS}::label .tf.lbar.flabel -text "[mc "Find"] "
-    ${NS}::button .tf.lbar.fnext -text [mc "next"] -command {dofind 1 1}
-    ${NS}::button .tf.lbar.fprev -text [mc "prev"] -command {dofind -1 1}
+
+    set bm_down_data {
+	#define down_width 16
+	#define down_height 16
+	static unsigned char down_bits[] = {
+	0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01,
+	0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01,
+	0x87, 0xe1, 0x8e, 0x71, 0x9c, 0x39, 0xb8, 0x1d,
+	0xf0, 0x0f, 0xe0, 0x07, 0xc0, 0x03, 0x80, 0x01};
+    }
+    image create bitmap bm-down -data $bm_down_data -foreground $uifgcolor
+    ${NS}::button .tf.lbar.fnext -width 26 -command {dofind 1 1}
+    .tf.lbar.fnext configure -image bm-down
+
+    set bm_up_data {
+	#define up_width 16
+	#define up_height 16
+	static unsigned char up_bits[] = {
+	0x80, 0x01, 0xc0, 0x03, 0xe0, 0x07, 0xf0, 0x0f,
+	0xb8, 0x1d, 0x9c, 0x39, 0x8e, 0x71, 0x87, 0xe1,
+	0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01,
+	0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01};
+    }
+    image create bitmap bm-up -data $bm_up_data -foreground $uifgcolor
+    ${NS}::button .tf.lbar.fprev -width 26 -command {dofind -1 1}
+    .tf.lbar.fprev configure -image bm-up
+
     ${NS}::label .tf.lbar.flab2 -text " [mc "commit"] "
+
     pack .tf.lbar.flabel .tf.lbar.fnext .tf.lbar.fprev .tf.lbar.flab2 \
 	-side left -fill y
     set gdttype [mc "containing:"]
-- 
1.8.5.2.2.g49768e2
