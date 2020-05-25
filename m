Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E36C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A3120888
	for <git@archiver.kernel.org>; Mon, 25 May 2020 14:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/cnCGYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390911AbgEYO4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 10:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388687AbgEYO4C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 10:56:02 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F94DC061A0E
        for <git@vger.kernel.org>; Mon, 25 May 2020 07:56:02 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a68so13968131otb.10
        for <git@vger.kernel.org>; Mon, 25 May 2020 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4hQ84u/eZ2JJirYypSa/7SmRyD9mJEwVhaZv4v4VgU=;
        b=h/cnCGYbYsdAY3JrTftrE50urvPOTN92UIuIhauv1wNpr7yevQWv70p0jjtPbyNzY4
         eikA37iA0nzvt7rM13BSmdHk7FR5QI/HEKUdbDSZGGtc6KtI2cQLdD6g4zmq/wVP4Hd5
         2ML1fsCVpVRv0YFBYq9C3oJO1xYmjdw1k6p6U4VNEuuG8sib2nzD+WhB3vl/QjGzmakK
         Vu+iSvBzQbZSnrruwJclxrRemk25jOjoZjDhdpqLCDczqQA0FWnqbdVQaLXx/az81euZ
         j9E63620CnIYs777HiwLOxzCjV/NowDq9e1zRU37ZzlGvdtDCz7ZUpVoUgpNy/B4h6Qc
         gJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4hQ84u/eZ2JJirYypSa/7SmRyD9mJEwVhaZv4v4VgU=;
        b=ebx5CVoyFw2jFGA12rr6qEpCaVa/dIhQ2a+1RM9go83fsp1Z7sIdQbe0i+OuR4fjjm
         Q77gFUyA0S5HTrbbgM6kG4IkAYgXeP5IR46wcIXl8JB9CNlQfUFvPveS4dMEtwXNsGOb
         w1IdpSShc27VPE/Jh2Ovhrh9qC96Dr2Krc6DysC4T/K01TKkDybC7LQPp0Uiod19Y3+Q
         /F+6ALd4rolV18VW4LkHJnXQnLtnohdx1XSQAVvLZenoUuAybhtas2nmHbcDUCgJFgOz
         x12mLb5eZCxIqpjO8dw45cdHN7wyqYlXjlZ+FHPq0zwafwg6B+ozBbIeMx66yOrA5mYD
         uewg==
X-Gm-Message-State: AOAM531rYjwBKFkshQSQGZ0Ke/B5CWv1AhKrw1LNWz+i9U9Gwr7Pm4ZN
        nATXZrTOvggpZUR005B6TqRTz1kSHlADDrhW/QQ=
X-Google-Smtp-Source: ABdhPJx/n0YKGTCH+h6y1FoFdrBfFatAWqksS8Z/JeUVYoaJG/dWFQ6w0RTidiprlfa37IdKoiOWWnmc/NWQjF4BITY=
X-Received: by 2002:a9d:24e5:: with SMTP id z92mr21998385ota.345.1590418561586;
 Mon, 25 May 2020 07:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh7w4pulj.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7w4pulj.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 25 May 2020 07:55:48 -0700
Message-ID: <CABPp-BHxeDQS5QXd5Sf6Ws_58-aze_mes3xRvGZYQNWw3Et3VA@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2020, #08; Sun, 24)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 24, 2020 at 8:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> Git 2.27-rc2 will be tagged soon, but most of the topics planned for
> it are already in 'master'.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>     http://git-blame.blogspot.com/p/git-public-repositories.html

Looks like the scissors docfix at
https://lore.kernel.org/git/20200522142611.1217757-1-newren@gmail.com/
may have fallen through the cracks.  It's not important for 2.27, but
could that be picked up at least for pu?
