Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99334C43465
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5992820EDD
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh+Geq3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgIUKkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgIUKkS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2539FC0613CF
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so12172722wrn.6
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SvZ1fVsxMLyCcJ8zgy4iF9eMczQzBZxvlPawMLZwE/k=;
        b=Gh+Geq3fHZWjHlgUx1ALKArlqMFZZAbW3BqhSushloXs5q1HtFtXcXeR6dbCB7AleI
         XgDQRUErNHX9EoxKkAIlDUa4hxw492T8qGZ1s5FrYM8XcE1t+l2FzRXs1v+uqgyCqzuP
         yTyw9q+xIxhycXkXZ3GDeadVSFfrFOylV29P91H/OK7FJxCnRQPL1XzOThhGxZFeaR83
         bj+0J/jMguBSH/vF16AZm/Ke5n84UVDo8qdpuCFe8IlM40mMPqbqxi+fs+BYmprjUvg7
         JYYa7gP/MDJo/IMxb4cD9H+7FJEtsROp/QH2xC+6zn0eW9voVCrFAhK61QXxgH7aB6GP
         ncEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SvZ1fVsxMLyCcJ8zgy4iF9eMczQzBZxvlPawMLZwE/k=;
        b=S48aO8GfDoLInipwbDqZj22DmDaiAbLXPCE/tNxi+uvsxQ0s0SIpUKm3rQ9KH0EKIk
         UGfajX6/Ok8DjUJFAglKQKLbUaW5NDdXHHzSMM636JERlcwUD+WsFkYFAbD2eWVQqqiu
         62yzQVA7Lr3U7eQ0Cy78k8VzIH8A7ecGB64r0orcArN1c+dRDjnWQAVyIBr6/+et2fMQ
         TbQWSdXCQO1GpN+gp77Sj1BWJ72zlqmsL2+81GUE0MhcXW6aSFJ/yYLOP3AN1TRkW6vp
         4fOyNHLCdnW8Y1HKFyiVq9KC5iczMzN7RkrlL9bEq1haylkyKZUllezP3SAR49nWMjZk
         7H0Q==
X-Gm-Message-State: AOAM531Yr8Yuvxs+5Yr5zK9cX8QwfJnszSYUnYOftLIleJaE3DMm+OaE
        jdpTKC8YkITbz1xDhfn+FMg7+gSdEcjHbg==
X-Google-Smtp-Source: ABdhPJzcYWbBvcFZ7p0bbV8XRgwQFFNN252YbJx7Q2iDJtHiOdWgsOGuweSHGhHzjUfoi9Qho+1XiQ==
X-Received: by 2002:a05:6000:1083:: with SMTP id y3mr51442590wrw.405.1600684816609;
        Mon, 21 Sep 2020 03:40:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/18] remote-mediawiki doc: link to MediaWiki's current version
Date:   Mon, 21 Sep 2020 12:39:44 +0200
Message-Id: <20200921104000.2304-3-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a comment in the test.config file to point to the latest
upstream version, which makes it easier for the user to tweak this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/test.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/mw-to-git/t/test.config b/contrib/mw-to-git/t/test.config
index 5ba0684162..b6fb0b3993 100644
--- a/contrib/mw-to-git/t/test.config
+++ b/contrib/mw-to-git/t/test.config
@@ -31,6 +31,9 @@ WEB_WWW=$WEB/www
 # The variables below are used by the script to install a wiki.
 # You should not modify these unless you are modifying the script itself.
 # tested versions: 1.19.X -> 1.21.1
+#
+# See https://www.mediawiki.org/wiki/Download for what the latest
+# version is.
 MW_VERSION_MAJOR=1.21
 MW_VERSION_MINOR=1
 FILES_FOLDER=install-wiki
-- 
2.28.0.297.g1956fa8f8d

