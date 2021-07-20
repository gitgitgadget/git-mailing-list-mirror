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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7322AC636CA
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6061361003
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhGTQ2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhGTQYb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46220C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l6so12714359wmq.0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vS3g4wjwVgWYF9DEvXctmDtiPK5MuvaZwl5SZRTztt4=;
        b=l0HFKIvIGw/ljbQr7HrCcMgX64o7FcaQhOjQL1IORv3B7q5DbauQ/jXhqmmADcVDAD
         bLkTJ5x+viC/yR/8uwataojvNIksejA6myWuMgDIbdi5gDeprF6YSu3HZ2NnumceTaom
         it0MBgXlBSWegOzhoAx2V1n6Qzub+nPKsUWqIelv4bMSXz9mKI40gCOUEnJQphSFhcLC
         v46d3U7VoOQAatOjpVehL3n+LdgAJ7V1oxaJBTeE83feY3cv0y35cD8Whp3Tyy7vD2R6
         YI10rw06bNn7a7oVPcRT53Y7KI8wG+Cf2AeNTkT7bVceVZNzNj63e/ZRtZMGDXuKSA5/
         cl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vS3g4wjwVgWYF9DEvXctmDtiPK5MuvaZwl5SZRTztt4=;
        b=nZlyuJ4malkZ8F5SUcV2Q/a0mIZtyrDy4fRajbkHwyAIVP9LlURjDWqe0RBu5+T74Z
         5iIUBzmSq4LzgimxPVxFdLb5Db2tWDT6wIfpGnkQDRxP3YwLfDdO/Hl2ZhyRxxdUB1JA
         97oY2TRTsIptpAwmrC5wv0cFHEYeMY08t6Mb36SQ7e5LUMYWHMQ4nA7mUz7don4IZ95G
         fzICW8RL2B6iXyCro1C33D687TLgjFMvJM7u7JKNeqPtZt+YCn3k9wOI0spmepP9Ik96
         gqFrolP7MSue1Xbf/+hm8Re8jGNfFzRIkmm51OXDzLOwad7eKUZqCSIuXCDo0KO2jyRH
         cR4Q==
X-Gm-Message-State: AOAM531KFRMNJb+YWNSVU5MOoAcy711pJceJzn8j0nxmJIQMVSi0MmMs
        sP3em2sgtzmOIeLumbf0TvnyoKUXNj4=
X-Google-Smtp-Source: ABdhPJzqCTqA3IIU4b+tnE61i2SAs+9rwGr1ADZxBM3W2bl2JYJ+olBt8mNVGtVn3u5q9KxKqbGhDQ==
X-Received: by 2002:a05:600c:6d8:: with SMTP id b24mr39177253wmn.111.1626800704909;
        Tue, 20 Jul 2021 10:05:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2sm19876467wmg.6.2021.07.20.10.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:05:04 -0700 (PDT)
Message-Id: <4a5891fa8cc9514535d70b52a4fce2b21991bfef.1626800687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:46 +0000
Subject: [PATCH 26/26] t7004: avoid direct filesystem access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t7004-tag.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2f72c5c6883..8bd84b0e404 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -97,7 +97,8 @@ test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	test_when_finished "git tag -d tag_with_reflog" &&
 	git tag --create-reflog tag_with_reflog &&
 	git reflog exists refs/tags/tag_with_reflog &&
-	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog >actual &&
+	git reflog --format="format:tag: tagging %h (%s, %cd)%n" \
+		--date=format:%Y-%m-%d refs/tags/tag_with_reflog >actual &&
 	test_cmp expected actual
 '
 
@@ -108,7 +109,9 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
 	test_when_finished "git tag -d tag_with_reflog" &&
 	git tag -m "annotated tag" --create-reflog tag_with_reflog &&
 	git reflog exists refs/tags/tag_with_reflog &&
-	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog >actual &&
+	git reflog \
+		--format="format:tag: tagging %h (%s, %cd)%n" \
+		--date=format:%Y-%m-%d >actual &&
 	test_cmp expected actual
 '
 
-- 
gitgitgadget
