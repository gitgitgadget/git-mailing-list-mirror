Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFC9C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBC261DD4
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhF2T1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhF2T1o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 15:27:44 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5EFC061766
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 12:25:16 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso21868864otm.8
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ktPWJMtUEd9bI1XYuqOcC2yYMqZr9fGhozIc3A+aM4g=;
        b=CgqKyH9yWLlp7RFut7UBhV7cTh+2jrCrrN1pQDDTSElT0rthWzRyUBTOPmtKUMb06k
         n/WoBUyNx8mql19/uL1NQrcp0gmQVx9Rq503197S246aFtoSn9zBXZjrjCIjRYYp7s2a
         /YLEvY95Cm/l3bbgtbdG0njZoHox1fgX/XyzzDwru+CDETAkN2zVPcrVkqOYtCwa8xqo
         pH27mUDYUU9Edsc9Bei2uw1/32VNx9fvAy7tFJPFyq0gaqvTwu7qp8Pl4IJYRZcOxh9x
         KTA4eAp3xdKkVndUllKkw5OBpkkYDmhvZqb2n0jK4U5x9fhiUjwyq4lfZcj5aaKi9stx
         f62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ktPWJMtUEd9bI1XYuqOcC2yYMqZr9fGhozIc3A+aM4g=;
        b=c1Ac3oJa5+rJKdYDUeGaKHFuNcqWS1V9eKCHSkPRuCbSaFGSjXT9AxrbCB/8V0E7d5
         RzXqHzjBhk9coq9+fSZwp71dtBQ5CopRkKVjcosTf3gF4YQaYoZPW+yCWQtRQRkXQ48o
         eVFCcQlaXkkpAMCXtvNxtKsEpbtmnB+/ehFrJIUGL6Bei341mScpw8/QIUkqb+Zbn/Xk
         Zh/S9J9ra9l66l7qmMThR4gyBygQqEnq7gFcjYANsAoaCxuUljmM3gsvL0EsCJiJENrx
         aQSLTY+lOVZwG6wMPcFRZDGzz9Q8lQYQgUBdTgZVQneYeo/LgSA3NSTfrkjaJOza4r8d
         xkxQ==
X-Gm-Message-State: AOAM533X3h9s3gUI0ZEHEdmoxsoNVUC+QwGQBsdWf0xvT7+rGUKftZRB
        lseIMi5YuEZLQCaJVs70PHg=
X-Google-Smtp-Source: ABdhPJyh89GMQ9CWscIi4gNqMt1Jf9XjzAZX8EmeaeZ6b16Si15tBSf5o0Z+ktUYGXqK/6x78rTsqA==
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr5903653oti.201.1624994715944;
        Tue, 29 Jun 2021 12:25:15 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id 5sm3914632oot.29.2021.06.29.12.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 12:25:15 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:25:09 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60db73952e3af_4f7020818@natae.notmuch>
In-Reply-To: <cover-0.3-0000000000-20210629T190137Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210629T190137Z-avarab@gmail.com>
Subject: RE: [PATCH v2 0/3] Makefile: misc trivial fixes
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> A base topic for some larger changes. See the v1 CL for a summary:
> http://lore.kernel.org/git/cover-0.3-0000000000-20210617T095827Z-avarab=
@gmail.com
> =

> The only changes since v1 are to commit message issues pointed out by
> Felipe and a trivial whitespace change. I also updated the commit
> message of 2/3 as he suggested to point out why the change is being
> made.

This version looks good to me:

Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

-- =

Felipe Contreras=
