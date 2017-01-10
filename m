Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961AD20A93
	for <e@80x24.org>; Tue, 10 Jan 2017 20:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbdAJUnR (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:43:17 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35982 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdAJUmo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:44 -0500
Received: by mail-qt0-f173.google.com with SMTP id k15so406886793qtg.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cwUzlLQ2w9Bdl/Yf+LME4hLf5zU26LVuq2kROZKo59s=;
        b=HO+FzNxWLu+6gqky8wJaY8W//auUas9xz2ft9J5/hutW18VKaTjN+K9RovVX5EBzPL
         MkywiE2rhIdRr5bpDdEpFfDW7byOfZleI1PORAQQUlazZsN1Uz4jd81IpAx1lDhjNJD3
         JcXsIwcClHIFgnW/ejoVS1zZ3mAB/8fGOHNKNMwxWzTC6rhuQFjKPg/woEssrCPK8ads
         CbBYldiosUs44qF6xzXxRi5jqe1RC+dRoTlWStXFvAK9SisIzTsEGgqK2vjxZrSK2WZ5
         +otcdpZRzvOXkNoCZUK4Sfe+dBPY6iVjPMTdf3tNyPiYwScDsvKX355xBMvzFxGTSPiB
         pI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cwUzlLQ2w9Bdl/Yf+LME4hLf5zU26LVuq2kROZKo59s=;
        b=OrVFxj5ipLB7fk2m0IO13S/RwW8vsIE0di0XS7m0j85YCdppezRWdsJ8qUTWJaxcZz
         JYNFb4Ix9+Id3N0CCdvwWncris/r9DUjrmYfCKqq3SSyF3A9vorIoxBWsSYE/G0fZfnn
         yyt8BSyH5NqifB6e0NbmUxTNGBTaosr05btlbHdBwxrCDnJleTzaC2DPyuL3pHjfv7Xu
         K21siInjNZgDqYNoPku+2avdrtA220Esn5+vnNR0Zs6IzgQuetyzuiL7EhEk0U1BkcyP
         SXfPhFZu+DNLE9PVjYff6bQKm0keUzzy8A/FnXgvVAMfXdJ3C9o3vhgxe6iabRi2Giuw
         5qGQ==
X-Gm-Message-State: AIkVDXJZ5NvQAsMXR262FVdYwoY9+CtQL0NdO1abQR8OvT2aRdlr/q34pywocNEWlwzEsjNS
X-Received: by 10.200.36.166 with SMTP id s35mr4634626qts.6.1484080963370;
        Tue, 10 Jan 2017 12:42:43 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:42 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 06/14] t7610: don't rely on state from previous test
Date:   Tue, 10 Jan 2017 15:41:54 -0500
Message-Id: <20170110204202.21779-7-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the repository must be in a particular state (beyond what is
already done by the 'setup' test case) before the test can run, make
the necessary repository changes in the test script even if it means
duplicating some lines of code from the previous test case.

This is a step toward making the tests more independent so that if one
test fails it doesn't cause subsequent tests to fail.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index f62ceffdc..2d92a2646 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -181,8 +181,12 @@ test_expect_success 'mergetool in subdir' '
 '
 
 test_expect_success 'mergetool on file in parent dir' '
+	git reset --hard &&
+	git submodule update -N &&
 	(
 		cd subdir &&
+		test_must_fail git merge master >/dev/null 2>&1 &&
+		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
 		( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
 		( yes "" | git mergetool ../file2 ../spaced\ name >/dev/null 2>&1 ) &&
 		( yes "" | git mergetool ../both >/dev/null 2>&1 ) &&
@@ -651,6 +655,8 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
+	echo b >order-file &&
+	echo a >>order-file &&
 	test_must_fail git merge order-file-side1 &&
 	cat >expect <<-\EOF &&
 		Merging:
-- 
2.11.0.390.gc69c2f50cf-goog

