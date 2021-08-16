Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA603C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A4760F14
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhHPUKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhHPUKN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:10:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285B7C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:09:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w201-20020a25dfd2000000b00594695384d1so4570204ybg.20
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YzVlre/7ztstx78TnseAAR6TGXF/sPKGi+zT3FkEI6w=;
        b=nPxzWzOe2D6LqCWnGjfv+8Qg0SyJpwF1juT6NBvllY1e9YSBNthfZzcSwJjtHHl+p9
         pujsf0BsdrbLlFPHgD/6tJ9vliUHuftkCcNXtBijqkYGtTZ0CH4FRGWEk20ccw2tjiQS
         5F6daXouf8Y03hNQWBYujuHkZMbtXtq/SjHpJxIOYytsfiKqIy6EwvBbniC96Zpn/AV+
         RouyLq6ZRwzdGz2qjA6bSbCNy3/fSS/v3Uv7+OoBKqN0enbeTQmhl/jhFqjLcovYybP0
         VkOi7OuAuW4Imr3Pn+VEIB1eCj6DtvAiSyp2uNzzJB4T6MqsjvYm8Lfu6FAoT7B7Thoo
         ir6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YzVlre/7ztstx78TnseAAR6TGXF/sPKGi+zT3FkEI6w=;
        b=R0oG9PRZJxEVYjLRV1rV8Vmo6SGEkJyHkuQJkDPaTRzfJZQNqgk+YV5dLVv/JXIDiv
         ArutlqpFFi2xrr0BPQ0oYAQjOIY0YWxpQ3y67Lyip38+kbWoc2zYbMsmUag+e2bt+bU3
         8uTzS+CevoRnFNav6qW4vjXYIV8MXMdhzZHOsmqNBfUMg/jVr/gIRKzT6iAwUhHDmv2D
         Gc4jkRkWs+R1JHyoiO4EqTDbGCkaArytfSgGqFAspVlcowWcaj6l3utixqjEgrjaRSVT
         8fdVfSUpS9ii99hLK2z3BNR7uyaj7t81w6PQLleXsEQmXG4kaPRjPJVzFgPtI9iuqCtF
         9eVg==
X-Gm-Message-State: AOAM533+WtSSB7JlhLzSirZxsjMGWl8wtaYOWh8FIoknit4yCGGQg0nt
        XXcXKGpefhuZDFbrXiUhIk8kgBBBFuAm5tYffrOL
X-Google-Smtp-Source: ABdhPJyR9cx5qMgGuZHAeifePTCWFzYy3cEcrNyw3iHDzZAwxjkHJeEk9/wmaHugJhrolCMQPc/7x3o4/vsc3viDB8ue
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:e6d1:: with SMTP id
 d200mr167941ybh.451.1629144580367; Mon, 16 Aug 2021 13:09:40 -0700 (PDT)
Date:   Mon, 16 Aug 2021 13:09:38 -0700
In-Reply-To: <CAHd-oW4rd6=9WP-7k-Z9V1Z-4nDXR13-45cjyB6GEczxD3+56g@mail.gmail.com>
Message-Id: <20210816200938.1639871-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAHd-oW4rd6=9WP-7k-Z9V1Z-4nDXR13-45cjyB6GEczxD3+56g@mail.gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH v2 7/8] submodule-config: pass repo upon blob config read
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matheus.bernardino@usp.br
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -1827,7 +1829,7 @@ static int git_config_from_blob_ref(config_fn_t fn,
> >
> >         if (get_oid(name, &oid) < 0)
> 
> This should be `repo_get_oid(repo, ...)` now.

Ah, good catch! This wasn't caught by the tests because the submodule
config mechanism always passes a full-length hexadecimal string hash as
"name" - and probably would never be caught because
git_config_from_blob_ref() is only called from config_with_options(),
which is called with non-NULL source from only 2 files:
submodule-config.c (this one) and builtin/config.c (which most likely
will never operate on any repo other than the_repository). I'll refactor
the API to avoid this situation in the first place.
