From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 04/15] t4002 (diff-basic): use test_might_fail for commands that might fail
Date: Sun, 26 Sep 2010 17:14:28 -0600
Message-ID: <1285542879-16381-5-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:13:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00PK-0005V8-H9
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758236Ab0IZXNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:14 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43680 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218Ab0IZXNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:11 -0400
Received: by pwj6 with SMTP id 6so1036112pwj.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FAOCVN3kkeE6iBs+chIAAUcqwN5w+FT9oCBxSJYZxN8=;
        b=TFF/HEVBigwcG+TWZqhDSsy0MUzW+r2N/xhkGgsaETlXYwDCRuZomsJdMm/fwX3MzR
         5T+O2CLj/cuTiejtSIrdJpT6JgWDuWcqMgYzARU4uYZO3mFe3MfapJFZuzlzsIY9he+n
         LN4FDeE2tT5RW1803nuWksPGz0xwzXNtGMuBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bcxZ1JgtMLXr6byq4NUsjRPzzvEVOk2yM/ZULGa4UULZB++ecVfD2nV2yCIWJOJFLa
         rLzUuzXl145Q6nMjZvS0TCzU4+qv7MB7t4XMQqdKSx7O6RizxOub+cJ3XDSxtBZ1YmYQ
         7TlrCZ6q1OMj4TzA7+2vwqtM8A6Rj1TIYvh8g=
Received: by 10.114.94.18 with SMTP id r18mr7354524wab.188.1285542790586;
        Sun, 26 Sep 2010 16:13:10 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157266>

Also replace '|| return 1' by '&&' to allow chain of operations to be
checked for proper return status.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
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
=20
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
=20
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
=20
--=20
1.7.3.95.g14291
