From: "Brian Foster" <brian.foster@innova-card.com>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Thu, 17 Apr 2008 16:53:14 +0200
Message-ID: <a537dd660804170753i4dcfd189m45a9581294ce5091@mail.gmail.com>
References: <200804161626.44174.brian.foster@innova-card.com>
	 <a537dd660804160804t252d2900j33e30a01dc58979c@mail.gmail.com>
	 <480619AE.8010506@viscovery.net>
	 <200804171643.15504.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 17:09:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmVV1-0005EK-F8
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 16:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758515AbYDQOxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 10:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757793AbYDQOxT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 10:53:19 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:55819 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757479AbYDQOxS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 10:53:18 -0400
Received: by py-out-1112.google.com with SMTP id u52so154344pyb.10
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=1Cq7ZWJnoX1WO6l+hST8ftIzkdK+oe2RKTKfkNKTiug=;
        b=nJyLNSzTo/1oMbsfmRavM5C31hmRC5/tYMQAbdF49pke83QImKSegqRQNSOvVpBfCVEy3330Uxt8q7b+pjw9c4hf88eV5vdVd3Ic9yfbzuGi/UgOOVMQsWqUniv6R7PlDW1tde5KEBAxZ/EpfDzrdS0VHbq8s6gO9w7lcWEP4+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=izL6LIg2ifxmzogLbXEBSwTdLU9zyiP6c5S3KIq2SE97TTATL/0hPizMWpw+8HC98uKDnPCQGZJSx7AzuzGBHM1AHvRs/ONywSyMwmJfiopqYKVaYqoCUxBXCKMPW+12GblWUaYBS7ct78cFAQN1E81r8c5zsOzjPs7l/lV4PvQ=
Received: by 10.141.20.7 with SMTP id x7mr811622rvi.34.1208443995228;
        Thu, 17 Apr 2008 07:53:15 -0700 (PDT)
Received: by 10.141.123.21 with HTTP; Thu, 17 Apr 2008 07:53:14 -0700 (PDT)
In-Reply-To: <200804171643.15504.brian.foster@innova-card.com>
Content-Disposition: inline
X-Google-Sender-Auth: 1986d80e14fd34b1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79793>

Hannes suggested:
> Brian Foster schrieb:
> >[ ... ] is there some way of adding [ the missing commits,
> >  all of which seem to be from linux-mips, ] back to the bare
> >  repository (if that even makes sense?), or whatever?  (i.e.,
> >  [ they ] have not been lost, [ so ] is it possible to take
> >  advantage of that fact?)   [ ... ]
>
> In this case you might be able to salvage missing objects by cloning
> linux-mips. Just copy the objects/pack/* from that clone into your
> objects/pack, remove info/grafts, and maybe things "just work"?

Hannes et al.,

 thanks for the suggestion.  bingo!  that basically worked.
 after copying linux-mips  objects/pack/*  into my goofy
 bare repository,  `fsck --full'  (after moving  grafts
 out of the way) found different issues.  it complained
 about a zillion dangling tags (yawn), plus a handful of
 dangling commits.

 the dangling tags were the linux-mips  refs/tags/*.  copying
 them into my repository's  ref/tags  fixed that.  (there were
 no name collisions with the existing tags, so this was easy.)

 the dangling commits were linux-mips  refs/remotes/origin/*,
 and again could be safely/easily copied into my repository.

 `fsck --full' is now 100% happy.  (yea!)

 the obvious missing thing (which I _think_ is easy to fix?)
 is the remote URL &tc is not in my now-not-so-goofy bare
 repository.  hence `branch -r' shows  origin/*  branches,
 but (I speculate) a `pull' (e.g.) will be confused.

 at this point in time I've not done any extensive testing
 of the seemingly-fixed repository, but things are looking
 much better.

 before trying the copying suggestion, I played some
 more with `filter-branch'.  I had no success at all.
 as one example, with `--branches' instead of `--all'
 (one of Brandon's suggestions) produced:

	$ git filter-branch --tag-name-filter cat -- --branches
	Which ref do you want to rewrite?
	$

 also, Dmitry's suggestion of cloning (with grafts still
 in-place) after `filter-branch ... --all' accomplished
 nothing obvious:  `fsck --full' of the new clone was
 still unhappy (same set of complaints).

 whilst I'm still trying to understand the rationale for
 why things were set-up(? left-in?) this weird state,
 browsing the history gives some vague hints.  however,
 the intended usage model remains opaque.

 and that will soon be my next problem:  what's a better
 (best?) usage model (for this project)?  I need to do
 some more reading here ....  ;-\

cheers!
        -blf-

-- 
"How many surrealists does it take to    |  Brian Foster
 change a lightbulb?  Three.  One calms  |  somewhere in south of France
 the warthog, and two fill the bathtub   |     Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools."  |       http://www.stopesso.com
