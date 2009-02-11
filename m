From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] In the commit dialog, deal with Signed-off-by not on
 the last line (WAS: [PATCH JGIT] Deal with the signed-off in the commit text
 dialog)
Date: Wed, 11 Feb 2009 18:02:26 +0100
Message-ID: <499304A2.1060908@gmail.com>
References: <49917944.6030309@gmail.com> <200902110116.36172.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:04:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXIVR-0006Dl-6h
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345AbZBKRCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755329AbZBKRCg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:02:36 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:45163 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbZBKRCf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 12:02:35 -0500
Received: by fg-out-1718.google.com with SMTP id 16so94229fgg.17
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 09:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=HF87aiDdEc6OMnKbDfqrIGJZ7QdT2klPAW3V42Rzrls=;
        b=TfWmhqTPPB3TBG/v2JNvBHNO0g2bkdZ4/AC4+CC4KurtbEW+zCGiBifH4EYrO5PrDZ
         TIqhAlZfU3Ab4orY/QItB/nEdNYncmIWBuB8jolJ/sM3WtE5OP0KSDF9NRbDBo7ptvhR
         qppuEPeqXb+s6g7kyZ9NIQJL3b3MveGeHMl2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=PrgM/PhE9y+aKTEyoNRevBBiTA8C1qfYu+Qvi+o9M8nZ5+FQsu1Qz4IacqgGUiqUrN
         +eIvMGj3QV0s34bbekPtmT0Cb8uOwgOYgzwUo/U/EDnFAOn+xYpHiZ6x7TqkHClF66ME
         zhz4oQEuDVJXkTb4y0qhQEnNa6QIwR5v5E5LI=
Received: by 10.86.72.15 with SMTP id u15mr806749fga.33.1234371753211;
        Wed, 11 Feb 2009 09:02:33 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 4sm1727174fge.14.2009.02.11.09.02.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 09:02:32 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <200902110116.36172.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109446>

The previous implementation made the assumption that
the Signed-off-by is always on the last line.

Correct this assumption and deal with Signed-off-by everywhere in
the commit message.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
Robin Rosenberg wrote:
> tisdag 10 februari 2009 13:55:32 skrev Yann Simon:
> The toggle swithch will happily double the SOB-line. It assumes it is
> the last line. Isn't that too strict, though it is the common idiom, but
> we also have other types of X-by-lines that we often place below
> the SOB line.
>
> Signed-off-by: hacker
> Signed-off-by: pschorff
> Acked-by: bar

This patch should correct this assumption.

-- yann

 .../egit/ui/internal/dialogs/CommitDialog.java     |   65
++++++++++++--------
 1 files changed, 40 insertions(+), 25 deletions(-)

diff --git
a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index bbe7193..403d69d 100644
---
a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -179,14 +179,16 @@ public void keyPressed(KeyEvent arg0) {
         if (committer != null)
             committerText.setText(committer);
         committerText.addModifyListener(new ModifyListener() {
+            String oldCommitter = committerText.getText();
             public void modifyText(ModifyEvent e) {
                 if (signedOffButton.getSelection()) {
                     // the commit message is signed
                     // the signature must be updated
-                    String oldCommitText = commitText.getText();
-                    oldCommitText = removeLastLine(oldCommitText);
-                    oldCommitText = signOff(oldCommitText);
-                    commitText.setText(oldCommitText);
+                    String neuCommitter = committerText.getText();
+                    String oldSignOff = getSignedOff(oldCommitter);
+                    String neuSignOff = getSignedOff(neuCommitter);
+                   
commitText.setText(replaceSignOff(commitText.getText(), oldSignOff,
neuSignOff));
+                    oldCommitter = neuCommitter;
                 }
             }
         });
@@ -230,12 +232,16 @@ public void widgetDefaultSelected(SelectionEvent
arg0) {
 
         signedOffButton.addSelectionListener(new SelectionListener() {
             public void widgetSelected(SelectionEvent arg0) {
+                String curText = commitText.getText();
                 if (signedOffButton.getSelection()) {
                     // add signed off line
-                    commitText.setText(signOff(commitText.getText()));
+                    commitText.setText(signOff(curText));
                 } else {
                     // remove signed off line
-                   
commitText.setText(removeLastLine(commitText.getText()));
+                    curText = replaceSignOff(curText, getSignedOff(), "");
+                    if (curText.endsWith(Text.DELIMITER + Text.DELIMITER))
+                        curText = curText.substring(0, curText.length()
- Text.DELIMITER.length());
+                    commitText.setText(curText);
                 }
             }
 
@@ -279,11 +285,19 @@ public void modifyText(ModifyEvent e) {
     }
 
     private void updateSignedOffButton() {
-       
signedOffButton.setSelection(getLastLine(commitText.getText()).equals(getSignedOff()));
+        String curText = commitText.getText();
+        if (!curText.endsWith(Text.DELIMITER))
+            curText += Text.DELIMITER;
+
+        signedOffButton.setSelection(curText.indexOf(getSignedOff() +
Text.DELIMITER) != -1);
     }
 
     private String getSignedOff() {
-        return Constants.SIGNED_OFF_BY_TAG + committerText.getText();
+        return getSignedOff(committerText.getText());
+    }
+
+    private String getSignedOff(String signer) {
+        return Constants.SIGNED_OFF_BY_TAG + signer;
     }
 
     private String signOff(String input) {
@@ -299,32 +313,33 @@ private String signOff(String input) {
     }
 
     private String getLastLine(String input) {
-        String output = removeLastLineBreak(input);
+        String output = input;
         int breakLength = Text.DELIMITER.length();
 
-        // get the last line
+        // remove last line break if exist
         int lastIndexOfLineBreak = output.lastIndexOf(Text.DELIMITER);
+        if (lastIndexOfLineBreak != -1 && lastIndexOfLineBreak ==
output.length() - breakLength)
+            output = output.substring(0, output.length() - breakLength);
+
+        // get the last line
+        lastIndexOfLineBreak = output.lastIndexOf(Text.DELIMITER);
         return lastIndexOfLineBreak == -1 ? output :
output.substring(lastIndexOfLineBreak + breakLength, output.length());
     }
 
-    private String removeLastLine(String input) {
-        String output = removeLastLineBreak(input);
+    private String replaceSignOff(String input, String oldSignOff,
String newSignOff) {
+        assert input != null;
+        assert oldSignOff != null;
+        assert newSignOff != null;
 
-        // remove the last line if possible
-        int lastIndexOfLineBreak = output.lastIndexOf(Text.DELIMITER);
-        return lastIndexOfLineBreak == -1 ? "" : output.substring(0,
lastIndexOfLineBreak); //$NON-NLS-1$
-    }
-
-    private String removeLastLineBreak(String input) {
-        String output = input;
-        int breakLength = Text.DELIMITER.length();
+        String curText = input;
+        if (!curText.endsWith(Text.DELIMITER))
+            curText += Text.DELIMITER;
 
-        // remove last line break if exist
-        int lastIndexOfLineBreak = output.lastIndexOf(Text.DELIMITER);
-        if (lastIndexOfLineBreak != -1 && lastIndexOfLineBreak ==
output.length() - breakLength)
-            output = output.substring(0, output.length() - breakLength);
+        int indexOfSignOff = curText.indexOf(oldSignOff + Text.DELIMITER);
+        if (indexOfSignOff == -1)
+            return input;
 
-        return output;
+        return input.substring(0, indexOfSignOff) + newSignOff +
input.substring(indexOfSignOff + oldSignOff.length(), input.length());
     }
 
     private Menu getContextMenu() {
-- 
1.6.0.4
