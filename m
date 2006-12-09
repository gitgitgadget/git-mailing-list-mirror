X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: RFC PATCH: support for default remote in StGIT
Date: Sat, 9 Dec 2006 14:36:18 +0100
Message-ID: <20061209133618.GB17132@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1165656205.2816.47.camel@portland.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 13:37:40 +0000 (UTC)
Cc: "Catalin Marinas catalin.marinas"@gmail.org, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <1165656205.2816.47.camel@portland.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33815>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt2OY-0000Jn-9a for gcvg-git@gmane.org; Sat, 09 Dec
 2006 14:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761253AbWLINhf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 08:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761254AbWLINhf
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 08:37:35 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:54405 "EHLO
 smtp5-g19.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1761253AbWLINhe (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 08:37:34 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp5-g19.free.fr (Postfix) with ESMTP id A89EC27A51;
 Sat,  9 Dec 2006 14:37:32 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id 9837C20C1;
 Sat,  9 Dec 2006 14:36:18 +0100 (CET)
To: Pavel Roskin <proski@gnu.org>
Sender: git-owner@vger.kernel.org

Hi Pavel,

This is quite related to the subject of the "Handling of branches in
stgit" thread I launched recently (Nov 30th).

On Sat, Dec 09, 2006 at 04:23:25AM -0500, Pavel Roskin wrote:
> It's very important for me to have default remote support in StGIT.  I'm
> trying to track different Linux branches, and I don't want to remember
> what branch I'm on when I run "stg pull".

Right, that's the main problem with the current implementation.

> One approach is to leave the default remote selection completely to git.
> The downside is that StGIT prints the remote it's pulling from.  Now
> StGIT will have to print common words that it's pulling something.  Or
> maybe it shouldn't print anything?

It could just print a generic message and let GIT print out
the details.

> Also, git-pull doesn't allow to specify the refspec without the remote.
> This limitation seems artificial to me, but we have to pass this
> limitation to the StGIT users.

In which situtation do you need to pass a refspec ?  I thought all
necessary refspecs should already be part of a remote's definition.

> The positive side if that StGIT is completely unaware of the word
> "origin", and any changes in git handling of the default remote will
> propagate to StGIT immediately.

Indeed.


> The other approach is to calculate the default remote in StGIT.  This
> would allow StGIT to tell the user where it's pulling from.

Doing so would probably require to teach StGIT about every new way of
fetching a branch (we already have 3 ways, as outlined in my initial
mail).  OTOH, it may be the only way to present the user with a
uniform way of working, independently of the way we update the parent
branch.


Indeed, we may just want to distinguish whether the parent branch is a
remote one or not.  Then if it's a remote one, git-fetch already has
enough info to do its work updating the parent branch (whether using
.git/remotes or .git/branches).  If it's not a remote branch, there's
just nothing to do at this step.

Then, we just have to "pop -a" and move the stack base, without
relying on "pull".  That would also transparently give support for
branching off a non-forwarding branch (like git's "next" and "pu", or
like any stgit managed branch).  Would anyone miss the "git-pull" call ?

Best regards,
-- 
