From: Tobia Conforto <tobia.conforto@gmail.com>
Subject: Droppable Git Gui in Mac OS X
Date: Fri, 7 Aug 2009 10:12:11 +0000 (UTC)
Message-ID: <loom.20090807T090458-788@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 07 12:13:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZMRZ-0001H2-BQ
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 12:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394AbZHGKMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 06:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757392AbZHGKMX
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 06:12:23 -0400
Received: from main.gmane.org ([80.91.229.2]:57674 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757218AbZHGKMW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 06:12:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MZMQu-0004nN-QH
	for git@vger.kernel.org; Fri, 07 Aug 2009 10:12:20 +0000
Received: from static-217-133-32-17.clienti.tiscali.it ([217.133.32.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 10:12:20 +0000
Received: from tobia.conforto by static-217-133-32-17.clienti.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 10:12:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.133.32.17 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.19.2 (KHTML, like Gecko) Version/4.0.2 Safari/530.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125190>

Hello

I'm using Git 1.6.3.3 on Mac OS X 10.5.7, installed using MacPorts 1.710

I noticed that Git Gui cannot be launched on an existing repository by
simply dragging the repository folder onto Git Gui's icon in the dock,
but this is a standard UI feature in OS X.

Here is a fix "Git Gui.app" (which MacPorts installs in
/opt/local/share/git-gui/lib) to enable this feature.

The change to Info.plist enables dropping folders onto the application.
The modified AppMain.tcl, before launching the application, receives the
one pending OpenDocument event and cd's to the repository folder.

-Tobia


--- Git Gui.app/Contents/Info.plist
+++ Git Gui.app/Contents/Info.plist
@@ -24,5 +24,16 @@
 	<string>GITg</string>
 	<key>CFBundleVersion</key>
 	<string>0.12.0</string>
+	<key>CFBundleDocumentTypes</key>
+	<array>
+		<dict>
+			<key>CFBundleTypeOSTypes</key>
+			<array>
+				<string>fold</string>
+			</array>
+			<key>CFBundleTypeRole</key>
+			<string>Viewer</string>
+		</dict>
+	</array>
 </dict>
 </plist>
--- Git Gui.app/Contents/Resources/Scripts/AppMain.tcl
+++ Git Gui.app/Contents/Resources/Scripts/AppMain.tcl
@@ -19,4 +19,9 @@

 unset gitexecdir gitguilib
 set argv [lrange $argv 1 end]
-source $AppMain_source
+
+proc ::tk::mac::OpenDocument {args} {
+	cd [lindex $args 0]
+}
+
+after 1 { source $AppMain_source }
