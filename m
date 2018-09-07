Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2C21F404
	for <e@80x24.org>; Fri,  7 Sep 2018 00:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeIGFMT (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 01:12:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40358 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIGFMT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 01:12:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id c126-v6so8661608qkd.7
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 17:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+cVQJ1wr+l+ZbSs4vki1nR6gwFgqTNjlJTYNNRKXKlI=;
        b=B6tlLdkGlqXi5Z9inB1UsTjR0M1HwEZZl4auF5YcFTEAJ0qk3Q/RhrwDZuvc9CF2Pj
         69ykGVny+nE0fs8xHzTOjozKKdfj1dx1duxhwg3Gi3I5oeWFFbN7b2loC4rkKHlEg8P2
         mspC//azvd3Y2yMGkP0OmN4DuN+a8A0AaZ0PJe0Rn0Co01PX2CzlsUzK/JoEpKkNM5QW
         4UM7PhTd/FqzDGb/Fg6z+uLqA152iQh/liGEUfWk3Fnxa9QFDKUrl39Ny/MAN11eKdcv
         3Yz5fl9ovIJ7I8k92zRWaur+OilhKADWylu7rE75ItD/IXOsBpxzduVLytrEpz23WI9y
         yZ+Q==
X-Gm-Message-State: APzg51CzRMzgW8U3aQYC3ae+LC3FfgjvQrR3kEXPHDIKLdZSv20IbY7B
        wUrElqc7YIjPoX1SLY+OJYLmBez4YGPcwdgTR5k=
X-Google-Smtp-Source: ANB0VdZ2CcSNQ1xjtptbVUZShXcpyfbJrD5xPEDyFOj+vaJP4BRVHF9zRy7i4A0gv9FDz9TlD25/YpFMjPcbypfkDhk=
X-Received: by 2002:a37:48e:: with SMTP id 136-v6mr4194584qke.26.1536280453454;
 Thu, 06 Sep 2018 17:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.34.git.gitgitgadget@gmail.com> <e1498aea45eb46feb3664413f49b70bdf048d284.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <e1498aea45eb46feb3664413f49b70bdf048d284.1536158789.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Sep 2018 20:34:02 -0400
Message-ID: <CAPig+cQKt4sq4bhRUoGJMV=GxHzx-AtD_5J7DNtfMngH-uJRFQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] multi-pack-index: verify object offsets
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 10:46 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Replace the BUG() statement with a die() statement, now that we
> may hit a bad pack-int-id during a 'verify' command on a corrupt
> multi-pack-index, and it is covered by a test.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/midx.c b/midx.c
> @@ -197,7 +197,7 @@ int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id)
>         if (pack_int_id >= m->num_packs)
> -               BUG("bad pack-int-id");
> +               die(_("bad pack-int-id"));

For someone trying to diagnose this issue, would it be helpful to know
(that is, print out) the values of pack_int_id and num_packs?
