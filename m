Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D04208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 17:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbdHRRZM (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 13:25:12 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.109]:63145 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbdHRRZL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 13:25:11 -0400
Received: from [89.15.237.222] (helo=book.hvoigt.net)
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dijme-0007hs-Ct; Fri, 18 Aug 2017 18:06:04 +0200
Date:   Fri, 18 Aug 2017 18:06:03 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] add test for bug in git-mv with nested submodules
Message-ID: <20170818160603.GA69414@book.hvoigt.net>
References: <20170817103413.GA52233@book.hvoigt.net>
 <CAGZ79kZhUO95oSEzARqXi3+dm5Ow5Jwm-O1adowh0nkbqHdhMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZhUO95oSEzARqXi3+dm5Ow5Jwm-O1adowh0nkbqHdhMw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 12:05:56PM -0700, Stefan Beller wrote:
> On Thu, Aug 17, 2017 at 3:34 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > When using git-mv with a submodule it will detect that and update the
> > paths for its configurations (.gitmodules, worktree and gitfile). This
> > does not work for nested submodules where a user renames the root
> > submodule.
> >
> > We discovered this fact when working on on-demand fetch for renamed
> > submodules. Lets add a test to document.
> >
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > ---
> >  t/t7001-mv.sh | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> > index e365d1f..39f8aed 100755
> > --- a/t/t7001-mv.sh
> > +++ b/t/t7001-mv.sh
> > @@ -491,4 +491,13 @@ test_expect_success 'moving a submodule in nested directories' '
> >         test_cmp actual expect
> >  '
> >
> > +test_expect_failure 'moving nested submodules' '
> > +       git commit -am "cleanup commit" &&
> > +       git submodule add ./. sub_nested &&
> 
> If possible, I would avoid adding the repo itself
> as a submodule as it is unrealistic in the wild.
> 
> While it may be ok for the test here, later down the road
> other tests making use of it it may become an issue with
> the URL of the submodule.

I just copied the shortcut that they were adding themselfes as submodule
in 'setup submodule'. The whole setup of submodules in this test is like
this. This way we already had a nested submodule structure which I could
just add.

I agree that this is unrealistic so I can change that in the test I am
adding. But from what I have seen, this shortcut is taken in quite some
places when dealing with submodules.

Cheers Heiko
