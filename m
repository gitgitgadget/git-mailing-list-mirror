Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AEFC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA0B235FA
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF302XZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIRPK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 11:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRPK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 11:10:58 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5848EC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 08:10:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u21so5378473ljl.6
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diM7jwQyRDJ90DSTjfv6H/Q990aaWztesn2lc7vCWHo=;
        b=RF302XZzPD3dowvhWzrlrHEEsjDwuaHulYydszt3SkKST9QZv2I+eMt7CJ5i+BFuoH
         9YCL/NpkZlQu61kl7C0oQTOa7OjTJ8gw89hoAk2hkC8LibtTlL4BCUtq/uw5QZSZQBDB
         uxzbXGGesL6b+k/a6TCgDmzPCQjb4kGTcX1VrwcNx5T3SrySIJa4VTJqt4twLJ0dpvAg
         Ld/1qY3pcZYGTlpIYXnsysndXY+/XPzxz4PA15pH/13w9dVmxg45bD7qM4LyUq2GJG+m
         s8MZCf02zgPltHIHWJUeWzjL5G0d95IEQFwvz0dxeLjIB/SzF7MLo8o4LL1jFUq3QX7g
         TNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diM7jwQyRDJ90DSTjfv6H/Q990aaWztesn2lc7vCWHo=;
        b=aTYHahANXTjXEk1R8UC54i+rpNN7X8ZBaI8laFl4uQDXjGBrk5z05L1NNG6zSOUCpb
         uwxsZfEmjRCm9dFGeww0KFqtE8B8xWiV6SJ436cwnC6+tcOAHh8ellcYddhTH98+ruN9
         q2UCIGxhTM0DoatkxQ0CmE/z+rDWZD2xvDQBHat72hjVmdchkuaQvBKjpFfziMJr/oKn
         rgXLi17cgo6iBP59e6a4C3R4BU1yUaXKkxqvO+4XwLG3ryvLGBdAMqcStkOBDapgXp1N
         GjSNADIp+IsDgnxsN/IIRGKWbwzQr1ar1C77r/kJ8YOobWwmT5o+xq33R6+OKlhstp0w
         mFJA==
X-Gm-Message-State: AOAM531ChFA3XbFZbisuBmWDuOB1zNCqBnKmMcBbrM0wCEGBb6I0YGMp
        se3+WQepzwN4ceY2bfe4OJWgweoJlVHm8Mfv7Is5gUdg
X-Google-Smtp-Source: ABdhPJxsN8mlm7+1MMptdAAdjeQgyggshWVty9g9rTkmIwFmrRIBRvAKtSC5u5RxMRmk+6uUGjPW8wEos+ca+hIpVVA=
X-Received: by 2002:a2e:88c4:: with SMTP id a4mr11226761ljk.393.1600441856455;
 Fri, 18 Sep 2020 08:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200918113256.8699-1-tguyot@gmail.com> <20200918113256.8699-2-tguyot@gmail.com>
 <20200918144651.GA1612043@nand.local>
In-Reply-To: <20200918144651.GA1612043@nand.local>
From:   Thomas Guyot-Sionnest <tguyot@gmail.com>
Date:   Fri, 18 Sep 2020 11:10:45 -0400
Message-ID: <CALqVohfQZu=itUyfU7nubJpgBETh2q7W1TVx=c2E32ey2cFZkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and --numstat
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Thomas Guyot-Sionnest <dermoth@aei.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 18 Sep 2020 at 10:46, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, Sep 18, 2020 at 07:32:55AM -0400, Thomas Guyot-Sionnest wrote:
> > -     same_contents = oideq(&one->oid, &two->oid);
> > +     if (one->is_stdin && two->is_stdin)
> > +             same_contents = !strcmp(one->data, two->data);
>
> Hmm. A couple of thoughts here:
>
>   - strcmp seems like a slow-down here, since we'll have to go through
>     at worst the smaller of one->data and two->data to compare each of
>     them.
>
>   - strcmp is likely not the right way to do that, since we could be
>     diffing binary content, in which case we'd want to continue over
>     NULs and instead stop at a fixed length (the minimum of the length
>     of one->data and two->data, specifically). I'd have expected memcmp
>     here instead.
>

You're absolutely right - this is a bug I managed to figure out last
night - first real incursion into git C code - and I definitely didn't
think this through. TBH so far I coded mostly with tools dealing in
plaintext and C strings.

>   - Why do we have to do this at all all the way up in
>     'builtin_diffstat'? I would expect these to contain the right
>     OIDs by the time they are given back to us from the call to
>     'diff_fill_oid_info' in 'run_diffstat'.
>
> So, my last point is the most important of the three. I'd expect
> something more along the lines of:
>
>   1. diff_fill_oid_info resolve the link to the pipe, and
>   2. index_path handles the resolved fd.
>
> ...but it looks like that is already what it's doing? I'm confused why
> this doesn't work as-is.

So the idea is to checksum the data and write a valid oid. I'll see if
I can figure that out. Thanks for the hint though else I would likely
have gone with a buffer and memcmp. Your solution seems cleaner, and
there is a few other uses of oideq's that look dubious at best with
the case of null oids / buffered data so it's definitely a better
approach.

> > +     else
> > +             same_contents = oideq(&one->oid, &two->oid);
> >
> >       if (diff_filespec_is_binary(o->repo, one) ||
> >           diff_filespec_is_binary(o->repo, two)) {
> > diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> > index e024cff65c..4715e75b68 100755
> > --- a/t/t3206-range-diff.sh
> > +++ b/t/t3206-range-diff.sh
> > @@ -258,11 +258,11 @@ test_expect_success 'changed commit with --stat diff option' '
> >            a => b | 0
> >            1 file changed, 0 insertions(+), 0 deletions(-)
> >       3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
> > -          a => b | 0
> > -          1 file changed, 0 insertions(+), 0 deletions(-)
> > +          a => b | 2 +-
> > +          1 file changed, 1 insertion(+), 1 deletion(-)
> >       4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
> > -          a => b | 0
> > -          1 file changed, 0 insertions(+), 0 deletions(-)
> > +          a => b | 2 +-
> > +          1 file changed, 1 insertion(+), 1 deletion(-)
>
> The tests definitely demonstrate that the old behavior was wrong,
> though...
>

For the records I verified the actual diffs (I think they're even
hardcoded in the earlier tests) and the remaining 0-add/del's are also
valid.

Regards,

Thomas
