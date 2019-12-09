Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BD1C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313B220692
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj1Ahdzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLIQKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:10:15 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:40231 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLIQKO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:10:14 -0500
Received: by mail-wm1-f43.google.com with SMTP id t14so15540772wmi.5
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 08:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YO1x6Bl1cN8I+2lnEXNoZiGUylTf0WKPdHrCdk7M3fg=;
        b=cj1AhdznYKk0+13pUR7jog/pehlXMGTj/np0AYWA7SDWQFSELSKtQDmBrEUuKbgA4T
         7u4maIs4aw0RVoLkZBoWdV0liVZqNECaSCNLlzPRBUZ3cg9iotOboe8YdCbS2DvTN5ES
         AdaXggzC3+iefm1Vr1dyhpQ38VkHOFuk7+1VDLUx7LUTBwzUKdzkMd4DLVmEWP0ubRTE
         YmPCuwakiZOSq2Qmtv+wWAfLquPIpOsIv5g2poq/NjtrUfjxS2jaQ3+42WDFMfdNrppW
         sULrPAs0EjxgYsaUJc/pQc5DNZZ1KuebsfQf9+Q4FivGtR/5o47r9EV4pTKAQOQsF/9U
         udYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YO1x6Bl1cN8I+2lnEXNoZiGUylTf0WKPdHrCdk7M3fg=;
        b=r+jak4eJmdudw3Gi3WPgdElkBdNUMjJ5xsQzOLGAnpaSOjAn58C6neHe60V5exD87S
         ed2NopXjZOy4VmpxHQDDjhxQofZuw3w3mUDcA3N3utmmjMIO8vIcAtYF0JZBrsomozb8
         lg0KUs4vBM0lDkMDHU1TJxj7gBr+c5o4H6UFyAeb1ubDuEB0JTJt60dDm3FeMNyixfSL
         nUkaVfX8ZuIFjJiVmKL+J8Nj3CFsRXueWeOL/Phrz80GsHXSSl/Ur5CIf614qPe0dgVh
         sT9JnUi/RiIDYDtybzibDH6OUkYcm2c/ljc34m+niEzohCy2Sx0QXQPiO6JddHiLCM/p
         TpzQ==
X-Gm-Message-State: APjAAAVpx6gxI1BPuxJXRI4yUE6zQwo+JM6S/JIokgW/hLVzdxwtU5Gt
        gszslDKM2T3PQJ+UiRfwFfv4ok0n
X-Google-Smtp-Source: APXvYqy+21vr6BE1iMwUMtdjp6BewL/W/mbn1zWkXNWGw/3Imyf2xdACN8b98CLfpFbrLHGwIHkUGg==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr26360642wmc.154.1575907811962;
        Mon, 09 Dec 2019 08:10:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17sm27545001wro.77.2019.12.09.08.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:10:11 -0800 (PST)
Message-Id: <e51165f260d564ccb7a9b8e696691eccb184c01a.1575907804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
        <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 16:10:04 +0000
Subject: [PATCH v2 8/8] test-lib: clear watchman watches at test completion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The fsmonitor feature allows an external tool such as watchman to
monitor the working directory. The direct test
t7619-status-fsmonitor.sh provides some coverage, but it would be
better to run the entire test suite with watchman enabled. This
would provide more confidence that the feature is working as
intended.

When running the test suite in parallel with 'prove -j <N>', many
repos are created and deleted in parallel. When GIT_TEST_FSMONITOR
points to t/t7519/fsmonitor-watchman, this can lead to watchman
tracking many different folders, overloading its watch queue.

As a test script completes, we can tell watchman to stop watching
the directories inside the TRASH_DIRECTORY.

This is particularly important on Windows where watchman keeps an
open handle on the directories it watches, preventing them from
being deleted. There is currently a bug in watchman [1] where this
handle still is not closed, but if that is updated then these tests
can be run on Windows as well.

[1] https://github.com/facebook/watchman/issues/764

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/test-lib-functions.sh | 15 +++++++++++++++
 t/test-lib.sh           |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e0b3f28d3a..ef840ce097 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1475,3 +1475,18 @@ test_set_port () {
 	port=$(($port + ${GIT_TEST_STRESS_JOB_NR:-0}))
 	eval $var=$port
 }
+
+test_clear_watchman () {
+	if test -n "$GIT_TEST_FSMONITOR"
+	then
+		watchman watch-list |
+			grep "$TRASH_DIRECTORY" |
+			sed "s/\",//g" |
+			sed "s/\"//g" >repo-list
+
+		while read repo
+		do
+			watchman watch-del "$repo"
+		done <repo-list
+	fi
+}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 30b07e310f..4114953ebc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1081,6 +1081,10 @@ test_atexit_handler () {
 test_done () {
 	GIT_EXIT_OK=t
 
+	# If watchman is being used with GIT_TEST_FSMONITOR, then
+	# clear all watches on directories inside the TRASH_DIRECTORY.
+	test_clear_watchman
+
 	# Run the atexit commands _before_ the trash directory is
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
-- 
gitgitgadget
