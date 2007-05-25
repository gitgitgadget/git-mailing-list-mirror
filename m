From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGIT and conflicts
Date: Fri, 25 May 2007 14:45:58 +0200
Message-ID: <20070525124558.GA11096@diana.vm.bytemark.co.uk>
References: <20070524164038.GA27661@diana.vm.bytemark.co.uk> <b0943d9e0705250300o419d1d7ld175b273dbed2429@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 13:51:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrYKe-0007cS-W6
	for gcvg-git@gmane.org; Fri, 25 May 2007 13:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbXEYLvZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 25 May 2007 07:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753339AbXEYLvZ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 07:51:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1400 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbXEYLvY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 07:51:24 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HrZB8-0002zo-00; Fri, 25 May 2007 13:45:58 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0705250300o419d1d7ld175b273dbed2429@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48362>

On 2007-05-25 11:00:33 +0100, Catalin Marinas wrote:

> On 24/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > The current behavior of StGIT is to not use the index for
> > conflicts like git does. What advantages does this have that are
> > great enough to motivate a deviation from the git behavior?
>
> I don't think there are any advantages in deviating from the git
> behaviour, only that when I first implementing it, git didn't have
> any smarter behaviour and I used diff3 (or other external merger,
> which can be used right now as well).
>
> I'm not sure if git-diff still works when there are conflicts in the
> index. The current stg behaviour is to reset the index to the base
> of the patch and a stg diff would show the diff (including the
> config markers) to the base. I find this quite handy.

To be honest, I'm not very well versed in how git handles merge
conflicts -- with all the nontrivial projects I touch, I use StGIT for
everything that can conflict. :-) Grepping for "conflict" in the user
manual brings up a very good explanation, though; and to answer your
question: it seems to work very well indeed, surprise surprise. You
can make the diff show anything you want, including between the patch
base and the working dir. Though, as the manual points out, the most
important view is probably between index and working tree, which shows
you just the not-yet-fixed conflicts.

Step one would be to simply stop messing with the index after merges,
and just let "stg resolved" mean "git add".

Step two (somewhat more ambitious) might be to stop trying to hide the
index, by providing a flag to "stg refresh" to make it refresh only
what's in the index, and not everything -- that is, to make it do what
"git commit" does when _not_ given the -a flag. And once we stop
hiding the index, there's no point in having StGIT commands to do
things like add, remove, and so on -- we could just use what git
provides.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
