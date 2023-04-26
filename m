Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BFEC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 15:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbjDZPcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbjDZPcv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 11:32:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E294
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:32:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a66888cb89so57262125ad.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682523170; x=1685115170;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6D6dm42t4Zsu/g+39g64iaBs86kr/bWjSXJGsF2d038=;
        b=ngBBFeQ2q6AFzQRrrOXohH4si/LZGqq1IbNAdMlZ1Ery/HxtwnkUhcmJKtg0Xx+ooD
         rXwsXsT5LxGxtNbP87rYuH7M58GXH/bfS/R1woIzn0F1EVOCOvRSdHC9MbZVwVeN/nV0
         ogQ1dKWLkCJA9q1XAQq0x05WEWeOcI9eAnjQ3jxIXg+M9S39OtABEIpZdJDUa6esOhHf
         tipeoWoOho0v2RNXCs2X+h/EqnzP0EfnVnlzGodS8zEj+WpJJdiA8tZp8I10yqqK5JKs
         SfJ/UzrBCs/gbc/Q20q4dOulvHjIeuVtExaInszwAQIpI2HjglWKzTnBbXWTOdu6FfzV
         Oxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682523170; x=1685115170;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6D6dm42t4Zsu/g+39g64iaBs86kr/bWjSXJGsF2d038=;
        b=GaP63GeMG7Zq155rKjc8W5j210YwhdSObQ7JKvQcU1qMVg0UlDcb/P0SOcxhK/8Eon
         MvZGHkFYiEhfeU9NXWoQHKJxRK2cUgJeeY9Fj+q6lrchLid9sbwX90HtxDIxH6hjsDOp
         AHxW8GPtq4Wy14uBOIcjEjYdb6BG32T2i6Ac7wvygNdO+ZCXj84J/LvuIyxoIxYLYkIe
         dpHvy7PzT+8zJ0GYFetzAUq4vdcavqmtMz587I6hEOUQAOLK56DJwzC4NvUPeAw8z+Ld
         fh4eUFo7f8Bi5ivjcPWH5TBmqcO+TGSM+BZ90N7r9b6KP872Dc7lAJfzKHW80tx+b/Si
         kuKg==
X-Gm-Message-State: AC+VfDwfSqY5DKoikbMbqxZQreu27wuuDe90s9t5DboR374a4v3DqTIi
        ikpA/WEuSyhCGZCZtOfCZQQ=
X-Google-Smtp-Source: ACHHUZ7cpI0Wf4d0KcZLY8BBBqawnqIu/Wb2cYY+u6hEgp5Vo+uLNr88AIE/Ncq5KdTVNIRHdiaAMA==
X-Received: by 2002:a17:903:41c1:b0:1a9:80a0:47dc with SMTP id u1-20020a17090341c100b001a980a047dcmr10935501ple.3.1682523169699;
        Wed, 26 Apr 2023 08:32:49 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id t23-20020a170902b21700b0019fea4d61c9sm10115925plr.198.2023.04.26.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 08:32:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 3/4] parse_commit(): handle broken whitespace-only
 timestamp
References: <20230425055244.GA4014505@coredump.intra.peff.net>
        <20230425055458.GC4015649@coredump.intra.peff.net>
        <06bc5530-55b0-7299-a6e6-fde1deab6605@gmail.com>
        <xmqqttx43q08.fsf@gitster.g>
        <20230426113658.GC130148@coredump.intra.peff.net>
Date:   Wed, 26 Apr 2023 08:32:49 -0700
In-Reply-To: <20230426113658.GC130148@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 26 Apr 2023 07:36:58 -0400")
Message-ID: <xmqqildiveu6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Instead, we should go back to what the original iteration of the series
> was doing, and make sure there is at least one digit (i.e., a "forbid
> unknown" strategy). Assuming that there is no locale where ascii "1" is
> considered whitespace. ;)
>
> Note that will exclude a few cases that we do allow now, like:
>
>   committer name <email> \v123456 +0000\n
>
> Right now that parses as "123456", but we'd reject it as "0" after such
> a patch.

I would say that it is a good thing.

The only (somewhat) end-user controlled things on the line are the
name and email, and even there name is sanitized to remove "crud".
The user-supplied timestamp goes through date.c::parse_date(),
ending up with what date.c::date_string() formats, so there will not
be syntactically incorrect timestamp there.  So we can be strict
format-wise on the timestamp field, once we identify where it begins,
which is the point of scanning backwards for '>'.

Unless the user does "hash-object" and deliberately creates a
malformed commit object---they can keep both halves just fine in
such a case as long as we do reject such a timestamp correctly.

> The alternative is to check _all_ of the characters between ">" and the
> newline and make sure there is some digit somewhere, which would be
> sufficient to prevent strtoumax() from walking past the newline.
>
> I guess it's not even any more expensive in the normal case (since the
> very first non-whitespace entry should be a digit!). I'm not sure it's
> worth caring about too much either way. Garbage making it into
> name/email is an easy mistake to make (for users and implementations).
> Putting whitespace control codes into your timestamp is not, and marking
> them as "0" is an OK outcome.

Yeah, I think it is fine either way.

Thanks


