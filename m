Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E8C34055
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E6E2465D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBtkl4M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgBSQV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:21:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43181 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgBSQV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 11:21:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so1209441wrq.10
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZaV+f3N3NLhoX3MRcHYiDxFDwVds7NM2PMz6oDgoBNk=;
        b=QBtkl4M756UAgAZHkqXHd37qXHdRzxmyoRt3TXv+zaWbXPqQ6anoNIOWI4aStqnF3r
         LvQdXPh81g5u8h1d8DTosVNfRF+utnKgIyMEWp4c2sCHqJtvKngG8uoZN/fWEEUV8jvW
         99dVG/R1udPLohMHNP9hmV6YxIIWBOmPekfT7Z1HsKE+zY8Rh7NXaNAH15kJmYmJrXCl
         ZOV3rPslELK/JSaXjyq577Y7g4bo3EbOnH6YuG+x+FacatKC+yC/9hB9hjFu+NZi9BS0
         4ketcyswzs8J6KWBhHv0Vm1TX9LpYuq1xRr/Gfks4vstq3NLJBeYJizl3zHBRrclbsVi
         bWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZaV+f3N3NLhoX3MRcHYiDxFDwVds7NM2PMz6oDgoBNk=;
        b=N9XWlvBPsEcFxQtY9yPTKxQmRZMaCg74TJxMNdtJin1I7Sbm9T0zQ/oSHhRH4Xud8T
         TJIPj0e0P2CKDXpB8LXAMkR410CX9SLrhyxlvr3SgOvk7HZGWHPRAKfADg+7mf3P5hmG
         n7cqWsK660OMg7c+oa375ZP7JwDf3ycnUiidBWx/w3fFC7IEgwfrqWBabrM12vIc/fbp
         y0rfq1qPMI5XPm8vSIFNNuXVbnZRwAzIko2XdosjM8gHYZzgaq3wj6VzfJd1AaaPq5fY
         C+U8z09IkbGA0Y/tEdEaFt4HhTKeJV6ZnqPZPzJrGwzmMEyliZcs+Z+m5SX888PzMzVF
         hbvw==
X-Gm-Message-State: APjAAAUb048sepxFa6ts5C/PD+qd0d77yC18wTHi8/cP3r+3TZynoW/U
        8ZEblt/kfkMaaJBwLPNYI6J0JHsP
X-Google-Smtp-Source: APXvYqy5HOCKHFVPVzM+YVuNxMhz4fwXQn1GYOBigXq5/HqTkuyMzwxdwNWM39i4Q6UokDSLU5nCIA==
X-Received: by 2002:adf:e692:: with SMTP id r18mr37061939wrm.413.1582129314567;
        Wed, 19 Feb 2020 08:21:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y17sm252222wrs.82.2020.02.19.08.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:21:54 -0800 (PST)
Message-Id: <dbc1bdcae16f8b9941add514264b0fe04cda48c0.1582129312.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.556.git.1582129312.gitgitgadget@gmail.com>
References: <pull.556.git.1582129312.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 16:21:51 +0000
Subject: [PATCH 1/2] partial-clone: demonstrate bugs in partial fetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, jonathantanmy@google.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While testing partial clone, I noticed some odd behavior. I was testing
a way of running 'git init', followed by manually configuring the remote
for partial clone, and then running 'git fetch'. Astonishingly, I saw
the 'git fetch' process start asking the server for multiple rounds of
pack-file downloads! When tweaking the situation a little more, I
discovered that I could cause the remote to hang up with an error.

Add two tests that demonstrate these two issues.

In the first test, we find that when fetching with blob filters from
a repository that previously did not have any tags, the 'git fetch
--tags origin' command fails because the server sends "multiple
filter-specs cannot be combined".

In the second test, we see that a 'git fetch origin' request with
several ref updates results in multiple pack-file downloads. This must
be due to Git trying to fault-in the objects pointed by the refs. What
makes this matter particularly nasty is that this goes through the
do_oid_object_info_extended() method, so there are no "haves" in the
negotiation. This leads the remote to send every reachable commit and
tree from each new ref, providing a quadratic amount of data transfer!
This test is fixed if we revert 6462d5eb9a (fetch: remove
fetch_if_missing=0, 2019-11-05), but that revert causes other test
failures. The real fix will need more care.

The tests are ordered in this way because if I swap the test order the
tag test will succeed instead of fail. I believe this is because somehow
we need the srv.bare repo to not have any tags when we clone, but then
have tags in our next fetch.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5616-partial-clone.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index fea56cda6d3..ed2ef45c37a 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -374,6 +374,32 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 	grep "want $(cat hash)" trace
 '
 
+test_expect_failure 'verify fetch succeeds when asking for new tags' '
+	git clone --filter=blob:none "file://$(pwd)/srv.bare" tag-test &&
+	for i in I J K
+	do
+		test_commit -C src $i &&
+		git -C src branch $i
+	done &&
+	git -C srv.bare fetch --tags origin +refs/heads/*:refs/heads/* &&
+	git -C tag-test fetch --tags origin
+'
+
+test_expect_failure 'verify fetch downloads only one pack when updating refs' '
+	git clone --filter=blob:none "file://$(pwd)/srv.bare" pack-test &&
+	ls pack-test/.git/objects/pack/*pack >pack-list &&
+	test_line_count = 2 pack-list &&
+	for i in A B C
+	do
+		test_commit -C src $i &&
+		git -C src branch $i
+	done &&
+	git -C srv.bare fetch origin +refs/heads/*:refs/heads/* &&
+	git -C pack-test fetch origin &&
+	ls pack-test/.git/objects/pack/*pack >pack-list &&
+	test_line_count = 3 pack-list
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

