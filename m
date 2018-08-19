Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 944C31F954
	for <e@80x24.org>; Sun, 19 Aug 2018 23:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeHTCTf (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 22:19:35 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37687 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeHTCTf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 22:19:35 -0400
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so14396591qtl.4
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 16:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HRSsp7mKZuHrAN61qw0BXXSQh4W8j0H2s27A7ITMU4c=;
        b=UoAXNH6X67uwlDL5mFRtjG+H1K5iio7yuXW6h9rfLW0XhnIHgGISTCYtU2bm5f6s6x
         yvc630JVqKnFAPeJr/aUwcwQCMzkYtvhTFwvap/b/Pz9TrqvqYZnKUH8lDLtUNLeBxvG
         d5w/92EByzeOyqew8it/ASo9vQ88itf7w3vyMd1UdOemqUjBrWtQQsGQWFWQS5GfYGLH
         6B/rYBHo1Lm8XXZLkM5YQ2HmwfLTqqVBQrlE0ZHY39RZkVNcuv1T4UnEQTGxqN6uva/B
         J7HmoMPdwVIS5uV+8lCyvKHHdbt5eAVpXI58+UQJlFV5gfLzj58SUoanxduGGUJ7gKh1
         P1nQ==
X-Gm-Message-State: AOUpUlGaXU00XkEb4SWuZwjgLDywUnmkyR0FLsHmoIjgiTBFNeTJ316Z
        2rpAg3/0LKWHlgmjYnZsqbYjCunuQJQ6/375/zo=
X-Google-Smtp-Source: AA+uWPyq2R5Xpn3kMDS0K9gEqN/iqpfFLNclS55MWFYh5fcUsPbxMXu4r2Azpcn5s8h1IuCmMnIHF2d7cK+SKpKnqP4=
X-Received: by 2002:ac8:6c8:: with SMTP id j8-v6mr40770629qth.314.1534719985764;
 Sun, 19 Aug 2018 16:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
 <20180819175351.449973-2-sandals@crustytoothpaste.net> <CAPig+cRZsJ00wNW08-jxmD=aW0V1hJJYEa9EVTMQT4=r0B+jeQ@mail.gmail.com>
 <20180819215022.GH70480@genre.crustytoothpaste.net>
In-Reply-To: <20180819215022.GH70480@genre.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Aug 2018 19:06:14 -0400
Message-ID: <CAPig+cRSUDAdE2ECcH+b8h4urJySaS_VybQdHNv24rad_kFEag@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] t: add tool to translate hash-related values
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 19, 2018 at 5:50 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Aug 19, 2018 at 03:40:22PM -0400, Eric Sunshine wrote:
> > On Sun, Aug 19, 2018 at 1:54 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > +       test "$(test_oid hexsz)" -eq $(wc -c <actual) &&
> > > +       test $(( $(test_oid rawsz) * 2)) -eq "$(test_oid hexsz)"
> > > +'
> >
> > If $(test_oid rawsz) fails to find "rawsz" and returns nothing, this
> > expression will be "*2", which will error out in a
> > less-than-meaningful way. Perhaps it would make more sense to dump the
> > results of the two test_oid() to file and use test_cmp()?
>
> I think what I'd like to do instead is store in a variable and make
> test_oid return unsuccessfully if the value doesn't exist.  I think
> that's better for writing tests overall and will accomplish the same
> goal.

My knee-jerk reaction is that could get clunky in practice, but
perhaps I'm not seeing the full picture.

An alternative would be to return a distinguished error value.

> > > + test_oid_cache <"$TEST_DIRECTORY/oid-info/$1"
> >
> > What is the benefit of placing test-specific OID info in some
> > dedicated directory? I suppose the idea of lumping all these OID files
> > together in a single oid-info/ directory is that it makes it easier to
> > see at a glance what needs to be changed next time a new hash
> > algorithm is selected. However, that potential long-term benefit comes
> > at the cost of divorcing test-specific information from the tests
> > themselves. I imagine (for myself, at least) that it would be easier
> > to grok a test if its OID's were specified and cached directly in the
> > test script itself (via test_oid_cache <<here-doc). I could even
> > imagine a test script invoking test_oid_cache<<here-doc before each
> > test which has unique OID's in order to localize OID information to
> > the test which needs it, or perhaps even within a test.
>
> Putting them in a separate directory makes it possible to do something
> like this:
>
>    (cd t && ./t0002-* --verbose)
>
> and then use shell editing to change the command line.  If we put them
> in the same directory as the tests, we make developers' lives a bit
> harder.

Perhaps I'm missing something obvious, but I'm not following what
you're trying to convey.

Okay, thinking upon this further, I guess you mean people who type
your example directly rather than using "./t0002-*.sh" or something.

> You mentioned the desire to experiment with additional hash algorithms
> as a hope for this series.  I don't know if that's still something
> desirable to have, now that we've decided on SHA-256, but I felt it
> would make it easier to find all the places that need updating.

I'm still open to the idea of supporting experimentation with other
hash algorithms and I see how lumping all the OID tables into a single
directory can make it easy to locate everything that will require
adjustment for a new algorithm. But, this information can also be
gleaned via a simple grep for "test_oid_cache", so I'm not sure the
lumped-directory approach buys much.

Also, my gut feeling is that such experimentation will be very rare,
whereas the addition of new tests which have some sort of
OID-dependency will likely be a more frequent occurrence. And, the
locality of an OID-table plopped down right next to the test which
requires it seems a win (in my mind).

> > So, I'm having trouble understanding the benefit of the current
> > approach over merely loading OID's via here-docs in the test scripts
> > themselves. Perhaps the commit message could say something about why
> > the current approach was taken.
>
> I can do that.  The idea is that we have lots of common uses of certain
> values that will need to be loaded, and it's better to load some of
> those values from a file.  I felt it would be ugly to have to write out
> the full "$TEST_DIRECTORY..." piece every time.

I do favor the simplicity of the caller deciding whether to use
"test_oid_cache <file" or "test_oid_cache <<here-doc"; it provides
extra flexibility over a function which loads the OID tables from a
fixed path.

However, I'm sympathetic to the ugliness each caller having to specify
"$TEST_DIRECTORY/...". In my review of 2/11, I suggested the idea of a
test_oid_init() function which could load those common OID tables for
scripts which need them, thus hiding that ugliness. Another idea which
has some appeal is to define an $OIDDB variable (or some such name)
with value "$TEST_DIRECTORY/oid-info", which lets callers use:

    test_oid_cache <"$OIDDB/bloop"

which isn't so bad.

> > Why, specifically, return $? here, as opposed to simply returning?
>
> A simple return is probably better.  I think I wasn't clear on whether
> POSIX required a bare "return" to return $? and may not have been online
> at that time to look.  I remember being very clear that I didn't want to
> return 0 unconditionally, though.

I asked because, as far as I can see, this _is_ returning 0
unconditionally since $? will always be 0 by the time it gets to the
'return' (since it's not making any effort to break from the 'while'
loop with a meaningful value upon failure.

Fixing this function to return a meaningful value (success or failure)
might be sensible since that would allow it to be used directly in a
test rather than only outside.
