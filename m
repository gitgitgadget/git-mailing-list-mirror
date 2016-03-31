From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] recursive submodules: test for relative paths
Date: Wed, 30 Mar 2016 17:17:34 -0700
Message-ID: <1459383457-6848-2-git-send-email-sbeller@google.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
Cc: norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 02:17:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alQJ4-00052A-Jm
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 02:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbcCaARq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 20:17:46 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33308 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbcCaARq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 20:17:46 -0400
Received: by mail-pa0-f53.google.com with SMTP id zm5so52626144pac.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 17:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tcMeryC8px69a2w9xm4CAOfM6jFYVpGChh9D2Q4suOU=;
        b=ndH+nEQxPbJE/lU8hxUggzktfkBXtmvg0I/9LMEGGK8LbpR5N7tcGvpWcEM/u30K4H
         0NwseOvkIDVWub6GrfQlg+GWEqTVBV0TB7Eh13sit57IajoQqi/vVwpdT4WPxr1JH3Ur
         FrJ1JihCJQc3kp98D/M3bepWXM5tmB/p9eB2T07VAUmxUrSJoASEn4p5vy2RW6jUBb2x
         wjKa+Ma+Is7edOXhfNSxZZRrgEC7qM2PB1yX4jbBLla6NiBmNEv7dUGSRqmO3dw3jRvr
         cpg3S928fwEjZDJCTeBPVlUv9BnwmW12SHf0Jh43M8gdoQDTLdNcmev9pmhOlSo2WR1+
         81Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tcMeryC8px69a2w9xm4CAOfM6jFYVpGChh9D2Q4suOU=;
        b=X13e06PMnF1WMJpFLC+/+zJXCbHh/7egHJcXn053E6s87kaWGNUnRKn62DWnLmUcj0
         uCz23i44xOoPcIOZ/yJ2zGifKWIKa/zMf0ZGk6oHdWRSEbbHaEyao+fuGICrqotdtMYf
         d7/Z3ZI16y5KeJAwD01pKhtwZAp+9V3C6ooABySIg0m5+3jg9UW7sCUVvzWzvO/ygCrI
         dxsucLAVbvZCHwqysTwLR35mNAmdOojip8OWcqJN1JQGhZNwCbooncgjVyP0zZDfzpgX
         1m6Kag0wveL6Mc+H3l+giC6ZqHptu5L9G3Q1NYzaZIiFz9DqCMHw+ZFcS24bwblCOCRw
         gA0Q==
X-Gm-Message-State: AD7BkJISvDkLxMcx5hkaKq/VOwn79FT8BEk0nmx+HO/mKce6kFLk4rQB8Rb5EoGqvo00PDJG
X-Received: by 10.66.101.35 with SMTP id fd3mr17323809pab.7.1459383465096;
        Wed, 30 Mar 2016 17:17:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id yj1sm8531300pac.16.2016.03.30.17.17.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 17:17:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g4004fdc.dirty
In-Reply-To: <1459383457-6848-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290359>

This was reported as a regression at $gmane/290280. The root cause for
that bug is in using recursive submodules as their relative path handling
seems to be broken in ee8838d (2015-09-08, submodule: rewrite
`module_clone` shell function in C).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7400-submodule-basic.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 540771c..fc11809 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -818,6 +818,47 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
 	)
 '
 
+test_expect_failure 'recursive relative submodules stay relative' '
+	test_when_finished "rm -rf super clone2 subsub sub3" &&
+	mkdir subsub &&
+	(
+		cd subsub &&
+		git init &&
+		>t &&
+		git add t &&
+		git commit -m "initial commit"
+	) &&
+	mkdir sub3 &&
+	(
+		cd sub3 &&
+		git init &&
+		>t &&
+		git add t &&
+		git commit -m "initial commit" &&
+		git submodule add ../subsub dirdir/subsub &&
+		git commit -m "add submodule subsub"
+	) &&
+	mkdir super &&
+	(
+		cd super &&
+		git init &&
+		>t &&
+		git add t &&
+		git commit -m "initial commit" &&
+		git submodule add ../sub3 &&
+		git commit -m "add submodule sub"
+	) &&
+	git clone super clone2 &&
+	(
+		cd clone2 &&
+		git submodule update --init --recursive &&
+		echo "gitdir: ../.git/modules/sub3" >./sub3/.git_expect &&
+		echo "gitdir: ../../../.git/modules/sub3/modules/dirdir/subsub" >./sub3/dirdir/subsub/.git_expect
+	) &&
+	test_cmp clone2/sub3/.git_expect clone2/sub3/.git &&
+	test_cmp clone2/sub3/dirdir/subsub/.git_expect clone2/sub3/dirdir/subsub/.git
+'
+
 test_expect_success 'submodule add with an existing name fails unless forced' '
 	(
 		cd addtest2 &&
-- 
2.5.0.264.g4004fdc.dirty
