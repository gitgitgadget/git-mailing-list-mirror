From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/8] contrib: cc-cmd: add option parsing
Date: Fri, 19 Apr 2013 00:14:12 -0500
Message-ID: <1366348458-7706-3-git-send-email-felipe.contreras@gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 07:15:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT3fm-0007yE-5R
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab3DSFPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 01:15:38 -0400
Received: from mail-gg0-f170.google.com ([209.85.161.170]:37397 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab3DSFPg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:15:36 -0400
Received: by mail-gg0-f170.google.com with SMTP id r4so272708ggn.29
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 22:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=T3jEgj/PDByF+VSPDclF2NIFNlea1GQc2d/stv/ay50=;
        b=Z91utxZ2+ekNfWXdeZhx4wJdN+wbHLKpXZ4p4wXXvbO7swUF7YYVBUDJXTrwPieuLa
         6UuRB4uEIiIFZ/fGSUk5tdoBWY+hTwiGP7/z6N4cSfwrA5bYk67Y555QWLu3kcchZho4
         WhomAUKDKpnqkiDFa+H2scleYFdUYS8xoBw/YNRhGRBe5Wmz0/GaLlJCAyOX4IdMeG/i
         wzpmBjPGLQgxW2JoqweSD5XyEZMa09L0DlRW623CS4S2xANKO9EOSa5FHz7Vwd7vNWkP
         A//nCHSTaISkVGR2DjNw2zxzW/KlEpW1XYaNR9rTTRFvsWNMfY9hxiAJO/0zAWXjCswj
         KoTQ==
X-Received: by 10.236.44.39 with SMTP id m27mr10080780yhb.129.1366348536016;
        Thu, 18 Apr 2013 22:15:36 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id u33sm22353318yhn.7.2013.04.18.22.15.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 22:15:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221730>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index c7ecf79..0a5ec01 100755
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
 
   attr_reader :id
@@ -107,15 +124,15 @@ class Commits
         end
       end
     end
-    import
   end
 
 end
 
 exit 1 if ARGV.size != 1
 
-commits = Commits.new()
+commits = Commits.new
 commits.from_patch(ARGV[0])
+commits.import
 
 # hash of hashes
 persons = Hash.new { |hash, key| hash[key] = {} }
-- 
1.8.2.1.790.g4588561
