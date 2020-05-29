Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5DAC433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB07620723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWne7mYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgE2Ivt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgE2Ivr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7606C08C5C6
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c71so2287550wmd.5
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DmlILvQSwYjkFmMhHfaHxPRbDZnbba2maoT6vuIuUjs=;
        b=cWne7mYqImNpUUZAfTKlCl3GDK9thIuDzMAOG9h8ouEeRsSKqrxR8DBkYEEH6NiZE9
         rsfHfWbweC9c1AjU4oQK8Ttxz0SVOvefKly3tJDhmSqUDG5gwwTf2ag4aGdgVYv0aI22
         69ypkSBe32jVsYWUxYy6DC6HZ8hxSjwIREGYxoEgUCWP1PqIxUnQTfQjEColmWaenEkc
         v33AIvQ7I0Oft3uzXqTFDgqBPZpPYqgn19k2BOVxos1pmvxFY3SJ7RiD+41BSec9BW09
         dyRRztnL2iMf4lGrNZmFSupz2rUvq2OGiF2CKUrJwUs6FlW8vc51H404aY26yZPNScvE
         FUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DmlILvQSwYjkFmMhHfaHxPRbDZnbba2maoT6vuIuUjs=;
        b=qO64fqasNF9dduCxtAwiy8VuMLsMoS2uJM+CQ9ax4c85WUoHU0C+CC2aTPgUM6WDVE
         ZDSCK1RLtX2k45JpbjGiDZQZPOijX4wLbgZIYlz46EaJl3+VAtfCTEThY0sUDoQYMyCa
         OmOHg/E9Dza8xlFPBYco6KbPrtd1ydQCOCpXdQ3BT8GSfss3sNl60U/wY0oxs7/YWlx2
         ev+YHKyPJ9LRq9IGlVa2zoBfi+Rgh/0OJYd3IDzMm2GvymMUXnR+G/njhcRMldwGY1GR
         31FKgkTXJhU2xahnZPfeLsHzsjw9vrledP2NpeQCgu2xWacKZXsfS/WAsuHgv5j8gLH1
         cGaQ==
X-Gm-Message-State: AOAM5303YXNx5pGGuoCtP5PGNuuDRuF7/r6iGLcxv0nLtTqZz4m2qFoU
        h9eUh2xau9ah25h8Q+CRTu138BAK
X-Google-Smtp-Source: ABdhPJxO3pfWFsjctNdyZ3rSti45AUskbs19/Uob1ad7TDzgVYDj7YaYbqXqBkdX4Hkmlets/10Z6w==
X-Received: by 2002:a1c:df57:: with SMTP id w84mr7987773wmg.52.1590742305442;
        Fri, 29 May 2020 01:51:45 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:44 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 31/34] t7007-show: make the first test compatible with the next patch
Date:   Fri, 29 May 2020 10:50:35 +0200
Message-Id: <20200529085038.26008-32-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise it would fail with GIT_TEST_COMMIT_GRAPH=1.
---
 t/t7007-show.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index 42d3db6246..93244cd718 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -4,16 +4,15 @@ test_description='git show'
 
 . ./test-lib.sh
 
-test_expect_success setup '
+test_expect_success 'showing a tag that points at a missing object' '
+	test_when_finished "git tag -d foo-tag" &&
 	echo hello world >foo &&
 	H=$(git hash-object -w foo) &&
 	git tag -a foo-tag -m "Tags $H" $H &&
 	HH=$(expr "$H" : "\(..\)") &&
 	H38=$(expr "$H" : "..\(.*\)") &&
-	rm -f .git/objects/$HH/$H38
-'
+	rm -f .git/objects/$HH/$H38 &&
 
-test_expect_success 'showing a tag that point at a missing object' '
 	test_must_fail git --no-pager show foo-tag
 '
 
-- 
2.27.0.rc1.431.g5c813f95dc

