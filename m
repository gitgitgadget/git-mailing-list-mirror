From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 10/15] contrib: related: allow usage on other directories
Date: Sat, 18 May 2013 06:46:50 -0500
Message-ID: <1368877615-9563-11-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:49:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdfdK-0007ET-IO
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab3ERLtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:49:02 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:48403 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab3ERLtA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:49:00 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so5981608oag.25
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nbKjS7yXDLwD/pUU9bVCUd2gCECJI/oeiL9j4GKiobM=;
        b=E7RE6IbAsY7rPC/gDMLs2abKiM1irhObcmgMrKHQ4AKmsqZeV68FIj5dBRnOF8bbll
         cIk0QsD5OgtYdymFlRQZLzvvHKf43J/J7JqXhR+e4hDN7eOHtSuyNYctpA+EaY1JTkwj
         lvplLY5OUjimVj6VsW5oR0Mh8N51Jpr++2Bgr8yYWwQtdWde46m1E0ZeU7wwubWk5CZE
         WlEMV8jLFFWhsmQ8N/8E2u2gzBke8xCrsjOT73uTSmC6MFARdojneW8bhgjvpJCINJMe
         LcEWUU9JKB4mzL8lsvrs5e4cklw95CzsaJYkt0lkW3w8pZKB0Lr1+WjEmGeCeeOZcf52
         N2+g==
X-Received: by 10.60.63.238 with SMTP id j14mr24689798oes.77.1368877740055;
        Sat, 18 May 2013 04:49:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id na9sm3974969obb.10.2013.05.18.04.48.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:48:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224783>

Not just the root one (of the project).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 3b11930..def2af5 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -44,8 +44,12 @@ def get_mailmap(filename)
   end
 end
 
+git_dir = %x[git rev-parse --git-dir].chomp
+$base_dir = File.dirname(git_dir)
+$cur_dir = Dir.pwd
+
 get_aliases if $get_aliases
-get_mailmap('.mailmap')
+get_mailmap(File.join($base_dir, '.mailmap'))
 mailmap_file = %x[git config mailmap.file].chomp
 get_mailmap(mailmap_file)
 
@@ -180,6 +184,7 @@ class Commits
   def get_blame(source, start, len, from)
     return if len == 0
     len ||= 1
+    Dir.chdir($base_dir)
     File.popen(['git', 'blame', '--incremental', '-C',
                '-L', '%u,+%u' % [start, len],
                '--since', $since, from + '^',
@@ -191,6 +196,7 @@ class Commits
         end
       end
     end
+    Dir.chdir($cur_dir)
   end
 
   def from_patch(file)
-- 
1.8.3.rc2.542.g24820ba
