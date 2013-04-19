From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 02/11] contrib: cc-cmd: add option parsing
Date: Fri, 19 Apr 2013 14:30:22 -0500
Message-ID: <1366399831-5964-3-git-send-email-felipe.contreras@gmail.com>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 21:32:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTH2g-00053j-0a
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab3DSTb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:31:58 -0400
Received: from mail-qe0-f48.google.com ([209.85.128.48]:53376 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928Ab3DSTbv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:31:51 -0400
Received: by mail-qe0-f48.google.com with SMTP id 9so771072qea.21
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=oVSviHhdP9QtrS/eK19Yu8T1OZPzaXDDgXdX5d/9eyo=;
        b=pltr4CBuMAco0iEQs0pMbpmM9mov7wlMS/q+uhJJRmHEzpotqYyikayW/KEy/pfTkO
         B8SJwkRD+9MUuju25nhDCoe+g3y1HgxHhRaQLBmJltDlGh2nmbQ8jFz5X+pzQt4KptO4
         JSl4egU1pN67u7JuCOsm156tmM6pev9UZ3bDtstI9dNVMhx9i1aPEUTa2nhpIgzW8xmT
         EYGTiE/g0iv0wU3XRzAQ0jCaCZ0sq+P2COI7fXGuhe1HBIavWMs7LBWj+aaXKLDv40eZ
         GNEuXoT3Cl6jXqnZhzPHz3VxplpZPrWSm5q9jhqEZOR5sUMYqR+mygJ4/hJv4fZpfqeG
         Lq2A==
X-Received: by 10.229.76.141 with SMTP id c13mr1571924qck.115.1366399910903;
        Fri, 19 Apr 2013 12:31:50 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id hm4sm19573595qab.2.2013.04.19.12.31.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 12:31:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221800>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index aa83a1a..d78759d 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -1,8 +1,25 @@
 #!/usr/bin/env ruby
 
+require 'optparse'
+
 $since = '3-years-ago'
 $min_percent = 5
 
+begin
+  OptionParser.new do |opts|
+    opts.program_name = 'git cc-cmd'
+    opts.banner = 'usage: git cc-cmd [options] <file>'
+
+    opts.on('-p', '--min-percent N', Integer, 'Minium percentage of role participation') do |v|
+      $min_percent = v
+    end
+    opts.on('-d', '--since DATE', 'How far back to search for relevant commits') do |v|
+      $since = v
+    end
+  end.parse!
+rescue OptionParser::InvalidOption
+end
+
 class Commit
 
   attr_reader :id, :roles
-- 
1.8.2.1.790.g4588561
