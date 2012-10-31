From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Workflow for templates?
Date: Wed, 31 Oct 2012 11:44:04 +0100
Message-ID: <20121031104403.GC28437@raven.wolf.lan>
References: <20121025211522.GA28437@raven.wolf.lan>
 <3190de06-2eaf-4a39-91aa-9cc34c20fc8e@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 11:50:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTVsS-0005jX-2U
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 11:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756729Ab2JaKuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 06:50:15 -0400
Received: from quechua.inka.de ([193.197.184.2]:34193 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711Ab2JaKuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 06:50:14 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1TTVsB-0005Nz-JC; Wed, 31 Oct 2012 11:50:11 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 87493760D3; Wed, 31 Oct 2012 11:44:04 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <3190de06-2eaf-4a39-91aa-9cc34c20fc8e@zcs>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208805>

On Sat, Oct 27, 2012 at 08:45:45PM +0200, Enrico Weigelt wrote:
> I'd suggest a 3 level branch hierachy (IOW: the lower level
> is rebased ontop of the next higher level):
> 
> * #0: upstream branch
> * #1: generic local maintenance branch
> * #2: per-instance cutomization branches
> 
> Normal additions go to the lowest level #2. When you've got
> some generic commit, you propagate it to the next level
> (cherry-pick) and rebase layer #2 ontop of it.
> Now you can send your layer #1 to upstream for integration.
> 
> When upstream updated his branch, you simply rebase #1
> ontop of it, do your checks etc, then proceed to rebasing #3.
> 
> You could also introduce more intermediate layers (eg when you've
> got different groups of similar instance that share certain changes)

Thanks for the suggestion, Enrico!

I am somewhat unsure whether it would work this way. After all, there seems to
be an unbreakable rule with git: never rebase published branches.

Thus, once I have published my work to other people who also need to work on
the same localizations as I do, I have no longer the option of rebasing to get
rid of the localizations and put the generic template stuff for upstream.

I guess, my concern is because I have not yet fully understood the problems of
rebasing, and how to recover from them.

Maybe I should try to explain the problem in terms of repository
hierarchy. Let's assume, there is this hierarchy of repositories:

upstream: central repository, containing the generic template

foo-site: repository for site foo. Here we have localizations for a specific
          administrative entity named foo (say, google).
          This is where clones for production are made from, and production
          boxes pull from here to be kept up-to-date.

foo-prodA: A clone of foo-site, put in production and pulling from a specific
           branch on foo-site to receive released, blessed updates.
foo-prodB: Similar to foo-prodA, but on another box.
           
foo-devA: A clone of foo-site to make development, releases, and whatever for
          foo.
foo-devB: One more clone of foo-site, Developer B is working here.

Then, we might have more administrative entities: bar-site, bar-prodA,
bar-prodB, bar-devA, bar-devB, for example. This might be Microsoft, for
example.

Further, foo-devA might be the same person as bar-devA.

So when foo-devA pulls from foo-devB, then foo-devB will create problems when
he rebases after that pull.

I think I have some kind of misunderstanding here, but I just can't figure
what it is.


Maybe I should try to explain the problem in yet other words:

What I am trying to achieve, is to extend the workflow from development to
deployment across multiple administrative entities. As a picture:

  upstream     (templates only).
     ^
     |
     v
  development  (configured, might contain experimental changes)
     ^
     |
     v
  deployment   (configured)

This workflow should not stop at administrative borders. Just replace foo by
google and bar by Microsoft to get an idea of what I am trying to achieve.
