X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 1/3] Document some current bugs and add to the TODO list.
Date: Tue, 5 Dec 2006 23:02:22 +0100
Message-ID: <20061205220222.GA5320@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061130002304.21981.67797.stgit@gandelf.nowhere.earth> <20061130002717.21981.38049.stgit@gandelf.nowhere.earth> <b0943d9e0612050930t187e65c4g6a3c44ea1fefc940@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 22:03:56 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0612050930t187e65c4g6a3c44ea1fefc940@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33375>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GriO9-0003LI-MR for gcvg-git@gmane.org; Tue, 05 Dec
 2006 23:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760162AbWLEWDm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 17:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760184AbWLEWDm
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 17:03:42 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:56922 "EHLO
 smtp3-g19.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1760162AbWLEWDl (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 17:03:41 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp3-g19.free.fr (Postfix) with ESMTP id 4D26C4A1F5;
 Tue,  5 Dec 2006 23:03:24 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id EAABF1F089;
 Tue,  5 Dec 2006 23:02:22 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On Tue, Dec 05, 2006 at 05:30:56PM +0000, Catalin Marinas wrote:
> On 30/11/06, Yann Dirson <ydirson@altern.org> wrote:
> >+- numeric shortcuts for naming patches near top (eg. +1, -2)
> 
> We currently have the -n option for push and pop that accepts number.
> Because of python, you can also, for example, push to the last but one
> with "push -n -1" (similar for pop). Do you mean shortcuts for the
> "goto" command?

I rather meant shortcuts for "show", "fold --pick", and possibly a
handful of others.

While we're talking about shortcuts for goto, one that I regularly miss
would be something like "goto BACK", to allow for short excursions and
quickly going back without having to worry on which exact patch I was
before.  "refresh --patch" will make this less essential, but still
possibly useful.


> >+- refuse to "stg init" a branch known as remote (through .git/remotes/,
> >+  .git/branches/ or any other info)
> 
> I think it is up to the user not to do this.

It may not be obvious to a new user, so I'd think it would be useful to
guard against things we know should not be done.

"git checkout" being probably used as plumbing in several places should
probably not be taught to refuse switching to remote branches, so I'd
think porcelains should take care of this.


> You would first need to check out such a branch anyway.

Sure.  Especially, the following should probably fail :)

|stgit$ stg branch origin
|Switching to branch "origin"... done

Maybe it could be made to accept only to change to stgit-managed
branches ?
After all, if we're switching to a non-stgit branch, we're probably
going to use another set of tools anyway, so we can probably tell the
user to use git-checkout or cg-switch instead.


> >+- cannot use "stg refresh file" after "cg-rm file"
> 
> It seems to work for me. Can you send some log messages?

I should have done that first, I cannot reproduce it any more.


> >+- "stg goto $(stg top)" fails with unhandled exception
> 
> It works for me. What StGIT version do you use?

I got that error on 0.11 - and just checked that
9b63cf56576bf219d26f490f3c011e937a5f7129 fixes exactly this problem
already.  Sorry, I should have checked on master first.


> >+- at least "commit is not robust wrt out-of-diskspace condition:
> >+|deps$ stg commit
> >+|error: git-checkout-index: unable to write file MANIFEST
> >+|error: git-checkout-index: unable to write file META.yml
> >+|error: git-checkout-index: unable to write file Makefile.PL
> >+|error: git-checkout-index: unable to write file doc/README.dbk.xml
> >+|error: git-checkout-index: unable to write file graph-includes
> >+|error: git-checkout-index: unable to write file 
> >lib/graphincludes/params.pm
> >+|fatal: unable to write new index file
> >+|stg commit: git-read-tree failed (local changes maybe?)
> >+|Committing 4 patches...
> >+(luckily nothing was really committed)
> 
> But that's the correct behaviour, not to commit anything.

Right.

> StGIT cannot know
> how much space is needed by GIT to check this beforehand. It simply
> exits when a GIT command failed.

What I had in mind, is that when something fails midway, if we just exit
we may end up in an inconsistent state.  I have not taken the time to
check about that, that's why I wanted it to appear in the TODO file.
Again, it was quite poorly worded, to say the least.

Best regards,
-- 
