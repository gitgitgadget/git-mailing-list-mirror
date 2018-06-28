Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44A81F516
	for <e@80x24.org>; Thu, 28 Jun 2018 16:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935627AbeF1Qkm (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 12:40:42 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39713 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935611AbeF1Qjm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 12:39:42 -0400
Received: by mail-wr0-f193.google.com with SMTP id b8-v6so6166723wro.6
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0AwrPBRwmu94RYR8/KlVS5yNb1vcYItpz6HtSjtpH/E=;
        b=fRNhN2TZ5YJoqEcx6yFZ/g8aOkIHB2YDq3BkCufMGYu9iG4zUKNEEHqI3QHO9C38np
         YZVbtDxVzwvT2kqpuG1b9oM/y69EVK5HnOMs6XkFmlKC0nkjMyhMn7/d18yWrB9ycP34
         hdVLR/d79IU3vQSq9CNHCGNRctCX92OwRxJTfKu6oXxfykeVTU20up3uXpR9sGdtPp3v
         b5hpjnnJzn0+pHk54QxlXpiZ8R0sdpph4Ope5F91VDMq7vn6vKLAN1gwz+OWKT9e+For
         V5q05XQK6Wigb5gpWOQ0Y2kR2DUie1swv56pT7+ee6q1g3XPZCkFSmp8m8RhSvJWfdwY
         fMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0AwrPBRwmu94RYR8/KlVS5yNb1vcYItpz6HtSjtpH/E=;
        b=PbQnFJYKcUHtKucPlVJG/0uWlRXCUXhgf0KKVlz9L7LCNEMy3Wj1j2R2p+nIHSTmnu
         IC2ifD3d2RGtDKrPBjL1A9tdkz3l3kafRg4s89xa5+ULYi22kL7SC76EfxtS1epEMWSk
         mJ19QbZxII0VBPFccm4JXJUccOkWxc62u7AZObrWmXFT6/qnY0gcILvkO0mMdXMhCpJO
         1o6Lwc/cR8/TxMpCsUFZPPDz1kzyyjZ5Dvxwy9OWliP4VTrX6svymkAzlvEvdXH9IO9p
         akN9YH0C2I07hHOG1ftaS43bSDCLUy/lNEu8EocyBsUGQgot/5lDmC6Yxsg7Q6Tou1Sd
         05Ig==
X-Gm-Message-State: APt69E3S2pKy6Tjdr24QjYoqeJo0iOmTHuJ+ID8sJ6LaUVucFNtg9Y6p
        /eTScw6zzsTpeEAyjLmVnUY=
X-Google-Smtp-Source: AAOMgpcVqPzT3B09Q0PwBEzC2xh22fsoNpiw1/TY6peoLNU+SfNNqRVcxCvT7KsVNcClBFJqvNCBVg==
X-Received: by 2002:adf:ab18:: with SMTP id q24-v6mr9174728wrc.239.1530203980629;
        Thu, 28 Jun 2018 09:39:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u16-v6sm5737819wrp.44.2018.06.28.09.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 09:39:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
        <20180628114912.GA12901@sigill.intra.peff.net>
Date:   Thu, 28 Jun 2018 09:39:39 -0700
In-Reply-To: <20180628114912.GA12901@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 28 Jun 2018 07:49:12 -0400")
Message-ID: <xmqqr2kqyies.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, this solution seems sensible. Given that we would never report any
> error for that blob, there is no point in even looking at it. I wonder
> if we ought to do the same for other types, too. Is there any point in
> opening a tree that is in the skiplist?

Suppose the tree is listed there only because it has one entry for a
subtree with leading 0 in its mode.  We do want to ignore that
format violation, but we still want to learn the fact that the
subtree it points at and its contents are connected and not
dangling, so we do need to open it.  Is that open done in a separate
phase?
