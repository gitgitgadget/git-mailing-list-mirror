Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC29C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A7A610E9
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbhIGNiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344029AbhIGNiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 09:38:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783B8C061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 06:36:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u9so14477554wrg.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WbsBZWVl4KvCj9IY03Gebo9jmW5xuo+m0X7mW1oG4Nk=;
        b=KxDpCA7hF+k4TeKQLTev6tZRapJAvTpESjTn1CGJjjckJh1RbJpoWlwSFRwYWVl7ii
         6amt1KG33wX7NpNmX4+ot4Wricwo4KJ7rDU7oJ4yjRCmUPPZ5XsgI4gAl7MPUkqmocaW
         6JvWyAg5PVXtlpq/B5l1WmnR/PyUXUt+jFUmOEpUzZdKW0T7lFyHGNvfL+1b/Y5cvbtd
         tDQ66uirKgtAtrjyqqnor882Ffk7R2bgrLqEihTR44dPNpGPWL7uSnhs2EiGArNlhDoq
         Dy/Y5nwbsCKWT52CLOH4De3JxcJIHX/Z4tc48vK/SPaleUnjvDli0+KWJnUjAH8b3ajP
         5hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WbsBZWVl4KvCj9IY03Gebo9jmW5xuo+m0X7mW1oG4Nk=;
        b=OUVq+S6T43vt2LKFd4FMMq8zfyEj8AeEhhPl2sLw6hjeRUFQe0JfEDOWVLtNObsiOE
         K8VOxBbseP3jIEiLqWnNzB5lnqRmqdNc8E2U/PSH2RQikjJhCf7y9Whkr5LkXD70ZxlD
         Jx6mMflMhtmT0Wxqe0taBJu3p01x1SAycrunVdm2IGd/RP8xoXojtPcd0M8s/wxvzXHv
         j45EUWjJzfT8jT6xng0m9vap5MgNZzfK1+GmX+ZpMPiROXRxf0bKCiPk8Zfky97Xnl8r
         TIJd6l59ruF21dr50P5I7DfSMNtu5k+a7m39y+AeHKlC2PL0Pa/nJWeskcAM59toz1bT
         eHJw==
X-Gm-Message-State: AOAM5321XnPim4K3jIVkObmAo/WbIIZKVMe9ieVK7JnGmPrrjalqL8Rh
        18knyXa65+Z1WlhjWMbB3u77S0FquAY=
X-Google-Smtp-Source: ABdhPJxi4mgtVWGH740U2ZWdxV0lsGnHYuhO2L1ukovCf0nnTHPjM1S88IgtRmbUBscJQMWJbZGDaA==
X-Received: by 2002:a5d:464c:: with SMTP id j12mr19374291wrs.27.1631021810137;
        Tue, 07 Sep 2021 06:36:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm13896025wrv.18.2021.09.07.06.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:36:49 -0700 (PDT)
Message-Id: <e158882812fef0c6a69fb0bc1ff5d46f38906426.1631021808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
        <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 13:36:42 +0000
Subject: [PATCH v3 1/7] show-branch: show reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Before, --reflog option would look for '\t' in the reflog message. As refs.c
already parses the reflog line, the '\t' was never found, and show-branch
--reflog would always say "(none)" as reflog message

Add test.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/show-branch.c  | 12 +++++++-----
 t/t3202-show-branch.sh | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d77ce7aeb38..902a0d99850 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -762,6 +762,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			char *logmsg;
 			char *nth_desc;
 			const char *msg;
+			char *end;
 			timestamp_t timestamp;
 			int tz;
 
@@ -771,11 +772,12 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				reflog = i;
 				break;
 			}
-			msg = strchr(logmsg, '\t');
-			if (!msg)
-				msg = "(none)";
-			else
-				msg++;
+
+			end = strchr(logmsg, '\n');
+			if (end)
+				*end = '\0';
+
+			msg = (*logmsg == '\0') ? "(none)" : logmsg;
 			reflog_msg[i] = xstrfmt("(%s) %s",
 						show_date(timestamp, tz,
 							  DATE_MODE(RELATIVE)),
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index ad9902a06b9..d4d64401e4b 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -4,6 +4,9 @@ test_description='test show-branch'
 
 . ./test-lib.sh
 
+# arbitrary reference time: 2009-08-30 19:20:00
+GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
+
 test_expect_success 'setup' '
 	test_commit initial &&
 	for i in $(test_seq 1 10)
@@ -146,4 +149,16 @@ test_expect_success 'show branch --merge-base with N arguments' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show branch --reflog=2' '
+	sed "s/^>	//" >expect <<-\EOF &&
+	>	! [refs/heads/branch10@{0}] (4 years, 5 months ago) commit: branch10
+	>	 ! [refs/heads/branch10@{1}] (4 years, 5 months ago) commit: branch10
+	>	--
+	>	+  [refs/heads/branch10@{0}] branch10
+	>	++ [refs/heads/branch10@{1}] initial
+	EOF
+	git show-branch --reflog=2 >actual &&
+	test_cmp actual expect
+'
+
 test_done
-- 
gitgitgadget

