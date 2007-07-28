From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Sat, 28 Jul 2007 11:22:43 +0200
Organization: Organization?!?
Message-ID: <85hcno287w.fsf@lola.goethe.zz>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz> <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com> <20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org> <46896EF2.70006@vilain.net> <20070702215859.GA20597@thunk.org> <20070702221639.GB20597@thunk.org> <46898815.6030607@vilain.net> <20070703010955.GA5322@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 11:23:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEiW4-00016s-01
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 11:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbXG1JXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 05:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbXG1JXM
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 05:23:12 -0400
Received: from main.gmane.org ([80.91.229.2]:56688 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbXG1JXL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 05:23:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IEiVx-0000vA-1m
	for git@vger.kernel.org; Sat, 28 Jul 2007 11:23:09 +0200
Received: from dslb-084-061-039-045.pools.arcor-ip.net ([84.61.39.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 11:23:09 +0200
Received: from dak by dslb-084-061-039-045.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 11:23:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-039-045.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:tDLE3x6uadRiOiwBxXdGHqyFDsA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54018>


[Picking up an old thread]

Theodore Tso <tytso@mit.edu> writes:

> On Tue, Jul 03, 2007 at 11:19:49AM +1200, Sam Vilain wrote:
>
> Hmm, well, here's a way of fixing it.  (See attached, below.)  It
> adds a new command 'x', which when you hit it in the ediff control
> window, exits with a error status of '1', indicating that the merge
> has failed.  This is something which emerge, kdiff3, tkdiff, et. al
> all support; but which ediff doesn't.
>
>> I still don't really understand why having to save the merged buffer and
>> exit is such a huge issue.  Already I have to select "-t emerge" to get
>> emerge.  I would have thought it would be better to just make the other
>> mode available, and let the user figure it out.
>
> I'm just exploring alternatives.  Basically, it just seems
> interesting that ediff has a lot of nice features, but also has some
> incredibly user-hostile features.  The first time I tried using
> ediff, I indeed tried saving the buffer and exiting it.  That's when
> I discovered that after I changed the focus to the merge window and
> saved it, when I tried typing ^X^C, the exit failed with the error
> message "Attempt to delete a surrogate minibuffer frame".  That's
> the sort of thing that will cause non-elisp programmers to run
> screaming off into the distance.

Ted, I think you are somewhat missing the main audience here.  The
main audience are people who actually _use_ Emacs, and those will be
comfortable with the concept "save to have changes persist, don't save
if you don't want changes to persist, exit using C-x # or C-x C-c as
appropriate".  Basically, it would appear that you try figuring out
how to make ediff appeal to non-Emacs users.  But those would not have
emacs/emacsclient in their EDITOR variable in the first place.

I have been bitten by mergetool calling emacs rather than emacsclient,
resulting in a non-working merge (since the default directory was set
differently from what the call expected due to my use of the desktop
package), and mergetool afterwards assuming that the not-even-started
merge was successful.  A royal nuisance, and completely unworkable.

While it may be nice to have some Lisp preparation for people who
don't want to touch or learn Emacs _except_ for using it for merging
in git, I think we should first cater to people actually using Emacs
already.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
