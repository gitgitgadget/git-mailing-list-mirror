Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0A8C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A47207C4
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQj78+El"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgEOPAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726174AbgEOPAs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 11:00:48 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5973C05BD09
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:00:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d184so1063275pfd.4
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBJ+jPIcwuBD1JD1QVI7QJDbOjrDU1LlLEoe6rCXI8o=;
        b=jQj78+ElMOM5XVNqcB+nSMSNxYNjhToPTdsY/EOb5rBeE3zteP/3fB9sQRFEzjOWCh
         Sd2GV7TFS18vabm7bcgPqxxZZ1vLd4JiprAYNj9tkpuK/TDepTN86tFBy4gxwuEktA1v
         ISibKt8kaaT6eVCEPshy2H/7IY4RGXA9FUm93iyjw/QxXk/lix7AHF+5GH3fPWeeSqFv
         r1F9Q70gXRhikP6dl79aRxbQL6JGKNU8YWeCS7uz+JwRd41MfmNIRQCCCRuQ1RauRB/j
         SQN6PJVqW3vRUVDU61WrbAf45+nhMHvfcjrQG7bQxb3wOotZYs+SYCKYvVUFdQrmJGHj
         AViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBJ+jPIcwuBD1JD1QVI7QJDbOjrDU1LlLEoe6rCXI8o=;
        b=eSxJWiAc/uAKHsUglacuwWu/jDDlWKdE4wwLg5/e/DkBhZsuvIWE/vyaQG2W08H2ri
         FhEFNRHADSXZk/mxb5INcGswoFxMPmf/epV0k9m0CA8fLHlVeUptfOpVNELw/Zkbvtr2
         I+O1eiMU4c/OH6NmPQlP1h4OGv3SZhpQ1YStlP9MNyXP9afWWTwzDmEpNVVp0Qi68EL2
         zjHXqVJaZxW2WXVlpSXlFKzoF4jU5rP7syC9uHaZH2T9yPsZpa+h8Va/bGra5xpxO1nx
         uSPz3LJ356VP2xCtGURQ0CdfdbWh9Pe9BWZ8xEbk48+qp6IZTn4+t3dyJ34WzoEasxMV
         p3lg==
X-Gm-Message-State: AOAM530HCs+5u00dX9MNCN9HVLNn/qe2usUbu4YyfIkueFDcHNR4OzvK
        p9gPLszYEaujE4dlnKeD7B5ucQn6
X-Google-Smtp-Source: ABdhPJw1wuJ8TwAOkaV9i1dko4bEohBIXozj9oPN1Wq+Npu7CYguG1GqqPyzPCN3tgePWV4YKYYiJg==
X-Received: by 2002:a63:4f5c:: with SMTP id p28mr3576652pgl.412.1589554847425;
        Fri, 15 May 2020 08:00:47 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id g6sm1790458pjx.48.2020.05.15.08.00.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 08:00:46 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     alban.gruin@gmail.com, congdanhqx@gmail.com,
        johannes.schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH] t: move metadata into TAP test description
Date:   Fri, 15 May 2020 08:00:41 -0700
Message-Id: <20200515150041.22873-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.812.g046d49d455
In-Reply-To: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
References: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

662f9cf154 (tests: when run in Bash, annotate test failures with file
name/line number, 2020-04-11) adds metadata to the TAP output to help
identify the location of the failed test, but does it in a way that
break the TAP format and therefore confuses prove.

Move the metadata to the description to workaround the issue and
change the regex from 676eb0c1ce (ci: add a problem matcher for GitHub
Actions, 2020-04-11) to match.

Reported-by: Alban Gruin <alban.gruin@gmail.com>
---
 ci/git-problem-matcher.json | 10 +++++-----
 t/test-lib.sh               |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/ci/git-problem-matcher.json b/ci/git-problem-matcher.json
index 506dfbd97f..e10e88bba1 100644
--- a/ci/git-problem-matcher.json
+++ b/ci/git-problem-matcher.json
@@ -4,11 +4,11 @@
             "owner": "git-test-suite",
             "pattern": [
                 {
-                    "regexp": "^([^ :]+\\.sh):(\\d+): (error|warning|info):\\s+(.*)$",
-                    "file": 1,
-                    "line": 2,
-                    "severity": 3,
-                    "message": 4
+                    "regexp": "^(.*)(error|warning|info):\\([^ :]+\\.sh):(\\d+)\\)$",
+                    "file": 3,
+                    "line": 4,
+                    "severity": 2,
+                    "message": 1
                 }
             ]
         }
diff --git a/t/test-lib.sh b/t/test-lib.sh
index baf94546da..d5f59ab3bf 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -682,8 +682,8 @@ file_lineno () {
 		for i in ${!BASH_SOURCE[*]}
 		do
 			case $i,"${BASH_SOURCE[$i]##*/}" in
-			0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;;
-			*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${1+$1: }"; return;;
+			0,t[0-9]*.sh) echo "(${1+$1:}t/${BASH_SOURCE[$i]}:$LINENO)"; return;;
+			*,t[0-9]*.sh) echo "(${1+$1:}t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]})"; return;;
 			esac
 		done
 	'
@@ -734,7 +734,7 @@ test_failure_ () {
 		write_junit_xml_testcase "$1" "      $junit_insert"
 	fi
 	test_failure=$(($test_failure + 1))
-	say_color error "$(file_lineno error)not ok $test_count - $1"
+	say_color error "not ok $test_count - $1$(file_lineno error)"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	test "$immediate" = "" || { finalize_junit_xml; GIT_EXIT_OK=t; exit 1; }
-- 
2.26.2.812.g046d49d455

