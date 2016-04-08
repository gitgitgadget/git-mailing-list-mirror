From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 18/18] git-merge-octopus.sh: support --index-only option
Date: Thu,  7 Apr 2016 23:58:46 -0700
Message-ID: <1460098726-5958-19-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 09:00:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQOg-0002y6-FB
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 09:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbcDHG7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34943 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932661AbcDHG7S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id r187so8893075pfr.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZHhNAzcVRumJV81PZeNPRuaaKUU9HaSO1Ion71YHh7I=;
        b=FKvaB6Bnyxq/DlAI6MQqShxSb572OoAtUQoA7M6KvwigF4HR/hDD16oCHww+sc7qg0
         h084fXZhqYjC8xHJABOeATwT5Ny1mtGsaZZdN7behKmBmTzKxF1QRQOgihZ6kWCvgx7v
         brGc/+OjuXnofH3CDn13K/SLpSpjkRwqhupa95nzDMTEf+ZOCgYrNRiz130gv8DZZPSW
         6OY32jCggeLvoO+OzuVcQMl9u/+2EzakGFS1AwvUt4G7nh2m3qDymlrqb6dHp9wDGr9P
         arykeWOd9tcUY1q9JzK/Qm7zZIi/pOOBDs/zEjLxY7ERQdq+nIDUh4pVbUQlO6JBchR7
         k10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZHhNAzcVRumJV81PZeNPRuaaKUU9HaSO1Ion71YHh7I=;
        b=GYfN2+3VIm0plAKrQOrJwSdXCa+HHo1mdxwanPpl6ZaIC4pcGTWCj+CYqhAmL/lzo6
         d1WUHzs6vYCqNf2wifRe2Xte1ghTyc/4XQc+LuQWFe0rv1HilZpdx9JUzW5WkdckgSkn
         MBJc9TvEZipAYPoaGEJY8yI5mjpCHyX4GU0hGDe+8opvfT0acrX+3078MlST6eaSbA2E
         Y6Ju5OaqhqXMd4ZcFE+YYIGocoKMbEWJnOyxP2DcDi+ROwJmpyBZDzwQ54d2Ecn26RaG
         WRZ6eMu21OAkAN21mf5kk1+VDiOI1kmoqsDOyctlo8uwoOPj7b+qFa0eU8zr1fiGly9n
         AMAg==
X-Gm-Message-State: AD7BkJLeFJZ8B4lxrCrCr6yR48bBZ0aKWMPsCoNSht+97rQrdQU3yz4/h6B3UVMAmF0ezg==
X-Received: by 10.98.33.74 with SMTP id h71mr10346311pfh.157.1460098757220;
        Thu, 07 Apr 2016 23:59:17 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:16 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291017>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-merge-octopus.sh        | 14 +++++++++++---
 t/t6043-merge-index-only.sh |  4 ++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index a1d7702..e7915dc 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -13,6 +13,14 @@ die () {
     exit 1
 }
 
+read_tree_update="-u"
+index_only=
+if test "$1" = "--index-only"; then
+	read_tree_update="-i"
+	index_only="--index-only"
+	shift
+fi
+
 # The first parameters up to -- are merge bases; the rest are heads.
 bases= head= remotes= sep_seen=
 for arg
@@ -89,7 +97,7 @@ do
 		# We still need to count this as part of the parent set.
 
 		echo "Fast-forwarding to: $pretty_name"
-		git read-tree -u -m $head $SHA1 || exit
+		git read-tree $read_tree_update -m $head $SHA1 || exit
 		MRC=$SHA1 MRT=$(git write-tree)
 		continue
 	fi
@@ -97,12 +105,12 @@ do
 	NON_FF_MERGE=1
 
 	echo "Trying simple merge with $pretty_name"
-	git read-tree -u -m --aggressive  $common $MRT $SHA1 || exit 2
+	git read-tree $read_tree_update -m --aggressive  $common $MRT $SHA1 || exit 2
 	next=$(git write-tree 2>/dev/null)
 	if test $? -ne 0
 	then
 		echo "Simple merge did not work, trying automatic merge."
-		git-merge-index -o git-merge-one-file -a ||
+		git-merge-index -o git-merge-one-file $index_only -a ||
 		OCTOPUS_FAILURE=1
 		next=$(git write-tree 2>/dev/null)
 	fi
diff --git a/t/t6043-merge-index-only.sh b/t/t6043-merge-index-only.sh
index c0a553b..080e03d 100755
--- a/t/t6043-merge-index-only.sh
+++ b/t/t6043-merge-index-only.sh
@@ -333,7 +333,7 @@ test_expect_success '--index-only w/ resolve, non-trivial, bare' '
 	)
 '
 
-test_expect_failure '--index-only octopus, non-bare' '
+test_expect_success '--index-only octopus, non-bare' '
 	git reset --hard &&
 	git checkout B^0 &&
 
@@ -351,7 +351,7 @@ test_expect_failure '--index-only octopus, non-bare' '
 	test ! -f d
 '
 
-test_expect_failure '--index-only octopus, bare' '
+test_expect_success '--index-only octopus, bare' '
 	rm -rf bare.clone &&
 	git clone --bare . bare.clone &&
 	(cd bare.clone &&
-- 
2.8.0.18.gc685494
