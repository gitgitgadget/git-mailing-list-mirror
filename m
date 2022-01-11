Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B3C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 20:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbiAKULV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiAKULU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 15:11:20 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E0FC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:11:20 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id 19so459529ioz.4
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VYcXpWGmyP5/bXR6PwVvwAGH7yqvzUTcOJEi+741ybg=;
        b=vNUxNT0NwmdOvYuulqX3WPzl+kzuqMI4WWOMBSrCQy9IOMJsXn7Is8yaqzklb7hvV1
         LM0NRwYwE5W5EIu1Dqt5UoHhSegrJezRJIukZ5rm6aL/K8EbhJFnexW5ylodFtyRH85T
         xCUJ89QVHM0FUY6wmmg9y7JYCwqCNgjWhod+k8AIjCRc86MFruiVGia8AskceHTIVPAI
         XMkCGWExJKS8WHdbLZrfW3u24Ed51VHSK+szRYDKlAcC9zQH3sOv8PWyIK5jBDOqrhpl
         QrHNSkdq/bAzDno4LwfI2RqwJk5UtJE/RLoc8jOzNy8GV3DeZohKhuw1N0X6049GTbQL
         BvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VYcXpWGmyP5/bXR6PwVvwAGH7yqvzUTcOJEi+741ybg=;
        b=a96A8J25KJeGRNSZJyMfJrZDV1TbdmeZwWh08mZbcC1tHk+6hlf5VdZHebC2EKe+Ef
         Z2+IF+xk5kSsus1pbnxGsxcZ+jGkhV4LIwJ8VHG7gLgyoJj86IOhJJtHwotd+VT0am2n
         MWeXWWORyX6xkUqcjNmxndvshgNC7lG13zWE8nlDQA75eKfdokONr4LNPpxqu6SN2F1D
         vRgCrZUv5EuAZpjW598bOEdLJsRBdzk+fHN2HAWAirbMgx/+XxlFopq8Yz58lU5+xv3T
         Mvg5Ty1vG6lz8yUU4b60tvR6sNP/xbgUOFniMSWvdHhNIfXKMJXsJk0OmakLIO/b2ri+
         Vivg==
X-Gm-Message-State: AOAM530oKFQ2v35SQIWWcLkBaCR1eGtfCEBNbA91C9T3UolbhKYj/UST
        DtxPsQSBCtggMu/BXxNs/zRrqQ==
X-Google-Smtp-Source: ABdhPJzTiFWUJBeV+ti4+T0J+F9/qkPCgxVtLsyEdn17w1k1ewYlLZppyf9qNSXekc58tBrN5E8LIA==
X-Received: by 2002:a5d:9857:: with SMTP id p23mr3110583ios.137.1641931879643;
        Tue, 11 Jan 2022 12:11:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x15sm4505839iow.7.2022.01.11.12.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:11:19 -0800 (PST)
Date:   Tue, 11 Jan 2022 15:11:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Teng Long <dyroneteng@gmail.com>, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
Message-ID: <Yd3kZv4Oym1h7zap@nand.local>
References: <cover.1641440700.git.dyroneteng@gmail.com>
 <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
 <220110.86ilurzcxo.gmgdl@evledraar.gmail.com>
 <Yd2zXOrf+4qX8VLD@nand.local>
 <78aa8c28-d78b-7dee-6616-7708c363a244@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78aa8c28-d78b-7dee-6616-7708c363a244@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 08:06:00PM +0100, René Scharfe wrote:
> Am 11.01.22 um 17:42 schrieb Taylor Blau:
> > I find it helpful to have an alias like:
> >
> >     $ git config alias.ll
> >     !git always --no-pager log -1 --pretty='tformat:%h (%s, %ad)' --date=short
> >
> > in my $HOME/.gitconfig so that I can easily format commits in the
> > standard way.
>
> You can shorten "--pretty='tformat:%h (%s, %ad)' --date=short" to
> "--pretty=reference" or "--format=reference".  For me that's easy enough
> to remember that I don't need an alias.

Ah, of course. Peff's copy likely predates `--pretty=reference`, and I
inherited the cruft from him. Your suggestion has the nice benefit of
colorizing the output when going to the terminal.

> Silly question, going further off-topic: What's "git always" doing?

Oops, I should have mentioned. It's another alias to ensure that the
following command is always run in a Git repository (either the current
one or a hand-picked default):

    $ git config alias.always
    !git rev-parse 2>/dev/null || cd ~/src/git; git

I often read mail out of my home directory, and the above works with my
`:Git` command in Vim (which passes its arguments to `git always` and
inserts the result back into my buffer). That way I don't have to first
`:cd ~/src/git` and then `:Git ll xyz`, I can just `:Git ll xyz` and it
does what I meant most of the time.

Thanks,
Taylor
