Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250EBC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 02:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020F860232
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 02:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbhIQCqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 22:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhIQCqj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 22:46:39 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07C3C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 19:45:18 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h20so8707452ilj.13
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 19:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ABAEEpT69bZRoDx+z76JtpLA4TjgY7b63Kca0vDYVQs=;
        b=I8HagYtnkcSm5pCMpSYtv6w3sO4N6PpEDyHWIf3uTbnS+59IkDfBOwqSMlI98N+Rhs
         s7OBwNe0Khwslwoeq4j72uFeSA+3SKIWewqFNXYN1ycd7uS5/cKXxF05L1ADu+2kDRLG
         NOI/WEBX5wxCaJylcz63bDe9rrKADXxWVrhzsT/Lm5mNLCFQnaJ7Nuo7yQb+kryXuaw9
         5lZ22CLJf74pvLYz3yGOCpmQtx+EalYaQFDGMd4g1imuJagkS3wjfey2Dcr2VHidJGeg
         qwnoYC4GN86bu5QM/t/Hz2dgWZ9+i8c4GTwb4VlH3jOqm14NZbul1QmK5dogOgrSNcN6
         v6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ABAEEpT69bZRoDx+z76JtpLA4TjgY7b63Kca0vDYVQs=;
        b=kw6rON5xomvVR7krfgA2GObbAUFJoYZLDu1fTkpevpYPeLo+UciZS9Suj3dO2OA7n7
         lDNffzoL6/NqEBUPiXTnur4WxvBBhdJQ+dbgs5s/P+Go/ZvroALWJqmD3VLzINm0acG6
         az6sjwa7NqGgt8CothzE3p7RWB0T1hbTEf2s/U5eU9M3+QPDXUDs9NcR0UxAhhw4AZ7C
         KPXOdnQW0FlQUN8vgd73Hb5uEJsW2lvDJWY0zCMOok3a2xIo5q79omhKiWmVhfdW+egT
         4eIcELJjEcqKCEI7eI5rKsJJ+w/AYKdf2PDj5sdUPJJROCnv3BMYAu6w658tqC61IOM/
         7jDg==
X-Gm-Message-State: AOAM531z2okUNHEZMdpRfH2Aq450bse6YOICJg90T+ZRBpyIljj7XrmY
        ijG8sQWpjANEpCwV/YoslK+x4w==
X-Google-Smtp-Source: ABdhPJzf3x5zqh5APSVfxWbnfL4TTbErWFLcjxSV9nMGbDMLIIv34kNw7XoDOuuPVb98SDFRXYzW6w==
X-Received: by 2002:a92:b702:: with SMTP id k2mr6554988ili.150.1631846718131;
        Thu, 16 Sep 2021 19:45:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f17sm2810639ilq.44.2021.09.16.19.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 19:45:17 -0700 (PDT)
Date:   Thu, 16 Sep 2021 22:45:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 18/22] object-file.c: use "enum" return type for
 unpack_loose_header()
Message-ID: <YUQBPXPdCxumPWhL@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-18.22-1b7173a5b5b-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-18.22-1b7173a5b5b-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:58:13PM +0200, Ævar Arnfjörð Bjarmason wrote:
> In the preceding commits we changed and documented
> unpack_loose_header() from return any negative value or zero, to only
> -2, -1 or 0. Let's instead add an "enum unpack_loose_header_result"
> type and use it, and have the compiler assert that we're exhaustively
> covering all return values. This gets rid of the need for having a
> "default" BUG() case in loose_object_info().
>
> I'm on the fence about whether this is more readable or worth it, but
> since it was suggested in [1] to do this let's go for it.

:-). The first hunk is quite a long line, but I think that only suggests
the enum has a long name. I also can't think of anything shorter, so I
think what you have is just fine.

I do think that this is an improvement in readability, and for what it's
worth I am a fan of the previous two changes as well.

As a workflow comment, I would have perhaps done these conversions a
little earlier, maybe in these steps:

  - First a patch to introduce unpack_loose_header_result with just OK
    and BAD, and then converted all callers that return negative numbers
    to return BAD (and all others to return OK).

  - Then a second patch to convert some of the BAD returns into
    BAD_TOO_LONG.

That gets things done in two patches, instead of three, at the cost of a
slightly more complicated first patch. But I think you also get some
more insight into why we're making the change in the first place instead
of having to read through a couple of commits to get there.

In any case, what you have is certainly fine, and I don't think that one
approach is any better or worse than the other. Just mentioning it in
case it's something may try in the future.

This patch looks good.

Thanks,
Taylor
