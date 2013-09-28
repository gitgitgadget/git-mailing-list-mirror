From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 15/44] ruby: request-pull: use native dwim_ref()
Date: Sat, 28 Sep 2013 17:03:40 -0500
Message-ID: <1380405849-13000-16-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2ix-0003F5-HS
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265Ab3I1WKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:48 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:43019 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262Ab3I1WKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:45 -0400
Received: by mail-oa0-f44.google.com with SMTP id l10so3017894oag.17
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=blwbNbt3Bp2YbRedSW2YbECemNO1N68k5/Qmi/tk6xo=;
        b=ZgIe2tbUj0tKQwuJn3Wk0p07shZfYyYsthGD+NyExoWz4fjtceR3NXRd5rOqvyCgBU
         yN6K45lZxhZrYD1MaCGpnvIEqHwk/0MBNKjDzXwY2kjnZqLEk6qlr/3S6UgRWqQMaVSZ
         YImuhVQtd7AcNjkJBbvej3WEtPszJs2zSvfEml7J/S40y1Y+iKZA98VguFHzZzXwGVPM
         qshGXiPvB4/32h75rFKHp52bcqoZpOyGTR0cHm+Up6Wtydh8e+e+wKLsRYLgoNyaQXIS
         HJ8chup5+oecDpaE/vZ8zllzjvouyUJNR2F4CBOoOFJZcxhLN12ANnSJt0LKQuDJZ/Nd
         J+Pw==
X-Received: by 10.60.63.68 with SMTP id e4mr12345570oes.23.1380406244727;
        Sat, 28 Sep 2013 15:10:44 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hs4sm19518146obb.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235534>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    Our first real usage of the bindings doesn't look too different from what it
    would look like in C.
    
    In Ruby all variables are pointers to objects, and there's no concept of
    pointer to variables, so what in C looks like "ret1 = func(var, &ret2)", in
    Ruby looks like "ret1, ret2 = func(var)".

 git-request-pull.rb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index 9d3e9ab..416f880 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -66,7 +66,7 @@ branch_name = branch_desc = nil
 
 usage unless base or url
 
-headref = `git rev-parse -q --verify --symbolic-full-name "#{head}"`.chomp
+_, _, headref = dwim_ref(head)
 
 if headref.start_with?('refs/heads')
   branch_name = headref[11..-1]
-- 
1.8.4-fc
