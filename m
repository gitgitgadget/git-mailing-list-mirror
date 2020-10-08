Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EAEC4363D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 01:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BEC2145D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 01:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AHLxUA+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgJHBs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 21:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgJHBs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 21:48:58 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E18C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 18:48:57 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 139so2782257qkl.11
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 18:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3bSDMCuqDvDgfhnc5eUXsxNnFsOStahNgYEPkpK7Avg=;
        b=AHLxUA+fq433GUV0fI72J3YOAtPlSdPJ0NWcoW2J/kgpWHig0/TRABg8ItFSkK9CQ4
         aLqKq5Cb6twWEzzrimeVKqBFfgGuyQnjtsFhSjolcTWtNJ7mKb1a6//FqG/GI5zyPCkn
         sF0gV5nMkT1EzMY0JiliM5NG3eW9DLJWWYq8DP+AMWqYiFYYoNTAF2TiZeW6qfbgreUK
         V1XRLOHFvEHYAAHGuzsdV9kW2sqdWrTklYAh1yKqkcDuGtld00NqZRy48RFOcvnsBYCR
         ZLvvDXI6sq8T6ZZACSkIzXWTxRy3j6UF0ks7+vNqH4DRva54kvmXmRhD7D6Zb8m/gsB0
         jJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3bSDMCuqDvDgfhnc5eUXsxNnFsOStahNgYEPkpK7Avg=;
        b=knXEvKA3JTDJxQ62Yn6PVyzuXVX2oLJ29Or2PgKyDbOhyubWettxBCGjR0jXA90BDH
         Aa7RLH/FWGmEAu30oU7C5J4TVCnnmGLEEES1afrE8YUtri4/HIM38HedYtWdr6sr4Yd7
         99mGTpelFFnT6gJ2Z7ahT9vDVXg3HztjYeJ4UDElvt011dhA4NsOop9IRrD7bW80R374
         FtbgdA3WA8zJdG0WrycXZ6XHkY8B4TOqdSjSlaK+EDqhTw0/EMsP+zERTAEFbUiDhRjI
         YTZAogXfrHRQJpBKDomg1OiPWc+qTYVrM22p6ri7ojMg2oLaQ+gTcp+Okbgpcts1o72/
         5vlA==
X-Gm-Message-State: AOAM531A2l+vtfv62ZrO9XuUeBCK65OPomesHc8UHOZjV2uGASXqYPLt
        6YW8yp5oio9CBtGK4aeSPMQiKzDK/N7eKJdaQpul
X-Google-Smtp-Source: ABdhPJzgA85EW+fXiz/gMZZVlJtkw+Dnxhin5hufFt28bAO8mkkmPaYYfPwBQy2rh9xeFz9YryPMFUStbIHZ5qn8DU/I
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:4e4e:: with SMTP id
 eb14mr6036403qvb.41.1602121736961; Wed, 07 Oct 2020 18:48:56 -0700 (PDT)
Date:   Wed,  7 Oct 2020 18:48:55 -0700
In-Reply-To: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
Message-Id: <20201008014855.1416580-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [PATCH v2 05/13] reftable: utility functions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com, peff@peff.net,
        hanwenn@gmail.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> This commit provides basic utility classes for the reftable library.
> 
> Since the reftable library must compile standalone, there may be some overlap
> with git-core utility functions.
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  Makefile                  |  26 ++++++-
>  reftable/basics.c         | 131 +++++++++++++++++++++++++++++++++
>  reftable/basics.h         |  48 +++++++++++++
>  reftable/blocksource.c    | 148 ++++++++++++++++++++++++++++++++++++++
>  reftable/blocksource.h    |  22 ++++++
>  reftable/compat.c         | 110 ++++++++++++++++++++++++++++
>  reftable/compat.h         |  48 +++++++++++++
>  reftable/publicbasics.c   | 100 ++++++++++++++++++++++++++
>  reftable/reftable-tests.h |  22 ++++++
>  reftable/strbuf.c         | 142 ++++++++++++++++++++++++++++++++++++
>  reftable/strbuf.h         |  80 +++++++++++++++++++++
>  reftable/strbuf_test.c    |  37 ++++++++++
>  reftable/system.h         |  51 +++++++++++++
>  t/helper/test-reftable.c  |   8 +++
>  t/helper/test-tool.c      |   1 +
>  t/helper/test-tool.h      |   1 +

I think duplicating things like strbuf is an unnecessary burden if Git
is to maintain this library. Something like "reftable will only import
git-compat-util.h and strbuf.h, and any project that wants to use
reftable must make sure that these functions and data structures are
available" would be more plausible.
