Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AB7C1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 18:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfIZSoz (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 14:44:55 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34115 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbfIZSoy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 14:44:54 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 67CBA20008;
        Thu, 26 Sep 2019 18:44:52 +0000 (UTC)
Date:   Fri, 27 Sep 2019 00:14:49 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] git gui: fix staging a second line to a 1-line file
Message-ID: <20190926184449.swkqutltmwpzde6s@yadavpratyush.com>
References: <pull.359.git.gitgitgadget@gmail.com>
 <02ec6c5bde2f15c51e946c6806d8231fb5abffe5.1569519804.git.gitgitgadget@gmail.com>
 <CAKPyHN1XJHtcdzhaaeACFfb9=7PxdyHvrdafwJxDwQjbW_hbcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN1XJHtcdzhaaeACFfb9=7PxdyHvrdafwJxDwQjbW_hbcA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/19 08:25PM, Bert Wesarg wrote:
> On Thu, Sep 26, 2019 at 7:43 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When a 1-line file is augmented by a second line, and the user tries to
> > stage that single line via the "Stage Line" context menu item, we do not
> > want to see "apply: corrupt patch at line 5".
> >
> > The reason for this error was that the hunk header looks like this:
> >
> >         @@ -1 +1,2 @@
> >
> > but the existing code expects the original range always to contain a
> > comma. This problem is easily fixed by cutting the string "1 +1,2"
> > (that Git GUI formerly mistook for the starting line) at the space.
> >
> > This fixes https://github.com/git-for-windows/git/issues/515
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  lib/diff.tcl | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/diff.tcl b/lib/diff.tcl
> > index 4cae10a4c7..68c4a6c736 100644
> > --- a/lib/diff.tcl
> > +++ b/lib/diff.tcl
> > @@ -698,6 +698,7 @@ proc apply_range_or_line {x y} {
> >                 set hh [$ui_diff get $i_l "$i_l + 1 lines"]
> >                 set hh [lindex [split $hh ,] 0]
> >                 set hln [lindex [split $hh -] 1]
> > +               set hln [lindex [split $hln " "] 0]
> 
> this is already in that master

Yes, this was recently merged in when I was pulling in some stuff that 
went directly into git.git's git-gui subtree, instead of making it into 
git-gui first (thread at [0] in case someone wants to find out more). 
This commit was one of those. Junio directly merged this commit into 
git/git-gui, along with some other stuff from Johannes in the commit 
02a5f25d95 (Merge branch 'js/misc-git-gui-stuff' of ../git-gui) of 
git.git.

[0] https://public-inbox.org/git/CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com/

-- 
Regards,
Pratyush Yadav
