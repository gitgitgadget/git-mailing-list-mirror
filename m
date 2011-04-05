From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Tue, 5 Apr 2011 23:20:08 +0530
Message-ID: <20110405175003.GA12159@kytes>
References: <20110403172054.GA10220@kytes>
 <alpine.LNX.2.00.1104031407480.14365@iabervon.org>
 <20110404040610.GA30737@kytes>
 <20110404045437.GA2208@kytes>
 <alpine.LNX.2.00.1104041319570.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Stephen Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 19:51:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7APN-0008Nq-C0
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 19:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab1DERvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 13:51:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49596 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab1DERvK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 13:51:10 -0400
Received: by iwn34 with SMTP id 34so608194iwn.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MLI8QyYB0A7gZLvU/Y3SIrJ+m+H+O5ClpJuGBDbUQJw=;
        b=kcoOVjNxrCKgwettSOJyOrLKRMehT3qaxGSL2HHaJKgd+zD2S9QwXG8qNQ4/8/jBIE
         LTQpwdqRr0idAB1sgSPEP8hNxaax2JRenX3aiKmWj4PCoItI5kT/WGZqOtU9ptv5jrcp
         P7g/ySf4RT8+gENWJ9CzSZuTm/j5kRtHMOPzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cjixkBDscv3qp3FUkKXS41Zu17xE4tzGyHT4WQmZfjJGdPUoZwDkAbtRd0Ue6KHFzo
         I1qIHRS2JG2Xfi+MJ8M1BUkFDs9cTOiRr5CGl7JBXo+BYg11KhtHH1xyyJdDeJjNR7LD
         jyk8SNzQhOtHy/umqqUyG2h1StIKgVnvbMRLY=
Received: by 10.43.53.200 with SMTP id vr8mr7721472icb.43.1302025869590;
        Tue, 05 Apr 2011 10:51:09 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id i20sm4602871iby.14.2011.04.05.10.51.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 10:51:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1104041319570.14365@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170896>

Hi Daniel,

Daniel Barkalow writes:
> On Mon, 4 Apr 2011, Ramkumar Ramachandra wrote:
> > Ramkumar Ramachandra writes:
> > > Daniel Barkalow writes:
> > > > I actually think that it would be a worthwhile feature for git's library 
> > > > code to have a uniform mechanism for communicating that it is requesting 
> > > > human intervention in the middle of a particular operation, where library 
> > > > operations which conflict with being able to continue this operation are 
> > > > either blocked or abort the operation, and the library is able to be told 
> > > > in general that the human intervention is done and the library operation 
> > > > should be finished now (or produce complaints about the user's work). That 
> > > > is, a library-level, single-interrupted-step "sequencer". For that matter, 
> > > > it should also apply to the common '"git merge" gets a conflict' case, and 
> > > > it would be useful to get some representational uniformity between that 
> > > > and cherry-pick getting a conflict.
> > 
> > [...]

Thanks for the detailed response- I've rearragned your response and
added some comments.  I initially wanted to design it so that all
state is persisted by the sequencer, but I can clearly see what's
wrong with that approach now.

> I think, ultimately, that with this code structure in place, the 
> am/rebase/rebase--interactive/sequencer details of how the multi-step 
> process is recorded becomes less important. That way, your project can be 
> successful even if you can't find a syntax for the sequencer file that 
> meets the needs of all of these use cases. (Which is where I suspect 
> you'll get bogged down.) If you can get all of the cases where git exits 
> in order to get human intervention to share "everything that matters" and 
> the core to "know what's in progress as far as anything else cares", I 
> think that would be success, even if the various multi-step programs 
> continue using their own state files.

Excellent.  The crux of the idea: The sequencer should serve as the
entry/ exit point for Git when any operation requires user
intervention to proceed.  For this, it should have information about
how we got to this point, and how to proceed after the user
intervention is complete; this information is contained in:

> cherry_pick_conflict = { 
>   "cherry-pick", APPLIES_TO_CURRENT_BRANCH | IN_MIDDLE_OF_COMMIT,
>   cherry_pick_verify_resolution,
>   cherry_pick_abort,
>   cherry_pick_post_resolution
> };

Wait -- isn't it missing a skip callback?

cherry_pick_conflict = { 
  "cherry-pick", APPLIES_TO_CURRENT_BRANCH | IN_MIDDLE_OF_COMMIT,
  cherry_pick_verify_resolution,
  cherr_pick_skip,
  cherry_pick_abort,
  cherry_pick_post_resolution
};

This information is passed to report_conflict(), which takes care of
user intervention.  The user can do whatever she wants and then ask
the sequencer to "continue", "skip" or "abort":

> Where the sequencer-level conflict nests around the cherry-pick-level 
> conflict, and the generic "continue" completes things from the inside out.

Right.  And then the sequencer fires the appropriate callback and
returns control to the parent command.  More notes:

>  - cherry-pick can save whatever it needs to in its state file; that's 
>    its business, and the semantics here don't have to interact with other 
>    commands, because report_conflict() has taken care of interaction with 
>    other commands

At the end of a merge for example, the MERGE_MSG needs to be retrieved
to create a new merge commit.  The sequencer des not need to know
anything about this, since this is specific to 'merge'.

>  - arbitrary code can determine that you're in the middle of resolving 
>    some conflict, that the resolution of that conflict is about doing
>    something to your current branch, and how to abort what you're doing,
>    and how to finish it

Any arbitrary code simply has to ask the sequencer about the state of
the intermediate files that report_conflict() uses.  They don't have
to worry about command-specific intermediate files.

>  - the same code gets run after the conflict has been resolved that would 
>    have been run immediately if the merge went smoothly

Using these callbacks, there is no need for if-else ugliness inside
the specific command to decide what to do next.

I suppose we can call this  idea a "generic conflict handler".  I like
it very  much, and  I'll definitely  include this as  part of  my GSoC
work.  Thanks for taking the time to explain it in such detail :)

-- Ram
