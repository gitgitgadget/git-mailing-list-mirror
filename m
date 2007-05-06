From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [RFC PATCH] Rename "bury" back to "sink".
Date: Sun, 6 May 2007 12:49:44 +0200
Message-ID: <20070506104944.GB17498@diana.vm.bytemark.co.uk>
References: <20070504224639.26133.6157.stgit@gandelf.nowhere.earth> <f1gf8i$p52$1@sea.gmane.org> <20070505201307.GE19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun May 06 12:51:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkeKt-0000cE-Mz
	for gcvg-git@gmane.org; Sun, 06 May 2007 12:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933603AbXEFKvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 06:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933599AbXEFKvU
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 06:51:20 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2004 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933603AbXEFKvT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 06:51:19 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HkeJE-0004gU-00; Sun, 06 May 2007 11:49:44 +0100
Content-Disposition: inline
In-Reply-To: <20070505201307.GE19253@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46324>

On 2007-05-05 22:13:07 +0200, Yann Dirson wrote:

> The whole debate around burying, sinking and floating patches made
> me think a bit more about this. So we have:
>
> float:        move specified patches to top of stack
> bury/float:   move specified patches to bottom of stack or any place
>               in the stack identified by a nearby patch
>
> All in all, that all "move specified patches to a specified place".
> So wouldn't it be possible to end the debate by merging those
> commands into a single "stg move" command ?

I like that idea.

  stg move patch1 --bottom
  stg move patch1 --top
  stg move patch1 --before other-patch
  stg move patch1 --after other-patch
  stg move patch1 --position 17 # move to absolute pos. 17 (bottom is 0=
)
  stg move patch1 --up 3        # move 3 steps up
  stg move patch1 --down 2      # move 2 steps down

Or something. It could also be made to work with patch ranges as well
as single patches.

> Side note about the "stg move" name: yes it could possible to
> mistake it for "move file" (especially as we don't have "stg mv").
> My current state of mind would be to drop add/rm/cp from stgit, and
> move the "stg cp" logic to a new git-cp command. This way, stgit
> would just be about handling series of patches, with git being used
> for the working-copy. Any opinions on this ?

I would be in favor; I like to think of stgit as extending rather than
providing a complete replacement for the plain git porcelain. But as I
recall, Catalin didn't share my view on this. Better let him answer
the question himself than rely on my memory, though. ;-)

> Now to the new command. We could have something like:
>
>  stg move -t base <patches>     <=3D> stg sink <patches>
>  stg move -t <patch> <patches>  <=3D> stg sink -t <patch> <patches>
>  stg move -t current <patches>  <=3D> stg float <patches>
>
> Note the introduction of a new "curent" stg_id for the tip of the
> stack.

Ah, I wrote my suggested syntax above before reading yours. I like
mine better, though. :-)

> "-s [<series>]" would be allowed as an alternative to <patches>, so
> "move" would be a strict superset of "float".

Another useful option would be to have --interactive open up an editor
with the patch names in it; the user could rearrange the lines any way
she pleased, and when the editor exits, the patch series is rearranged
to match.

> If the target point is in $unapplied, then the command will be
> equivalent to "stg pop <patches>" with those patches reordered at
> the target (ie. no need to really execute steps 2 and 3 above).
> That's no rocket science, but a useful I have already missed, eg.
> when I just want to move the patches away from my working set
> (nowadays we could hide them, but that may not be always adequate).

Sounds very good.

> Opinions?

Lots, as you just saw. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
