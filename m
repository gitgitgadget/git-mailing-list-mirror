From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 11:03:52 +0100
Message-ID: <20130908100351.GI2582@serenity.lan>
References: <20130904081047.GB2582@serenity.lan>
 <20130904092527.GB22348@sigill.intra.peff.net>
 <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
 <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908044329.GA15087@sigill.intra.peff.net>
 <CAMP44s3kow9dooPzK6iD8p2LAgt1mtFuaNsVhkJHrqe4D+8xLQ@mail.gmail.com>
 <20130908052107.GA15610@sigill.intra.peff.net>
 <CAMP44s3U2rJsqTj4cAOpY1ntum53bEy2cP5XRNaMu5vwnYVoww@mail.gmail.com>
 <20130908065420.GI14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 12:04:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIbqk-0002wp-GM
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 12:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab3IHKEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 06:04:05 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:54618 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab3IHKEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 06:04:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id EBD7E19800C;
	Sun,  8 Sep 2013 11:04:02 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IacFnvMkYKnj; Sun,  8 Sep 2013 11:04:01 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 49C36198065;
	Sun,  8 Sep 2013 11:03:53 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130908065420.GI14019@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234233>

On Sun, Sep 08, 2013 at 02:54:20AM -0400, Jeff King wrote:
> I am genuinely curious what people in favor of this feature would want
> to say in the documentation to a user encountering this choice for the
> first time. In my experience, rebasing introduces more complications,
> specifically:
> 
>   1. the merge is "backwards" with respect to ours/theirs
> 
>   2. you may end up with difficult conflict resolution due to repeated
>      changes over the same section of code. E.g., you write some buggy
>      code and then fix it, but upstream has changed the same area.
>      Rebasing involves first resolving your buggy version with the
>      upstream code, and then resolving the fix on top of the previous
>      resolution.
> 
>   3. rewriting of commits found in other branches, which then need
>      rebased on top of the branch you just rebased
> 
>   4. a previously bug-free commit can show a bug after the rebase if
>      other parts of the project changed (whereas with a merge, the bug
>      would be attributable to the merge)
> 
> I know those are all balanced by some advantages of rebasing, but I also
> think they are things that can be troublesome for a user who does not
> fully grok the rebase process. I'm just wondering if we should mention
> both, but steer people towards merging as the safer alternative (you
> might have ugly history, but you are less likely to create a mess with
> duplicate commits or badly-resolved conflicts).

The really correct thing to do here is to encourage a feature branch
workflow, but in my experience people are happier to walk through a
rebase than to switch over to feature branches completely.

An alternative pull mode would be:

    git reset --keep @{u} &&
    git merge @{-1}

which gets a sensible history shape without any of your disadvantages
above.  But that didn't go anywhere last time it came up [1] [2].

[1] http://article.gmane.org/gmane.comp.version-control.git/210246
[2] http://article.gmane.org/gmane.comp.version-control.git/210625

> > Fortunately there probably are very few of these users.
> 
> Maybe. I am not sure how one would measure.
> 
> If you are interested, I can ask the opinion of some of the GitHub
> trainers. They see a lot of new users and have a sense of what kinds of
> confusion come up most frequently, what kinds of workflows they tend to
> see, etc. Their experience may be biased towards corporate-ish users,
> though, because those are the people who pay for training.

I expect corporate environments are the ones in which this is relevant.
Open source projects that care about the shape of history can have one
person able to write to the central repository who can enforce the
policy they want.  This tends to be more difficult in a corporate
environment, particularly one that was previously using a centralised
VCS.
