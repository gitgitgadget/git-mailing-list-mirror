From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitview: Add key binding for F5.
Date: Sat, 27 May 2006 15:54:14 +0530
Message-ID: <447828CE.3080600@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070400080207060707020201"
X-From: git-owner@vger.kernel.org Sat May 27 12:24:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjvyK-0006MP-W0
	for gcvg-git@gmane.org; Sat, 27 May 2006 12:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWE0KYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 06:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWE0KYZ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 06:24:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:43012 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751033AbWE0KYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 May 2006 06:24:25 -0400
Received: by wr-out-0506.google.com with SMTP id i21so213249wra
        for <git@vger.kernel.org>; Sat, 27 May 2006 03:24:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=PMjBPxw1ff78tDK3j2P/9rvAY5hk4boQ4LWuvbw/1VIZVqp0mhnB4J25BJIPLJNNRPz79r5nkUejW1/ulXWP4iOzvAUZRGD0UNUApkMh8Eo3MlayHjVyAmhTi2+AMBuCtpscXDZWIP9ixnSjRwCI9HMmBEK1g+XTpOxKqalXkx4=
Received: by 10.64.131.14 with SMTP id e14mr117047qbd;
        Sat, 27 May 2006 03:24:24 -0700 (PDT)
Received: from ?192.168.2.39? ( [59.92.132.221])
        by mx.gmail.com with ESMTP id e18sm377331qba.2006.05.27.03.24.22;
        Sat, 27 May 2006 03:24:24 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20842>

This is a multi-part message in MIME format.
--------------070400080207060707020201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------070400080207060707020201
Content-Type: text/plain;
 name="0001-gitview-Add-key-binding-for-F5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-gitview-Add-key-binding-for-F5.txt"

gitview: Add key binding for F5.

F5 will now refresh the window. This is useful if you are using git bisect
and want to visualize the change.

Also update the gitview version

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/gitview/gitview     |   17 +++++++++++++----
 contrib/gitview/gitview.txt |    6 ++++--
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 781badb..c708534 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -425,7 +425,7 @@ class DiffWindow:
 class GitView:
 	""" This is the main class
 	"""
-	version = "0.7"
+	version = "0.8"
 
 	def __init__(self, with_diff=0):
 		self.with_diff = with_diff
@@ -449,8 +449,17 @@ class GitView:
 
 		self.accel_group = gtk.AccelGroup()
 		self.window.add_accel_group(self.accel_group)
+		self.accel_group.connect_group(0xffc2, 0, gtk.ACCEL_LOCKED, self.refresh);
 
-		self.construct()
+		self.window.add(self.construct())
+
+	def refresh(self, widget, event=None, *arguments, **keywords):
+		self.get_encoding()
+		self.get_bt_sha1()
+		Commit.children_sha1 = {}
+		self.set_branch(sys.argv[without_diff:])
+		self.window.show()
+		return True
 
 	def get_bt_sha1(self):
 		""" Update the bt_sha1 dictionary with the
@@ -500,9 +509,9 @@ class GitView:
 		menu_bar.show()
 		vbox.pack_start(menu_bar, expand=False, fill=True)
 		vbox.pack_start(paned, expand=True, fill=True)
-		self.window.add(vbox)
 		paned.show()
 		vbox.show()
+		return vbox
 
 
 	def construct_top(self):
@@ -987,8 +996,8 @@ class GitView:
 		window.set_diff(commit_sha1, parent_sha1, encoding)
 		self.treeview.grab_focus()
 
+without_diff = 0
 if __name__ == "__main__":
-	without_diff = 0
 
 	if (len(sys.argv) > 1 ):
 		if (sys.argv[1] == "--without-diff"):
diff --git a/contrib/gitview/gitview.txt b/contrib/gitview/gitview.txt
index fcf759c..e3bc4f4 100644
--- a/contrib/gitview/gitview.txt
+++ b/contrib/gitview/gitview.txt
@@ -25,6 +25,9 @@ OPTIONS
 
 	<args>
 		All the valid option for git-rev-list(1)
+	Key Bindings:
+	F5:
+		To reread references.
 
 EXAMPLES
 ------
@@ -33,6 +36,5 @@ EXAMPLES
 	  or drivers/scsi subdirectories
 
 	gitview --since=2.weeks.ago
-	  Show the changes during the last two weeks 
+	  Show the changes during the last two weeks
 
-	
-- 
1.3.3.g4d548-dirty


--------------070400080207060707020201--
