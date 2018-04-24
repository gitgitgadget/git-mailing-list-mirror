Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F18D01F424
	for <e@80x24.org>; Tue, 24 Apr 2018 01:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932684AbeDXB2y (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 21:28:54 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33083 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeDXB2x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 21:28:53 -0400
Received: by mail-wr0-f196.google.com with SMTP id z73-v6so46103239wrb.0
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 18:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yW6K2BZ0iTuRr8JuXkh4GvDnALF5gORVy/0aBJANg/8=;
        b=M18V/v0nuYBMDptcIybN53+mOBYlcgPNEhCezAcKsB98/jsQh4mVzPEwObrW46qyme
         /FSNagRLSBI/o6jCSiRYRLgRgBiA2iL5HgZ0ka20VDKGvZfCqBAlpmMMgPPpz5Mi4c1Y
         LkebItCe1p462dNu+n59+A96SbNjb/4hyOa3Gc/vbsXXq48hh5dyjv8WrUc8BjgsVANm
         FyaPTpahScrTny5O18du74vTWaU3eGAYidxx8qGg1/seu6Y1Hnkf02WYdN5iKhsmQtt/
         YoWaqz300imTXl0dTS6cc8ISknklS6cLx/0MnGVEbBfq4d3c2hEzk3FEs9Ka314kT8Do
         btWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yW6K2BZ0iTuRr8JuXkh4GvDnALF5gORVy/0aBJANg/8=;
        b=PlT8DDJyvQ3crx/Ka4fxvcdn31cLXVWvD8xUptKrv0NiDNoml8x3iZjkZErZUlpMD5
         SmPOIqoEoTF+pkQwYanH464imeA+tPGPc5KasZXYg1A4NpkULCQX2Xp37nIRJVoN3C6T
         NQKsAZHpEcxTRrmJNicFVGIVl3I5AQY6NJwJTVCy4MsfyfpV1QycIYQHzfCuyX4SvLXf
         vCSL5BSUHaB6wlw2+z9PNTc8D9s1zMYYBTQkzH0+9MOELkVjrxFZVUH8xIqBFAtZCqXO
         c1Y2Q2l9svhoInh5rqqv9354mXp7Be4NjTs79SVqASLFF+NBiD9kbGwtlJetIbx1Qfg3
         L2pQ==
X-Gm-Message-State: ALQs6tAes08XJii9naOuX6WYmfDSXzSEkYuIAXoc5a2u5jxTv3iQxzDE
        bT32OhLrbYb4kgk2RCR0jpo=
X-Google-Smtp-Source: AIpwx48N3dQOS0MAZPAvTdcnA8fFr0S2whJ71gS4RwU8XWS54xEkGkKjSjKH5hmEzwr3AAQh3HW/DQ==
X-Received: by 10.28.202.22 with SMTP id a22mr11260768wmg.49.1524533331902;
        Mon, 23 Apr 2018 18:28:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j76sm24495778wmf.33.2018.04.23.18.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 18:28:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 0/4] rebase -i: avoid stale "# This is a combination of" in commit messages
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
        <cover.1524296064.git.johannes.schindelin@gmx.de>
Date:   Tue, 24 Apr 2018 10:28:50 +0900
In-Reply-To: <cover.1524296064.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Sat, 21 Apr 2018 09:34:41 +0200 (DST)")
Message-ID: <xmqq4lk18ka5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Eric Sunshine pointed out that I had such a commit message in
> https://public-inbox.org/git/CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com/
> and I went on a hunt to figure out how the heck this happened.
>
> Turns out that if there is a fixup/squash chain where the *last* command
> fails with merge conflicts, and we either --skip ahead or resolve the
> conflict to a clean tree and then --continue, our code does not do a
> final cleanup.
>
> Contrary to my initial gut feeling, this bug was not introduced by my
> rewrite in C of the core parts of rebase -i, but it looks to me as if
> that bug was with us for a very long time (at least the --skip part).
>
> The developer (read: user of rebase -i) in me says that we would want to
> fast-track this, but the author of rebase -i in me says that we should
> be cautious and cook this in `next` for a while.
>
> Fixes since v2 (thanks, Stefan!):
>
> - Fixed commit message of 2/4: "Thisis" -> "This is".
>
> - Reinstated the order where the `message-squash` file is renamed to
>   `message` first, and only if that succeeded, we delete the
>   `message-fixup` file.
>
> base-commit: fe0a9eaf31dd0c349ae4308498c33a5c3794b293

This round looks reasonable (the last one was already so, though
;-).  As this is not a recent regression, however, I think we would
want to have it regardless of recent updates to rebase-i that is
happening on the 'next down to master' front.

I've queued this round using base-commit of d32eb83c ("Git 2.16.3",
2018-03-22), the same base as the previous round, for that reason.

Merging it to the tip of 'master' and applying these patches
directly on top of 'master' result in identical trees, of course
(otherwise we wouldn't be able to maintain the stable releases and
make forward progress on the 'master' front at the same time ;-).

