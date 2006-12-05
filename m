X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: Handling of branches in stgit
Date: Tue, 5 Dec 2006 23:51:37 +0100
Message-ID: <20061205225137.GA17132@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061130000038.GA13324@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0612010442gf7bf2ccr8995967403788fe7@mail.gmail.com> <20061201221941.GA32337@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 22:52:45 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061201221941.GA32337@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33383>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grj9X-0001z1-Rw for gcvg-git@gmane.org; Tue, 05 Dec
 2006 23:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936954AbWLEWwl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 17:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937005AbWLEWwl
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 17:52:41 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:50079 "EHLO
 smtp4-g19.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S936954AbWLEWwk (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 17:52:40 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp4-g19.free.fr (Postfix) with ESMTP id E5D1888AB; Tue,
  5 Dec 2006 23:52:38 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id 6B9851F089;
 Tue,  5 Dec 2006 23:51:37 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, Dec 01, 2006 at 11:19:41PM +0100, Yann Dirson wrote:
> > >  annoying [ISSUE 1].  Hence this work of mine: being able to store
> > >  this info in .git/patches/<stack>/parent (my initial implementation)
> > >  was sufficient in theory.
> > 
> > I would leave this to GIT and its configuration files. Do you see any
> > problems with this approach?
> 
> I'd rather consider it a stgit issue: git itself does no have to know
> which of the various heads descending from our stack base is to be
> "prefered" by our stack.  Where to store it is anothe issue (see below).
> 
> 
> > I plan to merge the stgit config with the git one (and have a [stgit]
> > section) so that it is more maintainable.
> 
> Sure, let's take advantage of git-repo-config !
> My latest 1/3 patch could then be seen as a 1st step towards an
> abstraction of stgit object configuration, which could ease the transition

Indeed most of the current attributes of a stack (except maybe for the
description, which can hardly be seen as a config option) are quite
volatile, and thus unsuited for repo-config.
OTOH, as you said parent information would find easily its place there.


> > On 30/11/06, Yann Dirson <ydirson@altern.org> wrote:
> > >I have started to work on recording parent information for stgit
> > >branches, so we don't need to give the same info on every "git pull".
> >
> > Isn't this what the branch.<name>.remote configuration option is for?
> > I think we should leave GIT handle this and StGIT only invoke "git
> > pull" without any arguments.
> 
> This is one part of the problem (and I admit I have missed this config option),
> the other one being having stgit pull the correct branch, unstead of
> (implicitely) having git-pull using the 1st one in the remotes file.

I would also think that what really belongs to that config item would
be the declaration of which remote our parent branch should use to be
updated (ie. no need to duplicate the info in all the stgit stacks
forked off the same parent).

However it looks like this config option is not currently used unless
the branch to be git-fetched is the curent one, which is quite
annoying - we would need to get that setting ourselves to pass it to
git-fetch.

What's not clear to me is how to deal with cogito branches (maybe
check for the existence of .git/branches/<name> and then "git fetch
<name>" ?), and with local branches (how are we supposed to derive
that a branch is not a remote one ?  Should GIT add a
branch.<name>.remote or "." for locally-created branches ?).


We would also still need a config item to tell which parent branch we
should use, in order to know which branch.<name>.remote to extract,
and which branch to fast-forward our base onto.

Best regards,
-- 
