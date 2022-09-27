Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3CAC54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 17:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiI0R4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 13:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiI0Rzs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 13:55:48 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF4113E36
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 10:55:44 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f189so13105397yba.12
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TJLiLKfMjLn9WNZ2xxUc9nFmSkXBR+cZWMdrEVd1nmI=;
        b=sPJZMbhI50zKQSsXUONwTn46PCfSOEGSPaUQRzSYrDonSZG9LFyrZrhFCsZ3U7K1VE
         HBUPn9nql3pxG2CcZO8hUqp1dU4rO9QeuXJF1+s5e4LScd+7t1tq9eJGvjE41eu52790
         Bak/AmPeKdL8nFQ6p6a9ZdEB4VNZCwIm5WxWde13x24lWgiZ+9TNtxi232ABN8fBD6N/
         AHYbQheV/OXyhR0SkYlOs4MgafXntZD40kGY+l5MdlfiLQvaDAkuCAzie0PbyiX+NMEA
         gtGL3iSNzplAoWymCnhxbTVHs5zRZ0rEJkeNSC3OME+DdMId929klw9yyHUJ+Vf6mAYq
         RgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TJLiLKfMjLn9WNZ2xxUc9nFmSkXBR+cZWMdrEVd1nmI=;
        b=2nn89eHQEJpzUKc6AkoSJdn8LNHemXFcrWPtFEVBJdKHGx+hHALBqKXkyyMvlnhRMV
         gPjlo8VzfpDk3qkTYgWq06b1DneIkmX1LLmrwlOoSiRfT4IdIvKulGvJk3W9gJx0NbP4
         dprAmHY/xL8Mjn6NM8ZrH8XYnlyeJ3ihEoLse1nbNToUAA+k0zmAbRxEyRvMIYy8spH7
         0jme0yr2qTY1+3VRa6EYv1+s92SayRTZAIu7UfisXDcXEM8M85MdQ7UcnAgtIpr1Tqp6
         mwwzzwOEYHfcEeNQVJ+eok3biVwgWQWcK56hZl0rS/Cvp3TyNNA2v8EsGIwqZTWg/BLC
         AiFQ==
X-Gm-Message-State: ACrzQf2XwCzTIvr8l51undTiVfRX0H5YZyY74+Z6lKUtm9/mBTJ+7wr+
        a/FAaLCS3B6On+MwvHp86E5wiw/Tng0DinNuVTklwlTOcEI=
X-Google-Smtp-Source: AMsMyM4jYoBjlPz8qab2g0FPi1dqs4z0HxYUN8u/mebTS7H0DH13qi0OkIawyRN2QZu04+QroBl7/y0Sgf+vUr1VZus=
X-Received: by 2002:a5b:5c4:0:b0:67b:89d6:cbf5 with SMTP id
 w4-20020a5b05c4000000b0067b89d6cbf5mr26386644ybp.286.1664301343632; Tue, 27
 Sep 2022 10:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com> <20220922232947.631309-2-calvinwan@google.com>
 <xmqqy1u9uddc.fsf@gitster.g> <CAFySSZA=tThoHdTY7+bMStvC=xeeyMiv4aVDYt-eNW2mQE10qg@mail.gmail.com>
 <220927.86ill9yymv.gmgdl@evledraar.gmail.com>
In-Reply-To: <220927.86ill9yymv.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 27 Sep 2022 10:55:32 -0700
Message-ID: <CAFySSZBSAW=zea8UoMiaQkf8rdJUBGHDYZQFkPLW7mRSciS-FA@mail.gmail.com>
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I don't know if you started this work or not, but I had a WIP rebase of
> those on-list patches lying around in my tree, which I'm rebasing on
> "master" currently.
>
> Some of it's a bit tricky with the in-tree activity since then, I'll
> send them in when they're ready, maybe you already did your own rebasing
> of them, or maybe it helps & you'd like to base a re-submission on top
> of them.

I have not started on this part yet. Do you have an estimate as to when
you're planning on submitting your rebase? I'm also considering not using
my pipe_output option and going a different route since there is the
issue of dealing with potentially unbounded output.
