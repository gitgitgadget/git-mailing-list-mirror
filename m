Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B6E1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbeGaUhm (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 16:37:42 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43304 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbeGaUhm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 16:37:42 -0400
Received: by mail-yw0-f195.google.com with SMTP id l189-v6so6188698ywb.10
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0CKPBfYz2NXz47UvTsIVLM2oPf2lnRl5c3nma5w0Tw=;
        b=BzXr7AEgvIuG0auU1lfBRAhOGKv5xZITiq2D9Xv5hTtfT7eOrC/BhFCijLnHAynRYR
         /oC8/yvEFTx8lVFO6pkc7KtwddtzNcm+hfFc0A2xFLkvp9L2yoMYtElr4g2QG4zP1HzA
         XiLLsPYfF9finQ6Md2O8rZV7+eaNVGpFyZpYmd62Dznh5GxkTKI08CMcVKDxAxn1vr3Q
         0Wgl+L2VuEhAG5bkUBQeTEb6er1A0i/XPRrwuPOLYZm3D4T7PGK+N8j7A9KP6BvCBoZs
         +VtyJ9AD2aCPHWuP+Nd8npsKFUXT8tWJUl4DztDySkvwgQXegwpgfig4ZsgjapPaqs1n
         Fh1w==
X-Gm-Message-State: AOUpUlHnce11tjdNQdQAuQm4PBHMfuRcYfRDwhiOKYjyIvyY2S5GPpJQ
        m1vQfX63Qoa+dSRiZKvOI9u1OZpQnK2rP9o9RqA=
X-Google-Smtp-Source: AAOMgpeT9ue4htjeKSeJOyicrp9tsOQrBQeFib1hGYoseZrXYPMIHgssTfp+YfnKWpSAHrl9xZTOXe+XhWhj/8RFKII=
X-Received: by 2002:a81:1001:: with SMTP id 1-v6mr11780900ywq.120.1533063362688;
 Tue, 31 Jul 2018 11:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com> <20180711064642.6933-2-sunshine@sunshineco.com>
 <20180730181356.GA156463@aiede.svl.corp.google.com> <CAPig+cRFMKBQVVYjhS6-Yyy-aQCYXGiqG6XoqucJoedCvAzheQ@mail.gmail.com>
 <20180730205914.GE156463@aiede.svl.corp.google.com> <CAPig+cRTgh6DStUdmXqvhbL_7sQY6wu21h27rjq_i=kZ_d+LAw@mail.gmail.com>
 <20180731125026.GA8072@sigill.intra.peff.net>
In-Reply-To: <20180731125026.GA8072@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Jul 2018 14:55:51 -0400
Message-ID: <CAPig+cTqod7KY=EKPbFUFK=mpO1T2jUgpozMVN_0R51vgJLsDw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 8:50 AM Jeff King <peff@peff.net> wrote:
> On Mon, Jul 30, 2018 at 05:38:06PM -0400, Eric Sunshine wrote:
> > I considered that, but it doesn't handle nested here-docs, which we
> > actually have in the test suite. For instance, from t9300-fast-import:
> > [...]
> > Nesting could be handled easily enough either by stashing away the
> > opening tag and matching against it later _or_ by doing recursive
> > here-doc folding, however, 'sed' isn't a proper programming language
> > and can't be coerced into doing either of those. (And, it was tricky
> > enough just getting it to handle the nested case with a limited set of
> > recognized tag names, without having to explicitly handle every
> > combination of those names nested inside one another.)
>
> I hesitate to make any suggestion here, as I think we may have passed
> a point of useful cost/benefit in sinking more time into this script.
> But...is switching to awk or perl an option? Our test suite already
> depends on having a vanilla perl, so I don't think it would be a new
> dependency. And it would give you actual data structures.

It would, and I did consider it, however, I was very concerned about
startup cost (launch time) with heavyweight perl considering that it
would have to be run for _every_ test. With 13000+ tests, that cost
was a very real concern, especially for Windows users, but even for
MacOS users (such as myself, for which the full test suite already
takes probably close to 30 minutes to run, even on a ram drive). So, I
wanted something very lightweight (and deliberately used that word in
the commit message), and 'sed' seemed the lightest-weight of the
bunch.

'awk' might be about as lightweight as 'sed', and it may even be
possible to coerce it into handling the task (since the linter's job
is primarily just a bunch of regex matching with very little
"manipulating"). v1 of the linter was somewhat simpler and didn't deal
with these more complex cases, such as nested here-docs. v1 also did
rather more "manipulating" of the script since the result was meant to
be run by the shell. When it came time to implement v2, which detects
broken &&-chains itself by textual inspection, most of the
functionality (coming from v1) was already implemented in 'sed', so
'awk' never really came up as a candidate since rewriting the script
from scratch in 'awk' didn't seem like a good idea. (And, at the time
v2 was started, I didn't know that these more complex cases would
arise.) So, 'awk' might be a viable alternative, and perhaps I'll take
a stab at it for fun at some point (or not), but I don't think there's
a pressing need right now.
