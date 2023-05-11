Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F603C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 14:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbjEKO47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbjEKO4o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 10:56:44 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1448A40E5
        for <git@vger.kernel.org>; Thu, 11 May 2023 07:56:25 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55a14807e4cso155870117b3.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683816922; x=1686408922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTsn61FXYfmyCQqYamwlNF1ZmJH9OtqORn3BEVIZ8eQ=;
        b=XaTKpYtfc3USIxj4nrQ9OxGgHjTqfGTHzTM0PMGMqr3kEOyfSsBqImdOoJv+SDMzsN
         pG7nGIiZ/x6w26F7EjcbQNejjHuhSBA2aVM741EJj87+8CKc8ysPVUGUxwarE4GnGzgS
         a+/elgN7oPTNl1lYUXccXic/64ViVA2ScXG9T1qKwtBpLk+v4QLDsYUuUZDnwdiwT6qN
         crwlH7PsSfY8daOH1qFWCqKWDYPjCGSCSW5doVqovvKGj0+mTm1rMNvGrOumR2lMOfIQ
         uNctiVB8ghYyClXvvnGYHNPTKSHEphMJOHgE3Hz8OMbm+OgF/CyrZtrzcwwtk2ZGEemL
         cr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683816922; x=1686408922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTsn61FXYfmyCQqYamwlNF1ZmJH9OtqORn3BEVIZ8eQ=;
        b=Sn2W+Gc0FYQWPKuTkQh7OrktTw+P5tOBkgook874Rl0rSpwZp8qz0bdwlO+onXOZQ+
         Lzw6N3ov1XPMYzq9wz9iBNKETxqXMYxFwPn6mjgP4GXIo9u/AKXpyPcLdPZybQl+bqMJ
         87lWbdOMBTxKBuW6mMBLii46MfqmtLOnOGSnHRORfodgKVxWj4eGcOz4T48Haw9eJ8p3
         5eMB3jHXyWEhhRzAlYuYaBnz++m/W/T1G/quRupq9Q1XqRZWvyfaX6QnBIXHAQP9+VT5
         0B4ZEKaXIAQJOLGOjMAWqwO4YiYRteLkbEm5s3pK0s3kkZs3XCqU+51FLu1XDbU1Xs0v
         gtiA==
X-Gm-Message-State: AC+VfDxyRQOxEozB5nJ62Xx+dmvq24Yfr8AAbeoRY78dtWlaB6kfnzNe
        YkJ5FhGvBfPeaGlvDAEosCbHIA==
X-Google-Smtp-Source: ACHHUZ6vkY53nGN/fDLxI4D8MYxJYWQHOCPDuVWdKnCZPtLzBzYwWh0+jXa6WQGFtg0xqfp82K1SeQ==
X-Received: by 2002:a0d:c641:0:b0:544:ccde:b6b8 with SMTP id i62-20020a0dc641000000b00544ccdeb6b8mr21231011ywd.4.1683816922252;
        Thu, 11 May 2023 07:55:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w76-20020a81494f000000b0054fba0d6a88sm4901541ywa.100.2023.05.11.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:55:21 -0700 (PDT)
Date:   Thu, 11 May 2023 10:55:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Bug in unused.cocci?
Message-ID: <ZF0B2Prhc7jsqa3p@nand.local>
References: <5720a23e-6ac0-9a6d-3d05-4e0f34bc0589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5720a23e-6ac0-9a6d-3d05-4e0f34bc0589@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 10:16:21AM +0100, Phillip Wood wrote:
> I think this is due to a bug in unused.cocci. I'm not sure what is going
> wrong and admittedly we're unlikely to see code where an strbuf is
> initialized and then used it without calling any of the strbuf_* functions
> within our main codebase but it would be nice if the rule could handle this.

I don't think that this is a bug in unused.cocci, but rather a bug in
spatch not being able to read t/unit-tests/test-lib.h.

    $ spatch --verbose-parsing --debug --all-includes \
        --sp-file contrib/coccinelle/unused.old.cocci \
        t/unit-tests/t-strbuf.c | grep '^bad'
    init_defs_builtins: /usr/lib/coccinelle/standard.h
    -----------------------------------------------------------------------
    processing semantic patch file: contrib/coccinelle/unused.old.cocci
    with isos from: /usr/lib/coccinelle/standard.iso
    -----------------------------------------------------------------------

    HANDLING: t/unit-tests/t-strbuf.c
    parse error
     = error in t/unit-tests/test-lib.h; set verbose_parsing for more info
    badcount: 3
    bad: int test_done(void);
    bad:
    bad: /* Skip the current test. */
    BAD:!!!!! __attribute__((format (printf, 1, 2)))

From my understanding, spatch happily ignores macros that it doesn't
understand (like check_uint() and check_char()), so to it this code
looks like:

    struct strbuf buf;

    strbuf_init(&buf, 1024);
    strbuf_release(&buf);

which it marks as unused and applies the patch. Strangely, if you force
it to pre-process with the appropriate macro file by passing it
explicitly, it works as expected:

    $ spatch --macro-file t/unit-tests/test-lib.h \
        --sp-file contrib/coccinelle/unused.old.cocci \
        t/unit-tests/t-strbuf.c
    init_defs_builtins: /usr/lib/coccinelle/standard.h
    init_defs: t/unit-tests/test-lib.h
    HANDLING: t/unit-tests/t-strbuf.c

I am puzzled by spatch's behavior here.

Thanks,
Taylor
