Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91329C433FE
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7321A61152
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbhJHUK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhJHUKz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:10:55 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FE3C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 13:09:00 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id k1-20020a17090a590100b001971da53970so6269108pji.4
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EWCu8CA7PzXvzFPdAkMB1HYLxLKSH6aMozfRxOGuk9k=;
        b=WTLZKwbIOeqUe0aNxUK9+us6qG95YdOZffRx6uAQ2ynA88nFs9pjmD7EuJ9As8qmXj
         lmeqaNU2AOo7HZXwIRL5j45Pgd0ljAXFAlq6bz2x74Opl+ZhdP6wPGnhuptM/CriAh2U
         ZkMXqBsV55qU3iRX78GRzeG/z6wRAa6eNKxhbdsJkh8duMJvrMDdXozDPdfodPcqYK07
         vqP+B2G0AgADcEL2KvSbvhxVJY8nziMPBEUyEa7Va2SSTAYmiKW2qCqYSNR3w40wzd/C
         b/F08Q9seEVUBUEMpDtgqdwGIxLW5dqjR4CHbhiZgckfkmpQYzbdikD+oRk7kg84abuh
         XyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EWCu8CA7PzXvzFPdAkMB1HYLxLKSH6aMozfRxOGuk9k=;
        b=gC01LjupKcvsUwBIRtPUaLvEnXcH2fbT3X2ozIG9HtmBHKo7EijPQoI5g8/CWZeD9V
         AKBfHmJD4gl7SaoVyzg9fF+sLSdRJb13ah45CLDaKRHRY+WUfb++sdbuEw5hhmHEUOkU
         r1FU0NeBAM7zmZVF8zlHy1+GHLZzxPr/oCZXBBDWeFeVSfJ6Y6eePZ7mEs+Aw6/y0KvV
         DMK0F/OQtUwaYzJ35KRPaYuuS2O/iwNg5mHnr68Y06keNdUYO3A3YMkjh7OOPfJGuDE0
         2xvrM36w8wV4eKCG6N5Gjga/qCFs2uATbWerC6bh2TaKRm4VPFLtbXja0XcbEeitjaSp
         HhbA==
X-Gm-Message-State: AOAM532rBTj9yqfci6FHHl33DSjZiVKVCOtOUmXSmBB+1iUeZPG12q8W
        xNR7hymdV+rt6wsgr9ceUTJFWvxcZOGAExKiBUZU
X-Google-Smtp-Source: ABdhPJyYnPUVTatcniqOOm0pXJMgFWnnN7OMmAfBvbWm5YbRdeIXPcv7u3EGLFIB0ICJQ7aKY9wPeiqsBjiSiY6eD6cR
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:f817:: with SMTP id
 n23mr6372370pgh.250.1633723739382; Fri, 08 Oct 2021 13:08:59 -0700 (PDT)
Date:   Fri,  8 Oct 2021 13:08:57 -0700
In-Reply-To: <YV89aRzwnP4Jk8x1@google.com>
Message-Id: <20211008200857.1322311-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YV89aRzwnP4Jk8x1@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: Re: [PATCH v3 1/7] refs: plumb repo into ref stores
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 2021.09.29 16:06, Jonathan Tan wrote:
> > In preparation for the next 2 patches that adds (partial) support for
> > arbitrary repositories to ref iterators, plumb a repository into all ref
> > stores. There are no changes to program logic.
> > 
> > (The repository is plumbed into the ref stores instead of directly into
> > the ref iterators themselves, so that existing code that operates on ref
> > stores do not need to be modified to also handle repositories.)
> 
> The second paragraph is a bit confusing, as in patch 2 we do end up
> adding repository pointers into various iterators. Could you clarify
> this a bit?

Ah, good catch. I don't think the paragraph is adding much, so I'll just
remove it.
