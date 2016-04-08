From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 17/18] git-merge-resolve.sh: support --index-only option
Date: Thu,  7 Apr 2016 23:58:45 -0700
Message-ID: <1460098726-5958-18-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 08:59:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQOA-0002VL-Gr
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 08:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbcDHG7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:24 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33057 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932668AbcDHG7W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:22 -0400
Received: by mail-pa0-f66.google.com with SMTP id q6so8527324pav.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bwyvWKLhutur+OS/OgFQnghDMgsXbe4GzXEus2nVvSw=;
        b=ZMGmtP2ciynb+z6FbwgywXAh4EQ7n/QzBtX6QxWiAcInUR226dWVWGQcDONNy57wgz
         r5oFomlRbWtZYvRUh+oDdkhN58zvQm4/Xds3Axg9gg3j4g3pVVbGSWspXagxX/GtlmE0
         VJlyQoOR/KXVzJjK5wOELbKSb17pTaXfDBewt8iw5GjNoyQ3C72BUOx4ZqhyGqa9fmmI
         ZZzudRD//azUgLulJlTkkZPInfpe8oDWUWUGJSMQNA4hWqIrNsfS6OjGfcFTCNMLG+0T
         GtFk9hyNM/DlAMG/wHeq86zE2aKC2I4VCXkngUgAdxA/tLpNHpgCwLTuK8BIAcVEJrzp
         N9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bwyvWKLhutur+OS/OgFQnghDMgsXbe4GzXEus2nVvSw=;
        b=gQwAEmhu3zgY+buSsveAGWI6RhQItTji6/e10E0ucfE5m+2tAmDyBiQDmBh3GxzLoX
         i0xQNQueyPO7t2rngfKL7KcQ46tKPpnadOO8qdJTbCICjhZfHLR/u4M4Q1KTDBYuOAbx
         zIYq9vfRjWyKUyLV6rJY1aoOq6WqQ315CdiTZmSUr5RyYst2WNyrqMeevc2afJm6JuXf
         ZUFroIx8H1wrsxvPmuodi1UjG4UTyjLEoA5zFdeTnVQWGdd6k1oPDeRER/kEcAVD/st2
         hK1ptWLjmDNhH86KiyHw6YbYnV6HUmnwYsbJGLBku/un9Q+yh34pOnTsDODg6ubgFVHm
         9EFQ==
X-Gm-Message-State: AD7BkJJQLr/tX3nccQPT2ykhkJSsN9qDRF9cjeOpsIDOTcM/DOT3SLWBjIP/FndYyRdsQw==
X-Received: by 10.66.62.232 with SMTP id b8mr10418173pas.104.1460098756208;
        Thu, 07 Apr 2016 23:59:16 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:15 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291002>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-merge-resolve.sh        | 12 ++++++++++--
 t/t6043-merge-index-only.sh |  4 ++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
index c9da747..ed4a25b 100755
--- a/git-merge-resolve.sh
+++ b/git-merge-resolve.sh
@@ -5,6 +5,14 @@
 #
 # Resolve two trees, using enhanced multi-base read-tree.
 
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
@@ -38,14 +46,14 @@ then
 fi
 
 git update-index -q --refresh
-git read-tree -u -m --aggressive $bases $head $remotes || exit 2
+git read-tree $read_tree_update -m --aggressive $bases $head $remotes || exit 2
 echo "Trying simple merge."
 if result_tree=$(git write-tree 2>/dev/null)
 then
 	exit 0
 else
 	echo "Simple merge failed, trying Automatic merge."
-	if git-merge-index -o git-merge-one-file -a
+	if git-merge-index -o git-merge-one-file $index_only -a
 	then
 		exit 0
 	else
diff --git a/t/t6043-merge-index-only.sh b/t/t6043-merge-index-only.sh
index cb860f2..c0a553b 100755
--- a/t/t6043-merge-index-only.sh
+++ b/t/t6043-merge-index-only.sh
@@ -299,7 +299,7 @@ test_expect_failure '--index-only w/ resolve, trivial, bare' '
 	)
 '
 
-test_expect_failure '--index-only w/ resolve, non-trivial, non-bare' '
+test_expect_success '--index-only w/ resolve, non-trivial, non-bare' '
 	git reset --hard &&
 	git checkout B^0 &&
 
@@ -314,7 +314,7 @@ test_expect_failure '--index-only w/ resolve, non-trivial, non-bare' '
 	test ! -f d
 '
 
-test_expect_failure '--index-only w/ resolve, non-trivial, bare' '
+test_expect_success '--index-only w/ resolve, non-trivial, bare' '
 	rm -rf bare.clone &&
 	git clone --bare . bare.clone &&
 	(cd bare.clone &&
-- 
2.8.0.18.gc685494
