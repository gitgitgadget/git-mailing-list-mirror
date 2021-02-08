Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5719AC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1143E64E85
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhBHTbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbhBHT3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:29:36 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E914C06178A
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:28:51 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o63so10897485pgo.6
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=boNXWkyW/SVBwzU72WdcrhqCTxfDP9uyyqlsNwfBeLg=;
        b=XV4sdzEzoDHrllGfXPhCSoZ4Ts/Bz1RViiWAefgB/2uCAFPnrXuI29Q7L7VI/R58yq
         4O3BOIH/r7Jnhvpz/ZTCSEj8qfKM7AZlrcpY8oZNzD2/t0Ecif8JQ8AQRjtvPbtxUM1e
         dol5/TJ2SOyH75GIDx8KuNKRmri9uLPwyOkaqM86iiyLR0CJEYsVYdkTprMzdvIGaW63
         jmZXxQ4DRPC13H9Cj9TvpOVbsZ36YkkeHwJ6782O3svBcW8V7W8/W1a8DinxLd8RaPvy
         SXx0mBso8u261+rIqJy/Dji8helgqkp3T04YOMFwd6n+QzeWeHgkp3KL5CwPQ49Xk648
         CHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=boNXWkyW/SVBwzU72WdcrhqCTxfDP9uyyqlsNwfBeLg=;
        b=WtI65AyPlDZDmaA5ZdivfTTtytUaJd7WiKVmPOfsWVIim7bWjsJSyB5EjxMC5VMBqa
         mFEdwAY6ADMlii0hvadq/QtHk2pH5WfuEWnR01Ko89TokEyOqKaOZlARqKX06WRT4/ZY
         zLjt2yt2eD3JyWL0mGPSNfXniKXiz9DFkjXAqSWT1xLQpEa0XMTiaH9PFcdgYl6mUScm
         vKyFdaEGVXYi1lQnPuYMtbkopqYqqHEs55UZtDqPocYna/ApuN0R+REkm5fF+gor7yXr
         bca8oMpzSUvYX0j/vCAH8QGxjPd4VxDqqX/octadQFj1Gjx0oOxwVf2q88AIWQJxhxLe
         DoAQ==
X-Gm-Message-State: AOAM533PapHTSG40zh2/+BlXUjdwSJ0DklmI6IANd0bnjhEvKp9rW5ag
        58v0DEkIo7KY13nME3N0ic+u09nHMCeWQQ==
X-Google-Smtp-Source: ABdhPJzq8b1v7tLf0/ixc7Sax2Dyst4RH6ndHmjc/IV9OyWoMauMQQO0TlYNvKIe4scL2TU4CsVYoA==
X-Received: by 2002:a62:cf81:0:b029:1d5:50ba:83d3 with SMTP id b123-20020a62cf810000b02901d550ba83d3mr19204518pfg.50.1612812530778;
        Mon, 08 Feb 2021 11:28:50 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:91c3:5a1c:9f2d:b1e6])
        by smtp.googlemail.com with ESMTPSA id a141sm19765444pfa.189.2021.02.08.11.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:28:50 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 07/11] t/t3437: check author date of the fixed up commit
Date:   Tue,  9 Feb 2021 00:55:27 +0530
Message-Id: <20210208192528.21399-8-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add '%at' format in the get_author() function and update the test to check
that the author date of the fixed up commit is unchanged.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 242770a3ec..180fc50248 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -33,7 +33,7 @@ test_commit_message () {

 get_author () {
 	rev="$1" &&
-	git log -1 --pretty=format:"%an %ae" "$rev"
+	git log -1 --pretty=format:"%an %ae %at" "$rev"
 }

 test_expect_success 'setup' '
@@ -196,6 +196,8 @@ test_expect_success 'multiple fixup -c opens editor once' '
 		EXPECT_HEADER_COUNT=4 \
 		git rebase -i $base &&
 	test_cmp_rev $base HEAD^ &&
+	get_author HEAD >actual-author &&
+	test_cmp expected-author actual-author &&
 	test 1 = $(git show | grep Modified-A3 | wc -l)
 '

--
2.29.0.rc1

