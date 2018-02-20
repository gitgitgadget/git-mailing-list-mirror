Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86BCE1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbeBTWFq (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:05:46 -0500
Received: from titan.plasma.xg8.de ([85.10.203.189]:37556 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeBTWFp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:05:45 -0500
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w1KM5f4E001392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Feb 2018 23:05:41 +0100
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w1KM5fvp001391;
        Tue, 20 Feb 2018 23:05:41 +0100
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w1KM5Q1c025370;
        Tue, 20 Feb 2018 23:05:26 +0100
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w1KM5P7u025368;
        Tue, 20 Feb 2018 23:05:25 +0100
Date:   Tue, 20 Feb 2018 23:05:25 +0100
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180220220525.GA25134@helen.PLASMA.Xg8.DE>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <20180220211634.GA15232@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220211634.GA15232@sigill.intra.peff.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Tue, Feb 20, 2018 at 04:16:34PM -0500, Jeff King wrote:
> I think there are some references buried somewhere in that wiki, but did
> you look at any of the third-party tools that store file metadata
> alongside the files in the repository? E.g.:
> 
>   https://etckeeper.branchable.com/
> 
> or
> 
>   https://github.com/przemoc/metastore
> 
> I didn't see either of those mentioned in this thread (though I also do
> not have personal experience with them, either).
> 
> Modification times are a subset of the total metadata you might care
> about, so they are solving a much more general problem. Which may also
> partially answer your question about why this isn't built into git. The
> general problem gets much bigger when you start wanting to carry things
> like modes (which git doesn't actually track; we really only care about
> the executable bit) or extended attributes (acls, etc).

I know about those, but that's not what I am looking for. Those tools 
serve entirely different purposes, ie., tracking file system changes. 
I, however, am specifically interested in version control.

In version control, the user checks out his own copy of the tree for 
working. For this purpose, it is thus pointless to track ownership, 
permissions (except for the x bit), xattrs, or any other metadata. In 
fact, it can be considered the wrong thing to do.

The modification time, however, is special. It clearly has its place in 
version control. It tells us when the last modification was actually 
done to the file. I am often working on some feature, and one part is 
finished and is lying around, but I am still working on other parts in 
other files. Then, maybe after some weeks, the other parts are 
finished. Now, when committing, the information about modification time 
is lost. Maybe some weeks later I want to figure out when I last 
modified those files that were committed. But that information is now 
gone, at least in the git repository. Sure, I could do lots of WIP 
commits, but this would clutter up the history unneccessarly and I 
would have lots of versions that might not even compile, let alone run.

As far as I remember, bitkeeper had this distinction between checkins 
and commits. You could check in a file at any time, and any number of 
times, and then group all those checkins together with a commit. Git 
seems to have avoided this principle, or have kept it only 
rudimentarily via git add (but git add cannot add more than one version 
of the same file). Perhaps for simplificiation of use, perhaps for 
simplification of implementation, I don't know.

I assume, if it were not for the build tool issues, git would have 
tracked mtime from the very start.

Best wishes
Peter
-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
