From: Dan Holmsand <holmsand@gmail.com>
Subject: [PATCH] cg-Xlib: make showdate show timezone
Date: Sun, 12 Jun 2005 13:40:57 +0200
Message-ID: <42AC1F49.9010808@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000303040404020504080903"
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jun 12 13:37:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhQmR-0006jh-NP
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 13:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVFLLll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 07:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVFLLlk
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 07:41:40 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:41191 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262317AbVFLLlF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2005 07:41:05 -0400
Received: by wproxy.gmail.com with SMTP id 68so1264883wra
        for <git@vger.kernel.org>; Sun, 12 Jun 2005 04:41:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type;
        b=cKSLpwd737RSNWr+pzo7wCXf3wQN9FIpoHez9epJ5qUhjn/WucU6wFicULpNWctSso4Qv6er5Zd1VWrEFmV6z4I+8lYcABK5AztCcfsscBq7uwKKiwIbc0t+aDeMtvohntma/poAv0ljnOQn/27g1VQaInnkX3gkJOR4cCZdtEc=
Received: by 10.54.8.62 with SMTP id 62mr2156629wrh;
        Sun, 12 Jun 2005 04:41:02 -0700 (PDT)
Received: from ?213.114.31.152? ([213.114.31.152])
        by mx.gmail.com with ESMTP id d61sm1268100wra.2005.06.12.04.41.01;
        Sun, 12 Jun 2005 04:41:02 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------000303040404020504080903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This makes timezones show up again in showdate's default
format. Hopefully, this also makes showdate a little more
portable.

It also speeds things up a little, by avoiding an extra fork.

Signed-off-by: Dan Holmsand <holmsand@gmail.com>
---

--------------000303040404020504080903
Content-Type: text/plain;
 name="showdate.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="showdate.patch.txt"

 cg-Xlib |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -68,14 +68,12 @@ showdate () {
 	# bash doesn't like leading zeros
 	[ "${tzhours:1:1}" = 0 ] && tzhours=${2:0:1}${2:2:1}
 	secs=$(($secs + $tzhours * 3600 + $tzmins * 60))
+	[ "$format" ] || format="+%a, %d %b %Y %H:%M:%S $2"
 	if [ "$has_gnudate" ]; then
-		[ "$format" ] || format=-R
-		pdate=$(date -ud "1970-01-01 UTC + $secs sec" "$format")
+		LANG=C date -ud "1970-01-01 UTC + $secs sec" "$format"
 	else
-		[ "$format" ] || format=--
-		pdate=$(date -u -r $secs "$format")
+		LANG=C date -u -r $secs "$format"
 	fi
-	echo "${pdate/+0000/$tz}"
 }
 
 # Usage: tree_timewarp [--no-head-update] DIRECTION_STR ROLLBACK_BOOL BASE BRANCH

--------------000303040404020504080903--
