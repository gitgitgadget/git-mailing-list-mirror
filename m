From: Mark Allen <mrallen1@yahoo.com>
Subject: Re: [PATCH] Unset TZ in t5000
Date: Tue, 14 Jun 2005 06:17:27 -0700 (PDT)
Message-ID: <20050614131727.23011.qmail@web41211.mail.yahoo.com>
References: <42ADAC4D.7050408@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-926892123-1118755047=:20982"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 15:13:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiBDg-00042i-Nq
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 15:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFNNRe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 09:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVFNNRe
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 09:17:34 -0400
Received: from web41211.mail.yahoo.com ([66.218.93.44]:54380 "HELO
	web41211.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261155AbVFNNRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 09:17:31 -0400
Received: (qmail 23013 invoked by uid 60001); 14 Jun 2005 13:17:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6PBWlhwl/A3WCjtkNqqWlEQTwCRlYe2jUe6XGSOVyQsQIY3HMmD8Wcp7YYv0+WvsIzHC5QuhslffM0AD2A9Zcb7jUO/VEhhwwChcaApQ7rWxCW8Fxo6glyCG1dKumRcabPxuo8+OH/XJLS+Msob63XZ5JPLGvEwwMGMVERt73tU=  ;
Received: from [66.41.38.150] by web41211.mail.yahoo.com via HTTP; Tue, 14 Jun 2005 06:17:27 PDT
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <42ADAC4D.7050408@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--0-926892123-1118755047=:20982
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

--- Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:> Mark Allen schrieb:
 > The expression
> 
>    length($5)<7 ? $5":00" : $5
> 
> (where $5 is a time value) is there to cope with tars that format the
> time like hh:mm instead of the expected hh:mm:ss.

I put (escaped) parenthesis around the length function and now it works as expected.
Here's a new patch. Please ack if you approve. 

Thanks,

--Mark

Signed-off-by: Mark Allen <mrallen1@yahoo.com>


--0-926892123-1118755047=:20982
Content-Type: text/plain; name="t5000-portability.patch.txt"
Content-Description: 560000162-t5000-portability.patch.txt
Content-Disposition: inline; filename="t5000-portability.patch.txt"

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -50,8 +50,9 @@ test_expect_success \
 
 test_expect_success \
     'validate file modification time' \
-    'tar tvf b.tar a/a |
-     awk \{print\ \$4,\ length\(\$5\)\<7\ ?\ \$5\":00\"\ :\ \$5\} >b.mtime &&
+    'TZ= tar tvf b.tar a/a |
+     awk \{print\ \$4,\ \(length\(\$5\)\<7\)\ ?\ \$5\":00\"\ :\ \$5\} \
+     >b.mtime &&
      echo "2005-05-27 22:00:00" >expected.mtime &&
      diff expected.mtime b.mtime'
 

--0-926892123-1118755047=:20982--
