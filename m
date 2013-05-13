From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] stash: simplify option parser for create
Date: Mon, 13 May 2013 18:15:51 +0530
Message-ID: <1368449154-21882-4-git-send-email-artagnon@gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 14:44:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubs7F-0003rq-Mt
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 14:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205Ab3EMMoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 08:44:24 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:40043 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab3EMMoX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 08:44:23 -0400
Received: by mail-pa0-f45.google.com with SMTP id lj1so4603486pab.32
        for <git@vger.kernel.org>; Mon, 13 May 2013 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=O+9J7v1KEFOU+lvJUaZ90fMhVfBX3juUty5a5k9Ikc8=;
        b=EOn1qpPvvg353B6+KuqTUQk4hWtunT1K43O0O7EsbjR5UpcR4A8oQKTNxdwT7Pik8j
         PNPQwGW5TlHkWAKTtPzBXwSYiamyO1JlYYRaKGnV0GDytBbHDZfMny8ipyBnklvhYUFw
         pChuMlZwwYeObkUnFkVj/WVfaewjjgiBRvE1AUvcY1NMsZzCds6BYUG6T306FsHJGysK
         9o/FbIKW3do00im3F7DNQx2v/Y1ukJHKBai5GruEYsexLUgaQs8twtGXl2YfvmBVxk25
         CV1oUX07ibbeAZdRaqIbXd3TDiBdp1XxrhZdgA+pE3GBIUzc7PID5sGMc/m3BD6Sjs3+
         nlBQ==
X-Received: by 10.68.171.226 with SMTP id ax2mr13621538pbc.201.1368449062593;
        Mon, 13 May 2013 05:44:22 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id rn7sm3050227pbc.12.2013.05.13.05.44.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 05:44:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.57.g4ac1522
In-Reply-To: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224126>

The option parser for create unnecessarily checks "$1" inside a case
statement that matches "$1" in the first place.  Also, use "$@", not
"$*", as our caller is expecting "$1" "$2", not "$1c$2" (where c is the
first character of IFS).

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-stash.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index bbefdf6..0ede313 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -546,11 +546,8 @@ clear)
 	clear_stash "$@"
 	;;
 create)
-	if test $# -gt 0 && test "$1" = create
-	then
-		shift
-	fi
-	create_stash "$*" && echo "$w_commit"
+	shift
+	create_stash "$@" && echo "$w_commit"
 	;;
 drop)
 	shift
-- 
1.8.3.rc1.57.g4ac1522
