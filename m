From: John Keeping <john@keeping.me.uk>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 22:55:57 +0100
Message-ID: <20130523215557.GX27005@serenity.lan>
References: <20130522115042.GA20649@inner.h.apk.li>
 <7v4ndukhx0.fsf@alter.siamese.dyndns.org>
 <20130523090657.GB23933@inner.h.apk.li>
 <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
 <20130523102959.GP9448@inner.h.apk.li>
 <20130523110839.GT27005@serenity.lan>
 <7vd2shheic.fsf@alter.siamese.dyndns.org>
 <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 23:56:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfdUa-0002w4-GF
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759697Ab3EWV4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:56:08 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:39118 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759689Ab3EWV4H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:56:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 1705BCDA61F;
	Thu, 23 May 2013 22:56:06 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eM40kDJuKyhY; Thu, 23 May 2013 22:56:05 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id E1214CDA5BE;
	Thu, 23 May 2013 22:55:59 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225305>

On Thu, May 23, 2013 at 02:01:39PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > I have to wonder how often "git pull" with no arguments actually does
> > what users really want (even if they don't know it!) when it doesn't
> > result in a fast-forward (and pull.rebase isn't configured).
> 
> If you are in a totally centralized shared repository mindset
> without using topic branch workflow, --first-parent would not help
> you.  In your history the second parent is more likely to be the
> mainline.
> 
> So for them "git pull" that either fast-forward when it can, or
> makes a merge that records the then-current state of the central
> shared repository, is perfectly sensible.  They will view gitk and
> see all the changes, "git shortlog" and "git log --no-merges" will
> give them what they expect.

Yes, but for people used to a cleaner history it's confusing to see the
mainline branch and one small change the wrong way round.  When I see
people doing this, it's normally something like:

    ... do some work for several hours...
    git commit -a
    git push
    # fails because it's not a fast forward
    git pull
    git push

In this scenario, just adding --rebase to "git pull" actually results in
a much more sensible history.

> > Hence my suggestion to error when "git pull" doesn't result in a
> > fast-forward and no branch name is specified.  We could give some advice
> > like:
> >
> >     Your local changes are not included in the local branch and you
> >     haven't told Git how to preserve them.
> >
> >     If you want to rebase your changes onto the modified upstream
> >     branch, run:
> >
> >         git pull --rebase
> 
> I can parse the first paragraph above, but cannot make much sense
> out of it.  Unless you are talking about local changes that are not
> committed yet, that is.  But in that case I fail to see what it has
> to do with the current discussion, or suggestion to use rebase.

This isn't about "swap parents", it's about helping people realise that
just "git pull" isn't necessarily the best thing for them to do, and
that they may want --rebase.

So I was asking if it would be sensible (possibly in Git 2.0) to make
git-pull pass --ff-only to git-merge by default.
