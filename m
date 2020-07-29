Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BF0C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF3520809
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei8Ir/4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgG2Vlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Vlo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 17:41:44 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B85C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:41:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g6so14042891ljn.11
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=voBpGk9pFZ9Uv3f9m+vWulohIoXNo3SiipAku47JThs=;
        b=ei8Ir/4xTzVEQAasDIIRzFQu1R9MMd8KnaQHCSlBcDwZyH6mZMgsd7ONnZJ9QQuP++
         77Pex1jmIxVHTitBAKyGi603UQEVybz5SID4VAwHulRVG173Ole9A5Su3/kwGUPd+ilI
         aJeh8QSXT1ctLOfthZEPb4QC610s8xAEBsediSR2PqbGC0n2AfTCDYQ5+9zQEjYSLViu
         KholqimBc6dvVlOnW2/x0OfjhGWqo2YpEQCpuC84wCRAhU87ro10J/g8/6LqIqaJhk5/
         4RefVLSiB4eUYwVuQz9WKt6ZONAuwyvySwcHuXnS1Jz769/a+bPB3xOeGG24z/Ycz/1E
         MB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=voBpGk9pFZ9Uv3f9m+vWulohIoXNo3SiipAku47JThs=;
        b=hNQ1Uv7d8yyKQ63WlMYAqrM4kCvZFTHAbUPS57EZHAD1ZMRf3rGkrNGxsCsQUZ05Nd
         LeHPDMwdhVkpsbRwIYJy+cKY3e8a5K47vQ84KkkMADPjwvfyngOtkkhPfVcLJLNopCml
         v2htdSvEuaVj3ox5F2Q89byLMQCIHTGJuNTa6o3Yl1WtQN+GavwF940fuSKXUGAM2uDf
         iHFyGBW4UoyiekwSYzY9Apio4TOTMd/j8OWQYdat/uFhdUAAuqc6+J6IDUK6TS5YgCjS
         0uvayDZhQIH/vwXOLG44hHeKgY/R36I0g2OEOw58TGEgCMIqzMQ2u2k/DJrToUJXMutH
         qLMA==
X-Gm-Message-State: AOAM532945Rj3GHSgxBUgZGnqVGuS9/1UP39K9b+f7MAlrb63eafBLE4
        25PxE38jWvXuAT5m7GAfarXqQG0o
X-Google-Smtp-Source: ABdhPJzH4VxEOUN0QVl9sOVRD8rgrE0nmRxx7vLx9oriy+wgCCA7DRZyNnmBQWFUIGB7kh0JdAeNyA==
X-Received: by 2002:a2e:8085:: with SMTP id i5mr203429ljg.97.1596058901364;
        Wed, 29 Jul 2020 14:41:41 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l22sm738587lje.81.2020.07.29.14.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 14:41:40 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
Date:   Thu, 30 Jul 2020 00:41:39 +0300
In-Reply-To: <20200729201002.GA2989059@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Jul 2020 16:10:02 -0400")
Message-ID: <871rku3soc.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jul 28, 2020 at 12:36:18PM -0400, Jeff King wrote:
>
>> This series just makes --first-parent imply -m. That doesn't change any
>> output by itself, but does mean that diff options like "-p", "-S", etc,
>> behave sensibly.

This is definitely step in the right direction, thanks a lot for working
on it!

>
> Here's a re-roll taking into account the discussion so far:
>
>   - the escape hatch option name is flipped to "--no-diff-merges" (with
>     "--diff-merges" matching "-m")

Rather than being just a synonym for -m, is there a chance for
"--diff-merges" implementation to be turned to output diff to the first
parent only, no matter if --first-parent is active or not?

Alternatively, may it have a parameter such as "-m parent-number" of
"git cherry-pick" being set to "1" by default?

This -m output of diffs to all the parents is in fact primary source of
confusion for me, even over all these mind-blowing inter-dependencies
between --first-parent, --cc, -c, -m, -p and what not. Who ever needs
these (potentially huge) diffs against other parents, anyway?

Introduction of this new option is a great opportunity for improvement
that would be a pity to miss.

Thanks,
-- Sergey
