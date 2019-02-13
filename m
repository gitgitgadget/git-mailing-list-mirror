Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0EB81F453
	for <e@80x24.org>; Wed, 13 Feb 2019 04:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfBMEXP (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 23:23:15 -0500
Received: from p3plsmtpa07-05.prod.phx3.secureserver.net ([173.201.192.234]:46838
        "EHLO p3plsmtpa07-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727324AbfBMEXP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Feb 2019 23:23:15 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id tm4hgr8KzX9p2tm4ngv4G7; Tue, 12 Feb 2019 21:23:14 -0700
Date:   Wed, 13 Feb 2019 06:23:07 +0200
From:   Max Kirillov <max@max630.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Max Kirillov <max@max630.net>, Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.us>
Subject: Re: [PATCH v2] pack-refs: fail on falsely sorted packed-refs
Message-ID: <20190213042307.GA3064@jessie.local>
References: <CAPig+cTn2gURyQgWHZQMNf2cZ+zwFhbH1Q4iPmbwuvYjMrPZPg@mail.gmail.com>
 <20190208212221.31670-1-max@max630.net>
 <CAMy9T_EX_L80-V4zD626nFCxw6qa90+pZwcbd6wHw9ZHcj2rNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMy9T_EX_L80-V4zD626nFCxw6qa90+pZwcbd6wHw9ZHcj2rNA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfIvl1AAlSA6OTrP/H4gFNYOetvHtWfHVD7wM76N4RR5RfzAbhV1bex4DI03ZWHvXpk5DBMVbedO84ao9zMYqHHOj7ebozn9fQb2QlWh56Wve5O8KK6dt
 rPOOqrscsoaLZD0U3Pak86x5psnUNth4z1OfA0H1++e2sY73PuMy8BlZsFeXDk2PNub2x7vSfZh+XRiV1Y60tu9wdiKXpI+INSECCUQ/sQrIa9pL0iy9R63O
 PV/SLaEZ4DlhtxgXcx63GA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 08:24:46PM +0100, Michael Haggerty wrote:
> The change to `write_with_updates()` doesn't only affect `pack-refs`.
> That function is also called when the `packed-refs` file has to be
> rewritten when a packed reference is deleted. This is another thing
> that you could test.

Ok, I'll check ti and add to the tests.

> But that also means that fairly common commands like `git branch -d`
> could be slowed down by this change. I doubt that the slowdown is
> prohibitive, but it would be great to see numbers to prove it. For
> example, create a repository with a lot (say 10000) references, pack
> them, then run `git branch -d` to delete one of them. Benchmark that
> once with master and once with your modification and document the
> difference.

At my hardware, with 1M references, "branch -d" takes 0.31s
of user time before change vs 0.38 after change. Should I
mention it in the commit message?

>> +test_expect_success 'off-order branch not found' '
>> +       test_must_fail git show-ref --verify --quiet refs/heads/b00
>> +'
> 
> I don't think that the above test makes sense. We don't *guarantee*
> that an out-of-order reference won't be found. That is an
> implementation detail that we are free to change. I think that it
> would be OK to just omit this test.

Thanks, will remove this one
