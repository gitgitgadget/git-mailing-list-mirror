From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Wed, 6 Apr 2011 00:29:32 +0530
Message-ID: <20110405185929.GA25644@kytes>
References: <20110403172054.GA10220@kytes>
 <alpine.LNX.2.00.1104031407480.14365@iabervon.org>
 <20110404040610.GA30737@kytes>
 <20110404045437.GA2208@kytes>
 <alpine.LNX.2.00.1104041319570.14365@iabervon.org>
 <20110405175003.GA12159@kytes>
 <alpine.LNX.2.00.1104051354500.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Stephen Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 21:00:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7BUg-0002uF-Dn
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 21:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab1DETAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 15:00:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60133 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707Ab1DETAo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 15:00:44 -0400
Received: by iyb14 with SMTP id 14so666495iyb.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=z4SURTfWgiOZy8Oeom6ucbrnpBloTHZFctu6b2IHQ8E=;
        b=keSDdkGdZ4VMEau6QitcX0DVevUDnZwNdFs9bC5L3NBkfp/Zu65c257hd9e5XKblZL
         zfGsEuY2Z/W8yCJxFNhGOxYDBLOdIuGdF9Ti/b3DdmVTBpxLLX2o9wS2kMcE9Y4e1W78
         BFmOLpm0Mg6heO62U4zaOpIClU7tPPoYYEdig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PgQ/FYOHWP9VwUIPpLLdZ265RE7kL0an0sOfkTOQMsWN/c4NK6rvopsm5Fmz+LVhoC
         vwMNErZs4HhWs2wFnXo9RKjz7urHqDT8hD3/dPvUDFoHTHbZtLKwBV6gAzsrDV/AjeFr
         9Whln22bVts4NYSGLlSrQjwB8e8bu/Uz7p5NU=
Received: by 10.43.71.18 with SMTP id yi18mr86972icb.54.1302030043654;
        Tue, 05 Apr 2011 12:00:43 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id wo15sm4324977icb.16.2011.04.05.12.00.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 12:00:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1104051354500.14365@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170903>

Hi Daniel,

Daniel Barkalow writes:
> On Tue, 5 Apr 2011, Ramkumar Ramachandra wrote:
> > Excellent.  The crux of the idea: The sequencer should serve as the
> > entry/ exit point for Git when any operation requires user
> > intervention to proceed.
> 
> I'm a bit surprised by the idea of calling that "the sequencer" (rather 
> than having "the sequencer" be a command), but I actually think you're 
> entirely right to do so. Be sure to be very explicit about that, though, 
> because people will probably start with the wrong idea of what you're 
> proposing otherwise.

Ah.  I'll make sure to word it unambiguously in the proposal, and link
to this thread :)

> > For this, it should have information about
> > how we got to this point, and how to proceed after the user
> > intervention is complete; this information is contained in:
> > 
> > > cherry_pick_conflict = { 
> > >   "cherry-pick", APPLIES_TO_CURRENT_BRANCH | IN_MIDDLE_OF_COMMIT,
> > >   cherry_pick_verify_resolution,
> > >   cherry_pick_abort,
> > >   cherry_pick_post_resolution
> > > };
> > 
> > Wait -- isn't it missing a skip callback?
> 
> I think "skip" is actually: abort the lowest-level conflict and continue 
> the next-level conflict. If you're doing a rebase, and the rebase is doing 
> a "pick", and the pick got a conflict, --skip means that you abort the 
> pick (to get back to the state where the earlier commits have been picked 
> but this one hasn't been started, followed by having the rebase continue 
> with what it was going to do after the pick completed.
> 
> So I don't think you need a "skip" callback, as long as you've untangled 
> the levels cleanly and get the nesting support right.

Okay.  I'm not yet entirely clear about this yet, but I think it
should be sorted out during implementation.

> > cherry_pick_conflict = { 
> >   "cherry-pick", APPLIES_TO_CURRENT_BRANCH | IN_MIDDLE_OF_COMMIT,
> >   cherry_pick_verify_resolution,
> >   cherr_pick_skip,
> >   cherry_pick_abort,
> >   cherry_pick_post_resolution
> > };
> > 
> > This information is passed to report_conflict(), which takes care of
> > user intervention.  The user can do whatever she wants and then ask
> > the sequencer to "continue", "skip" or "abort":
> 
> Right, although I think:
> 
>   $ git cheery-pick some-sha1
>   Conflict needs to be fixed now!
> 
>   $ git skip
> 
> should give an error message about the current conflict not being a step 
> of a larger process. That is, you can always "continue" or "abort", but 
> you can only "skip" if there's something to skip to, even if it's only the 
> higher-order sequence reporting that it's completed successfully.

Right, got it.

-- Ram
