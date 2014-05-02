From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Fri, 02 May 2014 16:55:01 -0500
Message-ID: <536414352fa24_1976139f2f0f9@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5363edc954f8e_70ef0f30c24@nysa.notmuch>
 <20140502214817.GA10801@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:05:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgLaT-0008LW-OB
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbaEBWFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:05:41 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:60563 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbaEBWFk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 18:05:40 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so5912160obb.40
        for <git@vger.kernel.org>; Fri, 02 May 2014 15:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=vPY8oxfv3bAoy5AmrrC3PNBITQ9DeMYugMFhHytftlU=;
        b=CH0FmHgEFlK9dhg2f0c+GI2TnBfiqRsGzTgP9TfGyeBoLHP8dUlSQxOPqnihCGdtEl
         oBsZpYDLj1377RbSxJcOcfKMzvLp2Ar40jOZuXU6Xjmg1Vg/wX5zMKvr1aqKKg2ONHuW
         M9Tt44B5O6d1PQlbdFRRwA2RkcnWxLB6CraE4b2ez7CnX9xKfY9kRPo2gg3M8vik3VPH
         uZ4vx9JSN+FTHlAnl+0z667+ZbW+mPY1S8IN77beaazDGxzLgj2Ek2wp36A9IW+xKdTM
         awnPJInChsgaH7VhksjWkqyC3ViJcs3Ju859mtB2uwpKX1bm2YrdNAvVkccmHkFAZ5PJ
         DOUw==
X-Received: by 10.182.60.65 with SMTP id f1mr3091440obr.78.1399068340355;
        Fri, 02 May 2014 15:05:40 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jr2sm592690obb.8.2014.05.02.15.05.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 15:05:39 -0700 (PDT)
In-Reply-To: <20140502214817.GA10801@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247991>

Jeff King wrote:
> On Fri, May 02, 2014 at 02:11:05PM -0500, Felipe Contreras wrote:
> 
> > Junio C Hamano wrote:
> > > If we step back a bit, because we are forcing him to differentiate
> > > these two pulls in his mental model anyway, perhaps it may help
> > > people (both new and old) if we had a new command to make the
> > > distinction stand out more.  What if the command sequence were like
> > > this instead?
> > > 
> > >     $ git checkout maint
> > >     $ git update [ origin maint ]
> > > 
> > >     $ git pull [--no-ff] developer-remote topic-branch
> > >     $ git push [ origin maint ]
> > > 
> > > where the new command 'update' enforces the '--ff-only' update.  And
> > > then we would stop telling "'git pull' first" when a push does not
> > > fast-forward.
> > 
> > In addition to barf when it's not a fast-forward, such command can
> > switch the parents, so it appears 'maint' was merged to 'origin/maint'.
> > Many people have complained about this order.
> 
> I realize this has veered off into talking about an "update" command,
> and not necessarily "pull", but since there a lot of proposals floating
> around, I wanted to make one point: if we are going to do such a switch,
> let's please make it something the user explicitly turns on.

This is sensible, but with warning "X will be the default in the
future", just like we did with push.default = simple.

> One common workflow for GitHub users is to back-merge master into a
> topic, because they want the final "integrated" version on the topic
> branch. That lets it get review, run tests, and even get test-deployed
> from there before merging to master (and then when it does merge to
> master, we know the result will be a trivial merge).  This workflow
> helps spread out the load (there is no central "integration" person or
> script, and the merge itself becomes a possible part of the review/test
> cycle).  Some projects will do this by rebasing the topic, but that has
> its own complications (like making collaboration harder because the
> commits are being frequently rewritten).

They can do:

% git pull origin master

That shouldn't revese the bases.

> Such users are going to run "git pull origin master" or just "git pull"
> to get that merge.

I'd say the vast majority of users running "git pull" want the parents
reversed, the minority that doesn't can switch to "git pull origin
master" (or add a configuration).

> A switch to disallowing non-ff is going to disrupt
> that workflow.

Only if the refuse to do "git pull origin master".

> But I think that is the same moment they should probably be deciding on
> whether their workflow wants "regular" or "reverse" merges. And I do not
> think the decision between the two has an obvious split over which is
> better.

Because there hasn't been enough discussion on this topic. I'm fairly
certain there will be consensus once concrete proposals are properly
discussed.

Most likely the consensus and the proposals will be ignored and nothing
will change as usual, but that's a different thing.

-- 
Felipe Contreras
