Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C119C433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 19:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5B360F12
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 19:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhIETUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 15:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhIETUi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 15:20:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7195FC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 12:19:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c8so9059037lfi.3
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FSwMXtkBgmFRRkPW+W0gLkpEwK3jpnhk2LfX27QA0D4=;
        b=P6rtH3IifYDgQiw5PNrE/1LZJgm1YIncsMeO/QhQ/TapAFXP0ajrRS6HempeTLWNEi
         mZPhqz963LTdIk39JmXYiowAhbhjcOvxy4hP1SU36bdAHWmn8u2WvQhalmtQYGdgsb4Q
         j4QKRSwiLMSfnckfcSn3T6vdhjeCZmWlCi3MalVeB8cXWfYLsF/FU2JG2mcn2lWCYAIA
         fGbKr0JPrXvQBgkPa6mDsc6YRqVmIMb/mHLnP35OOmKag+CM4q9k5NBITviQq3uaLTFg
         KGl/erYTrndLmti3u74DEHJ34Bk0wErvs3ExAvezN22rO9pnhgKw4mg8YaQJKJfcw6Gt
         xX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FSwMXtkBgmFRRkPW+W0gLkpEwK3jpnhk2LfX27QA0D4=;
        b=VgaXjNSD/1LIHp39GuCUO+St19KAKDiebRCK5mY0JIUbm7PskuAH1RvNhqs36zYTXa
         nll5vgnSTx0qsz/+DJsdW8HEf0vrr1uuZ/QoL57hxVVvWOb6VDzeUIGUcbK+2dCIwl1j
         tQsPitDictZqy1lG8rlqA17pjgNVdPpWg2yYcb7rncgPY7DKyhrbrLAOFQ2mGOP4MCOv
         KH0pnGXPfavWqh6XTQ3nohsZ9Uosrc+drS+ggw8pFrD9l1uo/bD9hngPGgcHo3q93JhW
         GU7ULtNrDwjXLC/WrxvQPE3gxwW3IQyAD+rrgAjKgOyXKraSxfwh9iPvGU+XOLTavjT1
         kRRw==
X-Gm-Message-State: AOAM531/+BAfdydXRjXQs3oVsNaVCAC/VdiMhIwCOUBTN+eAbad8x1+r
        +/qVWB8hYfTZNVW30A7xokVqBrC7jZ2Chp4U3HR7VjJY
X-Google-Smtp-Source: ABdhPJzBuNVVHDoA7AeYuYOCSBwlCL6zOS/lo+KwJaXHIhuv0kIPvx/zJcyRICuuYNziAX06+jkbg37kfnrbCSnAt1k=
X-Received: by 2002:a19:ee14:: with SMTP id g20mr6835480lfb.299.1630869572816;
 Sun, 05 Sep 2021 12:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <0e1f7a47-89e3-5f49-663e-bdd3e8efb6e5@rawbw.com>
 <CAPx1Gvc6noTDYPt9x3b4_TE0z8-KE5cB6KQHcn5UL9pi0cKoGg@mail.gmail.com> <5f09cba9-b7dc-d7b6-1d3f-e7fb8ca28c6c@rawbw.com>
In-Reply-To: <5f09cba9-b7dc-d7b6-1d3f-e7fb8ca28c6c@rawbw.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 5 Sep 2021 12:19:21 -0700
Message-ID: <CAPx1GvfEW4rVHjxmmNmAEOVYFgeehbmDQouCWWZx=aiiDy89Vg@mail.gmail.com>
Subject: Re: stash push/pop unstages files?
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 5, 2021 at 12:02 PM Yuri <yuri@rawbw.com> wrote:
> Why 'stash push' and 'stash pop' are asymmetric in what they do by defaul=
t?
> Wouldn't it make more sense to make 'stash pop' precisely revert what
> 'stash push' does, and have an option '--no-index' instead?

If you ask me, yes, it would=E2=80=94but it would make even *more* sense
if `git stash` didn't bother saving the index at all without `--index`, and
just errored out if the index and working tree didn't match.  But I didn't
write `git stash`.

My personal recommendation is: never (or hardly ever) use it.  Just
make a commit.

Chris
