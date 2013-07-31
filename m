From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 06/11] t4211: retire soon-to-be unimplementable tests
Date: Wed, 31 Jul 2013 04:15:40 -0400
Message-ID: <1375258545-42240-7-git-send-email-sunshine@sunshineco.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 10:21:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Rel-0000Tb-7C
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 10:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759249Ab3GaIVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 04:21:10 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:60549 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755988Ab3GaIQk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 04:16:40 -0400
Received: by mail-yh0-f50.google.com with SMTP id a41so220275yho.37
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 01:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=mEOTq14go5rHlcwwvmmHFCjenSEnG3U/6HyF1a/Ta0I=;
        b=QXUiCrk0ODRVdmIqJxTIojaL8jObaJ3mEp7Md+5/TAsTV6k2z8JPlzm8PBbd/AeK1q
         gjMaSnvrwOXkuxacaGH65zRPd/hkLHfuwdvu8vkaORg057KvncFMjBsdJhjrU/FEbGgs
         qfJf5ckoBd8FYeEzmvlg+M1AhYUhFnOHV59DiedRweYnaLPwmmFJaKjfgpu6ZbDDHcA5
         i0jA7SUiAhKWlpziBiL0GbCC4Oz2goWyp28l4wMf5f7ROFIkNs5TVENDC5wkHq9XLZvL
         kimhGycAAXcLGtEb9b5+RE9QFIJiF/Q9A2idcq8LVWcsSsN7sqgwm+ueZIgmV5gaRFjM
         7eKQ==
X-Received: by 10.236.85.45 with SMTP id t33mr31790533yhe.211.1375258600184;
        Wed, 31 Jul 2013 01:16:40 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id i4sm636759yhg.16.2013.07.31.01.16.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 01:16:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231410>

58960978 and 99780b0a added tests which demonstrated bugs (crashes) in
range-set and line-log when handed empty ranges specified via "log
-LX:file" where X is one greater than the last line of the file.  After
these tests were added, it was realized that the ability to specify an
empty range is a loophole due to a bug in -L bounds checking. That bug
is slated to be fixed in a subsequent patch.

Unfortunately, the closure of this loophole makes it impossible to
continue checking range-set and line-log behavior with regard to empty
ranges since there is no other way to specify empty ranges via the
command-line.  APIs of both facilities are private (file static) so
there likewise is no way to test their behaviors programmatically.
Consequently, retire these two tests.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4211-line-log.sh | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index f98275c..769ac68 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -94,17 +94,4 @@ test_expect_success '-L ,Y (Y == nlines + 2)' '
 	test_must_fail git log -L ,$n:b.c
 '
 
-# There is a separate bug when an empty -L range is the first -L encountered,
-# thus to demonstrate this particular bug, the empty -L range must follow a
-# non-empty -L range.
-test_expect_success '-L {empty-range} (any -L)' '
-	n=$(expr $(wc -l <b.c) + 1) &&
-	git log -L1,1:b.c -L$n:b.c
-'
-
-test_expect_success '-L {empty-range} (first -L)' '
-	n=$(expr $(wc -l <b.c) + 1) &&
-	git log -L$n:b.c
-'
-
 test_done
-- 
1.8.3.4.1120.gc240c48
