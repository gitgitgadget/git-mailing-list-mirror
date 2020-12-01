Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93919C63777
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545D520809
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyYQQ2Vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389162AbgLAArj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389150AbgLAArj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 19:47:39 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6FAC0617A6
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:46:59 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id l20so17882oot.3
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4ApOr0TN5Ls6zxLxW5FNxUuULjVWpIh3mM0eEFSUWE=;
        b=eyYQQ2VcHgRlmXckWGooRS+Gt7t4791A0guNvDQEsnmOIxH7sZ93i9Cd2m/qZ3T7jo
         +UVr+o/8eYYccwZtByaNXAK004nPkClptQXj26I6nGqEjFb/ZwDCnxIrTC9HlaNYBnaK
         hROMMxJQ+7f7HuVbTX3TBGZbJGj7EhTb2xpKZUwiRTYvKouk8VIGgEzf8SZhZsdKl1Mf
         JaZboDKwQXsbf+0DXkQ5gCq5Q/i7B5p9sCe74aXJEvwZhGl/FyxhnJVIsVJpbMtFn2Oo
         HlVgtcdgONJkJGHASp6iqahFOd6WVZYyzazhpbLMzyFcuyO3yksaR8AWE2sytNKpwnjC
         NxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4ApOr0TN5Ls6zxLxW5FNxUuULjVWpIh3mM0eEFSUWE=;
        b=sjk8LQDcGgBly2cBLGHwpomjijZrLPYlfy3TB+1+HUK7wl2o2sf3o5A4czCAJmwQ7x
         QXYNxq3m5oKLgEaWb/Nks5+YeX8OoXXwJVrr8kO8+V8AOB63+Cool3NoZgrNXnmPCaE6
         v0SXik6WR0+aesBQh5KAi8rKnBFIrUxz290MjojZ2VyIv48jd/9ViNCqL3xVU7yo1CF6
         y6AM54yv+lSSzhgubnBKhVT30cG11sH04k9ABPkQ+GqMbflznHsr2IQV7pzySRlPbHw7
         5KReqTUKn4ymiT/K8EWComys7L936hXsplEXQrEhXENJCSCXVipBhN68Q7b0Xt4mdwb5
         LkJg==
X-Gm-Message-State: AOAM531AE0cmxDPtLIWdk9RFcYchIb/xpuLxzjMtmwkrsNABkWNNq/lu
        5AEIqE7P3JXUQqgw1QhN1kva1BzO6LDDEg==
X-Google-Smtp-Source: ABdhPJxxHsec08digfoAe7ETHJhSV72NmQhiETG+/SYz3IWuZEVJT/ENDnflA9bnXrboJGXb21yu7g==
X-Received: by 2002:a05:6820:104d:: with SMTP id x13mr213785oot.41.1606783618634;
        Mon, 30 Nov 2020 16:46:58 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r4sm996otd.66.2020.11.30.16.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:46:58 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] tests: lib-functions: trivial style cleanups
Date:   Mon, 30 Nov 2020 18:46:49 -0600
Message-Id: <20201201004649.57548-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201004649.57548-1-felipe.contreras@gmail.com>
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/test-lib-functions.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 7ba3011b90..a791f2f1d6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -955,7 +955,7 @@ test_expect_code () {
 # - cmp's output is not nearly as easy to read as diff -u
 # - not all diff versions understand "-u"
 
-test_cmp() {
+test_cmp () {
 	eval "$GIT_TEST_CMP" '"$@"'
 }
 
@@ -968,7 +968,7 @@ test_cmp() {
 #
 #    test_cmp_config foo core.bar
 #
-test_cmp_config() {
+test_cmp_config () {
 	local GD &&
 	if test "$1" = "-C"
 	then
@@ -984,7 +984,7 @@ test_cmp_config() {
 
 # test_cmp_bin - helper to compare binary files
 
-test_cmp_bin() {
+test_cmp_bin () {
 	cmp "$@"
 }
 
@@ -1418,7 +1418,7 @@ nongit () {
 # whitespace and put in a single packet. Note that data containing NULs must be
 # given on stdin, and that empty input becomes an empty packet, not a flush
 # packet (for that you can just print 0000 yourself).
-packetize() {
+packetize () {
 	if test $# -gt 0
 	then
 		packet="$*"
-- 
2.29.2

