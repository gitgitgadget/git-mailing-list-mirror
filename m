Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215B41F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeHHVAj (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:00:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51209 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHVAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:00:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so3771166wma.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Q9BpZoI4oXcXy3Ux0EOBuIH1ab64lEnoCo1+g7hW3Mo=;
        b=JDhXTjuI2lNK9apLQzcj92Qxklt3KMGM7u4FtArzm3mdcEmP+G7uJ9wYcSw7PxxwQk
         idI5rU+C2FAbg328Cs3NySjC6R2MhHCZvCthzSfDoBDzlfZb7mmHnKAco5ztREnUf3PL
         kgwSEAptsTZdHA06vPg95NXwPAI/+EfJt1wAkceO4yYdPxLy8iGvV5/hla2FbqEpfeyh
         RKRthJKXdc/hyfLuASPj9AlsRZ9PcxpxIkI5pPFMl+mBQppTo5gZqKfRFmripyn9HFUj
         gbi1hIs400Mb2wUCWMyka01vJgEyE06zhsNZNFuKU+kyEEjT7gL/cre9SKgOjDaQo0ki
         BtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Q9BpZoI4oXcXy3Ux0EOBuIH1ab64lEnoCo1+g7hW3Mo=;
        b=BCNDrIRgC5PYznITj9lmf8OyLrSekvMZrdGuVANQT/9+DNH4C3x6J0ktRh4d0PxLQL
         Lf80DxfPajopDztFKuA9bzSevQ+bKWAHzc3gu2QMDfRNluPDgkwTBpeLgwEVgIKUn0oI
         oHdRh0bvd7bsXEo1jAj0IoctsaYPFVEzKZ8Mz+SHabKb1XLaiKKwdEyKMjDVdMfYQOxC
         tZ8GF8ZiWWdcnOA45cGEHPol/py3XbTBOhqgPq/e3of4JFbWgbuc7QxIG/vhCzC21LqE
         Zn7COvKCxceVuhmcerIVsN0Yt1Kz0DcKQrex22h+TdIco7tSK7OflquU+lEbagiTPfQ2
         1C5w==
X-Gm-Message-State: AOUpUlFv5tZZ4g7X4GPp8OMztF/WCvyX4VlKC6BSh27abrsuSkeRP+ZE
        SrojMc/NEuo6KsGooOYt1NU=
X-Google-Smtp-Source: AA+uWPycG6o0+8X9t9euAEgQoqidhGxW+x0aH4woVvBkXzLhbrbhmTCzSENNNT8or+gR2ZAjuFA3Bg==
X-Received: by 2002:a1c:8e8c:: with SMTP id q134-v6mr2889856wmd.3.1533753580964;
        Wed, 08 Aug 2018 11:39:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d12-v6sm5825090wru.36.2018.08.08.11.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 11:39:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Speed up unpack_trees()
References: <20180729103306.16403-1-pclouds@gmail.com>
        <20180804053723.4695-1-pclouds@gmail.com>
        <xmqq7el3qywq.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CzuxjjLyf637dtTHc1wK-UFVnNjwa0O300kYOWehz1vA@mail.gmail.com>
        <xmqqpnyshhtt.fsf@gitster-ct.c.googlers.com>
        <xmqqin4khgm5.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 08 Aug 2018 11:39:39 -0700
In-Reply-To: <xmqqin4khgm5.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 08 Aug 2018 11:12:50 -0700")
Message-ID: <xmqqeff8hfdg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> not used behind is *not* OK.  And lack of restoring the bottom in
>> the new codepath makes me suspect exactly such a bug _after_ the
>> traversal exits the subtree we are using this new optimization in
>> and moves on.
>
> Hmph, thinking about this further, I cannot convince myself that
> lack of bottom adjustment can lead to a triggerable bug.  The only
> case that a subtree traversal need to skip some unpacked entries in
> the index and then revisit them by rewinding, e.g. entries "t-i" and
> "t-j" that are left unprocessed while entries "t/1", "t/2", etc. are
> processed, in the illustration of da165f47 ("unpack-trees.c: prepare
> for looking ahead in the index", 2010-01-07), is when one of the
> trees have a non-tree with the same name as the subtree we are
> trying to descend into, and as long as we know all trees have the
> thing as a tree, I do not think of a case where such ordering
> inversion would get in the way.

One more, and hopefully the final, note.

A paranoid may be soothed by a simple "cache_bottom must match pos
at this point" at the beginning of the optimized traversal.  Just
like you already have an assert to ensure that pos points at the
first entry in the directory in index_pos_by_traverse_info(), there
should not be any unused entry in the index before that entry and
the bottom pointer must be pointing at it.  It is a cheap check, and
if violated, would indicate that the above "I do not think of a
case ..." was incomplete.

> That was the only thing I found questionable in 2/4, which is the
> most important piece in the series, so we probably are OK.
>
> Thanks for working on this one.
