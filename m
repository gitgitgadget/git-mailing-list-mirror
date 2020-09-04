Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E98FC433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 07:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CB8206D4
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 07:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7QBS38w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIDHIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIDHIo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 03:08:44 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABBDC061245
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 00:08:42 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t13so5464792ile.9
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udNH8yeHpFWVdd6YQu9UgrG4522T0NXseoi3Jzs2Z0A=;
        b=c7QBS38wNxpR9RFK+PyhnCBJJgMwvOKa5s1Y0tin9lutXzASV2txj3BEWPhanT8O+E
         MBO6yw39tiU33Z3Jq73TEMClBjz4kfawdRg9ImQzdAb3+n9tfE+i1rlvhdsUarqEghEe
         rXYntbKNyRlBjbyljFcdimB+0w28PRjaskBAx/veQAIn/MZtt4aZpuGjrvesOGP9Kdlm
         cgIlerk1A9aygxE7MUa5cB/F2jcDO+fsacxeLbw3WRvVtdwe7doi7U5zVkDUm1oIlzTi
         67ICBZzTKntCQb9naYSjcrB7vys94b8ZZ54RgxwF7L6SbsqAcrBNRHOSsQJ93mZlrvMA
         IcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=udNH8yeHpFWVdd6YQu9UgrG4522T0NXseoi3Jzs2Z0A=;
        b=YZ3u1f/FhG43WuSRbmmc4KDwwCBQ5hOaptZ3wOAJMbcUotlJ51eDZYQutHShiRlfHt
         HhCuxrxPZnTUbFSgYhKgvwk4HTKr104F7oBp+W7A2C7begOXziI6eXlofKOdq6/198FP
         getsIGsuBbDZqhhAUjKDRVZ/XPsPpkLCnEQ67q8/zzPzfrYgKhmXdFubvthM9SewT5Qq
         x2/z1AEx24xQeI3nuYjSO0K/Njt2VQuMe1PoLOf28f3w+hZSBqxjpAKsntVcrP+stt0A
         0AKj1bTe+6c8C669jzKkcJ1cAZlCup9V1GJvXQfnMEQAt7TxCideywqgw6cL5q1/6jNJ
         YDTg==
X-Gm-Message-State: AOAM530TqmwlkwKbMNBWwNNPWjfGJAkOGDBxuk8dsR40+nTvWtsj8pLK
        g0A4Xn0HQrjbvD3TWpa5uuL66RBgPLA=
X-Google-Smtp-Source: ABdhPJxNmiCTxUI4dedIh6IbchRGiiZY84eXAWZ5o3H9Md2t0E8ocUycONrTEsoPvEfu7UKvZaxT6A==
X-Received: by 2002:a05:6e02:ee9:: with SMTP id j9mr4509233ilk.18.1599203321489;
        Fri, 04 Sep 2020 00:08:41 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n62sm2881950ild.36.2020.09.04.00.08.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 00:08:41 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] git-checkout.txt: document -d short option for --detach
Date:   Fri,  4 Sep 2020 03:07:01 -0400
Message-Id: <20200904070703.47898-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <20200904070703.47898-1-sunshine@sunshineco.com>
References: <20200904070703.47898-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-checkout learned -d as short option for --detach in 163e3b2975
(switch: add short option for --detach, 2019-03-29) but the
documentation was never updated to reflect the change.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-checkout.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 5b697eee1b..afa5c11fd3 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -198,6 +198,7 @@ Use `--no-guess` to disable this.
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
 
+-d::
 --detach::
 	Rather than checking out a branch to work on it, check out a
 	commit for inspection and discardable experiments.
-- 
2.28.0.618.gf4bc123cb7

