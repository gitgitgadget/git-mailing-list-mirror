From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitview: Code cleanup
Date: Fri, 24 Feb 2006 21:49:54 +0530
Message-ID: <43FF322A.5020809@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010503020806070804030008"
X-From: git-owner@vger.kernel.org Fri Feb 24 17:20:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCfgC-0008Ad-Ms
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 17:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWBXQUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 11:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWBXQUI
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 11:20:08 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:37257 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932341AbWBXQUG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 11:20:06 -0500
Received: by pproxy.gmail.com with SMTP id 57so415297pya
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 08:20:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=uANIY5hnKFmyeknJ0HVo+L6ImHuqhIvhNlB1owxX9bwYSlK3KHyq6dEUcle40E/cXKVqJcicqOmA53gOgFjHpU1yOWJNvRD6v/TXRqc19rICKM8CnM9XXfrUyqoPpssRsYFzgv6yyy5b0ODshQ7J76eWY2j6n890gQy6jq65AOc=
Received: by 10.35.49.4 with SMTP id b4mr265042pyk;
        Fri, 24 Feb 2006 08:20:04 -0800 (PST)
Received: from ?192.168.2.11? ( [59.92.199.177])
        by mx.gmail.com with ESMTP id m78sm594814pye.2006.02.24.08.20.02;
        Fri, 24 Feb 2006 08:20:04 -0800 (PST)
User-Agent: Mail/News 1.5 (X11/20060213)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16711>

This is a multi-part message in MIME format.
--------------010503020806070804030008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------010503020806070804030008
Content-Type: text/plain;
 name="0004-gitview-Code-cleanup.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0004-gitview-Code-cleanup.txt"

Subject: gitview: Code cleanup

Rearrange the code little bit so that it is easier to read

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |   50 +++++++++++++++++++++--------------------------
 1 files changed, 22 insertions(+), 28 deletions(-)

1dd075c97bae172d0c1b6f31897fec962217aab2
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 02e2445..2cde71e 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -870,21 +870,22 @@ class GitView:
 
 		# Reset nodepostion
 		if (last_nodepos > 5):
-			last_nodepos = 0
+			last_nodepos = -1 
 
 		# Add the incomplete lines of the last cell in this
 		try:
 			colour = self.colours[commit.commit_sha1]
 		except KeyError:
-			last_colour +=1
-			self.colours[commit.commit_sha1] = last_colour
-			colour =  last_colour
+			self.colours[commit.commit_sha1] = last_colour+1
+			last_colour = self.colours[commit.commit_sha1] 
+			colour =   self.colours[commit.commit_sha1] 
+
 		try:
 			node_pos = self.nodepos[commit.commit_sha1]
 		except KeyError:
-			last_nodepos +=1
-			self.nodepos[commit.commit_sha1] = last_nodepos
-			node_pos = last_nodepos
+			self.nodepos[commit.commit_sha1] = last_nodepos+1
+			last_nodepos = self.nodepos[commit.commit_sha1]
+			node_pos =  self.nodepos[commit.commit_sha1]
 
 		#The first parent always continue on the same line
 		try:
@@ -895,32 +896,25 @@ class GitView:
 			self.nodepos[commit.parent_sha1[0]] = node_pos
 
 		for sha1 in self.incomplete_line.keys():
-			if ( sha1 != commit.commit_sha1):
+			if (sha1 != commit.commit_sha1):
 				self.draw_incomplete_line(sha1, node_pos,
 						out_line, in_line, index)
 			else:
 				del self.incomplete_line[sha1]
 
 
-		in_line.append((node_pos, self.nodepos[commit.parent_sha1[0]],
-					self.colours[commit.parent_sha1[0]]))
-
-		self.add_incomplete_line(commit.parent_sha1[0], index+1)
-
-		if (len(commit.parent_sha1) > 1):
-			for parent_id in commit.parent_sha1[1:]:
-				try:
-					tmp_node_pos = self.nodepos[parent_id]
-				except KeyError:
-					last_colour += 1;
-					self.colours[parent_id] = last_colour
-					last_nodepos +=1
-					self.nodepos[parent_id] = last_nodepos
-
-				in_line.append((node_pos, self.nodepos[parent_id],
-							self.colours[parent_id]))
-				self.add_incomplete_line(parent_id, index+1)
-
+		for parent_id in commit.parent_sha1:
+			try:
+				tmp_node_pos = self.nodepos[parent_id]
+			except KeyError:
+				self.colours[parent_id] = last_colour+1
+				last_colour = self.colours[parent_id]
+				self.nodepos[parent_id] = last_nodepos+1
+				last_nodepos = self.nodepos[parent_id] 
+
+			in_line.append((node_pos, self.nodepos[parent_id],
+						self.colours[parent_id]))
+			self.add_incomplete_line(parent_id)
 
 		try:
 			branch_tag = self.bt_sha1[commit.commit_sha1]
@@ -935,7 +929,7 @@ class GitView:
 
 		return (in_line, last_colour, last_nodepos)
 
-	def add_incomplete_line(self, sha1, index):
+	def add_incomplete_line(self, sha1):
 		try:
 			self.incomplete_line[sha1].append(self.nodepos[sha1])
 		except KeyError:
-- 
1.2.3.g2cf3-dirty


--------------010503020806070804030008--
