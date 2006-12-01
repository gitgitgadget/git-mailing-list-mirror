X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: Handling of branches in stgit
Date: Fri, 1 Dec 2006 23:19:41 +0100
Message-ID: <20061201221941.GA32337@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061130000038.GA13324@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0612010442gf7bf2ccr8995967403788fe7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 22:20:47 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0612010442gf7bf2ccr8995967403788fe7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32973>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqGkL-0002f0-3i for gcvg-git@gmane.org; Fri, 01 Dec
 2006 23:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162071AbWLAWUh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 17:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162102AbWLAWUh
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 17:20:37 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:45486 "EHLO
 smtp3-g19.free.fr") by vger.kernel.org with ESMTP id S1162071AbWLAWUh (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 17:20:37 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp3-g19.free.fr (Postfix) with ESMTP id 982714A1CA;
 Fri,  1 Dec 2006 23:20:31 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id DA1281F066;
 Fri,  1 Dec 2006 23:19:41 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, Dec 01, 2006 at 12:42:19PM +0000, Catalin Marinas wrote:
> On 30/11/06, Yann Dirson <ydirson@altern.org> wrote:
> >I have started to work on recording parent information for stgit
> >branches, so we don't need to give the same info on every "git pull".
> 
> Isn't this what the branch.<name>.remote configuration option is for?
> I think we should leave GIT handle this and StGIT only invoke "git
> pull" without any arguments.

This is one part of the problem (and I admit I have missed this config option),
the other one being having stgit pull the correct branch, unstead of
(implicitely) having git-pull using the 1st one in the remotes file.


> >I'm facing a problem, in that we have several kind of stgit branches:
> >
> >* those created against a cogito branch (eg. by "cg clone" and "stg
> >  init").  They work pretty much intuitively (and it happens I mostly
> >  used this flavour before those tests).  All we need is the name of
> >  the local branch, and "stg pull <branch>" relies on "git fetch" to
> >  find the repository information in .git/branches/<branch>.
> 
> But I think .git/branches got deprecated or it is a cogito-only feature.

.git/branches still seems to be the only type of branch created by
cogito.  And in fact, when remotes started to appear, I wondered how the 
cogito branch management (a quite intuitive and classical one) would be
made to work well with remotes-defining-several-branches, as well as
branches-potentially-defined-in-several-remotes (possible repo
inconsistency AFAICT, or maybe to specify different protocols to a
single repo ?) - and indeed I still don't have an answer, I guess cogito
would have to possibly change its user interface if it were to be able
to use multi-branch remotes.

In the meantime, we should support them in cogito.  And indeed, I found
stgit to work perfectly with those.


> >  In this case, it is easy to request pulling from any branch, but
> >  usually only one of them is what you want, and the results of using
> >  another one (or forgetting to specify the one you want) can be
> >  annoying [ISSUE 1].  Hence this work of mine: being able to store
> >  this info in .git/patches/<stack>/parent (my initial implementation)
> >  was sufficient in theory.
> 
> I would leave this to GIT and its configuration files. Do you see any
> problems with this approach?

I'd rather consider it a stgit issue: git itself does no have to know
which of the various heads descending from our stack base is to be
"prefered" by our stack.  Where to store it is anothe issue (see below).


> I plan to merge the stgit config with the git one (and have a [stgit]
> section) so that it is more maintainable.

Sure, let's take advantage of git-repo-config !
My latest 1/3 patch could then be seen as a 1st step towards an
abstraction of stgit object configuration, which could ease the transition
from file storage to config items :)

Best regards,
-- 
Yann.
