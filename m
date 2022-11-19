Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7C2C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 02:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKSCxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 21:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiKSCxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 21:53:25 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC74313D2D
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 18:53:23 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 11so5235789iou.0
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 18:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEgkFI4ZUWJKHgpjZX50ulQ9ucEG2NjjwBzEz2Pz47Y=;
        b=hNJ8IDgM1ageSwj0MURhU677JbJLwOIRYef87/l1WwTqas+AaIw3jCg0irtdOPj/QP
         6CT1sNpaXb9W3i7twm4mHbKUUhBhsyyYxUGAST5jtApAHQFfFi0gqAQHz0LjrBYnUPJq
         MPK5uX28snpbCdOx/+feMFCcRuNOqB2WIxqRAc+n5qLujUZrEQ7Ep31pWcMLYJk1b9r3
         FZSFqrVHBnxN3hmkwxgUQjFzGrfR/OyzeSz2s75gf3l3h3t1VFy6HynQl5pbY7Bnp36+
         yiGBH+n3jM96ZLEuUv3Bw45+izuX+khNGfngq7kMtnjeGJmktRBUKOFu4WI00fbOwujP
         Df4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEgkFI4ZUWJKHgpjZX50ulQ9ucEG2NjjwBzEz2Pz47Y=;
        b=TI3EVQpOrkaKsibZyzkyHJHxt4fWTCEqOx9p2hos8guhDHlVk4oP5S2NNAl3IAah56
         F9juKtlpOZz5mr2Rjd31MZcEYb9b0vlEzuK0vH2MSR2qmVUFP76WBXnKJNhHm8gIKHlr
         1U1VxLwCWh26c2ZbDRyhjI0QklvAX3TJms2yF+OhCXAtaeqtTSUfBJ7kolrkEdn7QKZ7
         iBBYk0NkPJ+o8LqcB1sZP6QM2EDWx+0UgUQ3y2Bh7LVXnop68eFezg6sN+tAhYMM7RSM
         7fW5Xf921G7KUmi91481tpjg0d4GwaZ++QciXD10GCK2u8cG8E8dhoQ0gTDtv64DxsnB
         e9gQ==
X-Gm-Message-State: ANoB5pnYklbJXs247G7gfwh++6uZt20bG1tE2TlVGimkC6u/SiEFu9BD
        GiNkUU8EZ4BC7IuUDbgpRTyFnA==
X-Google-Smtp-Source: AA0mqf7As8XY3hEVNiwVodwo64+dJNvefmJ6VZpIUvUgIkTVOtrpv9q2r0DXNgpMQXpX20VTRCaJ0Q==
X-Received: by 2002:a5d:9505:0:b0:6a3:ebdc:6ef8 with SMTP id d5-20020a5d9505000000b006a3ebdc6ef8mr69333iom.189.1668826403323;
        Fri, 18 Nov 2022 18:53:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a4-20020a021604000000b003759adf748dsm1858843jaa.64.2022.11.18.18.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 18:53:22 -0800 (PST)
Date:   Fri, 18 Nov 2022 21:53:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Message-ID: <Y3hFITt+8VUubC8v@nand.local>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
 <Y3B36HjDJhIY5jNz@nand.local>
 <xmqqv8nbkg77.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8nbkg77.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 03:15:08PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > One thing that the commit message doesn't allude to (that is covered in
> > the earlier discussion) is why it is important to pass
> > `--ignore-cr-at-eol`. I think that is worth mentioning here.
>
> Isn't it because Git on the platform is expected to use CRLF in
> certain places, unlike on other platforms where LF is used, but the
> platform port hasn't adjusted tests to match that expectation?  And
> vice versa, where Git is expected to produce LF terminated text
> everywhere but the expected output is not "ported" to force LF
> termination and instead produces CRLF terminated text on platforms
> whose native line ending is CRLF?

Yes, I think that's right. My suggestion to Johannes was to (a) make
sure that your and my understanding is correct, and (b) to memorialize
that understanding in the commit message itself.

> Use of "ignore-cr-at-eol" may allow such tests that are not ported
> correctly to prepare expected output with a "wrong" line ending and
> still pass, and I do think it may be an expedite way to make tests
> appear to pass.
>
> But I worry that it may not be a good thing for the health of the
> Windows port in the longer term.

I share your concerns, too.

Thanks,
Taylor
