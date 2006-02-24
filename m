From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitview: Fix the graph display
Date: Fri, 24 Feb 2006 21:57:51 +0530
Message-ID: <43FF3407.5080607@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040408070909000805000104"
X-From: git-owner@vger.kernel.org Fri Feb 24 17:28:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCfnh-0001lx-Qf
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 17:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWBXQ17 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 11:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWBXQ17
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 11:27:59 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:44180 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932241AbWBXQ16 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 11:27:58 -0500
Received: by pproxy.gmail.com with SMTP id i75so417295pye
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 08:27:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=CnwZZ1W/eAk1wJP2Opw6h1iVtg+1sWauoQbo0/QicsK4uZKcBjVQZntlqNf9IhcGax6/VYyAirggny/L2rMvFvXgLrieBczbTnal1QdQmqbfA4AGMttQHRqOoemLLH87wCYazlwGiWfDxykiXswR0Y9HsHZZyj3BNHxzr7DMcuc=
Received: by 10.35.84.12 with SMTP id m12mr371909pyl;
        Fri, 24 Feb 2006 08:27:57 -0800 (PST)
Received: from ?192.168.2.11? ( [59.92.199.177])
        by mx.gmail.com with ESMTP id m39sm633357pye.2006.02.24.08.27.55;
        Fri, 24 Feb 2006 08:27:57 -0800 (PST)
User-Agent: Mail/News 1.5 (X11/20060213)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16712>

This is a multi-part message in MIME format.
--------------040408070909000805000104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------040408070909000805000104
Content-Type: text/plain;
 name="0005-gitview-Fix-the-graph-display.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0005-gitview-Fix-the-graph-display.txt"

Subject: gitview: Fix the graph display .

This fix all the known issue with the graph display
The bug need to be explained graphically

                                 |
                                 a
This line need not be there ---->| \
                                 b  |
                                 | /
                                 c 

c is parent of a and all a,b and c are placed on the same line and b is child of c 
With my last checkin I added  a seperate line to indicate that a is
connected to c. But then we had the line connecting a and b which should 
not be ther. This changes fixes the same bug
 


Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

d4da5f1243c47322ede9dae2a65098cbc7e9ecb5
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 2cde71e..4e3847d 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -938,8 +938,10 @@ class GitView:
 	def draw_incomplete_line(self, sha1, node_pos, out_line, in_line, index):
 		for idx, pos in enumerate(self.incomplete_line[sha1]):
 			if(pos == node_pos):
-				out_line.append((pos,
-					pos+0.5, self.colours[sha1]))
+				#remove the straight line and add a slash
+				if ((pos, pos, self.colours[sha1]) in out_line):
+					out_line.remove((pos, pos, self.colours[sha1]))
+				out_line.append((pos, pos+0.5, self.colours[sha1]))
 				self.incomplete_line[sha1][idx] = pos = pos+0.5
 			try:
 				next_commit = self.commits[index+1]
-- 
1.2.3.g2cf3-dirty


--------------040408070909000805000104--
