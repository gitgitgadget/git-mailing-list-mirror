From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Add test case for $Id$ expanded in the repository
Date: Sun, 27 May 2007 11:52:11 +0100
Message-ID: <200705271152.11962.andyparkins@gmail.com>
References: <200705271150.50147.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 12:52:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsGMk-0005bA-SI
	for gcvg-git@gmane.org; Sun, 27 May 2007 12:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbXE0Kwo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 06:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbXE0Kwo
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 06:52:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:60921 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbXE0Kwn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 06:52:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1427452ugf
        for <git@vger.kernel.org>; Sun, 27 May 2007 03:52:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=SvcbzRmYRo23QDsVrGjhsUzaE4OZzfbDaHKzYzeSHspUgSAG6cYyrYGeX4uQgLMu7ef29iMI13OBRsZDnkH8/w7N6sNUXLlcc8MmioUqP70wGy0dlaDvIHvjl67scArw8SkHZdM5coa1bDpxCipUvRLYdrJXhL+OuFNnChXONks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=McX+Xlo3Lsh/iFy8AlKfrlklsHERaMbOwY3Kd0B/1xD8FLj98VXxyQoz4FKNrbp9I48L0hZjLwTugqsZfln1FXUaSOu9HyZYj47RcuphFfxJGjF26Lvx1wM8PuxiPwxXacQaizaiqUpcoQldGxzsfPAicnsqdos3SQk/NJiHKlI=
Received: by 10.67.20.3 with SMTP id x3mr4393053ugi.1180263162136;
        Sun, 27 May 2007 03:52:42 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 39sm3036735ugb.2007.05.27.03.52.40;
        Sun, 27 May 2007 03:52:41 -0700 (PDT)
In-Reply-To: <200705271150.50147.andyparkins@gmail.com>
X-TUID: 0290d6fc6abb6c4e
X-UID: 313
X-Length: 2342
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48531>

This test case would have caught the bug fixed by revision
c23290d5.

It puts various forms of $Id$ into a file in the repository,
without allowing git to collapse them to uniformity.  Then enables the
$Id$ expansion on checkout, and checks that what is checked out has
coped with the various forms.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 t/t0021-conversion.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 6c26fd8..a839f4e 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -45,4 +45,40 @@ test_expect_success check '
 	test "z$id" = "z$embedded"
 '
 
+# If an expanded ident ever gets into the repository, we want to make sure that
+# it is collapsed before being expanded again on checkout
+test_expect_success expanded_in_repo '
+	{
+		echo "File with expanded keywords"
+		echo "\$Id\$"
+		echo "\$Id:\$"
+		echo "\$Id: 0000000000000000000000000000000000000000 \$"
+		echo "\$Id: NoSpaceAtEnd\$"
+		echo "\$Id:NoSpaceAtFront \$"
+		echo "\$Id:NoSpaceAtEitherEnd\$"
+		echo "\$Id: NoTerminatingSymbol"
+	} > expanded-keywords &&
+
+	{
+		echo "File with expanded keywords"
+		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
+		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
+		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
+		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
+		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
+		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
+		echo "\$Id: NoTerminatingSymbol"
+	} > expected-output &&
+
+	git add expanded-keywords &&
+	git commit -m "File with keywords expanded" &&
+
+	echo "expanded-keywords ident" >> .gitattributes &&
+
+	rm -f expanded-keywords &&
+	git checkout -- expanded-keywords &&
+	cat expanded-keywords &&
+	cmp expanded-keywords expected-output
+'
+
 test_done
-- 
1.5.2.86.g99b5-dirty
