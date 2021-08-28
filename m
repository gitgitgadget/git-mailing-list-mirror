Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324DDC4320A
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 03:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0720960F58
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 03:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhH1DKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 23:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbhH1DKP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 23:10:15 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC6CC0617A8
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 20:09:25 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id eh1so5149722qvb.11
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 20:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0q12AZFZV03fcJFttHPoMQJ4J7EKPMXAEU6OKGI7UBQ=;
        b=b/gDCdvvW39j+UHKT0KMiMKi55UPbdzG/og+7Iy2vtzxmvyFvq0Nxw/9eJ0H8cenJ5
         ZIs7JfDPBOngSJhKuBJYsawBj+vKIP2BOz3/NiUO5+fWthqGZxhW9miXFnfJxQqCSYH/
         cwne1tk/+IC7TPDwNkWJ8oLJcdWeehj7p/kj1BvkOa5XX3IXP7kUAjM8nw8Nahog46Nh
         j+trYdQUKnFIwUkecUKN+/ca5QHooyksHuHEqKPabhNyr7y21vrgUiU6PpJOtGesrHsN
         YAKTaQ7ICKcHe4nzOJ+ee3FkYVOQ+rpeZzUSJwHk2hCUajPy7tS8PQGzzcnnD+riVeDF
         3uOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0q12AZFZV03fcJFttHPoMQJ4J7EKPMXAEU6OKGI7UBQ=;
        b=KfDPFBWB9QaMj/pzvqgxF1pS+sxInqj7Usevl8iPAJGjXDVc8ehIRMX3PjyiJ7DxmA
         zcDL58PHy0Inhg8YXFI4e0fgDaUarKLGDb2tcD9z4pc53vv7ulOhYNNji33x647sLgef
         1DR5AxDJWdQfRVWGKNtzTRbkoUHH8Pxiq5u3smqFAYTnvH1X449eFeBzxb+2TxLhPnbc
         mzvXFbHzJyLqKtAn/mlgd0fSbf2YwMOVOq0JN6I2DQUaDyxqf+9t2bBbZ2q6duanLLrt
         XyGjksoBhZQOQi07W76iJ55i6jZFevrwULPS2/lcKzv90fqfKrIgWfT7bWo9FAFmWrUP
         ZRoA==
X-Gm-Message-State: AOAM531odFjlxPV/jI7ArRjyTD1mHscXks5/llCCaVlXSjMjt1IxRxTT
        wCT8cbCOQ7FEQSMAGexh5wc=
X-Google-Smtp-Source: ABdhPJygoYcHHs7fzwDx4tNrbwYLUlHVt19/EUk9KUEU1bVR06uzwhgBAa95KNmUVtpHgwQW4Mb7bQ==
X-Received: by 2002:a0c:e18e:: with SMTP id p14mr12529614qvl.61.1630120165046;
        Fri, 27 Aug 2021 20:09:25 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id e25sm6071682qka.83.2021.08.27.20.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 20:09:24 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, tbperrotta@gmail.com
Subject: [PATCH v3 3/3] send-email docs: add format-patch options
Date:   Fri, 27 Aug 2021 23:08:39 -0400
Message-Id: <20210828030839.2989-4-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <xmqqmtpbub07.fsf@gitster.g>
References: <xmqqmtpbub07.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-send-email(1) does not mention that "git format-patch" options are
accepted. Augment SYNOPSIS and DESCRIPTION to mention it.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 Documentation/git-send-email.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3db4eab4ba..8adc8ace79 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -9,7 +9,8 @@ git-send-email - Send a collection of patches as emails
 SYNOPSIS
 --------
 [verse]
-'git send-email' [<options>] <file|directory|rev-list options>...
+'git send-email' [<options>] <file|directory>...
+'git send-email' [<options>] <format-patch options>
 'git send-email' --dump-aliases
 
 
@@ -19,7 +20,8 @@ Takes the patches given on the command line and emails them out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
 last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email.
+be passed to git send-email, and options understood by
+linkgit:git-format-patch[1] can be passed.
 
 The header of the email is configurable via command-line options.  If not
 specified on the command line, the user will be prompted with a ReadLine
-- 
2.33.0

