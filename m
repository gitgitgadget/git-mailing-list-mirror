From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH] feature request: git-mergetool --force
Date: Sat, 18 Oct 2008 00:23:05 +0100
Message-ID: <48F91E59.50202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 01:24:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqygC-0003p0-56
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 01:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbYJQXXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 19:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbYJQXXL
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 19:23:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:40702 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbYJQXXK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 19:23:10 -0400
Received: by nf-out-0910.google.com with SMTP id d3so450564nfc.21
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 16:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=D7z4dm/TGSl7NilRRZRCiNiSZYmNjNuf3FQzOkRGXQg=;
        b=WpbLhuyim8bUaMtM6cbKcxsvcSgc1Whz2RZK8xLq3pi1/5CoE1Lp8vKzTXm/nKzGAd
         /naehbg0kJhqq+RiXbhXKyz7TsDbPyFEEVGp4OlWuWkoZ9N1Zvui2SaCw6DwgfHFC2Fn
         ZsJ2XUWkl3UrEUVSIzzjnVNZFQ9AgHoCUwWPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=ScFgLJGrycY7L5MZS2IGzx5Ehz2Lqy5T8Um3YMI4wmoj4H6mHW/vBuV+7wVI9fOB9F
         Rs2BNL6/NYPBvIA8scvO5BUkqV3qhz5aA//ZdURlJu1xd8np9h8nFdIod1l3CasaUyL+
         NVf5oqpY9u97lz1JfXH1c8mA4zsKS7uO0Egxo=
Received: by 10.210.92.8 with SMTP id p8mr565121ebb.101.1224285789332;
        Fri, 17 Oct 2008 16:23:09 -0700 (PDT)
Received: from clam.local (5ad934a0.bb.sky.com [90.217.52.160])
        by mx.google.com with ESMTPS id t2sm3703219gve.5.2008.10.17.16.23.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Oct 2008 16:23:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Macintosh/20080914)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98499>

I occasionally use commands like 'cp $REMOTE $MERGED' with
mergetool, and would prefer to not be prompted to start
the tool on each file.  A --force option would be handy.

-- 
William Pursell


diff --git a/git-mergetool.sh b/git-mergetool.sh
index 94187c3..5c9ce09 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -8,7 +8,7 @@
  # at the discretion of Junio C Hamano.
  #

-USAGE='[--tool=tool] [file to merge] ...'
+USAGE='[--tool=tool] [--force] [file to merge] ...'
  SUBDIRECTORY_OK=Yes
  OPTIONS_SPEC=
  . git-sh-setup
@@ -176,8 +176,10 @@ merge_file () {
      echo "Normal merge conflict for '$MERGED':"
      describe_file "$local_mode" "local" "$LOCAL"
      describe_file "$remote_mode" "remote" "$REMOTE"
-    printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
-    read ans
+    if test x"$force_option" != xyes; then
+	printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
+	read ans
+    fi

      case "$merge_tool" in
  	kdiff3)
@@ -283,6 +285,9 @@ merge_file () {
  while test $# != 0
  do
      case "$1" in
+	-f|--fo|--for|--forc|--force)
+	    force_option=yes
+	    ;;
  	-t|--tool*)
  	    case "$#,$1" in
  		*,*=*)
