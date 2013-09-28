From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 31/44] ruby: request-pull: use read_sha1_file()
Date: Sat, 28 Sep 2013 17:03:56 -0500
Message-ID: <1380405849-13000-32-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jj-0003sA-Oi
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab3I1WLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:34 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:46398 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab3I1WLa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:30 -0400
Received: by mail-oa0-f52.google.com with SMTP id n2so3053613oag.11
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TtC+aLx+RYmSQ5HViuRrC6Cvt82gclrfbmo1RWojmbU=;
        b=hm1DeV929AtB+Rv2+tvIjk5IgQCLWGigE0w8y3f1FWLm2Yut5wm6m1/yiRoi5NBc57
         g68sxPDx2r1eFIE29MxsMIbYFPdC/Bac9Pf9fy74CMhVY0lN6eFAZzs6h4jIxWIB/Tu7
         hcmgpajRcp29UIrqaK8a0b5T7sZOEqRblHsO5wI3ndfDxDEjKDAqosFxnDfmtHAoH9U6
         //p77LAvo1EXE/njD5T/U9MzL8aEE972dJ6slocHi/g1tZbImm8a9jo3bnogGxFKtfQd
         Vg4bJ5Txl3hpVmej/alh/PUAE2eA+LgC4HC/Hg8mstm7oJvJ8+f81YydhqbZVmmadHFu
         9dXg==
X-Received: by 10.60.118.41 with SMTP id kj9mr12242826oeb.31.1380406289968;
        Sat, 28 Sep 2013 15:11:29 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm19483151obc.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235551>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.rb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index 5f40901..233981f 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -165,7 +165,8 @@ for you to fetch changes up to %s:
       $stderr.puts "warn: appear to be at #{url}"
       $stderr.puts "warn: Do you want to push it there, perhaps?"
     end
-    run(%[git cat-file tag "#{tag_name}" | sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p])
+    buffer, _ = read_sha1_file(get_sha1(tag_name))
+    puts buffer.scan(/(?:\n\n)(.+)(?:-----BEGIN PGP )?/m).first
     puts
   end
 
-- 
1.8.4-fc
