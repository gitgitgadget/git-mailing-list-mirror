From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 7 Jul 2008 08:21:49 +0200
Message-ID: <20080707062142.GA5506@jhaampe.org>
References: <20080701150119.GE5852@joyeux> <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de> <20080706160758.GA23385@jhaampe.org> <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 08:23:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFk7l-00007s-O4
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 08:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbYGGGV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 02:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbYGGGV7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 02:21:59 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:56331 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYGGGV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 02:21:59 -0400
Received: from jhaampe.org (p5B3CCD36.dip.t-dialin.net [91.60.205.54])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id 317F53316E;
	Mon,  7 Jul 2008 08:21:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Mon Jul  7 08:21:56 2008 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.047516, queueID=2E55E33170
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87583>

> IOW the mail body should look like the output of format-patch, optionally 
> some comments between "--" and the diffstat.
> 
> Write a patch for SubmittingPatches.
I shall do that :)

> > > Not yet.  Will test/comment when the spurious "fetch" is fixed.
> >
> > I thought that the only thing that 'fetch' does is update FETCH_HEAD.
> 
> Uhoh.  'fetch' fetches.  Which means it does not only update something.

Yes, it fetches objects (admittedly, it updates something on the current
partition), but AFAIK does not change the state of the repository. So I thought
that it could be considered as a no-op from the repo point of view. The idea
behind the 'fetch' thing was to get the latest objects from the repository,
therefore being able to know the relationship between the currently committed
submodule state 

> There are three states that are interesting:
> 
> - the committed submodule state:
> 
>   You get this in the superproject by "git ls-tree HEAD -- <dir>"
> 
> - the local HEAD of the submodule:
> 
>   (cd "<dir>" && git rev-parse --verify HEAD)
> 
> - the HEAD of the default branch of the upstream repository of the 
>   submodule:
> 
>   (cd "<dir>" && git ls-remote origin HEAD)
>   NOTE: this does not have to do _anything_ with the submodule: you can 
>   easily have two independent branches (see "html" and "next" in git.git), 
>   and the submodule is free to be pinned to whatever commit is available
>   in the upstream repository.
>
>   It is even possible that it is pinned to a commit that is only reachable 
>   from a tag, not from a branch.
Then when you initialize your submodules it will be unable to fetch the commit
object, isn't it ? Since git-submodule clones origin/HEAD, the submodule state
committed in the repository must be reachable from origin/HEAD.

Or the third interesting state is not "the default branch of the upstream
repository of the submodule", i.e.  origin/HEAD, but the
most-probably-interesting-branch, i.e. the branch configured in .git/config as
being fetched for the current branch of the local submodule HEAD.

That is the point of this patch. It make clear, *for all registered submodules*,
what is the current relationship between the current submodule state committed
in the repository and the current submodule HEAD. The "fetch" is there to take
into account the fact that the submodule state may not yet be available locally.

Best,
--
Sylvain
