Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B801CC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 06:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6499122838
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 06:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbhAEGok (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 01:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbhAEGok (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 01:44:40 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AE8C061574
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 22:43:59 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x18so15853349pln.6
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 22:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3CQ5WOTfo0z2WTNNJDZySWdgJ0e6+o0RqK+pvK5DGSw=;
        b=FSGda6VmAqhRWo3Pn+H92TmAQZYmwvILFVxFb+vnlfid2Zw0KmZjx9Gh18aZukh0lz
         JNq5ldWwLZfDctacnwZZS7kI2ton7aD6eOh/nvFv+chKv6JPKnEwion+Zmg7iGxz/4w9
         kfIFF2g9rm23AgHchm+NEpmGd74UXqqooS8jVIolK6TafdN5gvAUUVnN5v+LxddvENFd
         4r8BGaa9GGeKIb/Awt+Gdye6HrAzIgIe82g4iWo+FGNWI+zg/n958j11lrn53yyixmRr
         6gxMxgKv1ELrOYj8KHV4Kedkt/SKHApCupu0SO42D2K3DMeekWsRzGDWB5ouAAEfNSRr
         SDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3CQ5WOTfo0z2WTNNJDZySWdgJ0e6+o0RqK+pvK5DGSw=;
        b=IXZB0qH04u7oz52W+ex/in6SEDTHjN3x5yjJ7volv4Z48itOm2K3pMS9C/PT4z0Rrr
         vfpua6zidWB7t1exo/6pPixxWGt+HzLRLjoKlshfEIKdpNja/V4AkhlTftFwicCaFCyM
         GGwuIXlOZWC90qtQdACFAbSAHgnhBjYH0JQKOMfiumtqIUdRJAFagqomx+accMZcQlfo
         oUKzE8VH/KiK64vaXWfPaYIGFR4E8PaYoUVsYhOarS19CZmmK/Q61GKN3hvGvkeqFlbh
         rTnsmjhW6F706KD0sUm5d4O29ahE6HbLmfGPr3KaGl/3rjp91MgDPQYF7QEB4UEhwhF+
         SL3Q==
X-Gm-Message-State: AOAM533bI597KYJoy2UJVVqahNusXSdwri3VdyhiZvg3yMLs1lC8yOdA
        an5FwLRec90fCM82OED5VOUXyGcWIA/69A==
X-Google-Smtp-Source: ABdhPJw6VTQHuly82e4Dsd6TUm6HOR/MTGZMq33CmqWQR4P+99WxxpydiimGyw9lmxcSMu2vuDJCyw==
X-Received: by 2002:a17:90a:8508:: with SMTP id l8mr2567632pjn.131.1609829038892;
        Mon, 04 Jan 2021 22:43:58 -0800 (PST)
Received: from ADLADL.lan ([103.135.249.72])
        by smtp.gmail.com with ESMTPSA id d8sm1397652pjv.3.2021.01.04.22.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 22:43:58 -0800 (PST)
From:   ZheNing Hu <adlternative@gmail.com>
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>
Subject: [RFC PATCH v1 0/1] strbuf.c/h: add the constant version initialization method of strbuf
Date:   Tue,  5 Jan 2021 14:45:01 +0800
Message-Id: <20210105064502.725307-1-adlternative@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to
https://public-inbox.org/git/nycvar.QRO.7.76.6.1806210857520.11870@tvgsbejvaqbjf.bet/,
we can create a new way to initialize strbuf
with string constantto save the overhead of
dynamically allocated memory.The marco function
STRBUF_INIT_CONST(str).For example,STRBUF_ININ_DEFAULT("default")
will create a strbuf which buf eqoal to "default",
len eqoal to 7 and alloc eqoal to 0.This constant
strbuf will be changed to dynamic allocation when
we want to modify the contents of the constant buffer,
The function strbuf_const_to_no_const do this by change
buf with xstrdup,some function like strbuf_grow and
strbuf_setlen will use it,to change the strbuf
to a dynamically expand buffer.

My inference is based on an non-const strbuf
with alloc greater than 0 and len greater than 0,
const strbuf with alloc = 0 and len greater than 0.
But now it have some bug because of I don't know where
is the situation that non-const strbuf with 0 alloc
and more then 0 len,this is a bit out of my expectation.
So I fail check in gitgitgadget's check.
Who can give me some advice?

Thanks.

ZheNing Hu (1):
  strbuf.c/h: add the constant version initialization method of strbuf

 strbuf.c | 33 +++++++++++++++++++++++++++++----
 strbuf.h |  8 ++++++++
 2 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.30.0

