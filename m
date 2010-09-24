From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 05/16] t4002 (diff-basic): use test_might_fail for commands that might fail
Date: Fri, 24 Sep 2010 16:22:45 -0600
Message-ID: <1285366976-22216-6-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGem-0000n6-B4
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758259Ab0IXWVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:30 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45492 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758253Ab0IXWV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:26 -0400
Received: by mail-qy0-f181.google.com with SMTP id 33so4608692qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qXRa0F3A0kzIWI5EmxpMba3QeWvvKhQ0ntTkC63f6zQ=;
        b=rst2a9b8lNqkwZdcY49wx8AqfiGJBWz/h8OO+T7r0fuWSBGW8mhZBbwzuio7MVkzrl
         nRwOuTZVyo2MkBp0ktKfOrKF6vMFo2ALXj0O75rEsXFR2ZzV8cy033TqFr9FcxMCfF1t
         kkYiPO+yahM277ChYNonmkQ5R+oa/HenKz3zI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cAGnBbPVou+DBsWBJlS2ziEn4W4niBA/YPmgTqmm5Vk5Vg0GHxC5oQBgY3Pf/wHbLE
         CmKgmUsYWAaeI2DemkeuC7vOLTKQiaOnwjg3sxS6ueXBSomQEfeDfWHZzaAwJzI/NupZ
         HpksHl798E0RqmjKkEfwTkXPaDG+EgNIpKPdc=
Received: by 10.220.181.133 with SMTP id by5mr1679026vcb.149.1285366886305;
        Fri, 24 Sep 2010 15:21:26 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.24
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157077>

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
