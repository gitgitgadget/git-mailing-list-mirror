From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 2/2] Write to a stack log when stack is modified
Date: Fri, 22 Feb 2008 15:56:09 +0100
Message-ID: <20080222145609.GA19172@diana.vm.bytemark.co.uk>
References: <20080214012119.22365.54526.stgit@yoghurt> <20080214012912.22365.83207.stgit@yoghurt> <b0943d9e0802201446g2840c3d9v576f840936253525@mail.gmail.com> <20080221071819.GA8250@diana.vm.bytemark.co.uk> <b0943d9e0802220605t56257718p850c677a59671862@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 15:57:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSZKc-000665-UN
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 15:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbYBVO4V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 09:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753447AbYBVO4V
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 09:56:21 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2424 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbYBVO4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 09:56:20 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JSZJp-0005FD-00; Fri, 22 Feb 2008 14:56:09 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0802220605t56257718p850c677a59671862@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74726>

On 2008-02-22 14:05:55 +0000, Catalin Marinas wrote:

> On 21/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2008-02-20 22:46:48 +0000, Catalin Marinas wrote:
> >
> >  > The abstractions are really nice (and I still wonder how StGIT
> >  > codebase increased that much when all I needed two years ago
> >  > was a simple script-like application to reorder commits :-)).
> >
> > :-) I'll take some of the blame, but StGit was quite large already
> >  when I started submitting patches to it.
>
> Anyway, the new restructuring is much cleaner, though heavily OO and
> some people might not like it (me not included).

That it's conceptually OO is unavoidable, I think (the only way to
avoid that would be through obfuscation). And using Python's OO
features to write code for such a model is the least bad you can do in
Python. IMHO.

> > When you say "it's still slow", are you referring to the existing
> > per-patch log, my per-branch log, or just StGit in general?
>
> I think it's more GIT in general. Checking the tree status takes
> some time and a 3-way merge on a 512MB RAM machine with GIT using
> over 200MB gets a bit slow.

I just upgraded my laptop from 512 MB to 2 GB, so I'll start
neglecting this kind of problem, I fear. :-/

> >  Have you noticed any difference between commands using the old
> >  and new infrastructure (say, stg push vs. stg goto)? The latter
> >  should be taking less time, due to touching the worktree only
> >  when necessary.
>
> In the patch pushing functions, it now first calls simple_merge()
> which is still a 3-way merge but without rename detection. The old
> StGIT implementation was using "git-diff | git-apply" and falling
> back to the recursive merge. Most of the patches apply cleanly and
> we don't need the three-way merge which uses more RAM.

I didn't include patch application because it wasn't necessary to get
things working, and is easy to add at any later point.

I'd be curious to see how much of a difference it makes.

> The "(modified)" information was also displayed for a three-way
> merge (either read-tree or recursive-merge) but now it is only shown
> for the recursive one. Correctly, merging git-read-tree modifies a
> patch as well since it no longer applied cleanly.

Ah, so the precise meaning of a patch being "modified" is that git
apply failed to apply it. I didn't know that.

> We could use this "modified" feature to automatically export patches
> (some people asked for this in the past, as means for backup in case
> of StGIT failures).

You mean automatically export only the changed patches? (Otherwise stg
export would do the job -- I used to use that before I got confident
enough with StGit.)

One cool thing we could do is export the patches as files in a git
branch -- the log machinery I'm building should make it trivial. That
way, you'd get the history of the patches too.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
