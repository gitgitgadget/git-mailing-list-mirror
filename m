From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 15/15] contrib: related: fix parsing of rev-list args
Date: Sat, 18 May 2013 06:46:55 -0500
Message-ID: <1368877615-9563-16-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:49:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udfdh-0007YI-4O
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab3ERLtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:49:22 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34068 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087Ab3ERLtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:49:16 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so5524644obc.41
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nkD9MuRWR82hcB3r81wjaFbhKO9I9V8buQM1GP49kxA=;
        b=MJcIb4RZCVM5AIkKezfNHxLOEk0sJRKVJdIgI/CgcP0+uu1vOH9geIhSpNdk0kYtfn
         9GcdLvuVRUY0clZRe1FjVwyt+Cdjd3dZmzOFgewzrXwBGwcYv/bsM8bdDjo3yiPDB8Mo
         /iV6TrZjBIZRsScjz60fg89dqY6m3d70tDPbdlF3TY8ATCC4hGlZD156PUxlzaMG6Pcn
         tmxXsQFwwfofOUWct3mhY3vVejim7rSUtJElGQRrsf1XSdY+s/TnLB8lyGUKkkmO6GqV
         +VYRkOXDxF1fN1F6As0wVJli27yNO6UWR/A0Rgeb6Il9XRvvc3Kz4dlIVCP4qbJBcIps
         IxjA==
X-Received: by 10.60.125.201 with SMTP id ms9mr13663979oeb.65.1368877756329;
        Sat, 18 May 2013 04:49:16 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id z5sm5132205obw.4.2013.05.18.04.49.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:49:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224788>

For example '-1'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 62c9b56..69737ac 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -29,7 +29,8 @@ begin
       $show_commits = v || true
     end
   end.parse!
-rescue OptionParser::InvalidOption
+rescue OptionParser::InvalidOption => e
+  $rev_args += e.args
 end
 
 def get_mailmap(filename)
@@ -241,9 +242,11 @@ class Commits
 
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
1.8.3.rc2.542.g24820ba
