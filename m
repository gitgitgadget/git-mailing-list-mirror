Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FABC38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 21:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjARVT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 16:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjARVTY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 16:19:24 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CD72C672
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 13:19:23 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id z194so84874iof.10
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 13:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vkOvh/F/gHvGwf54DR810BsVa0h1umAIgjvODvUs4EQ=;
        b=EYGYa3A3TadwpdlEi/uWRoaYIWj6e+4dtPCvYTXewjc8IZQD36YL8RY7KApp70vnKD
         q1dJOPNYHwiOPySmUhP6SaKCULzVrpWXG4UHdnNaXZHf8S+ObuA8fD40PSJbvR7URl6/
         CCDHAJNgFjKher21fj2kfMTdC/IIoX+VDQhYECIe9E/5d4TEAaIPrEd9XcRPybRSdwz8
         fhiWFrhegzyMWmzYQoe1ZH6jpvHedNB7Sg3xISENrIWUs8rNDMWKSXhItuTKDmZvjVU3
         TvbfPeFt2nL00aw3WnlKbCCFufnjbn/iqpeTxlYM4l7bJJ+f/Os2TSy43CySzRopsoba
         VAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkOvh/F/gHvGwf54DR810BsVa0h1umAIgjvODvUs4EQ=;
        b=e4Dp7Rhk6ryYOU1nMlD8oXzosOiA5k6Vj+vx1LQYcicIqyo8r/uO6BVcnhu6yfSpg5
         4P4PCHkKEkcMjvkSj2llKA2+Fpc+jxICg6neksn9EYlhVJ/DHHFbTL6J1yqis8MHvRiu
         eBQA766b5bKhlNebGGIh8LtOVYGSaDGHaeznOnWkNgfhMUzjR6RjlEC/91zaVnVb3GSx
         I9K10SjiMOoc75BSiudSklZjHCqfUspXoAEu18x+ZUrlZGFQ3cBGHMi9QeLv8sGULvn3
         aeetGKCmvE5T+CHPEsHUZti8IRhcBz1qdInTOZC/acdal+Ajm+eZxSsJG+j56ngwoZPj
         x3Ig==
X-Gm-Message-State: AFqh2kpdEqvCcQxcEqNnibeRzp3BG6sTO4mgC4gVv6u5Xb88geAuwU/Z
        ez35Di9ir3Xh/nZU1jC6V9t4mA==
X-Google-Smtp-Source: AMrXdXvMlTBnVypPV3P43j4qi4O0vmn29AeX62CFmq2qElhqf3fNLTtda3gdSFUUxwQXdiabB60nmw==
X-Received: by 2002:a6b:7210:0:b0:704:d931:45ec with SMTP id n16-20020a6b7210000000b00704d93145ecmr4654234ioc.20.1674076763222;
        Wed, 18 Jan 2023 13:19:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k1-20020a0566022d8100b006e4e8ad6b2bsm11666474iow.36.2023.01.18.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:19:22 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:19:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 4/6] t: use hash-object --literally when created
 malformed objects
Message-ID: <Y8hiWGOArYqzen58@nand.local>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8hZlN9rRg1msc0L@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8hZlN9rRg1msc0L@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 03:41:56PM -0500, Jeff King wrote:
> Many test scripts use hash-object to create malformed objects to see how
> we handle the results in various commands. In some cases we already have
> to use "hash-object --literally", because it does some rudimentary
> quality checks. But let's use "--literally" more consistently to
> future-proof these tests against hash-object learning to be more
> careful.

Heh, I suppose this is a good illustration of how loose our checks our
even without `--literally` ;-).

> ---
> This patch is worth looking at because it shows the kinds of things the
> new hash-object from patch 6 will reject.

Obviously we could avoid this patch entirely by making the new behavior
of fscking the incoming objects hidden behind a `--fsck` flag or
something. But I think the decision not to is a good one.

We already have `--literally`, and it makes sense that passing that
should let us write anything, and that not passing it should perform
some validity checks. But I think exactly *what* those checks are is
ambiguous enough that the absence of `--literally` implying fsck checks
isn't out of the question.

You address this in the last patch more thoroughly, but I figure that it
is worth stating some of this here during review to indicate that I
think the direction you pursued here is a good one.

>  t/t1450-fsck.sh                 | 28 ++++++++++++++--------------
>  t/t4054-diff-bogus-tree.sh      |  2 +-
>  t/t4058-diff-duplicates.sh      |  2 +-
>  t/t4212-log-corrupt.sh          |  4 ++--
>  t/t5302-pack-index.sh           |  2 +-
>  t/t5504-fetch-receive-strict.sh |  2 +-
>  t/t5702-protocol-v2.sh          |  2 +-
>  t/t6300-for-each-ref.sh         |  2 +-
>  t/t7509-commit-authorship.sh    |  2 +-
>  t/t7510-signed-commit.sh        |  2 +-
>  t/t7528-signed-commit-ssh.sh    |  2 +-
>  t/t8003-blame-corner-cases.sh   |  2 +-
>  t/t9350-fast-export.sh          |  2 +-
>  13 files changed, 27 insertions(+), 27 deletions(-)

And these all look good, too. Each of the spots you touch here is
limited to replacing "git hash-object" with "git hash-object --literally".

Thanks,
Taylor
