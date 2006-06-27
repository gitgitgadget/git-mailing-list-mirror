From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of some adhocery
Date: Tue, 27 Jun 2006 21:52:21 +1200
Message-ID: <46a038f90606270252p2beac88bo3cf7aa8d3845450c@mail.gmail.com>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>
	 <Pine.LNX.4.63.0606270038200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <46a038f90606261550p145b20a6gbe960e0abc16e8a4@mail.gmail.com>
	 <Pine.LNX.4.63.0606270057260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <44A06A8D.7080202@catalyst.net.nz>
	 <Pine.LNX.4.63.0606271016450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 27 11:52:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvAF9-0000HQ-FY
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 11:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWF0JwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 05:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWF0JwY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 05:52:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:41402 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750749AbWF0JwX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 05:52:23 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2494442ugf
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 02:52:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PVKQ1SxIn+JPFSgzHejPtgovsru5f3yyLKr7oZHw+7sl5rwBZwLxKz7M6+uX7GAMHLr56rIX1uUijZI7TiXmUAjir+upi+O6SC2VT4afrGcxcQ5YupVdgMwfv3WlXKrPbKZT2K39obEW1uIrM0QhGasA5fZxVzy+KvfzHGaKvNY=
Received: by 10.78.177.11 with SMTP id z11mr2438563hue;
        Tue, 27 Jun 2006 02:52:22 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Tue, 27 Jun 2006 02:52:21 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606271016450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22720>

On 6/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> I just cloned your repo, and as far as I can tell, the latest commit is on
> June 23rd. So your numbers should be the same as mine. But not all are.

Taht repo is on a machine at work, but it's possible that I've cherry
picked a new commit onto master that isn't on the publc repo yet.

> The problem I see: from the 53 non-merges in nzvleportfolio (who makes up
> your branch names anyway?), there are two already in upstream: e3f56c and
> 7e448c5c. So it really should be 51.
>
> >   $ git-rev-list svnhead..master  | wc -l
> >   61
>
> Same on my repo.

And if you add --no-merges it'll give you 51 or 52, depending...

> >   $ ~/local/git/git-format-patch.sh  -o .patchesold svnhead master
> >   ...
> >   $ ls .patchesold | wc -l
> >   52
>
> I guess this propagates from git-cherry. (Did not test here, since I do
> not have an old git-format-patch.sh handy, and am too lazy to get the last
> version from my git repo.)

I think I did something like

  git-cat-file blob v1.3.3:git-format-patch.sh > git-format-patch.sh
  chmod ugo+x git-format-patch.sh

> But anyway, looking at your numbers I take it that the new format-patch
> with --ignore-if-in-upstream has the same output as the old format-patch,
> right?

It does, but it may be "right" even though it's not realising that
some of the patches were cherry picked. git-cherry doesn't either. So
that algorythm isn't so hot in this case :-/

I jumped to conclusions earlier because I called git format-patch with
the old syntax (theirs ours) and it gave me 186 patches, which may
very well be the whole repo history, like it did earlier with git
itself. I thought that 186 were the patches pending, and that
git-cherry was cutting that to 52. Not so: it was a syntax issue.
Sorry about the noise!

cheers,



martin
