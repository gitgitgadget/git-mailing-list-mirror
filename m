From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: submodules, was Re: RFC: display dirty submodule working 
	directory in git gui and gitk
Date: Mon, 4 Jan 2010 13:29:27 -0500
Message-ID: <32541b131001041029t5adc535bt9681d33174042871@mail.gmail.com>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> 
	<61083.85.16.196.198.1262601871.squirrel@archive.darksea.de> 
	<alpine.DEB.1.00.1001041157020.3695@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 19:29:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRrgf-0002t8-VP
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 19:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab0ADS3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 13:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753576Ab0ADS3s
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 13:29:48 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:33376 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab0ADS3r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 13:29:47 -0500
Received: by yxe26 with SMTP id 26so14798837yxe.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 10:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=y5heUmqKiOAQeqHbPAFtXb2AcS53lNZl2ekDLqGajdU=;
        b=SIAAPsJj0Azk364ehp9dup92qttCbHw4l8bw7LnCQr8DPn/+DzUEr0DDXYYj4chzy+
         xTb1My4YeLNcFTjPxsSp0JfhobqYDYq8P7lXvKZjPX4MMlG1sM2VKAuDrWpk0w+TZARD
         Zqxs2aztEv767lovtdEjbIAAWsXrzr1qzTHjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HzIPXE/QqjAahzKAxalWoyZw5mm93cWOyIu78mC9rBCbC0R2clf8W+TGWZqDZMg68z
         3HvXHXTUpp/6tpNwOPlQaXxEFKcuzLQ0P3ceWG0I63+obKT1zw6y5+yLGRCW8zdme7sx
         Ed1bwqBGXDbT3I+zsYm7AzROCePrSvapQcouE=
Received: by 10.150.28.42 with SMTP id b42mr26539717ybb.138.1262629787067; 
	Mon, 04 Jan 2010 10:29:47 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001041157020.3695@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136133>

On Mon, Jan 4, 2010 at 6:46 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> But I think that an important precondition to come up with a better design
> of the submodules is to have suffered the current implementation in
> real-world work using submodules. (Which reminds me very much of the
> autocrlf mess.)

I suffered the current implementation, which is why I wrote
git-subtree :)  I'm still suffering, though; git-subtree works much
better for my own use cases, but after some experience with it, I'm
still not totally happy.

For me one big problem comes down to producing accurate output for
'git log'.  git submodules assume that the history inside the module
is entirely separate (you need to run multiple 'git log' instances to
see the full history); git-subtree assumes that it's entirely
integrated.  In that sense, git-subtree is somewhat more in line with
the core principle of git (we track the history of "the content", not
any particular file or subdir).  Unfortunately, it also exposes a
problem with that core principle: taken to its extreme, "the content"
includes all data in the universe.  And while git could branch and
merge the universe very efficiently in about O(log n) time, 'git log'
output gets less useful about O(n) with the size of the tree.

Neither git-subtree nor git submodules seem to help with this "log
pollution" problem very much - but I don't know what to do that would
be better.

Outside of this, my major problem with submodules is they use separate
work trees and repositories, and thus require lots of extra
housekeeping to get anything done.  I'd be much happier if submodules
would share the same objects/packs/.gitdir/refs/indexfile as the
superproject, and the *only* thing special about them would be that
the superproject's tree points at a commit object instead of a tree
object.  In other words, I think the actual repo format is correct
as-is, but the tools surrounding it cause a lot of confusion.

Imagine if cloning a superproject also checked out the subproject
transparently, and committing dirty data inside the subproject's tree
created a new commit object for the subproject, then tacked that
commit object into the superproject's index for a later commit
(exactly as changing a subdir creates a new tree object that the
parent directory can refer to).

This doesn't solve some use cases, however, such as ones where people
really don't want to check out (or even fetch) the contents of some
submodules, even when they check out the superproject.  The current
implementation *does* handle that situation.  I'm not sure how many
people rely on that behaviour, though.  (And maybe the correct
solution to *that* is proper support for sparse clone/checkout
regardless of submodules.)

Have fun,

Avery
