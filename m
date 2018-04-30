Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48964215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 17:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeD3ReQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 13:34:16 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:38894 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753181AbeD3ReP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 13:34:15 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Apr 2018 13:34:15 EDT
Received: from [93.212.104.183] (helo=book.hvoigt.net)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1fDCC3-0008EF-19; Mon, 30 Apr 2018 19:02:27 +0200
Date:   Mon, 30 Apr 2018 19:02:29 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git merge banch w/ different submodule revision
Message-ID: <20180430170229.GA775@book.hvoigt.net>
References: <1524739599.20251.17.camel@klsmartin.com>
 <CAGZ79kZA_R-5bA6mPdoHkVW-C21pNn_0x6FayhuuXqnOTrmjWw@mail.gmail.com>
 <CA+P7+xrUwq0G2YySC3SLKqyihhPnFPCiQnQpoVVa89+=W9O9+w@mail.gmail.com>
 <CAGZ79kaub2k-q-Mcj3H5o6ekyZ8ZZzG7+r5sHt5Ne25Nc3_nPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaub2k-q-Mcj3H5o6ekyZ8ZZzG7+r5sHt5Ne25Nc3_nPQ@mail.gmail.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 03:19:36PM -0700, Stefan Beller wrote:
> Stefan wrote:
> > See https://github.com/git/git/commit/68d03e4a6e448aa557f52adef92595ac4d6cd4bd
> > (68d03e4a6e (Implement automatic fast-forward merge for submodules, 2010-07-07)
> > to explain the situation you encounter. (specifically merge_submodule
> > at the end of the diff)
> 
> +cc Heiko, author of that commit.

In that commit we tried to be very careful about. I do not understand
the situation in which the current strategy would be wrong by default.

We only merge if the following applies:

 * The changes in the superproject on both sides point forward in the
   submodule.

 * One side is contained in the other. Contained from the submodule
   perspective. Sides from the superproject merge perspective.

So in case of the mentioned rewind of a submodule: Only one side of the
3-way merge would point forward and the merge would fail.

I can imagine, that in case of a temporary revert of a commit in the
submodule that you would not want that merged into some other branch.
But that would be the same without submodules. If you merge a temporary
revert from another branch you will not get any conflict.

So maybe someone can explain the use case in which one would get the
results that seem wrong?

Cheers Heiko
