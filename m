Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2AEA1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 18:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfKRSph (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 13:45:37 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:45482 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfKRSpg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 13:45:36 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id A8DF53C04C0;
        Mon, 18 Nov 2019 19:45:32 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BFnAtTLBFLmF; Mon, 18 Nov 2019 19:45:26 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 3FD0E3C0022;
        Mon, 18 Nov 2019 19:45:26 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 18 Nov
 2019 19:45:25 +0100
Date:   Mon, 18 Nov 2019 19:45:23 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>, <git@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Signal conflict on merging metadata-differing patches
Message-ID: <20191118184523.GA6894@vmlxhi-102.adit-jv.com>
References: <20191118172917.GA6063@vmlxhi-102.adit-jv.com>
 <20191118173517.GA599094@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191118173517.GA599094@kroah.com>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 18, 2019 at 06:35:17PM +0100, Greg KH wrote:
> On Mon, Nov 18, 2019 at 06:29:17PM +0100, Eugeniu Rosca wrote:
> > Dear Git community,
> > 
> > Due to high inflow of patches which Linux maintainers carry on their
> > shoulders and due to occasionally intricate relationships between
> > consecutive revisions of the same series, it may [1] happen that two
> > distinct revisions of the same patch (differing only/mostly in
> > metadata, e.g. Author's time-stamp and commit description) may end up
> > being merged on the same branch, without git to complain about that.
> 
> Why would git complain about that?

This would help those performing the merge identify and (if needed)
avoid having several slightly different patches on the same branch.

> 
> > Is there any "git merge" flag available off-the-shelf which (if used)
> > would signal such situations?
> 
> I don't understand what you are looking for here.  Two different
> versions of the patch were merged to different branches and then merged
> together, and git did the right thing with the resolution of the code.

I personally care about commit metadata (i.e. Author's/Committer's names
and timestamps, as well as commit description) as much as (and sometimes
more than) the code contents of the patch.

If I am given multiple patches which perform the same code changes, but
provide different descriptions, this _already_ generates potential work
on my plate, since I have to make sense of those differences when I
stumble upon them. Which patch do I recommend to the customer (who,
let's say, still lives on the older v4.14 LTS), if I am asked to?

Why should I (or anybody else) spend time doing research at all, if this
can be avoided by just passing an additional option to "git merge"?

It is the most basic requirement I can think of that the maintainers
select the _latest_ version of a patch series, without intertwining it
with a superseded version.

> 
> What more can it do here?

Currently Git says nothing in below merge scenarios (all of them are
conflict-less successful merges):
 - Merge two commits which perform identical code changes but have
   different metadata
 - Merge commit "A" and commits ("B", "C", "D"), the latter being
   subsets of "A"

I don't advocate for "git merge" to fail in the above scenarios. No.
I just say that Git could likely detect such scenarios and help people
like you not pushing v2 and v5 of the same patch into the main tree.

> 
> thanks,
> 
> greg k-h

-- 
Best Regards,
Eugeniu
