From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] t4201 (shortlog): guard setup with test_expect_success
Date: Mon, 26 Apr 2010 04:58:05 -0500
Message-ID: <20100426095805.GB31483@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <20100426031012.GA29953@progeny.tock>
 <u2i5b9751661004260047n168ad87bx6083fc201bfb21d9@mail.gmail.com>
 <20100426095206.GA31483@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Thomas Rast <trast@student.ethz.ch>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 11:57:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6L46-0005T9-Bx
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 11:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416Ab0DZJ5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 05:57:15 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:35824 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab0DZJ5O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 05:57:14 -0400
Received: by pxi17 with SMTP id 17so1509693pxi.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=o3i4IiBF/nKOzXvQisCWr9nm/CJRx6+/4er6Jp7J+mA=;
        b=BtKfnEKLB4oA9mVaJcZNRx65mHLsLXgtYubV2Vzc5R4PDpVuKH3ylg8C1zkR5FBPH9
         56lzggopa5ASMb31EI91DgFNeIePvLWsMiZBVU4zFw0QDxs50sZ3L+zmMseWWkP1kOrI
         WDNWZSYturpKX+sdkxodD9xejQ9BTiCN1/9os=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wrYcsFgM1QHkKdbg9vsOzaPYcMi3HybkR+FJvBVgmIWnLtFznEx4DV5eRa16ZC0RGH
         39gFp61JwPjHHiE/ETf3D35g9htMwIoaee6uY2wWWXoaX/LsugfJw7WnlA5WkOccSTPo
         +0sv6abVFISz5tdbyTNE5FSIri/n7qScnUr0o=
Received: by 10.114.19.11 with SMTP id 11mr3780304was.139.1272275832935;
        Mon, 26 Apr 2010 02:57:12 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3009828iwn.8.2010.04.26.02.57.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 02:57:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100426095206.GA31483@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145802>

Follow the current prevailing style.  This also has the benefit of
capturing any stray output and noticing if any of the setup commands
start failing.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
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
1.7.1.3.g5f1e.dirty
