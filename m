From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/8] contrib: cc-cmd: add option to show commits
Date: Fri, 19 Apr 2013 00:14:14 -0500
Message-ID: <1366348458-7706-5-git-send-email-felipe.contreras@gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 07:16:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT3gN-0008Vo-HI
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400Ab3DSFPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 01:15:44 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:45777 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab3DSFPm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:15:42 -0400
Received: by mail-yh0-f54.google.com with SMTP id i21so582996yha.13
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 22:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=QA87fCXdCI+DGEafUG6EF2XNWhzvRnBXSBdr5aorfaQ=;
        b=i0jRxQ10nVuXlVQqPwpXcXsumOCLxAdI76ps2FQtFXSrBGpXObsymMt+W7p51j37Fv
         Qp6/3hI0TLf0WRyVq5Zt6jeFTSjVqHeV97/0WMSjIxHvQZstsfTrKLkNF+O/JHMDnu5s
         bPOGO83rCgv+TduC7LMneGN8fSfpSfVVKfuZStQYp0+0mq0FI0LDieoEQfGMyYmp9GyP
         hTWVSKjrqbdenMGJzN2yzCfgr7Kv4ed2p82zpv5fSIF4nGA8W1Y/JxWTkJypp03osW12
         bDLyjAglP++1j5tDPxaXtd09Z5MEvl401H1YXwkqkG6RCVUu7u1iavfu3dGSMKE3Tcjc
         Tfuw==
X-Received: by 10.236.87.45 with SMTP id x33mr9999382yhe.138.1366348541359;
        Thu, 18 Apr 2013 22:15:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 30sm22356423yhb.6.2013.04.18.22.15.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 22:15:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221735>

Instead of showing the authors and signers, show the commits themselves.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index e36b1bf..f13ed8f 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -4,6 +4,7 @@ require 'optparse'
 
 $since = '3-years-ago'
 $min_percent = 5
+$show_commits = false
 
 begin
   OptionParser.new do |opts|
@@ -16,6 +17,9 @@ begin
     opts.on('-d', '--since DATE', 'How far back to search for relevant commits') do |v|
       $since = v
     end
+    opts.on('-c', '--commits[=FORMAT]', [:raw], 'List commits instead of persons') do |v|
+      $show_commits = v || true
+    end
   end.parse!
 rescue OptionParser::InvalidOption
 end
@@ -136,6 +140,15 @@ commits = Commits.new
 commits.from_patches(ARGV)
 commits.import
 
+if $show_commits
+  if $show_commits == :raw
+    puts commits.items.keys
+  else
+    system(*['git', 'log', '--oneline', '--no-walk'] + commits.items.keys)
+  end
+  exit 0
+end
+
 # hash of hashes
 persons = Hash.new { |hash, key| hash[key] = {} }
 
-- 
1.8.2.1.790.g4588561
