From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT PATCH 2/4] Abstract a PatchSet object out of Series.
Date: Fri, 15 Jun 2007 22:14:39 +0200
Message-ID: <20070615201439.GT6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth> <20070611003330.4736.69293.stgit@gandelf.nowhere.earth> <b0943d9e0706121509j5088e164iadedb561501d6a55@mail.gmail.com> <20070613203821.GQ6992@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0706141556w1fb280dbu12e55dc91f6d5941@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 22:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzIBl-0002Xg-Sh
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 22:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbXFOUOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 16:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354AbXFOUOc
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 16:14:32 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:48630 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbXFOUOb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 16:14:31 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BBF4E5A286;
	Fri, 15 Jun 2007 22:14:30 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 5D1C31F158; Fri, 15 Jun 2007 22:14:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0706141556w1fb280dbu12e55dc91f6d5941@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50276>

On Thu, Jun 14, 2007 at 11:56:47PM +0100, Catalin Marinas wrote:
> On 13/06/07, Yann Dirson <ydirson@altern.org> wrote:
> >I have started to work on a Hydra class (available at [1], but be
> >aware it doesn't do much more than creating an octopus, and breaking
> >many current StGIT assumptions), with a testcase to demonstrate its
> >use), which binds together a set of stacks with an octopus, to allow
> >keeping related patches together, and allow people to pull from one
> >topic stack without getting unrelated work.
> 
> If it works, it would be really useful. Do the stacks need to be
> independent? I can group my patches easily (and I was thinking about
> "collapse/expand" commands for better viewing) but one stack might
> still depend on patches from a different one. It would be nice if one
> could also set the base of a series in this kind of hydra structure
> (unless it makes it difficult to understand).

Indeed one of the things that naturally come to mind after hydra, is
to abstract a parent class above PatchSet and Patch, and allow those
to be mostly used everywhere one of them is allowed.

That way we can have a (sub-)stack anywhere between 2 patches in a
stack, and that should I think address the need you describe.  But
that would also allow to have an hydra built of single patches instead
of stacks, which would be quite similar to how darcs organizes
patches.  Combinations are endless, and I don't even count the
possibility of adding new structures besides stacks and hydras :)


> >As described in that mail, there are problems both with the
> >original approach (Karl's test failing), and with that new one (that
> >exisiting test failing).
> >
> >Do you have any idea on how we could overcome the problem ?  In the
> >meantime, we could possibly just comment that testcase out (or add
> >support for continuing the testsuite even with a failure) - the
> >problem it exhibits is probably less common than the one that was
> >fixed.
> 
> I am happy with only 2 modes - one using ORIG_HEAD for people using
> StGIT in combination with plain GIT and the other overriding the base
> without checks. The second mode is for people not mixing StGIT with
> plain GIT. For the first mode, they have to deal with conflicts as
> with the standard GIT.

Well, I have to think about that in details - but right now I'm a bit
busy with the hydra thing.


> >BTW, a02ba4077f12578fe31c99d903488804a656e1c4 has a slight problem: it
> >is a patch by Karl, which I re-sent in the same group since it was
> >exhibiting the problem (and with the intent of adding a signed-off-by
> >line, but my way of adding them trough a buggy template showed its
> >limits and the commit now have 2 signed-off-by lines with Karl's
> >name).  However, it was applied with myself as author, which is quite
> >wrong: could that be a but in "stg import" ignoring the Author field ?
> 
> It's not a bug. The import command just uses the e-mail sender or a
> "From:" line before the patch description (see the default mail
> template). It doesn't check the sign lines (it is following the kernel
> patch submission guidelines).

We could surely improve things (and I'm not suggesting we should look
at sign lines).  Eg, by having stg-mail add an Author pseudo-header
when the patch author is different from the sender, and having
stg-import use that when available.


> I would drop both the above commits for release 0.13. Are you OK with this?

Seems reasonable: the previous situation only seems to hurt when using
a workflow not involving stgit alone, whereas with this patch we also
break stgit-only workflows.

Best regards,
-- 
Yann.
