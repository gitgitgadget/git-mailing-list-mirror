From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Sun, 29 Jul 2007 10:54:01 +0200
Message-ID: <85myxfzj2u.fsf@lola.goethe.zz>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz>
	<31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com>
	<20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org>
	<46896EF2.70006@vilain.net> <20070702215859.GA20597@thunk.org>
	<20070702221639.GB20597@thunk.org> <46898815.6030607@vilain.net>
	<20070703010955.GA5322@thunk.org> <85hcno287w.fsf@lola.goethe.zz>
	<20070729023854.GA17204@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 29 10:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF4Xm-0002jO-QP
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 10:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760651AbXG2Iy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 04:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760645AbXG2Iy0
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 04:54:26 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:44033 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755692AbXG2IyY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 04:54:24 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 9939131F106;
	Sun, 29 Jul 2007 10:54:22 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 88C0328EC4D;
	Sun, 29 Jul 2007 10:54:22 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-015.pools.arcor-ip.net [84.61.17.15])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 40AE930A9F3;
	Sun, 29 Jul 2007 10:54:22 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E54581CFF95E; Sun, 29 Jul 2007 10:54:01 +0200 (CEST)
In-Reply-To: <20070729023854.GA17204@thunk.org> (Theodore Tso's message of "Sat\, 28 Jul 2007 22\:38\:54 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3804/Sun Jul 29 06:09:31 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54095>

Theodore Tso <tytso@mit.edu> writes:

> On Sat, Jul 28, 2007 at 11:22:43AM +0200, David Kastrup wrote:

>> Ted, I think you are somewhat missing the main audience here.  The
>> main audience are people who actually _use_ Emacs, and those will
>> be comfortable with the concept "save to have changes persist,
>> don't save if you don't want changes to persist, exit using C-x #
>> or C-x C-c as appropriate".  Basically, it would appear that you
>> try figuring out how to make ediff appeal to non-Emacs users.  But
>> those would not have emacs/emacsclient in their EDITOR variable in
>> the first place.
>> 
>> I have been bitten by mergetool calling emacs rather than
>> emacsclient, resulting in a non-working merge (since the default
>> directory was set differently from what the call expected due to my
>> use of the desktop package), and mergetool afterwards assuming that
>> the not-even-started merge was successful.  A royal nuisance, and
>> completely unworkable.
>
> Emacsclient is a completely different problem, or at least adds a
> whole new dimention, compared to the ediff/emerge issue.  You can't
> run either emerge or ediff using the emacsclient in emacs21, since
> it lacks support for either the -e or the -f command-line option.

If the user asks for it, we should try giving it to him.  If
Emacsclient bombs out because of a non-understood option, one can
still fall back to calling a separate Emacs.

> All you can do in emacs21 when using eamcsclient is to request emacs
> to edit a file.

Yes, but emacsclient --version returns a version string, and
emacsclient will exit with an error if it can't get to understand the
command line options or to talk with Emacs.  So there are reasonably
ways to notice when to fallback.

> One of the problems with emacs is that it is so customizable that
> people can set up emacs in such a way that different ways of
> launching emacs may lead to surprises, thanks to their .emacs21.
> This makes supporting emacs based merging clients to be highly
> problematic.  Use of the desktop package is one way in which things
> can be quite surprising.  Worse yet, the desktop package is only in
> emacs22 and up.

The desktop package has already been in Emacs 21, so it is not exactly
a new problem but has been round for more than 7 years.

> (And emacs 22 was *just* released, not all that long ago; many
> people may still be using emacs21).  So if we use emacs --no-desktop
> to disable the desktop package, it will cause emacs21 to complain
> about an unknown option.  Joy.

Correct: the --no-desktop option is new.

> Which means that to avoid running into problems with emacs22 users
> who are using the desktop package, git-mergetool is going to have to
> find out in advance whether emacs21 or emacs22 (or an emacs
> development 23.0.0 snapshot) is in use; on a debian system you can
> have 3 or 4 emacs installed simultaneously.  What fun.

$EDITOR --version

> In any case, the main issue is that there is an emerging (sorry)
> standard about how merge tools are supposed to work, in terms of
> being able to support 2-way or 3-way merges, about being able to
> specify which file (and which file only, in the best case) should be
> used as the output file as the result of the merge, and about how
> tools can signal either a successful merge, or a request by the user
> to abort the merge becuase things didn't work out for one reason or
> another.
>
> The problem is that ediff doesn't really fit this model.

Emacs is an editor.  If we can't make an editor fit into merge
resolution, we have a design problem.  It is a matter of convenience
that the editor is called with some initial files and something like
ediff-whatever, but the end result clearly should be that the user
writes the file if he wants changes to persist, and doesn't if
doesn't.

> For people who really want to live their life in emacs, and using
> emacs as their desktop (not for me, but maybe for some folks), maybe
> it would be better for those folks to simply build a
> git-mergetool.el that ran 100% in emacs, instead of trying to shift
> back and forth between the command-line and emacs, would make
> everyone happier.  Right now git-mergetool needs to ask questions
> about the disposition of symlinks, permission changes, etc.  If it
> is done as a git-mergetool.el which is tied into git.el and ediff,
> it could be a lot more seamless.

But this is no reason not to fix the currently broken behavior.  If
you insist that "emerge" or "ediff" is _not_ to be used as an editor,
but rather as a special-purpose mergetool for the sake of git, then
the only logical conclusion can be to call it with "-q", bypassing any
user initialization.

I believe this would be a mistake at least when $EDITOR points to
Emacs, because this means the user is used to using Emacs/Emacsclient
as _editor_, and anything else would be _confusing_.

>> While it may be nice to have some Lisp preparation for people who
>> don't want to touch or learn Emacs _except_ for using it for
>> merging in git, I think we should first cater to people actually
>> using Emacs already.
>
> Catering to the hard-core Emacs folks is *hard*.

Saving a desktop session is not hard-core.  Using emacsclient is not
hard-core.  Those are standard, basic, use cases.

> I knew someone who had PDP-10 assembly language in their .emacs.el
> file, and one day his custom emacs extension worked again when he
> started playing with the KLH10 PDP-10 emulator, and reused his
> .emacs.el startup file there....

Can we get another strawman a bit closer to the main road, please?

> Of course, at some level folks like that will always need to fend
> for themselves.

Yes.  I am not talking about people breaking things by code of their
own.  I am talking about a _standard_ setup being broken by git.

> As I said earlier, I don't have a huge objection to support ediff in
> some degraded mode (I think the UI is ghastly bad), if users
> explicitly request it, but I would *not* want to make it the default
> and spring it on some unsuspecting user.  Quite frankly, right now
> the KDE and GNOME tools are way better either emerge or ediff, so
> they are only really useful as a default in the terminal-only case.

Again, you fall into the trap of not allowing others to have a life
and Emacs outside of git's preconceptions.  emerge and ediff might be
worse for people who would not use Emacs for anything but merging.
But one advantage of Emacs is that I can look at all sorts of other
files and buffers and information sources _while_ I am merging, and
declare the merge finished when _I_ want it (signaled by exiting
either Emacs or Emacsclient), not when some arbitrary command thinks
it finished.

Emacs is one of the most flexible tools ever.  Disallowing any editing
use not foreseen and sanctioned by git-mergetool is _always_ going to
lead to trouble.  If you do _anything_ like this, you _must_ call
Emacs -q in order to omit _any_ user initializations you did not
foresee.  But this will also kill user-specific major modes which he
might want to use for visualizing files.  It will be less onerous than
having all hell break lose because you can't cater for even standard
initializations or setup, but it will still be a nuisance.

So please don't try crippling Emacs into a git-only tool.  Call it
with the files in question, give it an appropriate initial command to
work with if possible, and leave the rest to the user.  He will save
and finish, or not save and finish, which is the way of an editor to
communicate with its environment.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
