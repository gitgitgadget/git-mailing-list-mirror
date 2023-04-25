Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E74C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 19:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjDYTBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjDYTBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 15:01:31 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C05249D8
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 12:01:30 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54fb8a8a597so73467257b3.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682449289; x=1685041289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6alnOgxEllLjdSk1JmIG5dm9e8s7i+HbC7ac7TzrP7U=;
        b=Te1S7ErN6KjsVMR7WComJd6BLE+DXLsFOkzx/Ze0s3Tpq+UVJT8CxAKe3XrPPBe9No
         3DJ+dvMiXdQuti6A8ne++FxxDrVrVfHxgVauOz/c0zUFTVpBZk25iDuP1Owu/5ePiUQh
         Mfziv4X0N3P3fTS8Box5uS4nXI9pYVeZHpqymbMLl9lP420dOPuxfUwLLAB2mD19Wzn7
         KwYCbqaLt1ebsUWEz/NrWaqO5XmkqllSRWGLVwYdDrrqAKNRiE73E31IgmlQlPCotFGu
         gxyqDqavp1D+/CfdBOlr/22MXMxpAlPcSg25jJYmrU39CMChTYhMous8D+CIetIZvEK1
         jt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449289; x=1685041289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6alnOgxEllLjdSk1JmIG5dm9e8s7i+HbC7ac7TzrP7U=;
        b=g9ZEBoqM9KqHbXqrzhjEqjaVyQvF/QVhoVuy3vJ8J8pjfXu2zDfbvqSVolOs9Rsvxh
         3IJQ/lftudSPvSSSk9iMu3cs3MpBwpzzvtagQ5wmEXgDdW+3DIdxNC4ye7GnBWtimYJN
         DbAl4RAaF1Y9lm6G+vvpLJTlbqHqCxgTXPXMSHXfgs1Yu6otVaRq6ncMG710ooW4FgGY
         CX8w9jbtp4d35Gl72ODY+cH8b+3iL/6mWufCMC7NQQdPPhMzJHTd9UTZfeSmVzUdp9wY
         lRmLcpfCZ+IrHtl2veqsitMeDozZBwd3n786QO7l8Ir6k3tjAbmULsQFOy/V2sSj5n/z
         kdfg==
X-Gm-Message-State: AAQBX9dbh+TgHxovdudH6+s4QliYaM7i5P/CV1mSCb5ao5aukX7AgMxW
        ufz6XlM6lDDM0eOPq/VjEobYlw==
X-Google-Smtp-Source: AKy350bds9UPmO0uoWQj/r604SkodzyEEqoAam0YjVT95rbeur50/hyQAubAWCn130ontAQfX4B+nA==
X-Received: by 2002:a25:1fd6:0:b0:b8f:53ec:ac03 with SMTP id f205-20020a251fd6000000b00b8f53ecac03mr13818479ybf.34.1682449289538;
        Tue, 25 Apr 2023 12:01:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k184-20020a2524c1000000b00b8ed4e15acbsm3593634ybk.63.2023.04.25.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 12:01:29 -0700 (PDT)
Date:   Tue, 25 Apr 2023 15:01:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] pack-bitmap: boundary-based bitmap traversal
Message-ID: <ZEgjiAtK8O0+dbht@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <f25c6234-83c0-fa49-85f5-9005e312b8a3@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f25c6234-83c0-fa49-85f5-9005e312b8a3@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 02:06:25PM -0400, Derrick Stolee wrote:
> In other words: this generates something closer to the object set in the
> non-bitmapped object walk. The only difference is that the new bitmapped
> algorithm will see objects that were re-introduced across the boundary
> (say, a blob was reverted to its older mode).

Very well put, thank you.

> For my curiosity, and since you already have a test environment set up,
> could you redo the "without bitmaps" case with pack.useSparse true and
> false? When the option was created and defaulted to true, we never
> really explored comparing it to the bitmap case. In fact, I assumed the
> bitmap case was faster in important cases like this (where there is a
> substantial difference in object counts), but your data is surprising me
> that the sparse algorithm is outperforming bitmaps, even with this new
> algorithm.
>
> The main question I'd like to ask is: is pack.useSparse contributing
> in an important way to the performance here?

I don't know enough about pack.useSparse to say with certainty, but
trying again on the same repository (which is reasonably well-packed at
the moment), they appear about the same:

    $ time git -c pack.useSparse=false rev-list --count --objects master \
      --not --exclude=master --branches
    14

    real	0m0.986s
    user	0m0.599s
    sys	0m0.387s

    $ time git -c pack.useSparse=true rev-list --count --objects master \
      --not --exclude=master --branches
    14

    real	0m0.985s
    user	0m0.600s
    sys	0m0.385s

> I'll go poking into the patches now.

Thanks in advance for your review :-).

Thanks,
Taylor
