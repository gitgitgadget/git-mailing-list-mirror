Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC5C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 16:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D1B6108B
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 16:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbhDIQYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhDIQYd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 12:24:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3641CC061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 09:24:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v186so5826658ybe.5
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 09:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cfNINLNdJCGRvf0WlwSY2LIkLbw58sBXMmtUDGy2kt4=;
        b=KX4vPCp/7tLxS2Fropn2Grw6dNAW4TvAgmCel25H9/QkBhsCvJojGmKbipn+Yq7Y8t
         aocyQn+YQJjJIf60ppXf6yb4sYVsBCGkqe19Riv+dxhLmKZMmGexwoaw7MS/jJDyPJQN
         Uhdiom3tcYPt0XTpbwm4Ayo5jm1uCrAr/LvHy4qAg/aVVdO0LVgTFebAq8nA1zuJ9cnr
         Iq9ujBY0MSdtdYfKFZoLe/ed4Di41qon53nIYgdaHSX8QcHvouz5XFUaFrG5qofDrUoP
         3Mt5n1AIEUqsAwpaixnGqmmOZQYYFc+jEnqJw+um5M8L3Qiwoh6jdueSy3PAo9ntrCJz
         505A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cfNINLNdJCGRvf0WlwSY2LIkLbw58sBXMmtUDGy2kt4=;
        b=oELAYFHR2EqF6bJDpyi1MIpNLsUR7Kapl+1k/f3eCmEGr4hK9kasdgsSHdDxyZ8Rsz
         Gg9NpYvSkrpmeeY74ZK3/sRT5peKhkkZnjCo3IC7jOsi/3OUWu4DDWGWTjBh7vVHyZBV
         evlHcqP7OBDgkEAqneVSpLgoE6RHO0xmT5R44Z0EhZj37LGTQkvbqcLfpfnNDYuCpEda
         /ZULqt6yLRIXypNjgDlSw6JA6lsqOcDS3PO0dkpabJjUVyUhAMH28juMUA1UNwFi74q1
         w+NfObZYu89Clan2+RHPONRmGX8d7Q6w9zDxkaLahSbyEIoHnft7zdqWxVLEPSMjK6SR
         3/Kw==
X-Gm-Message-State: AOAM532e5eb1eIH1oIaD/jZMf8zufGfU6dq6ivI9PAhJGT5wfxOHSjLL
        3y+mqAdztMyJiJScMsh6jGR5l4+TYJd994Nxtun4
X-Google-Smtp-Source: ABdhPJxmu6yIM+idX+nHPDYh7l/b+Q7lUIoC8xR/7gZEjfc7BGest40QD8Me4SqP1aQ1zDhXVGqvUfs6/G5SB25lD82y
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:10c5:: with SMTP id
 188mr17352746ybq.38.1617985459328; Fri, 09 Apr 2021 09:24:19 -0700 (PDT)
Date:   Fri,  9 Apr 2021 09:24:17 -0700
In-Reply-To: <xmqqy2dsnjuf.fsf@gitster.g>
Message-Id: <20210409162417.2558134-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqy2dsnjuf.fsf@gitster.g>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: Re: [PATCH 1/6] fetch-pack: buffer object-format with other args
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > In send_fetch_request(), "object-format" is written directly to the file
> > descriptor, as opposed to the other arguments, which are buffered.
> > Buffer "object-format" as well. "object-format" must be buffered; in
> > particular, it must appear after "command=fetch" in the request.
> >
> > This divergence was introduced in 4b831208bb ("fetch-pack: parse and
> > advertise the object-format capability", 2020-05-27), perhaps as an
> > oversight (the surrounding code at the point of this commit has already
> > been using a request buffer.)
> 
> Good find.  Did this actually resulted in a data corruption and that
> was how you discovered it?

No, I did not see any data corruption. I discovered it because I was
looking at this function, thinking that I needed to refactor it.
