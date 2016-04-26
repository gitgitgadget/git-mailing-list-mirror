From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/15] git submodule summary respects groups
Date: Tue, 26 Apr 2016 13:50:30 -0700
Message-ID: <1461703833-10350-13-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9wu-0006bb-3Z
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbcDZUvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:51:05 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36372 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbcDZUvC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:51:02 -0400
Received: by mail-pa0-f50.google.com with SMTP id bt5so10784334pac.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQUmuB2VqNMo9hOSpHRiX2++sP30wqdoARkt4+IO9uc=;
        b=JtlkTRKpz6mr9z9UEAjvgTOY+ctBm7Y0CQ3ACBhxv63ZOMiNvOumMnnHtFc2yLnVaJ
         ZxUoGPmPRfYnxgt0Nnz6xoI8m7I9aRuiaBd8tXojv7xwT3t7bCCVJ2jzi7vxOeVH9gCz
         Ale3APbk2hk7F+dFhBYe29gLPSqz8v/j/7hX5B1yS09tuiBrxI3LLGKuJFmgRPZdGSLp
         4rZKt9kJL6Ttx1CcVHhBjaoERyIXKweJvMxMdayf7GdxCg33p4Q5Ub8FkG6qwr3ppWB/
         KLAdeNkoXs4Ytv/Jm41zZC2STr1z0PC7PRAj+RNx+LVn+H6mv4yxz2Wi/6cCjV5mfLHj
         RZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DQUmuB2VqNMo9hOSpHRiX2++sP30wqdoARkt4+IO9uc=;
        b=IslxlMeNu6oJI5zUQl1s+xMEVoUvT3GGPYNwWsv5kB2cgcFhXvM/Wjki1KF93y38p+
         KmE3K5BBKMKiI9/GAaAWJmWIYDGYX1mO2SuOIU76H8R8lO+wVKlrIRfSus/Jlxh2PS49
         iq0mjvs7p6rVacLkZXZALrEaL/iJBiqNWN+/uuslB8fVyqKJvbHVaBv3KMzAfu0gIo6Q
         RjBgblm+rNSQnOJitdGzOnkxkjTNrOXIpe1ZNTkxNs14+CRVexh9yQ+rVikLolPscM5c
         ilU0udU08x5JKHnhfskbiGDyVFKJ1SOhlcF125Z94N47PVZJEdbv/9HeXKBczNa2+Ioe
         PeiA==
X-Gm-Message-State: AOPr4FVkqFdko727voQtuttV5sf6a5HXFy109x9wsDZn7cSg4gyaz9QLZtwUtVqxezbkrFxZ
X-Received: by 10.66.41.107 with SMTP id e11mr6585095pal.15.1461703861804;
        Tue, 26 Apr 2016 13:51:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id t1sm712213paa.17.2016.04.26.13.51.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:51:01 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292676>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh             |  5 +++++
 t/t7413-submodule--helper.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 253ad07..f065b1f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -833,6 +833,11 @@ cmd_summary() {
 		sane_egrep '^:([0-7]* )?160000' |
 		while read mod_src mod_dst sha1_src sha1_dst status sm_path
 		do
+			# ignore modules not in group
+			if ! git submodule--helper in-group $sm_path
+			then
+				continue
+			fi
 			# Always show modules deleted or type-changed (blob<->module)
 			if test "$status" = D || test "$status" = T
 			then
diff --git a/t/t7413-submodule--helper.sh b/t/t7413-submodule--helper.sh
index 39e469f..d01cdc6 100755
--- a/t/t7413-submodule--helper.sh
+++ b/t/t7413-submodule--helper.sh
@@ -226,4 +226,30 @@ test_expect_success 'git submodule update respects groups' '
 	test_cmp expect actual
 '
 
+range_back="$(echo $submodule_sha1|cut -c1-7)...$(echo $sub_priorsha1|cut -c1-7)"
+cat >expect <<-EOF
+* sub0 $range_back (1):
+  < test2
+
+* sub1 $range_back (1):
+  < test2
+
+* sub3 $range_back (1):
+  < test2
+
+EOF
+
+test_expect_success 'git submodule summary respects groups' '
+	(
+		cd super_clone &&
+		git submodule update --init &&
+		git submodule foreach "git checkout HEAD^" &&
+		git config --add submodule.defaultGroup *bit1 &&
+		git config --add submodule.defaultGroup ./sub0 &&
+		git submodule summary >../actual &&
+		git config --unset-all submodule.defaultGroup
+	) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.8.0.41.g8d9aeb3
