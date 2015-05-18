From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 7/8] t5521: test --dry-run does not make any changes
Date: Mon, 18 May 2015 21:32:57 +0800
Message-ID: <1431955978-17890-8-git-send-email-pyokagan@gmail.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:34:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLBn-0001WL-Ok
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbbERNeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:34:25 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33770 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbbERNdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:33:38 -0400
Received: by pdbqa5 with SMTP id qa5so150009425pdb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VoLfUfJJhVARKhzs6YRBg9qy7YM6h/jSTIRFyk04wxU=;
        b=LeT2GgOuiPITeYCfWgpc38Pp0L4aPH7CSFByI7itua7WvUgSn4JLYKe7FZklEn9w76
         eS1R/HbKaAavk16aVb5K70k4YR811VccRqb73VB7M7jmnz5BlsK44RZN1/WpepcCYiPM
         Nua5bzUyKJj7zDvdAE15WmZ4TtmBmH6mreglBG5xoMpi2ghHWiuAstK95uEBUhJP67YB
         kO1nCFBEQNIxU1xvuauJOeqmvBQ1E9KX5fFzAoKPGbv8vG/4/rP8blSunmIn8KOn9lTy
         jBbvChgXHwfCcIKfFn1hT7e6a9jiahJN07DJLnRzSVSSpVgfwY2wE/qTZDHTUOhAD1B3
         Klvw==
X-Received: by 10.66.154.111 with SMTP id vn15mr43697064pab.108.1431956017637;
        Mon, 18 May 2015 06:33:37 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id da2sm10119540pbb.57.2015.05.18.06.33.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:33:36 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269243>

Test that when --dry-run is provided to git-pull, it does not make any
changes, namely:

* --dry-run gets passed to git-fetch, so no FETCH_HEAD will be created
  and no refs will be fetched.

* The index and work tree will not be modified.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
* No changes

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
