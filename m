Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4F1C433FE
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 22:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiDYWdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 18:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiDYWct (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 18:32:49 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309A463BA
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 15:29:08 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w187so20308557ybe.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 15:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkVtlMan80AYPM5uO3vRkNSq2PiqUepbqJJ0Bhyztjc=;
        b=QpqntFrnvDVU4r8YxBL6gVFW4GTgP8JfNR6gqGVGC84sT6FRfNmojiI/XYIqdXwe/a
         Z027E8tdFC02BrEKRNaIU8apknlONtk0aCZfhqFQwpAskN+rn1eXrQhwhQQSagOqWPGI
         7UyTypBwd+Grf3LaIUOasn+CXLSABQKiW9+m2RnM7HctXHXLl6mJ9gSx6XZrpsyFW7Kb
         ALrxeJFRHk6YUMqjckfdAh5WM9ytbtI7zX+9q6H0O1mbp+A6Rp25m+d5xLEr0VBtxbcC
         7WimlMmlhX3nIOnYJ0HLSyOPuo7TTMr3o4QcD5V3iGloGM+lHfMySfYn+1Zpo4G3j6aR
         G8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkVtlMan80AYPM5uO3vRkNSq2PiqUepbqJJ0Bhyztjc=;
        b=kn3h/EK+iVK0hVXAFQGnyuQrZBIcMep1MqRHEOJSe1eANfBSSo5PKiIbDEAWP4HcXj
         OdjQKMmHgpPOBVbKx+Og8qm7nYrahZi7fK4dR2cUkV1gEGARUHPR5HLVKTCmq/z9ipgw
         5Dd+3hjmDjYNLfaqIcypgck1pl9MCm50KwJ92u8lSX41E3bI7WXp6BR9TRHLZs1G4FW7
         zMPksO8exQYHcPWaimy0ntkKCOPdDcJwExmysxb+NYsa/XMVpTm3CZsvEBVJ1zK1l2l4
         amj+XlQv+ZB5z/K5g1E05lpLHYy8za6wFsYDcHp412dIgP4nsl+cEggPUEdtuhLvFTYH
         AfSw==
X-Gm-Message-State: AOAM532eAFvjxEEunuoQ5flBYi4uKcIKsMXtJPalGjj/nAm9dIKOiABw
        GUax3XNoM7rm1o8qKE8cg62BaP769sFB2+b2z54=
X-Google-Smtp-Source: ABdhPJyE0MQfDtRRi/mZrOMNa02l1bftZh/hp0E5NJkq2uoc1niKrvLW2kVyZQlgkYAnb7tvWOUY8IS2AcCNgmHKJl0=
X-Received: by 2002:a25:6b0f:0:b0:633:d1a3:9dbf with SMTP id
 g15-20020a256b0f000000b00633d1a39dbfmr18515837ybc.216.1650925747461; Mon, 25
 Apr 2022 15:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqfsmg97ac.fsf@gitster.g> <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
 <xmqqczh4vp6e.fsf@gitster.g>
In-Reply-To: <xmqqczh4vp6e.fsf@gitster.g>
From:   Guillaume Cogoni <cogoni.guillaume@gmail.com>
Date:   Tue, 26 Apr 2022 00:28:57 +0200
Message-ID: <CAA0Qn1u50ncejNtWs1AV5tcXjFC-jnmnvjFkBDQyqU4Wcvoy0g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Be nicer to the user on tracked/untracked merge conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan <git.jonathan.bressat@gmail.com>,
        Jonathan.bressat@etu.univ-lyon1.fr,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>, git@vger.kernel.org,
        guillaume.cogoni@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 Junio C Hamano <gitster@pobox.com> writes:

> So, I am not sure if this is really a good idea to begin with.  It
> certainly would make it slightly simpler in a trivial case, but it
> surely looks like a dangerous behaviour change, especially if it is
> done unconditionally.

Can we create a configuration variable to avoid this problem?
We keep the old behavior by default, and make a configuration variable
for people who wants to have this new behavior, but if the user set the variable
a message informs it about the problem that you mention.

Or, we add an option like git pull --doSomething.

Maybe, we can think about another behaviour.
When the user git pull and this error occurs:
error: The following untracked working tree files would be overwritten by merge:
file1.txt
file2.txt
Please move or remove them before you merge.
Aborting
We don't abort, but we prompt a yes/no for each file, if the user
wants to remove it.

We just make suggestions, we will think more about it.

> Wait.  Isn't it backwards?  The existing tests _may_ be casting an
> undesirable current behaviour in stone, but most of the time it is
> protecting existing user's expectations.  If you have an untracked
> file, you can rest assured that they won't be clobbered by a merge.

> So we'd need to think twice and carefully examine if it makes sense
> to update the expectations.  I haven't read the change to the tests,
> so I cannot tell which case it is.

Yes, we'll figure out a solution, if there is one.

Thanks for your review and your quick response, it give us a lot of information,

COGONI Guillaume and BRESSAT Jonathan
