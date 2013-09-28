From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 41/44] ruby: request-pull: remove rescue block
Date: Sat, 28 Sep 2013 17:04:06 -0500
Message-ID: <1380405849-13000-42-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:12:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2kG-0004IF-HJ
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393Ab3I1WMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:12:08 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:41278 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab3I1WMD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:12:03 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so4054871obc.25
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6tWsSAugeQov2qEabsX10fKQsVvzv6vA+PaJHYIeYFs=;
        b=h4K4Oz+Q9uSZu4S2oo6xAkLiv8EBz5ezBNEaXC5ySQDxW2jESaPLKN5Bly+EEEwMPO
         NpvoYRB4ojPRkW6cj/wifMb8+PNKm6eTNejSNXYxRiJ/jN2lF+JzLJCYilZqAP+uI82v
         Cgyf4ojaZZwN0q3OGwwQRs9P7VjP2ZXDThI3t8Fw3C3xNAO7oYvq8+dDxcPGPINxx0OR
         eMM5zOU4vEL37zyD/2ErYk/NQvvDlgQhdjG89VSuQVt/n6Ok5enMWgg2/qoIiICs1QyQ
         OIx58Pk0uSOSZSGNcSKYqKeaPcArm+n7//GhPsy1A4dbe/FJXxWgjPfJ4RXQPnlp6ZMv
         uYyA==
X-Received: by 10.182.121.137 with SMTP id lk9mr12550174obb.32.1380406322946;
        Sat, 28 Sep 2013 15:12:02 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm25486536oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:12:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235561>

We are not calling any git commands any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.rb | 61 ++++++++++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index e884d0d..fde8d1a 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -115,7 +115,6 @@ end
 base = ARGV[0]
 url = ARGV[1]
 head = ARGV[2] || 'HEAD'
-status = 0
 branch_name = branch_desc = nil
 
 usage unless base or url
@@ -154,16 +153,15 @@ url = remote.url.first
 merge_base_summary, merge_base_date = parse_buffer(merge_base_commit.buffer)
 head_summary, head_date = parse_buffer(head_commit.buffer)
 
-begin
-  puts "The following changes since commit %s:
+puts "The following changes since commit %s:
 
   %s (%s)
 
 are available in the git repository at:
 
 " % [merge_base_commit, merge_base_summary, merge_base_date]
-  puts "  #{url}" + (ref ? " #{ref}" : "")
-  puts "
+puts "  #{url}" + (ref ? " #{ref}" : "")
+puts "
 for you to fetch changes up to %s:
 
   %s (%s)
@@ -171,38 +169,33 @@ for you to fetch changes up to %s:
 ----------------------------------------------------------------
 " % [head_commit, head_summary, head_date]
 
-  if branch_name
-    puts "(from the branch description for #{branch_name} local branch)"
-    puts
-    puts branch_desc
-  end
+if branch_name
+  puts "(from the branch description for #{branch_name} local branch)"
+  puts
+  puts branch_desc
+end
 
-  if tag_name
-    if ref != "tags/#{tag_name}"
-      $stderr.puts "warn: You locally have #{tag_name} but it does not (yet)"
-      $stderr.puts "warn: appear to be at #{url}"
-      $stderr.puts "warn: Do you want to push it there, perhaps?"
-    end
-    buffer, _ = read_sha1_file(get_sha1(tag_name))
-    puts buffer.scan(/(?:\n\n)(.+)(?:-----BEGIN PGP )?/m).first
-    puts
+if tag_name
+  if ref != "tags/#{tag_name}"
+    $stderr.puts "warn: You locally have #{tag_name} but it does not (yet)"
+    $stderr.puts "warn: appear to be at #{url}"
+    $stderr.puts "warn: Do you want to push it there, perhaps?"
   end
+  buffer, _ = read_sha1_file(get_sha1(tag_name))
+  puts buffer.scan(/(?:\n\n)(.+)(?:-----BEGIN PGP )?/m).first
+  puts
+end
 
-  if branch_name || tag_name
-    puts "----------------------------------------------------------------"
-  end
+if branch_name || tag_name
+  puts "----------------------------------------------------------------"
+end
 
-  show_shortlog(base, head)
-  show_diff(patch, merge_base_id, head_id)
+show_shortlog(base, head)
+show_diff(patch, merge_base_id, head_id)
 
-  if ! ref
-    $stderr.puts "warn: No branch of #{url} is at:"
-    $stderr.puts "warn:   %s: %s'" % [find_unique_abbrev(head_id, DEFAULT_ABBREV), head_summary]
-    $stderr.puts "warn: Are you sure you pushed '#{abbr(head_ref)}' there?"
-    status = 1
-  end
-rescue CommandError
-  status = 1
+if ! ref
+  $stderr.puts "warn: No branch of #{url} is at:"
+  $stderr.puts "warn:   %s: %s'" % [find_unique_abbrev(head_id, DEFAULT_ABBREV), head_summary]
+  $stderr.puts "warn: Are you sure you pushed '#{abbr(head_ref)}' there?"
+  exit 1
 end
-
-exit status
-- 
1.8.4-fc
