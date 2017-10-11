Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77341FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 14:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbdJKO5D (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 10:57:03 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.95]:15341 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdJKO5D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 10:57:03 -0400
Received: from [84.188.151.28] (helo=book.hvoigt.net)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e2IRO-0008WE-VI; Wed, 11 Oct 2017 16:56:59 +0200
Date:   Wed, 11 Oct 2017 16:56:57 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC PATCH 2/4] change submodule push test to use proper
 repository setup
Message-ID: <20171011145657.GB85076@book.hvoigt.net>
References: <20171006222544.GA26642@sandbox>
 <20171006223234.GC26642@sandbox>
 <CAGZ79kZqaC-hFAa3dc7_j8Ah94Ua0+sAjcDUYBL0N-C_J4Bx4A@mail.gmail.com>
 <20171010130335.GB75189@book.hvoigt.net>
 <CAGZ79kZFtMxD8wf59SViOOc_mrhwTVr6v0ucAePp+-8hg_im-Q@mail.gmail.com>
 <xmqq7ew2pokm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7ew2pokm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2017 at 08:31:37AM +0900, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> > So you propose to make git-add behave like "git submodule add"
> > (i.e. also add the .gitmodules entry for name/path/URL), which I
> > like from a submodule perspective.
> >
> > However other users of gitlinks might be confused[1], which is why
> > I refrained from "making every gitlink into a submodule". Specifically
> > the more powerful a submodule operation is (the more fluff adds),
> > the harder it should be for people to mis-use it.
> 
> A few questions that come to mind are:
> 
>  - Does "git add sub/" have enough information to populate
>    .gitmodules?  If we have reasonable "default" values for
>    .gitmodules entries (e.g. missing URL means we won't fetch when
>    asked to go recursively fetch), perhaps we can leave everything
>    other than "submodule.$name.path" undefined.

My suggestion would be: If we do not have them we do not populate them.
We could even go further and say: If we do not have the set "git
submodule add" would populate then we do not add anything to .gitmodules
and warn the user.

>  - Can't we help those who have gitlinks without .gitmodules entries
>    exactly the same way as above, i.e. when we see a gitlink and try
>    to treat it as a submodule, we'd first try to look it up from
>    .gitmodules (by going from path to name and then to
>    submodule.$name.$var); the above "'git add sub/' would add an
>    entry for .gitmodules" wish is based on the assumption that there
>    are reasonable "default" values for each of these $var--so by
>    basing on the same assumption, we can "pretend" as if these
>    submodule.$name.$var were in .gitmodules file when we see
>    gitlinks without .gitmodules entries.  IOW, if "git add sub/" can
>    add .gitmodules to help people without having to type "git
>    submodule add sub/", then we can give exactly the same degree of
>    help without even modifying .gitmodules when "git add sub/" is
>    run.

This "default" value thing got me thinking in a different direction. We
could use a scheme like that to get names (and values) for submodules
that are missing from the .gitmodules file. If we decide that we need to
handle them.

Cheers Heiko
