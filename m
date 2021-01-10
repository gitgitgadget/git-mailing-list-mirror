Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD13BC433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 12:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD2D224D2
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 12:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbhAJM3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 07:29:22 -0500
Received: from colin.muc.de ([193.149.48.1]:10880 "HELO mail.muc.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
        id S1726250AbhAJM3W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 07:29:22 -0500
Received: (qmail 74720 invoked by uid 3782); 10 Jan 2021 12:28:41 -0000
Received: from acm.muc.de (p4fe15e6c.dip0.t-ipconnect.de [79.225.94.108]) by
        colin.muc.de (tmda-ofmipd) with ESMTP;
        Sun, 10 Jan 2021 13:28:40 +0100
Received: (qmail 7383 invoked by uid 1000); 10 Jan 2021 12:28:40 -0000
Date:   Sun, 10 Jan 2021 12:28:40 +0000
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: add description of status output table
Message-ID: <X/ry+ApdWMFs5l/+@ACM>
References: <X/oAhdZlLwcFRCrR@ACM>
        <20210109220614.759779-1-sandals@crustytoothpaste.net>
        <xmqqim85d0vw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqim85d0vw.fsf@gitster.c.googlers.com>
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
From:   Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Junio and Brian.

Thanks for such rapid and helpful responses to my post.

On Sat, Jan 09, 2021 at 17:41:23 -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:

> > The table describing the porcelain format in git-status(1) is helpful,
> > but it's not completely clear what the three sections mean, even to
> > some contributors.  As a result, users are unable to find how to detect
> > common cases like merge conflicts programmatically.

> I agree that the addition clarifies, but it is a bit sad that we
> already have a beginning of the explanation; I wonder if we should
> improve the existing description in addition, even if it may not be
> sufficient to eliminate the need for this new paragraph.  Here is
> what we already have:

>     For paths with merge conflicts, `X` and `Y` show the modification
>     states of each side of the merge. For paths that do not have merge
>     conflicts, `X` shows the status of the index, and `Y` shows the status
>     of the work tree.  For untracked paths, `XY` are `??`.  Other status
>     codes can be interpreted as follows:

Another problem I tripped over was that word "Other", which is
ambiguous.  For quite some time I read it wrongly as meaning "Other than
the codes already described in this paragraph" rather than its intended
meaning "Other than for untracked paths".  So I was searching through
the man page looking for a description of codes for conflicts.

> This introductory text does sort-of hint that there are three
> classes (merged paths, unmerged paths and untracked paths), but (1)
> the order the three classes are described do not match that of the
> table, and (2) the explanation of the untracked paths predates the
> addition of ignored ones to the untracked class, so the description
> is added after the legends as if an afterthought.

When you amend this documentation, would you please consider using the
term "conflicts" instead of, or as well as "unmerged".  "Conflicts" is
something definite and clear - "unmerged" feels a bit vague and
indefinite, to me at any rate.  Why might a file be "unmerged" still?

> I am actually tempted to suggest rewriting the whole section,
> starting from the paragraph above and ending at the table, with
> something like this:

>     Three different classes of paths are shown in the same format,
>     but the meaning of `XY` are different:

>     * For merged paths, `X` shows the status of the index, and `Y`
>       shows the status of the working tree.

>     * For unmerged paths, `X` and `Y` show the modification states
>       of each side of the merge, relative to the common ancestor.

Also missing from the current doc, I think, is a description of which
"side" of the difference is represented by X, and which by Y.  In my use
case (having conflicts after doing a git stash pop) those "sides" would
be the work tree and the repository.  In other scenarios (say a merge
conflict after git pull) I think they would be something else (though my
head is hurting a bit, here).

>     * For untracked paths, `X` and `Y` do not convey different
>       meaning (as, by definition, they are not known to the index);
>       `??` is shown for untracked paths, and when `--ignored` option
>       is in effect, ignored paths are shown with `!!`.

>     In the following table, these three classes are shown in
>     separate sections, and these characters are used for `X` and `Y`
>     fields for the first two sections that show tracked paths:

>     * ' ' = unmodified
>     * 'M' = modified

>        ...

>     ....
>     X        Y       Meaning
>     ------------------------------------------------------------
>             [AMD]    not updated

>        ...

> Hmm?

I would appreciate such a new formulation.  Thanks!

-- 
Alan Mackenzie (Nuremberg, Germany).
