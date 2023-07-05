Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E236AEB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 18:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjGESlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGESlK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 14:41:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A91130
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 11:41:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so10916553e87.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688582466; x=1691174466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzvaGY9E50a3Fhf1UsaJTlMCJ8DJMlRo602Xhr0nx6w=;
        b=e4JDueDdhf7Lp6E/gualFC2AAnGjkNqvUc7kiit59MMDL837OVoJY0Ip+644xmlzTM
         yPzNmjl960kUMtugaO2LAw4LHtCeBmKcHLNIDPPMToYc8PjTk5Q8g/H8PC30HXknDnO0
         nS35x+e8KlXjVO7twAjU5ZB8Zy0TCJGkhCEK/q2UjNGLqUOr5cWjtvx0FOqMtZjWjOhI
         7D+a4v1DiQlqkvXb8evZKpkLm6I3ulnHasUqnANqj6/3KleKGwDAXRKqJJWQXSRwshzv
         36hsTs6M40blme/O8+Mzp5GVt3nOmT1J6oQm7qPtrF8CVT1H9mEVf9tnlbXZefdoJTNe
         T3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688582466; x=1691174466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzvaGY9E50a3Fhf1UsaJTlMCJ8DJMlRo602Xhr0nx6w=;
        b=BlBUqVW7iTiVLbOE6SRACv71t5ZguVChGKD1DpvWJCFSqdCsU9Mj6fKTZsxV2qpHn5
         FkQJlKLLmj0y8u3u9pTONwdj+lytOPd9kuwiHXNAejfVCWaALiTNU+2bEGYBHp4Qffnw
         bR2khcTpf0JolrWIiIUeptYGm1oTKqZCMtIkVTWsgI9E54YZ2i1ncwIuLGzVjmNxl65o
         Pfja0AHrtlaDYkmMJlBYBEbTCb7SrAzc9wZhAo1KE86yL5EtA58Z/HVGamsMhHi1XQOT
         Eoma/siiu1ntXmKF+w8pxL6VKtzdkmN1J9S+P47clKMl0TxsEx1SBJjbknqGHS8pggUb
         Eipg==
X-Gm-Message-State: ABy/qLbf3nhIa0tvGr8idfRFlKsQMQS03UrgO0qLR89sLSkjOrPQR/AH
        c+jLqWVVjzv+Kg27GtVkMjN9iWcD9bA=
X-Google-Smtp-Source: APBJJlEOa9dDKRsuyL+YjQuocGH0R6m/sxYNtyu7U5JYiIX6LXlOmfu96AOFtstE40UNKeKwa6SVnw==
X-Received: by 2002:a05:6512:3c90:b0:4f9:5622:4795 with SMTP id h16-20020a0565123c9000b004f956224795mr14465526lfv.42.1688582465603;
        Wed, 05 Jul 2023 11:41:05 -0700 (PDT)
Received: from localhost.localdomain (2-248-185-180-no600.tbcn.telia.com. [2.248.185.180])
        by smtp.gmail.com with ESMTPSA id d20-20020ac24c94000000b004fbab80ecefsm2647522lfl.145.2023.07.05.11.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 11:41:04 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3] t0091-bugreport.sh: actually verify some content of report
Date:   Wed,  5 Jul 2023 20:40:57 +0200
Message-ID: <20230705184058.3057709-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.41.0.404.g5b50783d6b
In-Reply-To: <CAN0heSrMCnygWUC5Sh1UA9v2JGtjcxYDKPFE0xUPddGEW29c3w@mail.gmail.com>
References: <CAN0heSrMCnygWUC5Sh1UA9v2JGtjcxYDKPFE0xUPddGEW29c3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the first test in this script, 'creates a report with content in the
right places', we generate a report and pipe it into our helper
`check_all_headers_populated()`. The idea of the helper is to find all
lines that look like headers ("[Some Header Here]") and to check that
the next line is non-empty. This is supposed to catch erroneous outputs
such as the following:

  [A Header]
  something
  more here

  [Another Header]

  [Too Early Header]
  contents

However, we provide the lines of the bug report as filenames to grep,
meaning we mostly end up spewing errors:

  grep: : No such file or directory
  grep: [System Info]: No such file or directory
  grep: git version:: No such file or directory
  grep: git version 2.41.0.2.gfb7d80edca: No such file or directory

This doesn't disturb the test, which tugs along and reports success, not
really having verified the contents of the report at all.

Note that after 788a776069 ("bugreport: collect list of populated
hooks", 2020-05-07), the bug report, which is created in our hook-less
test repo, contains an empty section with the enabled hooks. Thus, even
the intention of our helper is a bit misguided: there is nothing
inherently wrong with having an empty section in the bug report.

Let's instead split this test into three: first verify that we generate
a report at all, then check that the introductory blurb looks the way it
should, then verify that the "[System Info]" seems to contain the right
things. (The "[Enabled Hooks]" section is tested later in the script.)

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 (Resend of v3, now with correct In-Reply-To.)

 t/t0091-bugreport.sh | 67 +++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index b6d2f591ac..f6998269be 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -5,29 +5,50 @@ test_description='git bugreport'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-# Headers "[System Info]" will be followed by a non-empty line if we put some
-# information there; we can make sure all our headers were followed by some
-# information to check if the command was successful.
-HEADER_PATTERN="^\[.*\]$"
-
-check_all_headers_populated () {
-	while read -r line
-	do
-		if test "$(grep "$HEADER_PATTERN" "$line")"
-		then
-			echo "$line"
-			read -r nextline
-			if test -z "$nextline"; then
-				return 1;
-			fi
-		fi
-	done
-}
-
-test_expect_success 'creates a report with content in the right places' '
-	test_when_finished rm git-bugreport-check-headers.txt &&
-	git bugreport -s check-headers &&
-	check_all_headers_populated <git-bugreport-check-headers.txt
+test_expect_success 'create a report' '
+	git bugreport -s format &&
+	test_file_not_empty git-bugreport-format.txt
+'
+
+test_expect_success 'report contains wanted template (before first section)' '
+	sed -ne "/^\[/q;p" git-bugreport-format.txt >actual &&
+	cat >expect <<-\EOF &&
+	Thank you for filling out a Git bug report!
+	Please answer the following questions to help us understand your issue.
+
+	What did you do before the bug happened? (Steps to reproduce your issue)
+
+	What did you expect to happen? (Expected behavior)
+
+	What happened instead? (Actual behavior)
+
+	What'\''s different between what you expected and what actually happened?
+
+	Anything else you want to add:
+
+	Please review the rest of the bug report below.
+	You can delete any lines you don'\''t wish to share.
+
+
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'sanity check "System Info" section' '
+	test_when_finished rm -f git-bugreport-format.txt &&
+
+	sed -ne "/^\[System Info\]$/,/^$/p" <git-bugreport-format.txt >system &&
+
+	# The beginning should match "git version --build-info" verbatim,
+	# but rather than checking bit-for-bit equality, just test some basics.
+	grep "git version [0-9]." system &&
+	grep "shell-path: ." system &&
+
+	# After the version, there should be some more info.
+	# This is bound to differ from environment to environment,
+	# so we just do some rather high-level checks.
+	grep "uname: ." system &&
+	grep "compiler info: ." system
 '
 
 test_expect_success 'dies if file with same name as report already exists' '
-- 
2.41.0.404.g5b50783d6b

