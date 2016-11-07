Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EC562021E
	for <e@80x24.org>; Mon,  7 Nov 2016 01:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbcKGBUN (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 20:20:13 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55050 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbcKGBUM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 20:20:12 -0500
Received: from mfilter49-d.gandi.net (mfilter49-d.gandi.net [217.70.178.180])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id 2B4B2A80C8;
        Mon,  7 Nov 2016 02:18:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter49-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter49-d.gandi.net (mfilter49-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id rJ-N9CDXUhS1; Mon,  7 Nov 2016 02:18:46 +0100 (CET)
X-Originating-IP: 50.39.170.172
Received: from x (50-39-170-172.bvtn.or.frontiernet.net [50.39.170.172])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C5C6BA80C1;
        Mon,  7 Nov 2016 02:18:43 +0100 (CET)
Date:   Sun, 6 Nov 2016 17:18:41 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161107011841.vy2qfnbefidd2sjf@x>
References: <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
 <CAP8UFD1EZ8HBzLAeyFBFgU7n2uJpswqgEgA4XM1YJuRAG_ZAAQ@mail.gmail.com>
 <20161105151836.wztypzrdywyltvrc@x>
 <CAP8UFD3XFHr7POKmZr_6guapC6sme3GvWBV5vPw4XO7FE5HOPw@mail.gmail.com>
 <20161105202553.migx75gfuujakqyk@x>
 <CA+P7+xoG3ag8dj7s_NRoqz-EwjVENSJSzE_qj6gnW-SmWt0bgA@mail.gmail.com>
 <20161106163410.ilysej5r6qd3744e@x>
 <xmqqshr4cyy7.fsf@gitster.mtv.corp.google.com>
 <20161106173311.lqoxxgcklx4jlrg7@x>
 <CA+P7+xoxjwvjXrW0Pwh7ZK-OYBiYamPAxvf_=zqJOsQ8xWDPWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xoxjwvjXrW0Pwh7ZK-OYBiYamPAxvf_=zqJOsQ8xWDPWw@mail.gmail.com>
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 06, 2016 at 12:17:10PM -0800, Jacob Keller wrote:
> On Sun, Nov 6, 2016 at 9:33 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> > On Sun, Nov 06, 2016 at 09:14:56AM -0800, Junio C Hamano wrote:
> >> Josh Triplett <josh@joshtriplett.org> writes:
> >> > We could, but if we (or one of the many third-party git implementations)
> >> > miss a case, gitlinks+reachability may appear to work in many cases with
> >> > dataloss afterward, while gitrefs will fail early and not appear
> >> > functional.
> >>
> >> I wonder what happens if we do not introduce the "gitref" but
> >> instead change the behaviour of "gitlink" to imply an optional
> >> reachability.  That is, when enumerating what is reachable in your
> >> repository, if you see a gitlink and if you notice that you locally
> >> have the target of that gitlink, you follow, but if you know you
> >> lack it, you do not error out.  This may be making things too
> >> complex to feasibily implement by simplify them ;-) and I see a few
> >> immediate fallout that needs to be thought through (i.e. downsides)
> >> and a few upsides, too.  I am feeling feverish and not thinking
> >> straight, so I won't try to weigh pros-and-cons.
> >>
> >> This would definitely need protocol extension when transferring
> >> objects across repositories.
> >
> > It'd also need a repository format extension locally.  Otherwise, if you
> > ever touched that repository with an older git (or a tool built on an
> > older libgit2 or JGit or other library), you could lose data.
> >
> > It does seem conceptually appealing, though.  In an ideal world, the
> > original version of gitlink would have had opt-out reachability (and
> > .gitmodules with an external repository reference could count as opting
> > out).
> >
> > But I can't think of any case where it's OK for a git implementation to
> > not know about this reachability extension and still operate on the
> > gitlink.  And given that, it might as well use a new object type that
> > the old version definitely won't think it understands.
> >
> > - Josh Triplett
> 
> That's still only true if the receiving end runs fsck, isn't it? I
> suppose that's a large number of receivers, and at least there are
> ways post-push to determine that objects don't make sense to that
> version of git.
> 
> I think using a new mode is the safest way, and it allows easily
> implementing RefTrees as well as other projects. Additionally, if we
> *wanted* additional "opt-in / opt-out" support we could add this by
> default to gitrefs,and they could (possibly) replace gitlinks in the
> future?

Once we have gitrefs, you have both alternatives: reachable (gitref) or
not reachable (gitlink).

However, if you want some way to mark reachable objects as not
reachable, such as for a sparse checkout, external large-object storage,
or similar, then you can use a single unified mechanism for that whether
working with gitrefs, trees, or blobs.
