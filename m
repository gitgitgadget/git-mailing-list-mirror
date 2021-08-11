Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78D6C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 01:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D8C60F25
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 01:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhHKBsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 21:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhHKBsM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 21:48:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B558EC061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 18:47:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w14so920303pjh.5
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 18:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9smVm6K8ReY63Prk4vRam8fAcz+VpbM5zwrVPLFqIY=;
        b=j9YQd5lOPcuyH1nxJu7cDoRtKeGHJgOVk5hoCnZrhdEmBs+PRqekEs2G5RTBZ34l2g
         0IJxNtEIjCW8tPeHAR4GI7jhzgbQLrijdKv9xSlxMDQjItcUPTzTVNvl93m7tYEPF7HE
         JwtDaVOntdVYrtdeWjJBNq/mzUuPT80qcntNWS9YZ79P6otQtraZKODZMohnqp7wOyGe
         4XQdT8ZMUJsndY3tP6pTu4nFPK8vUxKBn9Fl7pxxfqp0lXYeeqRIaTqLLO5+rMgf62Xq
         wsXZyVGCdR62fqgQWib0uOxd5GESgrWEKWpFk6VE/E/F6f7ZuOfosficLKxUFrxeQXP6
         xcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9smVm6K8ReY63Prk4vRam8fAcz+VpbM5zwrVPLFqIY=;
        b=WqrGV1h6TTJVE4FbfFoVANrnko9aa0CGHf+kUQHvhJ4SCAt3ni0xYUxE26hYj9+Uo3
         TsZxBdeGPRwHovRy4jOHgjlGpv3DD/HjGTaJQ1vvXLgVQqpibFVPXEr0YfXUQ54x8U8Y
         v3wD5bTLdjWpTXVkTlM92tEpw4cMj62EsL6Y5qhGhX55Yvxfi1lQJVRCSNLWbUPZYdPv
         o2V1OTIeOmnqzn2Wrd333+YlI6EGBxYK+ZWuS9Y1PQh8rBEuQtimg3Rhoo4g6WjyCEsg
         8BqSgEV4KrXU8Z9DvzudLFR0kyq8/qF3nZxkQsUrBPxtKbKdn4MLU+x+vF5MYf8KXyxV
         6Vsw==
X-Gm-Message-State: AOAM532MT8Vp8Ooz2iyWYHdI0J5dMmwxzZmzzkghByUiwN9dIwW2tl9p
        QDm4VYLwmDf+aJckKXAR7CY=
X-Google-Smtp-Source: ABdhPJwD6ttvtS6TITOjTWBAcluw+15M3wATYr/EmkI/VKcU1LdUraeFnFhzDcGrxRo6Ke+/wF4Eag==
X-Received: by 2002:a17:90a:5583:: with SMTP id c3mr24859786pji.133.1628646469355;
        Tue, 10 Aug 2021 18:47:49 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id ep21sm426900pjb.18.2021.08.10.18.47.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 18:47:49 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 3/3] packfile-uri.txt: support for excluding commit objects
Date:   Wed, 11 Aug 2021 09:47:42 +0800
Message-Id: <20210811014742.15594-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.449.gb2aa5456a8.dirty
In-Reply-To: <xmqqr1fkhk5w.fsf@gitster.g>
References: <xmqqr1fkhk5w.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>Do not hint deprecation and future removal with "still" and "for
>>now", before seeing a concensus that it should be deprecated and
>>removed.

Agree.
Will remove.

>>The new thing, <recursively>, deserves some explanation.  What are
>>the acceptable values (yes/no? spatial/time/both? infinitely/limited?)
>>and what do these values mean?

More expanation.
I think over about <recursively> and consider to remove it in next patch
because offer a pack only contains commit or tree object individually
may not make much sense, so <recursively> will remove(as default on tree
and commit object) in next patch.

>>Why is this limited to only <blob> and <commit>?

Will support tree but not tag(maybe furture work) in next patch.

>>There isn't a fundamental reason why I shouldn't be able to say
>>"v2.32.0" instead of ebf3c04b262aa27fbb97f8a0156c2347fecafafb (or
>>"v2.32.0~0") to say "I want anything reachable from v2.32.0 (in
>>other words, that version and everything before it)", is there?

>>For that matter, "everything reachable from this tree object" may
>>also be a reasonable way to specify which set of objects are
>>offloaded to an out-of-band URI.

Agree.
Will provide more detailed instuctions in next patch.

Thank you.


