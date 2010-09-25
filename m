From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 04/16] t4002 (diff-basic): use test_might_fail for commands that might fail
Date: Sat, 25 Sep 2010 13:06:55 -0600
Message-ID: <1285441627-28233-5-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:06:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza4q-0005Xq-Fx
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568Ab0IYTFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:05:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39899 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0IYTFe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:34 -0400
Received: by pwj6 with SMTP id 6so880409pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qXRa0F3A0kzIWI5EmxpMba3QeWvvKhQ0ntTkC63f6zQ=;
        b=RSdbpsSHUcYLLEMgSlsNJOLBMCschcm5AUATGCEomYkm+ps6emhrY/knbFI0C/YSCE
         m+lOq97UNbd3KBtkO1rSaRGcIHzogWLF7EcIV+nxvZzKU2hW+I/90XC1/DkGiVfRMjLa
         GZ4+Rua8dul4NBUPUMhuBiUn7iI1ltkAdSKyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZEAQTNmgsDklDWq2EXwWzXUFxD2SPOSr3FOjBe3OP0ljdcB2qp9H5vMIlld1tZXnZt
         AifNvgM41USNErGQAzg9qzrmnJQMyi/D2W+Qnli1btuFdSNqy1jcx62cOhmbd+lJsLhJ
         vHqCfqG2Q7qiV2nUTdxzu5X3SJ4g2tLVhsWMo=
Received: by 10.114.103.7 with SMTP id a7mr5652078wac.173.1285441534351;
        Sat, 25 Sep 2010 12:05:34 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157184>

Also replace '|| return 1' by '&&' to allow chain of operations to be
checked for proper return status.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4002-diff-basic.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index 73441a5..340aa7d 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -205,8 +205,8 @@ test_expect_success \
     'rm -fr Z [A-Z][A-Z] &&
      git read-tree $tree_A &&
      git checkout-index -f -a &&
-     git read-tree --reset $tree_O || return 1
-     git update-index --refresh >/dev/null ;# this can exit non-zero
+     git read-tree --reset $tree_O &&
+     test_might_fail git update-index --refresh >/dev/null &&
      git diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-OA'
 
@@ -215,8 +215,8 @@ test_expect_success \
     'rm -fr Z [A-Z][A-Z] &&
      git read-tree $tree_B &&
      git checkout-index -f -a &&
-     git read-tree --reset $tree_O || return 1
-     git update-index --refresh >/dev/null ;# this can exit non-zero
+     git read-tree --reset $tree_O &&
+     test_might_fail git update-index --refresh >/dev/null &&
      git diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-OB'
 
@@ -225,8 +225,8 @@ test_expect_success \
     'rm -fr Z [A-Z][A-Z] &&
      git read-tree $tree_B &&
      git checkout-index -f -a &&
-     git read-tree --reset $tree_A || return 1
-     git update-index --refresh >/dev/null ;# this can exit non-zero
+     git read-tree --reset $tree_A &&
+     test_might_fail git update-index --refresh >/dev/null &&
      git diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-AB'
 
-- 
1.7.3.95.g14291
