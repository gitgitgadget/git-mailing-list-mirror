Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4531C433E9
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B655D64ECD
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhBIUCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 15:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhBITq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 14:46:58 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303F2C061A2B
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 11:35:03 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id u124so13583705pfb.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 11:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=04+bgZTWOnLH1EnmqiW1ovx3/r9jc40jAtZozEbynVY=;
        b=ufKRtML0cOS2x6RKHke/m4bthbpEHsbYZd3xA0QNLNtBSCgrAvWGUFoSe95ys4oZz2
         kAa50NwAbmhrqFeuagjVAEAD1743Hw0VAQoOmK3Lb3jz4faRx/xQajCdOhaP5ukgAL9A
         fzpylukc0OW+JacO/ykIuqx6XlXhefzCrpRtELyjLS9xcn0UYubibLQI0nM/Imf1o5G8
         WFvN7nWbop4X5NZSkZhn6PyydCQ9iMJRGmeAE20Z5OT4o48ABa5ltyA6EsNC+iF1bWHp
         CBAfBLAPc/vvEyG8IntWSJf282Hm9iWh5bZy+NoMQgETzhlw3BQDj+EtZf7NXj+rc7SV
         akDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=04+bgZTWOnLH1EnmqiW1ovx3/r9jc40jAtZozEbynVY=;
        b=OYY9KR7DOOw7OdI2r0/ScqGNySi+3+WyQlDyhzB6QpB0P0YusbBICC1plvsyi9oZmH
         5AyxHWFktBDvLJ57XJNK5NsdhsiYIEPbANtSQH1Bk6GE+eeIv1HFMhc9G9iFLj/5XuUK
         qFOOahruGthXNmLbXiTAlqyz0DBKwcxMzuCR4rKOHtkOnDZqAKTtU1wzjq8oVYB535uA
         l3QBbkbzJpSob0JYUHBwkrI8tX+xjq/xD29g9XlSRMSHxV+b52fBwUrBt4IF0waa2+UQ
         CAjzoKnQXG0CThzJLaRyrmpb1tlB4LdX9R9+OFcpdbDVI0+8xXy/eoj9VRUuo5Uj0jjk
         iB0Q==
X-Gm-Message-State: AOAM533HYffbFoCPrYiUK7SJtSBgIsa33yO6DmpKPbCsKk/8nvm5ctVR
        Rq6RZJwtje417Gyo/Kw5gyAvFEasrjRpvADMz+Vc
X-Google-Smtp-Source: ABdhPJxzYleE0rEXgK70F+jaSsnBNYOyYWtG8lF0s2pH5J6yVi5Zolgv0ALb3RPpCeOy2oo3Go8UVRL1+2zOx/9edDD8
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:f1c2:b029:e2:fb7d:7e58 with
 SMTP id e2-20020a170902f1c2b02900e2fb7d7e58mr2578016plc.54.1612899302740;
 Tue, 09 Feb 2021 11:35:02 -0800 (PST)
Date:   Tue,  9 Feb 2021 11:34:59 -0800
In-Reply-To: <YCJ6D1wGgmo1a+KT@coredump.intra.peff.net>
Message-Id: <20210209193459.3100734-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YCJ6D1wGgmo1a+KT@coredump.intra.peff.net>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: Re: [PATCH v2] usage: trace2 BUG() invocations
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com,
        gitster@pobox.com, jeffhost@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +# Verb 007bug
> > +#
> > +# Check that BUG writes to trace2
> > +
> > +test_expect_success 'normal stream, exit code 1' '
> 
> Is this description accurate? It doesn't really seem like "exit code 1".
> Maybe "99", though BUG is probably more accurate.

Ah...you're right. Maybe 'BUG messages are written to trace2' is better.
If Junio doesn't do it locally (or if there are other issues that need
fixing), I'll send out v3.
