From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/5] t4201 (shortlog): guard setup with test_expect_success
Date: Mon, 3 May 2010 21:57:36 -0500
Message-ID: <20100504025736.GC7322@progeny.tock>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
 <1272912875.3537.6.camel@dreddbeard>
 <20100504002526.GA7061@progeny.tock>
 <20100504015635.GA7258@progeny.tock>
 <20100504025217.GA7322@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 04:57:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O98KA-0002rv-Se
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 04:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313Ab0EDC5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 22:57:24 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:51362 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430Ab0EDC5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 22:57:23 -0400
Received: by ywh36 with SMTP id 36so1531879ywh.4
        for <git@vger.kernel.org>; Mon, 03 May 2010 19:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GrzeB9mT+3z+b+oxLt+7vUG3SvUno+KLyi3uBQIi7Oc=;
        b=tcYY7/k2nWeyrmqYflVOQUoveEYphiecVw5rSGpt8zN9InP/1as9GIX02amwcu4Pfa
         dql4d9w9FsvuuBXQF/ndJzPTcmVYzwug5qo2Jdo32ATqoUgF46AyIgoNQKFjPiFdM4rO
         greZ7u3Hr58lG5xkG/r0ECk4zSUPcZrH3wFz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uCt36jixdK8yJz6+omsl5Qq6x9GmhlajabBXR16x6oErqSWwUdLBuqeSU72lCDwngd
         4y3ywArtuNr7azoNrj0SoV+ff0xFeiGK4nghaWvscuCDqSetLyQyuu2TqQMu2l0bpeFp
         BmIHed3Dv7n3vQmVGOu6mrfURMYJ6iGifFRf8=
Received: by 10.151.87.7 with SMTP id p7mr9829451ybl.340.1272941842170;
        Mon, 03 May 2010 19:57:22 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm388668iwn.8.2010.05.03.19.57.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 19:57:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100504025217.GA7322@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146284>

Follow the current prevailing style.  This also has the benefit of
capturing any stray output and noticing if any of the setup commands
start failing.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before.

 t/t4201-shortlog.sh |   68 +++++++++++++++++++++++++++++---------------------
 1 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index a01e55b..438a826 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -8,30 +8,38 @@ test_description='git shortlog
 
 . ./test-lib.sh
 
-echo 1 > a1
-git add a1
-tree=$(git write-tree)
-commit=$( (echo "Test"; echo) | git commit-tree $tree )
-git update-ref HEAD $commit
-
-echo 2 > a1
-git commit --quiet -m "This is a very, very long first line for the commit message to see if it is wrapped correctly" a1
-
-# test if the wrapping is still valid when replacing all i's by treble clefs.
-echo 3 > a1
-git commit --quiet -m "$(echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" | sed "s/i/1234/g" | tr 1234 '\360\235\204\236')" a1
-
-# now fsck up the utf8
-git config i18n.commitencoding non-utf-8
-echo 4 > a1
-git commit --quiet -m "$(echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" | sed "s/i/1234/g" | tr 1234 '\370\235\204\236')" a1
-
-echo 5 > a1
-git commit --quiet -m "a								12	34	56	78" a1
-
-git shortlog -w HEAD > out
+test_expect_success 'setup' '
+	echo 1 >a1 &&
+	git add a1 &&
+	tree=$(git write-tree) &&
+	commit=$(printf "%s\n" "Test" "" | git commit-tree "$tree") &&
+	git update-ref HEAD "$commit" &&
+
+	echo 2 >a1 &&
+	git commit --quiet -m "This is a very, very long first line for the commit message to see if it is wrapped correctly" a1 &&
+
+	# test if the wrapping is still valid
+	# when replacing all is by treble clefs.
+	echo 3 >a1 &&
+	git commit --quiet -m "$(
+		echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" |
+		sed "s/i/1234/g" |
+		tr 1234 "\360\235\204\236")" a1 &&
+
+	# now fsck up the utf8
+	git config i18n.commitencoding non-utf-8 &&
+	echo 4 >a1 &&
+	git commit --quiet -m "$(
+		echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" |
+		sed "s/i/1234/g" |
+		tr 1234 "\370\235\204\236")" a1 &&
+
+	echo 5 >a1 &&
+	git commit --quiet -m "a								12	34	56	78" a1
+'
 
-cat > expect << EOF
+test_expect_success 'shortlog wrapping' '
+	cat >expect <<\EOF &&
 A U Thor (5):
       Test
       This is a very, very long first line for the commit message to see if
@@ -44,13 +52,15 @@ A U Thor (5):
          56	78
 
 EOF
+	git shortlog -w HEAD >out &&
+	test_cmp expect out
+'
 
-test_expect_success 'shortlog wrapping' 'test_cmp expect out'
-
-git log HEAD > log
-GIT_DIR=non-existing git shortlog -w < log > out
-
-test_expect_success 'shortlog from non-git directory' 'test_cmp expect out'
+test_expect_success 'shortlog from non-git directory' '
+	git log HEAD >log &&
+	GIT_DIR=non-existing git shortlog -w <log >out &&
+	test_cmp expect out
+'
 
 iconvfromutf8toiso88591() {
 	printf "%s" "$*" | iconv -f UTF-8 -t ISO8859-1
-- 
1.6.5
