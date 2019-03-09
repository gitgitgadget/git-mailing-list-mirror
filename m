Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F47A20248
	for <e@80x24.org>; Sat,  9 Mar 2019 18:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfCISNq (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 13:13:46 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:41306 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCISNq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 13:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rd8TisZsl16WB4orWZKJOcwOJ/QBr5kodznMcZNNkoM=; b=PV08mbq1eLEHZYcJR/Qa+FCff
        3m3j+vWJhLK9ZN9U1dg/Ua9Mi0MeFTnCrUwVCUrQqxEvs4Wggib5vOE+tsjsb0iuX/ie5RPMbpChm
        7DwKf3T1wAYBev68XX1AwVNBTal7PiiBYaZJiioS/COO+HxrrFrQOZFkGsnfLbBrHgwvf0PI9Q/13
        uAMH6fGPhhTll0bOM5mUaJs1/RU8SNqn7nPVb37Bv3f5OOYrFYibJOHVrUuxmLGADbrfKZLYh5Gbq
        k0YxG89XpYDGiri/FdM6Kv0kf9n0hNzNNqlTEkq8RaQo582WndHkWWWWOdXU1K+EDVDS+zk0H5UDP
        JrFa6wjNg==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:40156 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h2gTd-00GlnQ-TM; Sat, 09 Mar 2019 13:13:43 -0500
Date:   Sat, 9 Mar 2019 13:13:41 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Git Mailing list <git@vger.kernel.org>
Subject: Re: is it "git gc --prune=now" or "git gc --prune=all"?
In-Reply-To: <xmqqef7ksw2w.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.1903091309130.16641@localhost.localdomain>
References: <alpine.LFD.2.21.1903020323110.16672@localhost.localdomain> <20190305050326.GK19800@sigill.intra.peff.net> <xmqqef7ksw2w.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 6 Mar 2019, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> > ... I do think the documentation should recommend "now". Possibly
> > builtin/gc.c should be smarter about recognizing "all" in the
> > conditional you quoted, too, though I don't know that it's all
> > that important (especially if we tweak the documentation).
>
> Yup, as the placeholder for the value is labeled as "<date>", "now"
> would be the one we should be encouraging.

  i can submit an obviously trivial patch for that -- i can see in
date.c the equally valid alternatives:

    int parse_expiry_date(const char *date, timestamp_t *timestamp)
    {
        int errors = 0;

        if (!strcmp(date, "never") || !strcmp(date, "false"))
                *timestamp = 0;
        else if (!strcmp(date, "all") || !strcmp(date, "now"))
        ... snip ...

  is the preference to simply list both alternatives, or to
*encourage* the more intuitive "now" and "never" values while politely
deprecating the others? the impression i get is the latter.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

