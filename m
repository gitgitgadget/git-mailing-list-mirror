Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7967C433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 18:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C28222A84
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 18:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbhAZRRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389572AbhAZHkG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 02:40:06 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36FBC0617A9
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 23:31:58 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id n7so5677460oic.11
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 23:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Diq8uP+j176lWfo7o/eoHj8jVh+6PZTtBqXoNmqywwE=;
        b=AF+0U/xpnNJ47VHZE3gMRHeV+mRpzpIdfLESTyOZTYh0FmdLcVUQMqZ0d3dfEIDLZq
         XRCgHZDaSIzzni7AvxhsCFNT2sNF3oQbdAO20kkrFYrtEBRCl6dKb0ouj3pbbOMO4TRB
         VRg1P7fkemwW8qK96oRhYuffzE9ZDGtB38RpEJAfhy0V04fM8IW+SuzApRxdQwXWfg+n
         PM0i8Nh14XL0Y0+/76gJOm1uV9tf1wCDtA9JaMncybkXfedAIveHHsmF3Uxa2Qa8Rtei
         1hgWheFx8SzCacIehnufGQ/D+O2ox34/hz0yu0cTWgaGTvjMsO+KJTPaa6VpXNXSkiiC
         eKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Diq8uP+j176lWfo7o/eoHj8jVh+6PZTtBqXoNmqywwE=;
        b=phbwVq04KfJ6FJ8hPtHKpToZD/Y0SJ9tee3PMqPe6nasDPE2HzJEZnPVa3DxVHdG9p
         bLqNu7WBE4sIDA/Y2EbFemm9XgzbyDY+qNjwQdE8ipwfEL4F3dUEtgxSE+YROOx9JmaS
         oKBNT6mTlRru3VEgnb6lK7scTID1oBetxYRvypuqlRy/IOIXkReNIIe27W41b9klcRNO
         vUoy65V4Heokpz7WZ5ad1b01KBzvDcxYAJlxcRG44X5du97ZOBY8mPlahVTEn6pae7oR
         C2+qdzfEDq3ieMraySAgxN8DvpvQgNEARoQq8OHjNDqmCnRHSGvNsH4HoMLpFvkV3TU7
         fUUQ==
X-Gm-Message-State: AOAM530/l9c4+DMKQ9V1s2R0veAnxwxtXMvfBNl6icFVrXxhiWuOQH4G
        f6mCYeAXqY3l0BP25iReUJSQMHrUMVIJxHjpx87zLsZBFgM=
X-Google-Smtp-Source: ABdhPJxaxYzOEbWjldUHfQiRHPcZ6GxNNb0UMWvBplPjCJz0Wn/ggZIlpn7MBAqDAzKa6BTZn6O/YqBAqRTe3LU9Ws0=
X-Received: by 2002:aca:de06:: with SMTP id v6mr2345641oig.60.1611646318290;
 Mon, 25 Jan 2021 23:31:58 -0800 (PST)
MIME-Version: 1.0
References: <CAHjREB6+=ZT9B-XASAk7Hqt7qD5YhgROjDLCKoJR7cNyJDpDMw@mail.gmail.com>
In-Reply-To: <CAHjREB6+=ZT9B-XASAk7Hqt7qD5YhgROjDLCKoJR7cNyJDpDMw@mail.gmail.com>
From:   Sangeeta <sangunb09@gmail.com>
Date:   Tue, 26 Jan 2021 13:01:46 +0530
Message-ID: <CAHjREB7CRTHX5Z1Sdhipz-NPFxd=uFthyvMMiny17BuvuiE5yg@mail.gmail.com>
Subject: Re: [Outreachy] Blog Post Submission
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Everyone,

Here's my next blog post on the last few weeks update:
https://sangu09.github.io/testcases/

Do read it and let me know if you have any suggestions.

Thanks and Regards,
Sangeeta
