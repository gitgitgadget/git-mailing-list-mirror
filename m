Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42813C77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 05:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjFAFj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 01:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjFAFjF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 01:39:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6CB10EF
        for <git@vger.kernel.org>; Wed, 31 May 2023 22:38:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso1304151a12.1
        for <git@vger.kernel.org>; Wed, 31 May 2023 22:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685597887; x=1688189887;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcsHka5xZrclVqIpWl0HKRGcFzgrXO41LSJShmQdrng=;
        b=smLvG+fssoHJOQulccUDDa/93gFhVGEnuXBIynvd7rjc7Zcx4lMbmvNWXgMr3ukWDj
         h6+mLt3LF+1uSgAB98pLv4ygJ2eFmE5tsMgp5vqtHZ9+fs4P/TmUmda7EL8Ceh+BgAt9
         jahzhjugVL1MPSFInLHaoTwScknkpJugrz0jsUS3eZ+cjjamuE60rP4htJ4iYiDFlN4/
         3/FXR2O34LqhcVejDnSyS3qPQ7Vv5mkcqi/NGUTqCmXCLPApdHNby2TjUis3Xc1mX40u
         W38rFlAjUVJBws8Ndbf/SsxI7zcDpVlQPn6afotBNku7ZPPlITTl2BRUJLqwXpYC50j6
         KbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685597887; x=1688189887;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xcsHka5xZrclVqIpWl0HKRGcFzgrXO41LSJShmQdrng=;
        b=Rwq/2M5Lnns8pmbpiC0h5mCNXLns44yi1o6fMV266n/Goqv+Cqx7N0vWpn2UeD37o5
         ngZX+8HSJaV4HsqowsrxvVYsKFbb7j9qeqs12V133VHnepxx/tur2x9u5AdwcJ66S9ba
         0HLDdYkPXr0/JWwMwPIbKGumY/9oPycr/BGsubdG2jxqxZ/SkdFVavKDhM3MhG0fxqUU
         /lLOJFJywgRNvAt5LRrjddsK3QoxpRwIqAx7sVS/liMhrmqsyaLM/7eCBomUng73FUUf
         q1G+m5AeM5J8djfvdWkDVehB7uEvoJMTLlE9x8KAaFlYMdZ324Z8zF8l6M3/dE2xl91B
         CIzw==
X-Gm-Message-State: AC+VfDwO+H+DXzkiDaLillIU07i6nnSItpn45bSnmSpzHUKVeFVF8ONn
        1lcumeS1B7qfzJK53nL0n2w=
X-Google-Smtp-Source: ACHHUZ67JbrkrFtYBeR3T3UofM0HvpTyl+rbfuDKp9tHNF/o0hB5IQMmBGhKBkNLyfhZJr/YAEx8/Q==
X-Received: by 2002:a17:902:c952:b0:1af:e10f:ba96 with SMTP id i18-20020a170902c95200b001afe10fba96mr1062655pla.1.1685597887090;
        Wed, 31 May 2023 22:38:07 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090300d200b001ac94b33ab1sm2362824plc.304.2023.05.31.22.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 22:38:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jim Pryor <dubiousjim@gmail.com>, git@vger.kernel.org
Subject: Re: git 2.40.1 tree-diff crashes with (glob) magic on pathspecs
References: <c2b73d05-1214-4e30-bab6-14e0b8d69773@app.fastmail.com>
        <20230527173903.GB1460206@coredump.intra.peff.net>
Date:   Thu, 01 Jun 2023 14:38:05 +0900
In-Reply-To: <20230527173903.GB1460206@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 27 May 2023 13:39:03 -0400")
Message-ID: <xmqqsfbbd9oi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> 13a1b11 (HEAD -> master) third commit
>> BUG: tree-diff.c:596: unsupported magic 8
>> error: git died of signal 6
> ...
> Thanks for your report. I had trouble reproducing at first, but there is
> one extra twist. By default, the command you gave produces:
> But this also seems to be wading into a spot that is not actually
> supported by --follow. The code near where the BUG() is triggered looks
> like this:
>
> static void try_to_follow_renames([...])
> {
> [...]
>         /*
>          * follow-rename code is very specific, we need exactly one
>          * path. Magic that matches more than one path is not
>          * supported.
>          */
>         GUARD_PATHSPEC(&opt->pathspec, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
> #if 0
>         /*
>          * We should reject wildcards as well. Unfortunately we
>          * haven't got a reliable way to detect that 'foo\*bar' in
>          * fact has no wildcards. nowildcard_len is merely a hint for
>          * optimization. Let it slip for now until wildmatch is taught
>          * about dry-run mode and returns wildcard info.
>          */
>         if (opt->pathspec.has_wildcard)
>                 BUG("wildcards are not supported");
> #endif
>
> So follow-mode does not actually work with wildcards, but we err on the
> side of not rejecting them outright. In that sense, the simplest "fix"
> here would be to allow :(glob) to match the '#if 0' section, like:

Is it "fix" or widening the wound, though?  The runtime BUG is very
unpleasant to see, but silently giving a possibly wrong result would
be even worse, I am afraid.

> That would avoid the BUG() and make things work consistently. But it
> still would not produce the output you expect, because --follow simply
> does not work with wildcard pathspecs. And fixing that would presumably
> be a much bigger change (I didn't dig into it).

True.  And wildcard is not the only thing it is broken for; the
biggest one is that it only follows one path at the time across all
the traversal paths, which has interesting implications like it can
give inconsistent result depending on the traversal order in a mergy
history.

If somebody cares about the "--follow" mode very deeply, the "upon
finding that the path disappears, run the rename detection with the
parent and switch the (single) path to follow to the old path in the
parent" logic must be updated to keep track of these pathspecs per
traversal paths.  If false positives are allowed, an approximation
that may be easier to implement is to add paths to the set of paths
to be followed every time such a rename is found.


