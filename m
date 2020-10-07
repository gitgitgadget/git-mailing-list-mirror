Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A61BC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA64207EA
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzCBYjs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgJGUJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgJGUJK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 16:09:10 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705E9C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 13:09:09 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u16so1842292plq.18
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6XI2yQOZagMJOnBqpdvY+jRicxWR2I+qvywowchdWN0=;
        b=vzCBYjs4/lUABVpIh3iKQpbehESKdzmYb2Ltuuzty4KYOc5SsjFjxQaDCyMCNrAxyQ
         KJXZxMAbNS25ahw6C6MW31Xj5ax5SY902TJGStZL3cUsG/rgIBepdIYVsnny3zsRXPoI
         BLIdm5g30JsDxABZ89Z0c+TDqZ9zIibBzh2HrognUm+yP0y1rSdornmTlgssIm6h+xZ0
         kgeAXglKoa7v4gn5ZPwghmDHYSVZA3ep/8engaoZ5LFarPwrXeBafsYs0GNQefsXkxFt
         LNXgcYyvmKENevs8ilMqRSFaji6mLNC7Jg8aVl+cQuyi7hArpcw78lRyhJR/y7YE5+C7
         yHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6XI2yQOZagMJOnBqpdvY+jRicxWR2I+qvywowchdWN0=;
        b=HsfAR11Th22BTeDr5ckiX5msvSN3bHeibJqhPvcJFEBRGxf5d8BmS9CdudG9jq+3P/
         VuYRJI7gPrvhs5tF+r3ciM7E2ijaghg0Q93iFNvK+YELzEGzSLtGVa/DCOhugC0AYND4
         9j7XHFfgm+cLHKaRdrl1J8AuVRr92Yk/ojCqvdcVCwMFNB18rNniYsLFgaveE3o74XJc
         C8m+LkyK8ulKMDaIBzn5wE3c/6/F3441qktDawued4Mys7N+W36/36Jonpnd1dQ7VKFc
         hKCnunM0T/K2REXtryZT6UHR5AlXTq5jw6boyvAUsEkqeTYgcyY2XMD6sDQCk3jBUY8+
         HRcg==
X-Gm-Message-State: AOAM531g3Wr7nScWQEkTqp6x2c362AF3C33VTvIa+/81uhjIi0nXCxNC
        HkLyhhpaXqoyg//UdpnXxNn8IxPnFzSCS+Lfdz8d
X-Google-Smtp-Source: ABdhPJx3wxsDablvrV3a47nhrDRRIS9u/2wJYrJCCRVe/97ylHo8NrCs28qNR2Up/g6oQTbjA+dQ6oAgeMeFXgZ7sBie
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:b107:b029:d2:ab87:c418 with
 SMTP id q7-20020a170902b107b02900d2ab87c418mr4386934plr.40.1602101348943;
 Wed, 07 Oct 2020 13:09:08 -0700 (PDT)
Date:   Wed,  7 Oct 2020 13:09:06 -0700
In-Reply-To: <20201007181943.GB1976631@coredump.intra.peff.net>
Message-Id: <20201007200906.1318031-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201007181943.GB1976631@coredump.intra.peff.net>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [PATCH 2/3] index-pack: drop type_cas mutex
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     gitster@pobox.com, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The type_cas lock lost all of its callers in f08cbf60fe (index-pack:
> make quantum of work smaller, 2020-09-08), so we can safely delete it.
> The compiler didn't alert us that the variable became unused, because we
> still call pthread_mutex_init() and pthread_mutex_destroy() on it.
> 
> It's worth considering also whether that commit was in error to remove
> the use of the lock. Why don't we need it now, if we did before, as
> described in ab791dd138 (index-pack: fix race condition with duplicate
> bases, 2014-08-29)? I think the answer is that we now look at and assign
> the child_obj->real_type field in the main thread while holding the
> work_lock(). So we don't have to worry about racing with the worker
> threads.

Yeah - I probably should have made the change without removing the
compare-and-swap, and then removed the compare-and-swap in a subsequent
patch. Thanks for catching this.
