Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5D1C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 22:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8324C6128E
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 22:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347313AbhDMWV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 18:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347257AbhDMWV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 18:21:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98314C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 15:21:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s14so4374695pjl.5
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tDeb8OpXsJ3umUWDWkv0/Yifz+yrzb8LfXejufNkN1o=;
        b=pNx3I9+pcJWszgoweWv3uRCr7UQSk8dzk0tPoBekHVqODxRrVToVo2avE5iA8DDdhe
         PuVdefByZ0pKXsANwYsVBv4rwxixnpJMy+9VwmmXoAHqi6Wubne8fbaP10mwNCbEPtE7
         6mvU23aaSURSB6LYXI03VgoMy6g9eNr5/2+DiAmaWn2AzsBHkNar+C3VbzLq5rVd0SWZ
         UXDGcm0VAnjQp9/AhlHnrucRAbTLROeZI9TaklLQtcGlNl1VylZD5jeEAv6XTYIhVntY
         w1h5OGCKZKBnbmI/gQu9K613ZNSh4035xBFGZRz9Cf/ZXL6KQhsVbzLuGdE4hTRWCHdk
         SOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tDeb8OpXsJ3umUWDWkv0/Yifz+yrzb8LfXejufNkN1o=;
        b=g7rdtxLgSUoR6oOf1P08pYSKjIzanjDKFQZ5sIyvy6fRhvqPUrqEgjZVpRfaHGXT3o
         hqezMWpMhnWdSYwPKONSF838W4y84idIW6LqSeFd0Akoe0aNm+Yb4sqHsQDEuoLqE9nl
         elGYLFln0bOPKUPJh1P70t2mFXL5MUIC1Q4vEwPT9RFNLiqxgPZQAvdc6c4DDHmf6POC
         8BXUhCjuPt0AYycKxxSA7Ft5MYtllGNUfMMh/T0ktogy0NyuDpjEwPOMmDkEj9NFu1a5
         R0R08ic05Dm5p7cCqNdp1xUqNRDPItbdbpdw9QGC3ioKPzN0w6fpD007jVbtj/Cv+N+/
         GyUg==
X-Gm-Message-State: AOAM532X/CpWMBfdtI62MNpiIEaYc6YpKgSbWt00Qac7lKCP0YN7II8X
        W6PZcyi95wko6BGHGMs3oKBReQ==
X-Google-Smtp-Source: ABdhPJx+0E2gRsKZ6bpIcvFfqytCCVkiRIqCTbSCwHPGCB8LDai1HH36KhnIcB2JyqhPIPQ4BM3B/A==
X-Received: by 2002:a17:90b:714:: with SMTP id s20mr36936pjz.62.1618352466879;
        Tue, 13 Apr 2021 15:21:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:2386:6c3a:61d0:6901])
        by smtp.gmail.com with ESMTPSA id g10sm5914153pfr.67.2021.04.13.15.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 15:21:06 -0700 (PDT)
Date:   Tue, 13 Apr 2021 15:21:00 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t0091-bugreport.sh: actually verify some content of
 report
Message-ID: <YHYZTLl90rkWWVOr@google.com>
References: <20210409212724.GE2947267@szeder.dev>
 <20210411143354.25134-1-martin.agren@gmail.com>
 <xmqqwnt7e82i.fsf@gitster.g>
 <CAN0heSr3MQnqMiWiSYpmpx3ZRkyXK6z1VfW_T-EQi31ifs0drA@mail.gmail.com>
 <87a6q22dei.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6q22dei.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 09:27:33PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Tue, Apr 13 2021, Martin Ågren wrote:
> 
> > On Mon, 12 Apr 2021 at 19:17, Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Martin Ågren <martin.agren@gmail.com> writes:
> >>
> >> > In the first test in this script, 'creates a report with content in the
> >> > right places', we generate a report and pipe it into our helper
> >> > `check_all_headers_populated()`. The idea of the helper is to find all
> >> > lines that look like headers ("[Some Header Here]") and to check that
> >> > the next line is non-empty. This is supposed to catch erroneous outputs
> >> > such as the following:
> > ...
> >> > Let's instead grep for some contents that we expect to find in a bug
> >> > report. We won't verify that they appear in the right order, but at
> >> > least we end up verifying the contents more than before this commit.
> >>
> >> Nicely described.  I agree that the original intent (let alone the
> >> implementation) is misguided and we should allow an empty section as
> >> a perfectly normal thing.
> >
> >> > +test_expect_success 'creates a report with content' '
> >> >       test_when_finished rm git-bugreport-check-headers.txt &&
> >> >       git bugreport -s check-headers &&
> >> > -     check_all_headers_populated <git-bugreport-check-headers.txt
> >> > +     grep "^Please answer " git-bugreport-check-headers.txt &&
> >> > +     grep "^\[System Info\]$" git-bugreport-check-headers.txt &&
> >> > +     grep "^git version:$" git-bugreport-check-headers.txt &&
> >> > +     grep "^\[Enabled Hooks\]$" git-bugreport-check-headers.txt
> >> >  '
> >>
> >> It is a different matter if it is sufficient to ensure only certain
> >> selected lines appear in the report, though.  As all the lines lost
> >> by this fix comes from 238b439d (bugreport: add tool to generate
> >> debugging info, 2020-04-16), it would be nice to hear from Emily.
> >
> > Maybe something like
> >
> >        awk '\''BEGIN { sect="" }
> >                /^\[.*]$/ { sect=$0 }
> >                /./ { print sect, $0 }'\'' \
> >            git-bugreport-check-headers.txt >prefixed &&
> >        grep "^ Thank you for filling out a Git bug report" prefixed &&
> >        grep "^ Please review the rest of the bug report below" prefixed &&
> >        grep "^ You can delete any lines you don.t wish to share" prefixed &&
> >        grep "\[System Info\] git version ..." prefixed
> >
> > Something like that could be used to verify that a line goes into the
> > right section, as opposed to just seeing that it appears *somewhere*. Or
> > maybe
> >
> >   grep -e Thank.you -e Please.review -e You.can.delete -e "^\[" \
> >        -e git.version git-bugreport-check-headers.txt >actual
> >
> > then setting up an "expect" and comparing. That would help us verify the
> > order, including which section things appear in. Slightly less friendly
> > for comparing loosely, compared to the awk-then-grep above.
> >
> > Let's see what Emily thinks about the various alternatives. Maybe she can
> > think of something else.

My apologies for the slow reply :)

> I think a straight-up test_cmp is preferrable, both for correctness and
> also as self-documentation, you can see from the test what the full
> expected output is like.

Yeah, I like the sound of this.

> 
> Obviously in this case we can't do a test_cmp on the raw output, as it
> contains various things from uname.
> 
> But it looks like we could do that if we do some light awk/perl/sed
> munging of the "[System Info]" and "[Enabled Hooks]" section(s).
> 
> Or, since we also control the generator we could pass a --no-system-info
> and/or --no-hooks-info, which may be something some people want for
> privacy/reporting reasons anyway (e.g. I've often used perlbug and
> deleted that whole info, because info there has no relevance to the
> specific issue I'm reporting).

This approach sounds more appealing to me than awk munging. I think
you're right that folks may not want to share it in some cases.

Thanks for noticing.
 - Emily

