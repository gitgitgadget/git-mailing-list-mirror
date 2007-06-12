From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 14:05:08 +0200
Message-ID: <200706121405.08357.Josef.Weidendorfer@gmx.de>
References: <20070611225918.GD4323@planck.djpig.de> <200706121145.22699.Josef.Weidendorfer@gmx.de> <8c5c35580706120323t52b0d095v6ab6013ee2c8fdea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 14:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy586-0007hp-81
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 14:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbXFLMFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 08:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754257AbXFLMFP
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 08:05:15 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:38557 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755385AbXFLMFO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2007 08:05:14 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id 05A91229A;
	Tue, 12 Jun 2007 14:05:13 +0200 (MEST)
User-Agent: KMail/1.9.7
In-Reply-To: <8c5c35580706120323t52b0d095v6ab6013ee2c8fdea@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49951>

On Tuesday 12 June 2007, Lars Hjemli wrote:
> If you're thinking about the detached HEAD: yeah, that's a problem. My
> initial plan (with later modifications) was something like this:
> 
> ...
> 
> $ git-submodule update
>   git-clone --bare git://example.com/lib.git .git/submodules/lib.git
>   git-clone -l -s -n .git/submodules/lib.git lib1
>   (cd lib1 && git-checkout $sha1)
>   git-clone -l -s -n .git/submodules/lib.git lib2
>   (cd lib2 && git-checkout $sha2)
> ...

That looks fine to me.
 
> git-submodule push:
>   (cd lib1 && git-push origin $branch1)
>   (cd lib2 && git-push origin $branch2)

This could be problematic. You are only storing changes on the
given branch. Ah, you wanted to avoid this problem with the symlink?

Perhaps we need better support for "push all reachable objects
which are not on the remote side together with any branch tip changes".
Or is this somehow already available with git-push?

Or ...

> I thought I could avoid 'git-submodule push' by using symlinks, but
> you're right. It will not work. Back to the drawing board (again...)

... we revive the "lightweight checkout" idea: share everything
but index and HEAD with a given repository. Similar to
"contrib/workdir/git-new-workdir" but witt support in git-core
to avoid the need for symlinks.

> > A workaround for problem (1) would be to create multiple checkouts of the
> > same submodule if modified, e.g. in .git/submodule/$name/$sha1 .
> 
> And the $sha1 would be the sha1 found in the index? I don't think this
> would work either. If two branches in the superproject checkout the
> same submodule sha1, you could possibly want to keep different changes
> in the submodule depending on which branch of the superproject is
> checked out.

OK, does not work.

> > Allowing people to work like that is nice, but it should not be forced.
> > It would also be nice to allow the user to specify another place where
> > submodule checkouts are to be stored, e.g. when multiple supermodules
> > share the same submodule.
> 
> True. Maybe submodule.<name>.repopath in .git/config? (If not
> specified, default to .git/submodules/<name>.git)

Sounds good. However, can be done later.

Josef

> 
> --
> larsh
>
