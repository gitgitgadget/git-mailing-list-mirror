Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0F6C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbjELVZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjELVZN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:25:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B51731
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:25:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9968fb4a8cso19127288276.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683926709; x=1686518709;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B00HscbTEp644MDgMBOsb2d0bpbRt3L0b/xaFAkfLWE=;
        b=EeIVkyS9s5x1zBaIJSlXTTaTwn1VL0r4TPZKsGN8lEFqDCqZ4S+PysPs0AxrYtGA42
         hCNf8xlZ/r0Nr7byw9gTmLBxfj33VWoyBlCXVw2xp2hOh1Xg35TW0Q9MhQykifNqhHja
         aDCeuFrKAGHsr05y7fq6oIZA+UgR4JBQxj/apHX5/D4vMRahggZVeybcD2KG9wMTbcHS
         EZyc45Yte88iv6TKz3WFnJC23r+pjiMTB3cMu/rCt0kTj4pb3RSfIMoSi5s6t0ZkTw64
         ZFFD+gRZw+h+hcewhuIv+MFBpCF9J2FhxJGrmvlOiKOaeEAd39TzuT3E5zT0HNQjZPKp
         Irsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683926709; x=1686518709;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B00HscbTEp644MDgMBOsb2d0bpbRt3L0b/xaFAkfLWE=;
        b=dnGuuNcr9D3D6eKmrw1dIumM37qf3gqsrbvwrNSfVbohov7DSNIUZTRq/fz0mc4pDo
         CDo54RMVJugpFK1+Sbfd4Y7jzPyH+UNnpYR+KMa6rFbS19phyNonhG5EAmkSeNM0UvqF
         qiDKwB6ivkUYIlbUFZSze2oDSe5dBQf6L/s6BUGUr8lSR3mczyA/aL7/yzAe/azdU+ud
         p1mKGkX/nMBzL/x2tJ5dlEXd/vbh4qbrXWfREv82Xr+6axR4m/bjZVQyIg3x9/k1YxNK
         7YtpYtBZzwRghB3DRfqS/l2hkHxFGBURUGfnaUro0UwTr7YDHr5m2I0fgEdnFoYzLH7r
         toew==
X-Gm-Message-State: AC+VfDyqWwm5luin5yoVPJLLbPParGY9vQFw62bGz4DHPS3rgLgBwWdo
        bfVeiKVyUL23/6ldEeFDvqbB03gET0NKn3RJNVrj
X-Google-Smtp-Source: ACHHUZ7s+VLb3oDco6X10yigYwxV+g4NYUAIcHnCNeGyfn7okiyw/1e85iDEjc0PYBymL7c1vr9QOt2xeyvSNXNE8yld
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:fca5:20a4:493f:ac3a])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:5c8:0:b0:ba1:919a:8f08 with SMTP
 id w8-20020a5b05c8000000b00ba1919a8f08mr11386574ybp.2.1683926709825; Fri, 12
 May 2023 14:25:09 -0700 (PDT)
Date:   Fri, 12 May 2023 14:25:07 -0700
In-Reply-To: <ced75f464447f77fc8d89b5cc97477352f6bfd02.1683875070.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512212507.1125662-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 05/27] read-cache: move shared commit and ls-files code
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> -void overlay_tree_on_index(struct index_state *istate,
> -			   const char *tree_name, const char *prefix)
 
Thanks for moving the code in such a way that it's easy to see with
--color-moved. I saw that there was no corresponding .h change (unlike
the parent), but this function is declared in cache.h, so that makes
sense. (I think this will be dealt later on in this series anyway.)

Up to here looks good.
