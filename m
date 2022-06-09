Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3C0C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 17:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245466AbiFIRRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 13:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245409AbiFIRRN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 13:17:13 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F87614780D
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 10:17:12 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id k92-20020a17090a4ce500b001e69e8a98a4so9811819pjh.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=qgQiaMWwhP/a1M67QyhraTYt+7taEv3HfA2dxFdEZQg=;
        b=Hk0sbhTwIyo0mqfBtaFUvozrumJr5a0Hkd//Tle3P80qXvRiLkFU9DPJjAjJiPkIff
         e5Xq5bfhVJp7GYeP+qpNIakLXCFCo6lV5fC0Mg82tQWLngkd/UZZhPa/YRZBuxRued8k
         iF1IP2Yaa1YwPybCqT4uYqvETQUJPfJn08vQJu3rszx1NAXB8Td/sqV96nxBuOp6fC1h
         951RQaSNH+dkALygu74DCzLF4Rh6nCHUpVDRKyCvLBccMucwde2epn42mdl6x9VJSAWR
         8QNLgM0F29huoMNBwNUqOfJcchi+g0e26+zj8mEa3bPKg2/BmAoxiNRHSISBN3wMp5Ll
         wHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=qgQiaMWwhP/a1M67QyhraTYt+7taEv3HfA2dxFdEZQg=;
        b=nn/oa8Wv60QRW3Ge5mGLvTwvWgYXLFJEKYCBsjhLNTGcV7uDLSTDNSV9+N3nKcT2nD
         TBLdgg1ktyG7J1THu5tw9gJV5Kd3VPHYbptnh5WuJFzV0MSHSRIhYbEzH0IVU+h0Dlq5
         FCFBA+K8BIvLiQA3jUA34DjI8T3V5k5IvwRXSOx4hSZFiip6PpwIPIrZpP6yA3eQwwqv
         jPEND5qeJmyzl2/kGiWtmk/uJjdJATTtNueRFq7b7Desjbd8lmGU9Fol2KrzOKu0pCGY
         pMHBuqCE07KsxgAqsggCKQVzyJuTISPd0siHMT+2E7E4NYssfx6zQysU5yf3CdF5kWCH
         4/Vg==
X-Gm-Message-State: AOAM531+uNTT4XLZPeC4RBo4N0UKR6EYw5EbyUFDQPx6U1lJC08vYYqx
        FASzazJHgBc2FPI/9JkaZ2FSWVETqBtE5kVX0kuI
X-Google-Smtp-Source: ABdhPJyzpfIAUvd1706n/tJpfsFfM9GAYwHDhCmPqmMdJi7dKioaH2gJTqJYKatNnhAe59in4oGE5+ZIxMeD7Feaxglv
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:a705:b0:156:9cc5:1d6f with
 SMTP id w5-20020a170902a70500b001569cc51d6fmr39989855plq.66.1654795032008;
 Thu, 09 Jun 2022 10:17:12 -0700 (PDT)
Date:   Thu,  9 Jun 2022 10:17:08 -0700
In-Reply-To: <xmqqwndpn5dz.fsf@gitster.g>
Message-Id: <20220609171708.346901-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: Re: [PATCH] connected: distinguish local/remote bad objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >  builtin/fetch.c              |  2 +-
> >  connected.c                  |  1 +
> >  revision.c                   | 16 ++++++++++++--
> >  revision.h                   |  3 +++
> >  t/t5518-fetch-exit-status.sh | 43 ++++++++++++++++++++++++++++++++++++
> >  5 files changed, 62 insertions(+), 3 deletions(-)
> 
> This seems to break linux-leaks CI job by making 5518, which was
> marked in some topic in flight to expect to be leak-free, fail.
> 
> Because of the way linux-leaks test framework is done, it is not
> easy to tell if the code changes essential to this topic introduced
> new leaks, in which case we would want to fix that.

Thanks. I'll recheck this once I make a new version.
