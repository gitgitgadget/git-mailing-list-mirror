From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 7/7] t5520: test --[no-]autostash with pull.rebase=true
Date: Sat,  2 Apr 2016 23:28:32 +0530
Message-ID: <1459619912-5445-8-git-send-email-mehul.jain2029@gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 20:02:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amPrz-0000nx-04
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 20:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbcDBSBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 14:01:55 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36563 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbcDBSBy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 14:01:54 -0400
Received: by mail-pa0-f68.google.com with SMTP id 1so16132419pal.3
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e+g0F+ItL5yBsN/VN+S+XkhZRSrPYFA0BjQ/qaMBHGk=;
        b=oEn9MLfaW5joJ/OOb/dn4Nc/MeYl1dv3jMhtN/3CGEOkrqTNQyhwMukyv7fRRG0CCE
         WFo1lnEWoGwOlJzBDjjrgfgtmXuqW2XRCdiNhoT558dPP8Tq7nYGU8/poie4JMmVfuUQ
         o7qmq/pjahcqS6GBCBIAgtej3qIXOLdhOkDgxuT8QBrjmhLAfPLN+Lu1X2M42SxZPfoF
         U15T0rqKMynXQdPAjzAD03PnFlP8s1UX7H6u5WCKoZTd9hSiGBSi87T3/H/GmyJxKs28
         0sZdUejN8B2kNcel+S56mx6zAnvODsp5i2qVKUEXkG+5BkmJFwRwbeVSzhwrZeyAe6/M
         hVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e+g0F+ItL5yBsN/VN+S+XkhZRSrPYFA0BjQ/qaMBHGk=;
        b=kn4K1r+9ypJCfxOdR1/G4ipZ7nJZ+xudojFvt8lC8pii7ir5bJX7RsjkJMfbB/C7tK
         b0ANVo3I20zK6BlfqiZWFgza81uj347ijW3iu3VFa0jADAS3fdbibLdMzgjseIqcoTny
         1DiWYr1rRWhK/Q9sZSrUyaNS5OtpsM2ConQt9UFkAIXiIa2hnvparYTuj0aaPZXSQ/dk
         Hen2ioIh4eqLQAHk6NEQlhdHfFiAKHp/vER1zoSqfrfZDy7EGGc3dVh1/jA8uKWBEoZT
         qUwG8yFtBIdCwVDaPDUlpzNZRiumVMuEt0xySUQqfF/G1xq8lGahC/vcQk5Rcqq997Po
         y8sA==
X-Gm-Message-State: AD7BkJLhysFLKMbyE+mmPpsWWrRm7USt1fn3uU+CiI+MCQvuDuZ3SIBK0E1UvmrVdcN5RQ==
X-Received: by 10.66.122.3 with SMTP id lo3mr39990362pab.25.1459620114233;
        Sat, 02 Apr 2016 11:01:54 -0700 (PDT)
Received: from localhost.localdomain ([1.39.37.116])
        by smtp.gmail.com with ESMTPSA id v3sm30495734par.17.2016.04.02.11.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 11:01:53 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290603>

"--[no-]autostash" option for git-pull is only valid in rebase mode(
i.e. either --rebase should be used or pull.rebase=true). Existing
tests already check the cases when --rebase is used but fails to check
for pull.rebase=true case.

Add two new tests to check that --[no-]autostash option works with
pull.rebase=true.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t5520-pull.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e12af96..bed75f5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -314,6 +314,16 @@ test_expect_success 'pull.rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
+test_expect_success 'pull --autostash & pull.rebase=true' '
+	test_config pull.rebase true &&
+	test_pull_autostash --autostash
+'
+
+test_expect_success 'pull --no-autostash & pull.rebase=true' '
+	test_config pull.rebase true &&
+	test_pull_autostash_fail --no-autostash
+'
+
 test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
 	test_config branch.to-rebase.rebase true &&
-- 
2.7.1.340.g69eb491.dirty
