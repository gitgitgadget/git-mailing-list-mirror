Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C41C9202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 17:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbdKSRyi (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 12:54:38 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44573 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdKSRyi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 12:54:38 -0500
Received: by mail-pf0-f194.google.com with SMTP id n89so5565932pfk.11
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 09:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=lJiDhQfzuI0ZFwMWavAkItyCbO8spbj6Y3NSwtjZ6L0=;
        b=Nlrae9eBXw0OaboTtnF1duTTiojGlqDXLiMajk8DOTMQP8KT3Ai5E8/9h9IYO/ESQ1
         OFX1Gn0V57GuOpvJJb2Id+YHmhv2MKSoOUrLKezmAVzEhqEiUOKX5Mj/rdBVtX6dagsg
         QJaSXwzsEfiUWQVQPMw/soTKm62Ne2uqhFJXc7ncDBoDpKhd9/WyhpW/2conbCLcMt/U
         dytRMtkV27d5UG3iRlA7tkaLp2yckgGjKVtSFCHdSvQ43ZpEk0yuyagj+Vpq3zORrzPR
         22pGTKeinXa3KrXTxnSiampQrME31Y/Q/zq+BiWuMjBJjlXRw0mXpXXb8Eyu+K69u5ym
         R/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=lJiDhQfzuI0ZFwMWavAkItyCbO8spbj6Y3NSwtjZ6L0=;
        b=jSy7UwS2MvDpSnnmgepGs1aQllrro1dvC4xEPt55aqXHK0EGODgKYYe0HHuxFnjOf3
         zjgeo9lLuFFpWGf9j+yi6LKRSIcC/7DieYlhnXPBT0lrKjMwEQd+Vot91X+8AMIOcldA
         7yJnxKpkfw2McYklLERNJLCSDo3RaiKxXX8rdjyG21hxCGrdDfi5nr53UtM9B9oRFVGD
         bQLcWF3hiXBBvKjhuwzrdN87RMpSAhOdJovsbj5QUfBXglL/am3FWY62rs0dxlkYDaa5
         nKw/kj/wxdKrTbC0JEl3T1nQjSto0LZc+0UkkQDXv/4fPcZcnxaHgTJKrkqz59gNbjvh
         pCtQ==
X-Gm-Message-State: AJaThX56AbGldi05hlLU78cfWWoTIkhwKCn5ksYRpL1B+3fz+iIOn0W5
        WECfbHpukKj0zCQMqx0XRHg56OWh
X-Google-Smtp-Source: AGs4zMZ/GY25hWcAOF0AalKpcjSAkuVEbdZWzrs9bNLf+LZeToavSXQiEldRMBvAoJaKP7AN24QbIg==
X-Received: by 10.98.196.155 with SMTP id h27mr8610967pfk.137.1511114077234;
        Sun, 19 Nov 2017 09:54:37 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72c8:8b21:b8b1:7c41:1a33:6334])
        by smtp.gmail.com with ESMTPSA id w64sm18285241pfj.62.2017.11.19.09.54.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 09:54:36 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH] docs: checking out using @{-N} can lead to detached state
Date:   Sun, 19 Nov 2017 23:24:11 +0530
Message-Id: <20171119175411.13570-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.291.g0d8980c5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit message of 75d6e552a (Documentation: @{-N} can refer to
a commit, 2014-01-19) clearly specifies how @{-N} can be used to
refer not only to a branch but also to a commit. IOW, @{-N} is a
syntax for the N-th last "checkout" and not the N-th last "branch"
Therefore, in some cases using `git checkout @{-$N}` does lead to a
"detached HEAD" state.

Correct the misleading sentence which states that @{-N} doesn't
detach HEAD.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/git-checkout.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index e108b0f74..238880f10 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -272,9 +272,8 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	commit, your HEAD becomes "detached" and you are no longer on
 	any branch (see below for details).
 +
-As a special case, the `"@{-N}"` syntax for the N-th last branch/commit
-checks out branches (instead of detaching).  You may also specify
-`-` which is synonymous with `"@{-1}"`.
+As a special case, the `@{-N}` syntax checks out the N-th last branch/commit(checkout).
+You may also specify `-` which is synonymous with `@{-1}`.
 +
 As a further special case, you may use `"A...B"` as a shortcut for the
 merge base of `A` and `B` if there is exactly one merge base. You can
-- 
2.15.0.291.g0d8980c5d

