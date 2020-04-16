Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB223C3815B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 20:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04CE21BE5
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 20:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFpQqP/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgDPUTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730055AbgDPUTr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 16:19:47 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D6C0610D6
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 13:14:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id r7so3017716edo.11
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wMWAdJaDoesQ7l4YrmZbXUqFvfIk/aDRRi7TZz1QS+k=;
        b=IFpQqP/JEp1d7SC8ugVt9TBRH/A1hxyAswWDtbllHLraoOiTLoei+wyrAIxsD7DLf0
         KVQDW7WZ6M0nCElO9VxrVFop3p4E8rmo4LyXJHdWEDLs8GJyyKtmZ6nuZqaNHLQ2FCkS
         jmA+q6V77KetHmXGsP0ZfbN7+XgCRELEMWZb2CHxFgm4LiZK2akyBI5NkswWjHQhARIu
         j0RSHkiW7y62Sw8xpYddyf9JdoA6oq/wPi4dRhxEFdmCpnw77YuFHH1byTzyRpMvLKgx
         w5WmhHLCe7tOu2TGtGNIAoLUHFkbQXw9l0ASFWPdYuQP0yAhQWE5j70acJKfBpJMQMuO
         PayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wMWAdJaDoesQ7l4YrmZbXUqFvfIk/aDRRi7TZz1QS+k=;
        b=CX12ek3PS2fzCJpBF5UJWh9XaQ8v9IWScuuFd2WVClJgqH/7PAnShKgC2jFbyaqr6x
         CFKzUyllcp9cpX6vnfozOLIcHfSdSEtwdQALUDibS2cmEX1kKlAf/aiv1O8R7bFm8bSe
         2n5KvzxmuYi0Tb+R4oCzNPPgGx01F1t3v5KQw5pyucEWzhVMWf8k4lSjbs8IYcrlmgjw
         NyT1ZMwMeOGKui8To6jyLiwIRMtcjDMPVpBpZIQUWBHHU0wDc7yMR7ZB9nkf61vWB8yf
         B3RHSUlwlxZg52NjpKcV/EW1I1i9+0xsWx1uQLAl115MGs8KWfGCtIaQl6tr7dF6k11E
         q4Iw==
X-Gm-Message-State: AGi0PubGnu8tBZQJqGYW2OG5zx2eOT+bQ37Hf0AMg5mDAcHPP8phLeun
        Hk+0RBkDWJpXM/XdMN1KNhX7s9nM
X-Google-Smtp-Source: APiQypJxIxJOiMaWN3SO8M/6b40hSAkXoTXYg6/p7P8HmbycEQgylAFVXGD5ll1bAfRoXxJ8sWgZSw==
X-Received: by 2002:aa7:d1d6:: with SMTP id g22mr10343364edp.36.1587068046340;
        Thu, 16 Apr 2020 13:14:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13sm2657445edj.0.2020.04.16.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:14:05 -0700 (PDT)
Message-Id: <adc03eee4ac8a0911bfd2a7ae03364ef0e744ef0.1587068044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.609.v3.git.1587068044.gitgitgadget@gmail.com>
References: <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
        <pull.609.v3.git.1587068044.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Apr 2020 20:14:02 +0000
Subject: [PATCH v3 1/3] revision: complicated pathspecs disable filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The changed-path Bloom filters work only when we can compute an
explicit Bloom filter key in advance. When a pathspec is given
that allows case-insensitive checks or wildcard matching, we
must disable the Bloom filter performance checks.

By checking the pathspec in prepare_to_use_bloom_filters(), we
avoid setting up the Bloom filter data and thus revert to the
usual logic.

Before this change, the following tests would fail*:

	t6004-rev-list-path-optim.sh (Tests 6-7)
	t6130-pathspec-noglob.sh (Tests 3-6)
	t6131-pathspec-icase.sh (Tests 3-5)

*These tests would fail when using GIT_TEST_COMMIT_GRAPH and
GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS except that the latter
environment variable was not set up correctly to write the changed-
path Bloom filters in the test suite. That will be fixed in the
next change.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2b06ee739c8..f78c636e4d0 100644
--- a/revision.c
+++ b/revision.c
@@ -650,6 +650,20 @@ static void trace2_bloom_filter_statistics_atexit(void)
 	jw_release(&jw);
 }
 
+static int forbid_bloom_filters(struct pathspec *spec)
+{
+	if (spec->has_wildcard)
+		return 1;
+	if (spec->nr > 1)
+		return 1;
+	if (spec->magic & ~PATHSPEC_LITERAL)
+		return 1;
+	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
+		return 1;
+
+	return 0;
+}
+
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	struct pathspec_item *pi;
@@ -659,7 +673,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	int len;
 
 	if (!revs->commits)
-	    return;
+		return;
+
+	if (forbid_bloom_filters(&revs->prune_data))
+		return;
 
 	repo_parse_commit(revs->repo, revs->commits->item);
 
-- 
gitgitgadget

