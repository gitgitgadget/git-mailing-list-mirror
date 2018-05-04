Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB401F42E
	for <e@80x24.org>; Fri,  4 May 2018 10:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeEDK0m (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 06:26:42 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:16950 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeEDK0l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 06:26:41 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 May 2018 06:26:41 EDT
Received: from [93.212.106.122] (helo=book.hvoigt.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1fEXnk-0003kp-HL; Fri, 04 May 2018 12:18:56 +0200
Date:   Fri, 4 May 2018 12:18:54 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: git merge banch w/ different submodule revision
Message-ID: <20180504101854.GA29828@book.hvoigt.net>
References: <1524739599.20251.17.camel@klsmartin.com>
 <CAGZ79kZA_R-5bA6mPdoHkVW-C21pNn_0x6FayhuuXqnOTrmjWw@mail.gmail.com>
 <CA+P7+xrUwq0G2YySC3SLKqyihhPnFPCiQnQpoVVa89+=W9O9+w@mail.gmail.com>
 <CAGZ79kaub2k-q-Mcj3H5o6ekyZ8ZZzG7+r5sHt5Ne25Nc3_nPQ@mail.gmail.com>
 <20180430170229.GA775@book.hvoigt.net>
 <1525246025.2176.12.camel@klsmartin.com>
 <20180503164226.GB23564@book.hvoigt.net>
 <1525422571.2175.52.camel@klsmartin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525422571.2175.52.camel@klsmartin.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, May 04, 2018 at 08:29:32AM +0000, Middelschulte, Leif wrote:
> Am Donnerstag, den 03.05.2018, 18:42 +0200 schrieb Heiko Voigt:
> > I still do not understand how the current behaviour is mismatching with
> > users expectations. Let's assume that you directly tracked the files of
> > L in your product repository P, without any submodule boundary. How
> > would the behavior be different? Would it be? If D started on an older
> > revision and gets merged into a newer revision, there can always be
> > regressions even without submodules.
> > 
> > Why would the core developer need to be informed about mismatching
> > revisions if he himself advanced the submodule?
> In that case you'd be right. I should have picked my example more wisely.
> Assume right here that not a core developer, but another developer advanced
> the submodule (also via feature branch + merge).
> > 
> > It seems to me that you do not want to mix integration testing and
> > testing of the feature itself. 
> That's on point. That's why it would be nice if git *at least* warned
> about the different revisions wrt submodules.
> 
> But, I guess, I learned something about submodules:
> I used to think of submodules as means to pin down a specific revision like: `ver == x`.
> Now I'm learning that submodules are treated as `ver >= x` during a merge.

Well a submodule version is pinned down as long a you do not change it
and commit it. The same as files and the goal is to make submodules
behave as close to normal files as possible. And git "warns" about
changed submodules by displaying them in the diff.

Actually the use case you are describing is not even involving a real
merge for submodules. It is just changing the pointer to another
revision.

> > How about just testing/reviewing on the
> > branch then? You would still get the submodule revision D was working on
> > and then in a later stage check if integration with everything else
> > works.
> Sure. But if the behavior deviates after a merge the merging developer is currently not
> aware that it *might* have to do with different submodule revisions used, not the "actual" code merged.
> 
> Like not even "beware: the (feature) branch you've merged used an 'older' revision of X"

The submodule is part of the "actual" code and should be reviewed the
same. Maybe you want to set the diff.submodule option to 'diff' ? Then
git shows the actual diff of the changed contents in the submodule and
it would be more obvious how the code changed.

At the moment it seems to me that you want submodules to behave
differently than we handle normal files/directories which is the
opposite direction we have been trying to get git into. My feeling
though is that this should be covered by the review process instead of a
failing merge. Another option would be that you could write a hook that
warns reviewers that they are merging a submodule update.

Cheers Heiko
