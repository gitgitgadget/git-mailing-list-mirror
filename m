From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 11/15] contrib: related: allow usage on other directories
Date: Sat, 12 Oct 2013 02:06:22 -0500
Message-ID: <1381561584-20529-14-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNt-0005LL-6B
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402Ab3JLHNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:05 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:51940 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353Ab3JLHM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:59 -0400
Received: by mail-ob0-f170.google.com with SMTP id gq1so3496648obb.29
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C1MuC0GrpcuwpiVDdWGjQ5OwoNceNpvo3Qym5giG2kw=;
        b=MGDtuLz04KkP+d5CZIAt2DU4pqiJmCdGxkiyhDqqJKPfSaW9D1Bsb40/pPqGTIjrlE
         I6Bb0AosH3pU6WMWsqdpIUQ8Q9Y7k3Xy9V0fK5DdIr3thGKi6yYQN79mEvSf2+g09sUu
         LJh/hRfYFkCg8AxI5bw9v4e0a5ss8ruR52kotyAluBHdSOR3bgnL5xwTEHypKhyHLoQv
         6JmUpvwX29lNp2bebfQF9p3ZWJERwESZraatb6LH+4W20mC1/nUftDdYm50apn1AECcx
         dRJeAmLKU1nlC/eifkj/KGAOlKDTrwlbKazEinu1uFnHBuTtpR2X5M91Dl9VkcoapI/y
         dTXg==
X-Received: by 10.60.145.207 with SMTP id sw15mr13712576oeb.38.1381561978974;
        Sat, 12 Oct 2013 00:12:58 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm28646024obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236005>

Not just the root one (of the project).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 3399307..f15e4e7 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -8,6 +8,10 @@ $min_percent = 10
 $files = []
 $rev_args = []
 
+git_dir = %x[git rev-parse --git-dir].chomp
+$base_dir = File.dirname(git_dir)
+$cur_dir = Dir.pwd
+
 KNOWN_ROLES = {
   'Signed-off-by' => :signer,
   'Reviewed-by' => :reviewer,
@@ -130,6 +134,7 @@ class Commits
   def get_blame(source, start, len, from)
     return if len == 0
     len ||= 1
+    Dir.chdir($base_dir)
     File.popen(['git', 'blame', '--incremental', '-C', '-C',
                '-L', '%u,+%u' % [start, len],
                '--since', $since, from + '^',
@@ -141,6 +146,7 @@ class Commits
         end
       end
     end
+    Dir.chdir($cur_dir)
   end
 
   def scan_patch(f, id = nil)
-- 
1.8.4-fc
