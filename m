Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84020C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 21:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjCXViV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 17:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCXViU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 17:38:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1662724
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 14:38:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so6349904pjp.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 14:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679693898;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLepixS34BYxMjJCighEi/waEu6He5VT2VjUzfAOpLg=;
        b=Ktxcbmv32vG0+dsFhmQt8VD5D3Cnb1hmyf1FB7yzx/j21iJxJqUO94wQRnHAKUt31L
         7kr7GjqG8mLnyKO1BXdtUYgFXn8nXGFy7XDhORla8Lc1jiyUSUXA239hotaLuHY3jB/5
         gafi1bQooD1NGL3acNTIsM+GzT4htu5dik157SVngSgDGmpAGNc5yO5MVeZQXW1VZkgc
         6Bhhi6gPZxlYC1CcJyukDt8yDK0fiS8qep+sIb4m5nu13YgMsc36htu0FojPsKr77ywq
         eA3HJCMF7d9xp2Zx7BmK/kuRtJg7dY9eRUowkdarLa9f6T+59KXNvFkomehDEDj/1mkU
         b2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679693898;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fLepixS34BYxMjJCighEi/waEu6He5VT2VjUzfAOpLg=;
        b=JHxEQXWSFoIJkZL7AgLL+3Ph+h7q2RlgmsKxdG4UroNka0/gn6Nqo8UfSdZGvUC6Gu
         nFOmuQoLP/5QZMM3aGRNEZL6DU3wHBFWqss3MHchlc1rChYTtHeSamJTDTB/tC+ZgXti
         ECrJ2ZzOP54zv6dNnF2z4MkQueKFcXvAwhdQ++xSTrkEFtLsq7aunn5QOMOUElBLB1zA
         DFuKlsj9HVqnHG4g+/IyJjUlqAV+WcMf3K6xUTr6YZ8bVDrP8B2FKSm/HtU4tqiH4vCy
         2W8DWzBd2R3IQ3I5sFcKSNIJfRbv22hmteoE6upxObr+Sy/BNiLuv6AsKC3+Oo7HB9Le
         0feQ==
X-Gm-Message-State: AAQBX9clLMrvcM011k8yMwRnTzclSO47OuaERFvkz264/M5cZkRYw+9G
        Jqc7RYgCJRdndSMY5LYwczo=
X-Google-Smtp-Source: AKy350aeo7bhw1bT5aFvXiK0CeNnT70M3hJJt7FFe4Q2PRpDBLTgxFTlZSe31ZsH5YLKYaw5+SlneQ==
X-Received: by 2002:a17:903:41cd:b0:1a1:b65a:2072 with SMTP id u13-20020a17090341cd00b001a1b65a2072mr4942675ple.59.1679693898466;
        Fri, 24 Mar 2023 14:38:18 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id k2-20020a170902760200b001991e4e0bdcsm14669379pll.233.2023.03.24.14.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 14:38:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 5/6] pack-bitmap.c: use `bitmap_index_seek()` where
 possible
References: <cover.1679342296.git.me@ttaylorr.com>
        <9a3e45b78b7810e0116848f1de80096b04285a55.1679342296.git.me@ttaylorr.com>
        <20230321180525.GG3119834@coredump.intra.peff.net>
        <8a7cf287-421c-9a7f-0788-c5e219e6a8e3@github.com>
        <20230324183514.GB536252@coredump.intra.peff.net>
        <xmqqr0tedjf1.fsf@gitster.g>
        <20230324203737.GA549549@coredump.intra.peff.net>
Date:   Fri, 24 Mar 2023 14:38:17 -0700
In-Reply-To: <20230324203737.GA549549@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 24 Mar 2023 16:37:37 -0400")
Message-ID: <xmqqcz4xesom.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, I think the SEEK_SET cases really do need to be doing more
> checking. AFAICT they are blindly trusting the offsets in the file
> (which is locally generated, so it's more of a corruption problem than a
> security one, but still). And this series improves that, which is good
> (but I still think it should be a die() and not a BUG()).

Yes, I think by mistake I merged the topic way too early than it has
been discussed sufficiently.  I haven't reverted the merge into 'next'
but it may not be a bad idea if the concensus is that the seek-like
whence interface is too ugly to live.  BUG() that triggers on data
errors should be updated to die(), whether we do it as a follow-on
patch or with a replacement iteration.

> Certainly there could be more consistency in the magic numbers. E.g., in
> this code:
>
>                 if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
>                         error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
>                                 oid_to_hex(&xor_item->oid));
>                         goto corrupt;
>                 }
>
>                 bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
>                 xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
>                 bitmap = read_bitmap_1(bitmap_git);
>
> There is an assumption that sizeof(uint32_t) + sizeof(uint8_t) is equal
> to bitmap_header_size - 1. That's not wrong, but it's hard to verify
> that it's doing the right thing, and it's potentially fragile to changes
> (though such changes seem unlikely).

Yeah, that was the part of the code I was looking at when I wrote
the message you are responding to X-<.

Thanks.
