From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 07/11] contrib: related: fix parsing of rev-list args
Date: Thu, 25 Apr 2013 14:59:39 -0500
Message-ID: <1366919983-27521-8-git-send-email-felipe.contreras@gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 22:01:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSMQ-0004FC-2w
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229Ab3DYUB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:01:27 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:42043 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166Ab3DYUB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:01:26 -0400
Received: by mail-ob0-f176.google.com with SMTP id wd20so2871940obb.35
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9CRiP4Ll+QdcLHzhN1eLon/aCl/5WoUCXO7liKmJi6o=;
        b=eLoLcA+a4WOh0dT97HeA37oeWpfdGzpd/pnOJ5y6yjwtGG4SBmJEFlVniF41EJFjP+
         CAw+d/Oh503omAbWYRJGm6FxAEIdTytjyWAxYq02GmYsEC0GnXsAUNpM9CEXAQKnyeQE
         M2H2lcS2isR/PAC5sQhSwG+MOF9RkxYcrv+zHxyAv++bGo+J1VoOHMyoscESHed901ii
         JIIUjIg15vXqQuchbtnM+E+1T88QGZBIsFDuq+aC2ROg384qFn8J7BmHQrXq4T4PNE1o
         p3PyV5lwtmmStNxKS2Pm4Cu6hTAPEVWOxjiWepNVoO1gF17WCn8YXNT1yMic/qaOxjyV
         7+zg==
X-Received: by 10.60.92.230 with SMTP id cp6mr21117962oeb.91.1366920085686;
        Thu, 25 Apr 2013 13:01:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id it9sm4728397obb.6.2013.04.25.13.01.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 13:01:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222435>

For example '-1'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 2f38ee1..e8603be 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -23,7 +23,8 @@ begin
       $show_commits = v || true
     end
   end.parse!
-rescue OptionParser::InvalidOption
+rescue OptionParser::InvalidOption => e
+  $rev_args += e.args
 end
 
 class Commit
@@ -135,9 +136,11 @@ class Commits
 
     case revs.size
     when 1
-      committish = [ '%s..HEAD' % revs[0] ]
+      r = revs[0]
+      r = '^' + r if r[0] != '-'
+      args = [ r, 'HEAD' ]
     else
-      committish = revs
+      args = revs
     end
 
     source = nil
-- 
1.8.2.1
