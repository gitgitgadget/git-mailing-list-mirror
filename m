From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 21/44] ruby: request-pull: use get_sha1()
Date: Sat, 28 Sep 2013 17:03:46 -0500
Message-ID: <1380405849-13000-22-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jR-0003dv-3t
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab3I1WLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:13 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61883 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab3I1WLB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:01 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so4171568obc.19
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gnmDg30N8TQGBirpugN46asV/yqFdfd3rW5Wv4h1ndA=;
        b=hO/wWhlIaruyY9CL4gg4E+57TZ64ngajDdfTA8mXtY3q97R+g4miqUUzGMFO++hCos
         WIlFb5I/gI/DTqjq7eq2wKpeUuq2CsLLytMT9pZGjCIH3jRWTQRA9k8dnmG1wZGZELB1
         sXEM95ipP3gAz8kqQAKDRVv1aDwUHLFIOwCA7hNerrvzJVj7JbFdBwpC6+nMXDmXBM5Z
         1vsJI+WrITyBgyj0mdv1SOEsxhSnZztFFZIaPqrlT4kKGps+rpfdPYynEVsDJso5eo4y
         rO5WzwrjhZ00XfLQaw4GudLID1wYseXUhW5uBF+FPeEOyIS43AbjMk0bfNU3caZrkcVk
         E5ZQ==
X-Received: by 10.182.53.196 with SMTP id d4mr12530515obp.7.1380406261273;
        Sat, 28 Sep 2013 15:11:01 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm19508943obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235543>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    To minimize the changes in the rest of the script, the sha1 is converted by to
    a hex.

 git-request-pull.rb | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index 25dc04d..9267147 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -92,11 +92,14 @@ end
 
 tag_name = describe(head)
 
-baserev = `git rev-parse --verify --quiet "#{base}"^0`.chomp
-die "Not a valid revision: #{base}" if baserev.empty?
+baserev = get_sha1("#{base}^0")
+die "Not a valid revision: #{base}" unless baserev
 
-headrev = `git rev-parse --verify --quiet "#{head}"^0`.chomp
-die "Not a valid revision: #{head}" if headrev.empty?
+headrev = get_sha1("#{head}^0")
+die "Not a valid revision: #{head}" unless headrev
+
+baserev = sha1_to_hex(baserev)
+headrev = sha1_to_hex(headrev)
 
 merge_base = `git merge-base #{baserev} #{headrev}`.chomp
 die "No commits in common between #{base} and #{head}" unless $?.success?
-- 
1.8.4-fc
