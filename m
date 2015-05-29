From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 7/8] t5521: test --dry-run does not make any changes
Date: Fri, 29 May 2015 19:44:44 +0800
Message-ID: <1432899885-25143-8-git-send-email-pyokagan@gmail.com>
References: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 13:45:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyIj3-0003w7-Ft
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbbE2LpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 07:45:18 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34295 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbbE2LpP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 07:45:15 -0400
Received: by pabru16 with SMTP id ru16so56103743pab.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cWhrd1GFhnAhK7Kr/d95llWicm290xdGyuHOqxSu8B8=;
        b=vYLhpvteqDhRkTwzkf8+TesYzIRgOiJe7ZI3JItsBQ+6Rv8lP36D5J+O1cwTyJbTCm
         3VNA/hIyEvVRGBWuzWmdzy2YHw70Azh75Fw2xaMb4FHUcIhmUiMO5KTYzR6Duzf3muTQ
         tnR4GS1F7KEDzpbX7hwanH023BJDTHEyP8SrPEkiKyc95Btx5QV/J2h/GedmK+YS5knO
         GxipGVa7EFAoIoScnsWAiX7C9Fs25dl87TH/s8SFddkRHFP8wC8BAFxk2XGmXA4i3PT+
         vZ4Mdn5xMWZuOqxeXzNr+0mFLQ44UHOcM+CpDv097O8RCOcP+5ype8Cu0dXhkUDCnuMl
         Vg+A==
X-Received: by 10.66.236.226 with SMTP id ux2mr14517921pac.64.1432899914783;
        Fri, 29 May 2015 04:45:14 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qg5sm5392460pdb.13.2015.05.29.04.45.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 May 2015 04:45:13 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270231>

Test that when --dry-run is provided to git-pull, it does not make any
changes, namely:

* --dry-run gets passed to git-fetch, so no FETCH_HEAD will be created
  and no refs will be fetched.

* The index and work tree will not be modified.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

 t/t5521-pull-options.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 453aba5..56e7377 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -117,4 +117,17 @@ test_expect_success 'git pull --all' '
 	)
 '
 
+test_expect_success 'git pull --dry-run' '
+	test_when_finished "rm -rf clonedry" &&
+	git init clonedry &&
+	(
+		cd clonedry &&
+		git pull --dry-run ../parent &&
+		test_path_is_missing .git/FETCH_HEAD &&
+		test_path_is_missing .git/refs/heads/master &&
+		test_path_is_missing .git/index &&
+		test_path_is_missing file
+	)
+'
+
 test_done
-- 
2.1.4
