Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2649EC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 22:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACA22076D
	for <git@archiver.kernel.org>; Wed,  6 May 2020 22:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWTpXrgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgEFWHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 18:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728621AbgEFWHr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 18:07:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611F5C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 15:07:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h129so4372073ybc.3
        for <git@vger.kernel.org>; Wed, 06 May 2020 15:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ygLgYb/7S5E0HyzXwYUoWMmxhfqdVj1JKV+vM5kDEj4=;
        b=OWTpXrgxt1QiqSNTvUArZpKYsHSrtLoJsWUCcu/34I5b5qlNxZV/o84AIW0/mwBqba
         0oquIAwMOuOmcLNuas8F2Rv92D74wIS3tFpFY2m/XBgZV2kXT/RCuXjmy0PaHMT7Sh8Z
         /lhViZgl2o+vXAtZh/UgtXzHwuApnWwyqHPjPOwUgffsejz0VGg1FcPHp4jyEb3DwAgL
         /zPBcFFQLYYQAle5tAotYgidbVLGRxlmUwmjjYxQLRC68cKVOzJ9Tl2pHJIDn2+R5v6d
         Tf+FdqwoivBFqGmo4WttDv19qN0Z7gRaf1z1EQPzr9bls2RWn1/mPe8Z1LP7u1jS0oYw
         umZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ygLgYb/7S5E0HyzXwYUoWMmxhfqdVj1JKV+vM5kDEj4=;
        b=RxvLtufwAJIiaEDh8Wlk9J4SHPsmEDQkuT/yruKX0szY2xVCKHmtvd9I83x7n+Vjfa
         WSAunkxcj2XNfNRq+a0Mrvd0IT4C1mRMkdvUMbSnyEQ1/Zk9AzjyoGUmHzsDTY9jwrBQ
         1Avi1vN+ECINqsS+dHG012oGOIP0kPrg8EpCQu0awL8rxhSz4MoDKdqt7Sns+spClfTL
         ufdxEE4qQ3wb49LjAz3bDcB1L3oH8v/EY9e+9wkMbT/fol+H88cvtI0JtJlmrTeWKsI9
         CiL/PCCLr0WvjhrOzSvXeZKGQu7Hgh4N8K+RN7F/Nn2WZWLiGV4EfhE7bMS70RsTEG7A
         qmsA==
X-Gm-Message-State: AGi0PuabuINLpve5tAxO9eOEMmGScmqQlD9u6rpejw7P8hy7p1Eo+eFR
        w34wYHyQCq3x/3ITXqRtpNVMAuNk1oxFNj17nLIeQKABTOi1QyZY6ztQqg5Ic41gCo7xd84Mn5Z
        c1+DZq335Y1E0pp+AgB77nSgfD7Bdw7yfkVVn3EU75eeBJVBrvYIiKySXdwVfIUZsPH0LxsbjGp
        Bj
X-Google-Smtp-Source: APiQypI2YgDHUzIj37tGhOaWoO6vkwbwWbtOKcV6b+x5lLJVGOlNP3xZI3rIeBJYX6ndLDA6l8u/VyDJXdYlNPbrTKDe
X-Received: by 2002:a25:8389:: with SMTP id t9mr17058544ybk.255.1588802866149;
 Wed, 06 May 2020 15:07:46 -0700 (PDT)
Date:   Wed,  6 May 2020 15:07:40 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005062304410.56@tvgsbejvaqbjf.bet>
Message-Id: <20200506220741.71021-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <nycvar.QRO.7.76.6.2005062304410.56@tvgsbejvaqbjf.bet>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH] t5500: count objects through stderr, not trace
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In two tests introduced by 4fa3f00abb ("fetch-pack: in protocol v2,
in_vain only after ACK", 2020-04-28) and 2f0a093dd6 ("fetch-pack: in
protocol v2, reset in_vain upon ACK", 2020-04-28), the count of objects
downloaded is checked by grepping for a specific message in the packet
trace. However, this is flaky as that specific message may be delivered
over 2 or more packet lines.

Instead, grep over stderr, just like the "fetch creating new shallow
root" test in the same file.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks, Dscho. The commits introducing the flakiness have made it to
master, so this commit is on master.
---
 t/t5500-fetch-pack.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 52dd1a688c..8c54e34ef1 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -386,7 +386,7 @@ test_expect_success 'clone shallow with packed refs' '
 '
 
 test_expect_success 'in_vain not triggered before first ACK' '
-	rm -rf myserver myclient trace &&
+	rm -rf myserver myclient &&
 	git init myserver &&
 	test_commit -C myserver foo &&
 	git clone "file://$(pwd)/myserver" myclient &&
@@ -399,12 +399,12 @@ test_expect_success 'in_vain not triggered before first ACK' '
 	# The new commit that the client wants to fetch.
 	test_commit -C myserver bar &&
 
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C myclient fetch --progress origin &&
-	test_i18ngrep "Total 3 " trace
+	git -C myclient fetch --progress origin 2>log &&
+	test_i18ngrep "remote: Total 3 " log
 '
 
 test_expect_success 'in_vain resetted upon ACK' '
-	rm -rf myserver myclient trace &&
+	rm -rf myserver myclient &&
 	git init myserver &&
 
 	# Linked list of commits on master. The first is common; the rest are
@@ -429,8 +429,8 @@ test_expect_success 'in_vain resetted upon ACK' '
 	# first. The 256th commit is common between the client and the server,
 	# and should reset in_vain. This allows negotiation to continue until
 	# the client reports that first_anotherbranch_commit is common.
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C myclient fetch --progress origin master &&
-	test_i18ngrep "Total 3 " trace
+	git -C myclient fetch --progress origin master 2>log &&
+	test_i18ngrep "Total 3 " log
 '
 
 test_expect_success 'fetch in shallow repo unreachable shallow objects' '
-- 
2.26.2.526.g744177e7f7-goog

