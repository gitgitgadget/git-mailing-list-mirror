Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01CAD1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 18:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404741AbfJWS5n (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 14:57:43 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51157 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390366AbfJWS5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 14:57:42 -0400
X-Originating-IP: 1.186.12.46
Received: from localhost (unknown [1.186.12.46])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D729F1C0006;
        Wed, 23 Oct 2019 18:57:39 +0000 (UTC)
Date:   Thu, 24 Oct 2019 00:27:37 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 4/4] git-gui: allow undoing last revert
Message-ID: <20191023185737.cae6nxn72zsrt3yn@yadavpratyush.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190828215725.13376-1-me@yadavpratyush.com>
 <20190828215725.13376-5-me@yadavpratyush.com>
 <CAKPyHN0Kh8eKjzXink3YtE6wRrOgpzTYyPmLnbpbxPt3LFsvig@mail.gmail.com>
 <20191021190448.34vs3zsqvqc5hryl@yadavpratyush.com>
 <CAKPyHN2b1=2GefMDB987h5J4zXN7YWGsyLw7FADs+M5CgEUYow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPyHN2b1=2GefMDB987h5J4zXN7YWGsyLw7FADs+M5CgEUYow@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/10/19 10:17AM, Bert Wesarg wrote:
> On Mon, Oct 21, 2019 at 9:04 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> >
> > On 21/10/19 11:16AM, Bert Wesarg wrote:
> > > Dear Pratyush,
> > >
> > > I just noticed that the 'Revert Last Hunk' menu entry is enabled in
> > > the stage-list. But I think it should be disabled, like the 'Revert
> > > Hunk' and 'Revert Line' menu entry.
> >
> > I'm not sure what you mean. There is no "Revert Last Hunk" menu entry (I
> > assume you are talking about the context menu in the diff view that we
> > open by right clicking).
> >
> > My guess is that you mean the "Undo Last Revert" option. And you want it
> > disabled if the diff shown is of a staged file, correct?
> >
> > I'm not sure if disabling it would be a good idea.
> >
> > Say I revert a hunk or line while the file is not staged, and stage the
> > rest of the file. This would mean that file is no longer in the
> > "Unstaged Changes" widget. Now if I choose the file from the "Staged
> > Changes" widget, I get the option to undo the last revert. If I hit
> > that, it will put whatever I reverted in the "Unstaged Changes" widget.
> > So, now part of the file that was reverted is in "Unstaged Changes", and
> > the rest in "Unstaged Changes".
> >
> 
> Sorry for this confusion.
> 
> > IIUC, this is what you think should not happen, correct? What's wrong
> > with allowing the user to undo reverts from anywhere?
> 
> The 'Undo' changes the worktree not the staged content,.
> 
> >
> > The way I see it, it doesn't really matter what file is selected or
> > whether it is staged or not, the action of the undo remains the same, so
> > it makes sense to me to allow it from anywhere.
> 
> It would make sense to undo the revert on the staged content, if there
> are no more changes to this file in the worktree. I.e., you wont be
> able to apply the 'undo' anymore to the worktree file if it is not
> listed anymore. Though even that case should be able to implement.
> Though the undo is currently not bound to a specific path. This may be

I did it this way because I thought it would be best to go for the 
simplest implementation first, and then re-evaluate if needed. And 
nobody objected in the reviews. Maybe I didn't do a good job of 
clarifying the exact behaviour in the commit message.

I'm not opposed to something like a per-path undo though. But I'm not 
sure if that will cause any confusion as to what is being undone. Or 
maybe the current version is more confusing. I can't really say since I 
am the one who implemented it, so I know exactly what it does.

> the cause of our different view. I though the undo is bound to the
> path it was recorded, thus also would only be available when showing a
> diff on this path again. Therefore I think, having the 'Undo Last
> Revert' in the context menu may not be the best place to begin with,
> or at least indicate that this 'undo' operation does not necceseritly
> operate on the file currently shown.

Where else would you put it if not the context menu? There is the option 
of putting it in the menu bar at the top under the "Edit" menu entry, 
but I think that is too hidden. The original idea of the feature was 
that you could quickly undo an accidental revert. Hiding this in the 
menu bar would hurt discoverability, and some people might not realize 
they could have undone the revert.

Is there a better place to put it that I'm missing?

-- 
Regards,
Pratyush Yadav
