Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9A7C54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46652076A
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMGMAx/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgD0R1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgD0R1l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 13:27:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E49AC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:27:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t2so21202017ybq.11
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PJjTGCVpimlE4w+/oVN7ZQrf2W7zKq+0soV9vy8KtMo=;
        b=UMGMAx/GTsSvewoRyH/tVuzsxQbpQQURRmtVGuSe0t9JoGyqujybTmlaLwQo3TY31Y
         d0zmZOjxOjwwFb2u0+XJvlBhYx8VnEmDjBBlhwTyU6ucQfMzT0bexT5LzQS+Khh3CBRe
         D+m64r20jGwmUHmwvvDAeaCKpCg+9cnOU0/FNw1pF9bFT57Zvr4Kx36qF1fMJEuhvkzw
         PQcOEDDfSaiAXmgFfC3q1ZnN7S0XFW0GN0mzsXcYVfi/NqTk3h7gsLNzhsj5Wos9nilh
         XeoudWLmFblHsT+1k24l5M3q/+MfvQcZJSXcylqTrvHcwp0m0KRVyxS/XXKcoDv4F5L/
         O9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PJjTGCVpimlE4w+/oVN7ZQrf2W7zKq+0soV9vy8KtMo=;
        b=lUmSLMvY1C+kJM2wcGG/JlZ0q9h3eMpaTf1NibUCvwOb1p/jMgWC9As2xyCcKd3Tm9
         BEAXraBP+HzUDpCrZu6nIBY5wR4G5HAp9LYXn7ufFt6e827CvKFttw7HC3TRJDoc/wdM
         jK3588DTszpR8ceye+tfycqoUD6AecQvSom11+JcadEsmj8GatdEsVJdwqtX879q7OQt
         mOJpRq8A8EaNTvO1nJb1QM2rEUdNEqLBiTKcWK/6mXPrHp4BuCyah9qLdIP3/SFd8NBF
         QLQiKtUBR0OvVtUfrgvAWIfDUgnB5B8COOS1sCWCbSbd7cTKr7/wVut0ntB9Zn/AKRT4
         2JUw==
X-Gm-Message-State: AGi0PuZjCp3eaFCzpMvx27cwKnTc8U0mAU6Pm49kZy4K0CiuOl6J5do3
        39rdOJq1uUC4OWoBRC2nsfeFHUXZ7cg4odxra8X1
X-Google-Smtp-Source: APiQypLVuThwT8aEuGthDSV+OwhOWAN8OdVgo33ieB6vOf8l+tBklg8gi5+F5imvQKU/j+H4lJujL4k8VxzMgVrS+iQR
X-Received: by 2002:a25:9cc3:: with SMTP id z3mr39334220ybo.234.1588008459945;
 Mon, 27 Apr 2020 10:27:39 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:27:36 -0700
In-Reply-To: <20200426002802.GD877@gmail.com>
Message-Id: <20200427172736.61159-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200426002802.GD877@gmail.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: Re: [PATCH 1/2] fetch-pack: in protocol v2, in_vain only after ACK
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jrnieder@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> not about this patch: can these return values from process_acks be made
> into an enum with named enumerators?  That would make what's happening
> in the call site more obvious.

That sounds reasonable to me.

> > +	cp trace /tmp/x &&
> 
> Leftover debugging line?

Ah, yes. If Junio can't or won't do it locally then I'll send out
another set with this changed.

> > +	test_i18ngrep "Total 3 " trace
> 
> Clever.
> 
> In some sense this is a fragile test, since the server could change
> how it reports progress some day.  Would it make sense (perhaps as a
> followup patch) for this to use a trace2 log instead?  For example,
> if we turn on tracing in the server, then since 9ed8790282
> (pack-objects: write objects packed to trace2, 2019-04-11) it will
> report how many objects were in the pack it wrote.

Probably better to have tracing in the client and use that, but this
requires us to add that tracing. But in general I agree.

> After removing the "cp trace /tmp/x" line,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thanks.

Thanks for your review.
