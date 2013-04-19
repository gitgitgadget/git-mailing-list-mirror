From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 06/11] contrib: cc-cmd: parse committish like format-patch
Date: Fri, 19 Apr 2013 14:30:26 -0500
Message-ID: <1366399831-5964-7-git-send-email-felipe.contreras@gmail.com>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 21:32:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTH2h-00053j-Fn
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099Ab3DSTcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:32:07 -0400
Received: from mail-qe0-f54.google.com ([209.85.128.54]:46090 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab3DSTcE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:32:04 -0400
Received: by mail-qe0-f54.google.com with SMTP id s14so3005932qeb.27
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0fTXBS7ioO3WBFe4lKRqRy9BcJhzrlrDVS0Gh7foWLQ=;
        b=B46B0hk5QsdSL8lFUXOXiic6RjiQs4q8n2h7lE7PY0E+npWtncNNcLAOb8uV+hGLTI
         ElBGuncGQ5UyHAT72hexWYKrvUTWdYdS1vTQfzMVpOVzhDmOTfbiGm2g5k1g0lGYb/+O
         xWge6W7cJZ9Mv8lrsND2/mzElZt9OKhm0BRscKsQujKvriFeJgBj1SOqJc/pgBw6h8gK
         Kis53QP1y/Jt5AA2XoAcH2xufEVZ6NnHfcl/oSx7fvv5S+TFUYlOOL/kBSK+oKGpxb/t
         yCwXRvEtHYBLUcHzT3S+6s+ZrbJKc09McNa0CauauPcm8aJpEutecyy5FvVaGQZ7lc14
         Cnog==
X-Received: by 10.229.107.36 with SMTP id z36mr1963635qco.76.1366399923618;
        Fri, 19 Apr 2013 12:32:03 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id m8sm19538377qav.8.2013.04.19.12.32.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 12:32:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221803>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index aecfa45..4bca7f1 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -126,6 +126,20 @@ class Commits
 
   def from_rev_args(args)
     return if args.empty?
+
+    revs = []
+
+    File.popen(%w[git rev-parse --revs-only --default=HEAD --symbolic] + args).each do |rev|
+      revs << rev.chomp
+    end
+
+    case revs.size
+    when 1
+      committish = [ '%s..HEAD' % revs[0] ]
+    else
+      committish = revs
+    end
+
     source = nil
     File.popen(%w[git rev-list --reverse] + args) do |p|
       p.each do |e|
-- 
1.8.2.1.790.g4588561
