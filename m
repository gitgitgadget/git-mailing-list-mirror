From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGIT: Trouble adding files to non-topmost patch
Date: Fri, 8 Feb 2008 09:33:55 +0100
Message-ID: <20080208083355.GA8854@diana.vm.bytemark.co.uk>
References: <1202445024.27753.54.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 09:34:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNOh6-0001DS-Jv
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 09:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbYBHIeO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2008 03:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759551AbYBHIeN
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 03:34:13 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1420 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760812AbYBHIeN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 03:34:13 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JNOgF-0002Pk-00; Fri, 08 Feb 2008 08:33:55 +0000
Content-Disposition: inline
In-Reply-To: <1202445024.27753.54.camel@localhost>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73053>

On 2008-02-07 23:30:24 -0500, Matt McCutchen wrote:

> I keep a copy of the Eclipse source code checked out from CVS, and I
> use StGIT to manage both long-term and short-term local changes to
> the source. (StGIT is so much nicer than shuffling patches by hand!)
> My StGIT patch stack is based on an empty tree; the bottom-most
> patch (named "origin") contains the original Eclipse source and the
> others contain my changes. I use "cvs up" to pull updates from
> Eclipse's repository, a custom script to load the updates into the
> git index, and "stg refresh -p origin" to load them into the patch
> stack.
>
> However, when the Eclipse developers create new files, I can't seem
> to add them to "origin" this way. After my index-updating script
> runs, "git status" shows that the new files have been added to the
> index, but ???"stg refresh -p origin" doesn't change "origin" and
> the new files show as untracked again. Some investigation revealed
> that the problem is that, whenever StGIT pops a patch (including as
> part of "stg refresh -p"), it resets the index. Here's the relevant
> code in git.py:
>
>     def switch(tree_id, keep =3D False):
>         """Switch the tree to the given id
>         """
>         if keep:
>             # only update the index while keeping the local changes
>             GRun('read-tree', tree_id).run()
>
> This behavior doesn't affect changes and deletions since StGIT
> automatically adds them back to the index, but it completely
> controverts additions. Please provide a direct way to add files to
> non-topmost patches.

Thanks for the detailed bug report!

Unfortunately, I don't have time to fix it immediately, so I put it in
the bug tracker: https://gna.org/bugs/index.php?11009.

> One could argue that my setup is bad. I could work around the
> problem by loading updates using a separate tree holding a clean CVS
> checkout, but then it is less convenient to check out additional
> modules. I could download and import the entire CVS history with
> git-cvsimport, but that would take an enormous amount of time and
> disk space. I'm open to practical suggestions for a better setup,
> but I do hope the problem with StGIT gets fixed.

What I'd do if I were you is to have a regular git branch just for
importing the upstream, and make a new commit there whenever I run
'cvs up'. And then rebase my local StGit patch stack on top of that
branch. Which would conveniently side-step the StGit bug ... ;-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
