X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: Collection of stgit issues and wishes
Date: Mon, 18 Dec 2006 00:15:40 +0100
Message-ID: <20061217231540.GB16838@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0612100825h3ef2fa77kd5d9fd5022cbb3f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 23:16:03 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 20404 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 18:15:46 EST
Content-Disposition: inline
In-Reply-To: <b0943d9e0612100825h3ef2fa77kd5d9fd5022cbb3f9@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34709>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw5Ee-0000Wp-2S for gcvg-git@gmane.org; Mon, 18 Dec
 2006 00:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753201AbWLQXPr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 18:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202AbWLQXPr
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 18:15:47 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:36922 "EHLO
 smtp3-g19.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1753201AbWLQXPq (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 18:15:46 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp3-g19.free.fr (Postfix) with ESMTP id 20BBD49F32;
 Mon, 18 Dec 2006 00:15:45 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id 6414A1F092;
 Mon, 18 Dec 2006 00:15:40 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On Sun, Dec 10, 2006 at 04:25:52PM +0000, Catalin Marinas wrote:
> Since this list gets changed pretty often, I would rather add TODO
> Bugs wiki pages on http://wiki.procode.org/cgi-bin/wiki.cgi/StGIT

Great idea.

> (maybe I should create a page on one of the open-source hosting sites
> and get some bug-tracking support).

If you're only looking for bugtracking, I wonder whether
bugzilla.kernel.org could be used (as well as for core git and other
git-related tools).  Or maybe a new git-specialized bugzilla could be
setup somewhere ?

BTW, and a bit off-topic, one thing that would be great to have would be
git-bugzilla coupling (mainly, recording into bugzilla when a commit
addressing an issue gets pushed to an official tree).
Scmbug already provides a framework for such couplings, and already has
bugilla/mantis/RT support on the BTS side.


> I keep the TODO file mainly for
> what I plan to implement and, while I agree with many of the issues
> you point below, I don't guarantee I have time to fix/implement.

I tend do that myself too - in fact, a number of the issues I reported
are candidates for future patches from me :)


> >- "stg import" leaves empty patch on the stack after failed patch 
> >application
> 
> That's a feature in the sense that it creates the empty patch with the
> description and author information. It also leaves a
> .stgit-failed.patch which you can manually apply.

I was not aware of this.  It would be useful to tell the user when such
a failed patch is left behind (that would have saved me some timing
already ;).


> >- "patches -d" may be confused by files added then removed (below,
> >file added to platform-v0, removed in rm-junk, problem encountered on
> >2006-08-14, probably on 0.10):
> 
> Is this still the case now? I fixed a similar issue a few months ago
> (commit a57bd72016d3cf3ee8e8fd7ae2c12e047999b602; GIT considers a file
> name to be revision name if the file isn't found on disk; easily
> fixable by adding the "--" separator).

I should check.


> >- "stg show" should catch inexistant patch instead of saying "Unknown
> >revision: that-patch^{commit}"
> 
> This command works for commit ids as well as patches. If the patch
> isn't found, it considers the name to be a commit id.

OK.  Then some message like "No patch or commit id found matching
$commit" could be more informative.


> >- "clean" should give enough info for the user to locate any problem
> >(eg. conflict with files removed from revision control), eg. with a
> >"popping to ..." message
> 
> Clean only removes empty patches and there shouldn't be any conflicts
> caused by this operation (unless there is a bug).

I have already described the problem in a previous thread.  There is a
conflict when a generated file gets committed by error, and then a stgit
patch removes it.  If one tries to pop that patch when the generated
file exists, there is a conflict.


> >- "sink" or "burry" as opposite to "float" (possibly with a target
> >patch)
> 
> But how deep to burry it?

I'd think to bottom of stack by default (mostly to get a sane default),
but with an option to specify the position.
Or maybe as "stg bury-below <target> <patches-to-bury>".

> >- lacks "pick --patch=XXX" to pick by name
> 
> I don't understand this.

Hm, I must have been confused, just ignore.


> >- interactive merge tools could only be called automatically after
> >failed merge, instead of requiring not-so-intuitive "resolved -i"
> 
> You can set the stgit.merger config option for this (diff3 followed by
> xxdiff or emacs). I even have a .py file for doing this, I can add it
> to the contrib dir.

What about automatically triggering stgit.imerger when stgit.merger
failed ?


> >- needs a config example to call ediff via gnuserv (possibly sending
> >several merges at a time, making use of the session registry)
> 
> Don't know how to do it.

That's one of the TODO items directed at myself (unless some good soul
takes care of that first ;)


> >- "stg fold" should allow to run a merge (insert conflict markers, or
> >even just output a .rej patch somewhere)
> 
> It just calls git-apply. If this can do it, StGIT would use it.

I still have to invest some time into the available merge algorithms.
If nothing is available yet for this, we shall find out how to do it :)


> >- support for atomicity of complex transactions (stg begin/snapshot,
> >rollback, commit/finish - possibly with a transaction name so nesting would
> >just work)
> 
> Would be nice but probably not that easy.

Full logging of series file would help, I think.  Once we have full
logging of the stack, we get cheap transactions as well as arbitrary
undo depth, and the "stg undo" command to replace all those --undo
flags.  But right, it still requires some work :)


> >- "stg patches" should be able to report on unapplied patches
> 
> It invokes GIT to find out the commits modifying the give file. An
> unapplied patch doesn't modify any local file.

Right, but I think we could invoke GIT to report on each of the unapplied
patches that form a head, and restrict the output to those commits that
are stgit patches.

Best regards,
-- 
