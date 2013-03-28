From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Thu, 28 Mar 2013 17:18:49 +0530
Message-ID: <CALkWK0=GcxBh9o+sF1Q8t6SC0JU=NmPyRg6tqaOKmkJ6qDvRCA@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <20130327192630.GF28148@google.com> <7vppyklhot.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 12:49:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULBKu-0003zp-JX
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 12:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab3C1LtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 07:49:11 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:50011 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab3C1LtK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 07:49:10 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so11680186ieb.29
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 04:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8iq/pNpWf8rmkfXAIToWg0/8pWnuSIY7K/HkDi6m1lA=;
        b=v5uHDISYAiTpSymcL7vhg97+Auyhf0qg6y/xfIbJetNluDzKbviKzzHOQjnWkc42xg
         tkRjpascKja2klXPOcNapPdgbANEwDhlstUa94B60dTn8NfGIMYAiNDq8TQpAkMBScFC
         tLuGwC/U4oGGCHmL/h7D/C0VTrfCx/xYsRMmnUJ4RlHTEYlCGfb3JtWRAsIFvLOT/QpA
         879ncD3tIyucwN113jmfR0hGObK9puL80O9u9fVuScapsxyPLI+kzsHNMWOOMxLJPDv6
         ImAY07xVqGcnK51ymQlNNeYUp2ngyKVU/GvrQV441iAwtPShJ4au+YIstdCXS33Bt6rk
         aeIw==
X-Received: by 10.43.9.68 with SMTP id ov4mr14214976icb.22.1364471350003; Thu,
 28 Mar 2013 04:49:10 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 28 Mar 2013 04:48:49 -0700 (PDT)
In-Reply-To: <7vppyklhot.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219381>

Junio C Hamano wrote:
> As I said in another thread, your top-level may be only a part in
> somebody else's project, and what you consider just a part of your
> project may be the whole project to somebody else.  If you pick one
> location to store both for the above clone, e.g. cgit/.git (it could
> be cgit/.ram-git or any other name), embedding it in a yet larger
> project (perhaps having both cgit and gitolite to give a one-stop
> solution for hosting services) later would face the same issue as
> Ram seemed to be complaining.  It needs to address what happens when
> that cgit/.git (or whatever name) gets in the way in the scope of
> the larger project.  That is why I said Ram's rant, using subjective
> words like "elegant", without sound technical justification, did not
> make much sense to me.

I was having a lot of difficulty writing down my thoughts.  Thank you
for providing an illustrative example.  It is terribly hard to do with
our current implementation: we'd have to rewrite the "gitdir: " lines
in all the .git files in the submodule trees and rebuild all the
.git/modules paths.  I'm thinking that we need to separate the object
stores from the worktrees for good.  For a project with no submodules,
the object store can be present in .git/ of the toplevel directory,
like it is now.  The moment submodules are added, all the object
stores should be relocated to a place outside the worktree.  So my
~/src might look like: dotfiles.git/, auto-complete.git/, magit.git/,
git-commit-mode.git/, yasnippet.git/ and dotfiles/.  dotfiles/
contains lots of worktrees stitched together nicely, pointing to these
object stores in ~/src.  This would certainly get rid of the asymmetry
for good.

Now, we can focus our attention on composing git worktrees.  What is a
worktree?  A tree object pointed to by the commit object referred to
by HEAD.  What we need to do is embed one tree inside another using a
mediating object to establish repository boundaries, while not
introducing an ugly seam.  If you think about it, the mediator we've
picked conveys little/ no information to the parent; it says: "there's
a commit with this SHA-1 present in this submodule, but I can't tell
you the commit message, tree object, branch, remote, or anything else"
(obviously because the commit isn't present in the parent's object
store).  So, the mediator might as well have been a SHA-1 string.  And
we have an ugly .gitmodules conveying the remote and the branch.  Why
can't we stuff more information into the mediating object and get rid
of .gitmodules altogether?

Okay, here's a first draft of the new design.  The new mediator object
should look like:

    name = git
    ref = v1.7.8

The name is looked up in refs/modules/<branch>, which in turn looks like:

    [submodule "git"]
        origin = gh:artagnon/git
        path = git
    [submodule "magit"]
        origin = gh:magit/magit
        path = git/extensions/magit

The ref could be 'master', 'HEAD~1', or even a commit SHA-1 (to do the
current anchored-submodules).
Finally, there's a .git file in the worktree, which contains a
"gitdir: " line pointing to the object store, as before.

This solves the two problems that I brought up earlier:
- Floating submodules (which are _necessary_ if you don't want to
propagate commits upwards to the root).
- Initializing a nested submodule without having to initialize all the
submodules in the path leading up to it.

However, I suspect that we can put more information the mediator
object to make life easier for the parent repository and make seams
disappear.  I'm currently thinking about what information git core
needs to behave smoothly with submodules.
