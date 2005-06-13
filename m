From: Mark Allen <mrallen1@yahoo.com>
Subject: [PATCH] Unset TZ in t5000
Date: Sun, 12 Jun 2005 17:24:44 -0700 (PDT)
Message-ID: <20050613002444.80848.qmail@web41213.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2036780932-1118622284=:80217"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Jun 13 02:20:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhcgS-0003Zd-Mj
	for gcvg-git@gmane.org; Mon, 13 Jun 2005 02:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVFMAYs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 20:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVFMAYr
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 20:24:47 -0400
Received: from web41213.mail.yahoo.com ([66.218.93.46]:24914 "HELO
	web41213.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261291AbVFMAYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2005 20:24:45 -0400
Received: (qmail 80850 invoked by uid 60001); 13 Jun 2005 00:24:45 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xZ9Ojmp4nl/iXTlZb5jOqGH+zTZP8cj1NpDukmZAkKGxmuSGBIW0P2gttKeUmOdLqwZhK3EGnA/RQOpY2oPfC4wugu/ff8HwnjVzOnmn9+wszp54AXWWDuOTXy293oNzLlSHMxddRGnfDJUEI6BzsrQ3FCk/74YEvq35fxyVVVo=  ;
Received: from [66.41.38.150] by web41213.mail.yahoo.com via HTTP; Sun, 12 Jun 2005 17:24:44 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--0-2036780932-1118622284=:80217
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Unset TZ in t5000 and remove GNU awkism

The t5000 test script fails at test #4 on my box because my copy of tar adjusts the time
in the tarfile for local time if TZ is set. Explicitly unset TZ so that it reports GMT
time.  Additionally, my version of AWK doesn't like the "length" directive, so this patch
removes it.

Signed-off-by: Mark Allen <mrallen1@yahoo.com>
--0-2036780932-1118622284=:80217
Content-Type: text/plain; name="unset-tz-t5000.patch.txt"
Content-Description: 3951729877-unset-tz-t5000.patch.txt
Content-Disposition: inline; filename="unset-tz-t5000.patch.txt"

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -50,8 +50,8 @@ test_expect_success \
 
 test_expect_success \
     'validate file modification time' \
-    'tar tvf b.tar a/a |
-     awk \{print\ \$4,\ length\(\$5\)\<7\ ?\ \$5\":00\"\ :\ \$5\} >b.mtime &&
+    'TZ= tar tvf b.tar a/a |
+     awk \{print\ \$4\"\ \"\$5\} >b.mtime &&
      echo "2005-05-27 22:00:00" >expected.mtime &&
      diff expected.mtime b.mtime'

--0-2036780932-1118622284=:80217--
