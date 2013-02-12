From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH/FYI v4 13/12] fixup! t/t3511: add some tests of 'cherry-pick -s' functionality
Date: Tue, 12 Feb 2013 02:17:40 -0800
Message-ID: <1360664260-11803-14-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:19:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5CxG-0003dA-53
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998Ab3BLKSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 05:18:46 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:55511 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932980Ab3BLKSo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:18:44 -0500
Received: by mail-pa0-f53.google.com with SMTP id bg4so8148pad.26
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3e/pVl2ptMIKI+c0cU15S4KDlLMm3HtTmZ/3f2q3BTs=;
        b=DJ4H+ia/W//9sEPcWkvz2B+g9uSPLcUquBXaOdmPsEqr7dZ03CSh4L6b8JU5FKHwTa
         sSsF2DGZvCTV7V8ROO2X5AQYbkaz/BsjjauHOweeBFq2WaBnXP7Z82EZI1PbMgtVak4/
         ZL2LzNxHxxfxoCFgcib1XlzRirSUNOS9xrOKSzoClfzZc7Owsxli6TO6tC1M9w7DJ0r5
         +QKf//zYm0r00ufbCN2/HY71+Vytd1+ta8YZy4x174HeJAWtNmpDIXLy4RluY2cxF1Iw
         tHle0erCZDUdIV3No61syuk1dirm/Xa1ZWgKGs2tdEnMphV7sWVpfnl6/ncvU2MYma3+
         Tnbw==
X-Received: by 10.66.72.97 with SMTP id c1mr50791538pav.48.1360664324016;
        Tue, 12 Feb 2013 02:18:44 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id l5sm73839001pax.10.2013.02.12.02.18.41
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:18:43 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216141>

---

This test tests the behavior of 'cherry-pick -s' of a commit with an empty
commit message.

I created the test when I noticed during my series that cherry-pick was
adding a sob twice when a commit with an empty commit message was
cherry-picked.

I'm not sure we should apply this though.  I'm leaning towards saying that
the 'cherry-pick -s' behavior with respect to a commit with an empty message
body should be undefined.  If we want it to be undefined then we probably
shouldn't introduce a test which would have the effect of defining it.

Junio, if you think we should apply it, it's prepared as a fixup commit and
should autosquash easily.

-Brandon

 t/t3505-cherry-pick-empty.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index a0c6e30..da4c60e 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -58,6 +58,16 @@ test_expect_success 'cherry-pick a commit with an empty message with --allow-emp
 	git cherry-pick --allow-empty-message empty-branch
 '
 
+test_expect_success 'cherry-pick a commit with an empty message with --allow-empty-message and -s' '
+	git reset --hard HEAD^ &&
+	git cherry-pick --allow-empty-message -s empty-branch &&
+	{ git show --pretty=format:%B -s empty-branch &&
+	  printf "Signed-off-by: %s <%s>\n" "$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL"
+	} >expect &&
+	git show --pretty=format:%B -s HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
 	git checkout master &&
 	echo fourth >>file2 &&
-- 
1.8.1.1.252.gdb33759
