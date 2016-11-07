Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C5F22022A
	for <e@80x24.org>; Mon,  7 Nov 2016 16:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932428AbcKGQMI (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 11:12:08 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53418 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbcKGQMI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 11:12:08 -0500
Received: from mfilter35-d.gandi.net (mfilter35-d.gandi.net [217.70.178.166])
        by relay5-d.mail.gandi.net (Postfix) with ESMTP id 76AD941C0A9;
        Mon,  7 Nov 2016 17:12:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter35-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
        by mfilter35-d.gandi.net (mfilter35-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id SorLep1gkkso; Mon,  7 Nov 2016 17:12:05 +0100 (CET)
X-Originating-IP: 50.39.170.172
Received: from x (50-39-170-172.bvtn.or.frontiernet.net [50.39.170.172])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6512C41C0C2;
        Mon,  7 Nov 2016 17:12:00 +0100 (CET)
Date:   Mon, 7 Nov 2016 08:11:59 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Mike Hommey <mh@glandium.org>
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161107161158.7db3f3gthdlfuhyw@x>
References: <20161105151836.wztypzrdywyltvrc@x>
 <CAP8UFD3XFHr7POKmZr_6guapC6sme3GvWBV5vPw4XO7FE5HOPw@mail.gmail.com>
 <20161105202553.migx75gfuujakqyk@x>
 <CA+P7+xoG3ag8dj7s_NRoqz-EwjVENSJSzE_qj6gnW-SmWt0bgA@mail.gmail.com>
 <20161106163410.ilysej5r6qd3744e@x>
 <xmqqshr4cyy7.fsf@gitster.mtv.corp.google.com>
 <20161106173311.lqoxxgcklx4jlrg7@x>
 <CA+P7+xoxjwvjXrW0Pwh7ZK-OYBiYamPAxvf_=zqJOsQ8xWDPWw@mail.gmail.com>
 <20161107011841.vy2qfnbefidd2sjf@x>
 <CACsJy8BDySBWyp3iiLinRkBCew5FNXoQo7z9dMb6w6m9a5X=NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BDySBWyp3iiLinRkBCew5FNXoQo7z9dMb6w6m9a5X=NA@mail.gmail.com>
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2016 at 04:42:04PM +0700, Duy Nguyen wrote:
> On Mon, Nov 7, 2016 at 8:18 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> > Once we have gitrefs, you have both alternatives: reachable (gitref) or
> > not reachable (gitlink).
> >
> > However, if you want some way to mark reachable objects as not
> > reachable, such as for a sparse checkout, external large-object storage,
> > or similar, then you can use a single unified mechanism for that whether
> > working with gitrefs, trees, or blobs.
> 
> How? Whether an object reachable or not is baked in the definition (of
> either gitlink or gitref). I don't think you can have a "maybe
> reachable" type then rely on an external source to determine
> reachability,

You'd have various "reachable by default" entries in trees, including
trees, blobs, and gitrefs, and then have an external mechanism (likely
via .git/config) to say "ignore objects with these hashes/paths".  For
instance, you might say "ignore all objects only reachable from the path
'assets/video/*' within a commit's tree".  With the right set of client
and server extensions, you could then avoid downloading those objects.
