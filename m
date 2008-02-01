From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH] Use keyboard arrow keys to go to the next and previous find results.
Date: Fri,  1 Feb 2008 00:12:39 -0200
Message-ID: <1201831959-3805-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 03:07:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKlJf-0001Et-9w
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 03:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509AbYBACHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 21:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756216AbYBACHE
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 21:07:04 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1650 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755565AbYBACHB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 21:07:01 -0500
Received: (qmail 39530 invoked by uid 0); 1 Feb 2008 00:09:20 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 6.930854 secs); 01 Feb 2008 02:09:20 -0000
Received: from unknown (HELO localhost.localdomain) (189.5.214.104)
  by cvxbsd.convex.com.br with SMTP; 1 Feb 2008 02:09:13 -0000
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72145>

On the history find toolbar, if the pattern text field has focus,
the down arrow key will generate a next event and the up arrow key
will generate the previous event.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 .../src/org/spearce/egit/ui/FindToolbar.java       |   23 +++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
index bc48371..5527453 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
@@ -21,6 +21,8 @@ import java.util.List;
 
 import org.eclipse.core.runtime.Preferences;
 import org.eclipse.swt.SWT;
+import org.eclipse.swt.events.KeyAdapter;
+import org.eclipse.swt.events.KeyEvent;
 import org.eclipse.swt.events.ModifyEvent;
 import org.eclipse.swt.events.ModifyListener;
 import org.eclipse.swt.events.SelectionAdapter;
@@ -193,7 +195,7 @@ public class FindToolbar extends Composite {
 			}
 		});
 
-		Listener findButtonsListener = new Listener() {
+		final Listener findButtonsListener = new Listener() {
 			public void handleEvent(Event event) {
 				if (patternField.getText().length() > 0
 						&& findResults.size() == 0) {
@@ -242,6 +244,25 @@ public class FindToolbar extends Composite {
 		nextButton.addListener(SWT.Selection, findButtonsListener);
 		previousButton.addListener(SWT.Selection, findButtonsListener);
 
+		patternField.addKeyListener(new KeyAdapter() {
+			private Event event = new Event();
+
+			@Override
+			public void keyPressed(KeyEvent e) {
+				if(e.keyCode == SWT.ARROW_DOWN) {
+					if(nextButton.isEnabled()) {
+						event.widget = nextButton;
+						findButtonsListener.handleEvent(event);
+					}
+				} else if(e.keyCode == SWT.ARROW_UP) {
+					if(previousButton.isEnabled()) {
+						event.widget = previousButton;
+						findButtonsListener.handleEvent(event);
+					}
+				}
+			}
+		});
+
 		caseItem.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
 				prefs.setValue(UIPreferences.FINDTOOLBAR_IGNORE_CASE, caseItem
-- 
1.5.3.7
