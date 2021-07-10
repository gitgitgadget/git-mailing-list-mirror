Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12182C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3C8611CD
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhGJHvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 03:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhGJHvH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 03:51:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120C4C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 00:48:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso9590392pjc.0
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l73dfhO9syTvpqtI0cAhmOHRLso28OE3PN1TrIXRFI8=;
        b=ehGykBQO7aMKn+XtC7WZKtAwBMjn1w63U5MBL0/PHDVdRNSkObx8wM2lPnIQh0f6c2
         J6Ks0EPmNap/J87Jkpw0017aHJwlMJxiIpCYiydDVIUPEiKiMJ3Rt2j3iylBcDN/OJQz
         8tfJRP9ygfhVlUyCFSxbQqKd8sKXV1sf2vY15CG9TQTiR7cC9tNEv2XjOPW0GHsvddEp
         aOfBmtek8HX0aB5Ev97JftKbFBjAeq5sucwKoEki8av1Q4qv6hkg3KkLTgUFR51oXq6g
         whuUZYPAmL6CHvNtDBQ2leJJu3bsPl73QIcLDWbzRCtyfEy6uz44u3nEC2ne9/qRFKu1
         BzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l73dfhO9syTvpqtI0cAhmOHRLso28OE3PN1TrIXRFI8=;
        b=ESX5xIJkGoiCoNy1AGJGuTeo2GLqIrX5ssup6kY/XvJotjYq9MqHw4v4FA9XdrXzVy
         llXRkict/uI2CE0YcxFWm9rLQquG4XB4KnUXGXVkXojxnWp5WNgf//K4WUAW2P7LiUH2
         ZkGgnAP/8LyQ6iXzvKpPS7pmnrigV28u5hD+D+MCGTDhspX47whbA7ytyiW3cbwq6FIm
         pNzsRzr2oDDS9rwB3ujCnMT99Ra3Q2aRMAcv0Hz8MPyV+4ka54Skk1GPzcakVixPQa66
         3IVqkS98Zo76bZcZgfuIcQiDKH390+LKcnvxgKwn4UyiZ4svi3Auf3boavzANfRis5FU
         o2yg==
X-Gm-Message-State: AOAM530HMq2PKEmy8KEwStn81OO8dTfviEhJ4enfLjYAYe7PgJcdW9jt
        5GCavRM4UpKDznf3Ne8utHKHQhKPkTBla8Al
X-Google-Smtp-Source: ABdhPJzgANoQ5JQj5DAVuqRQLLbDo0e6a/bU1AxSl2MYmbVxXn0TkTzMvBmpRdYi1PRgE0jIEE2a6w==
X-Received: by 2002:a17:902:c00b:b029:129:c3:aeb7 with SMTP id v11-20020a170902c00bb029012900c3aeb7mr34220188plx.39.1625903301507;
        Sat, 10 Jul 2021 00:48:21 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id 125sm8811327pfg.52.2021.07.10.00.48.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jul 2021 00:48:21 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH v3 1/4] t7400: test failure to add submodule in tracked path
Date:   Sat, 10 Jul 2021 13:17:58 +0530
Message-Id: <20210710074801.19917-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210710074801.19917-1-raykar.ath@gmail.com>
References: <20210708095533.26226-1-raykar.ath@gmail.com>
 <20210710074801.19917-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test to ensure failure on adding a submodule to a directory with
tracked contents in the index.

As we are going to refactor and port to C some parts of `git submodule
add`, let's add a test to help ensure no regression is introduced.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Based-on-patch-by: Shourya Shukla <periperidip@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 t/t7400-submodule-basic.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a924fdb7a6..7aa7fefdfa 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -196,6 +196,17 @@ test_expect_success 'submodule add to .gitignored path with --force' '
 	)
 '
 
+test_expect_success 'submodule add to path with tracked content fails' '
+	(
+		cd addtest &&
+		echo "'\''dir-tracked'\'' already exists in the index" >expect &&
+		mkdir dir-tracked &&
+		test_commit foo dir-tracked/bar &&
+		test_must_fail git submodule add "$submodurl" dir-tracked >actual 2>&1 &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'submodule add to reconfigure existing submodule with --force' '
 	(
 		cd addtest-ignore &&
-- 
2.32.0

