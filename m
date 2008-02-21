From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 2/2] Write to a stack log when stack is modified
Date: Thu, 21 Feb 2008 08:18:19 +0100
Message-ID: <20080221071819.GA8250@diana.vm.bytemark.co.uk>
References: <20080214012119.22365.54526.stgit@yoghurt> <20080214012912.22365.83207.stgit@yoghurt> <b0943d9e0802201446g2840c3d9v576f840936253525@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 08:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS5iA-0001PU-G7
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 08:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbYBUHSm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2008 02:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbYBUHSm
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 02:18:42 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3804 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbYBUHSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 02:18:41 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JS5hD-0002C6-00; Thu, 21 Feb 2008 07:18:19 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0802201446g2840c3d9v576f840936253525@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74605>

On 2008-02-20 22:46:48 +0000, Catalin Marinas wrote:

> On 14/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Create a log branch (called <branchname>.stgit) for each StGit
> > branch, and write to it whenever the stack is modified.
>
> The abstractions are really nice (and I still wonder how StGIT
> codebase increased that much when all I needed two years ago was a
> simple script-like application to reorder commits :-)).

:-) I'll take some of the blame, but StGit was quite large already
when I started submitting patches to it.

> Anyway, I don't really like the idea of an additional commit (I
> don't even like the old patch log implementation) when the stack is
> modified. It needs some profiling but it has a visible impact on
> stacks with a big number of patches (my last kernel release at
> www.linux-arm.org/git had 80 patches and it takes a lot of time to
> push them).

One thing to remember is that my patch stack log gets one new commit
per StGit operation, not one per changed patch. So if you push 80
patches with one command, that will give you just one commit on the
log. (If someone makes a scripts that calls push 80 times this won't
help, of course.)

> Can we not use some of the automatic reflog recording that GIT does
> instead of writing a commit? It's cheaper to write a text file than
> generating a commit.

As I said, I'm not convinced that it's a huge difference when you have
just one log commit per operation, not one per changed patch. But
let's stop arguing about it until I have some numbers to back my claim
up. ;-)

> In my kernel repository I have several branches with many patches
> and, even after "git gc" and repacking, it is still slow (mainly
> because of git-read-tree but I'd like to reduce the number of calls
> to GIT).

When you say "it's still slow", are you referring to the existing
per-patch log, my per-branch log, or just StGit in general?

Have you noticed any difference between commands using the old and new
infrastructure (say, stg push vs. stg goto)? The latter should be
taking less time, due to touching the worktree only when necessary.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
