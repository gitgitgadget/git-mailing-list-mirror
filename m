From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Mon, 5 May 2014 19:45:46 +0100
Message-ID: <20140505184546.GB23935@serenity.lan>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 19:03:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi76-0006KZ-5g
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbaEESzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 14:55:38 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:58729 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbaEESzh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 14:55:37 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 May 2014 14:55:37 EDT
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 925AE606539;
	Mon,  5 May 2014 19:45:52 +0100 (BST)
X-Quarantine-ID: <J-7RAgKF6xV5>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id J-7RAgKF6xV5; Mon,  5 May 2014 19:45:51 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id E6E366064E8;
	Mon,  5 May 2014 19:45:48 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248167>

On Tue, Apr 29, 2014 at 03:38:07PM -0700, Junio C Hamano wrote:
> * fc/remote-helpers-hg-bzr-graduation (2014-04-29) 11 commits
>  - remote-hg: trivial cleanups
>  - remote-hg: make sure we omit multiple heads
>  - git-remote-hg: use internal clone's hgrc
>  - t: remote-hg: split into setup test
>  - remote-hg: properly detect missing contexts
>  - remote-{hg,bzr}: store marks only on success
>  - remote-hg: update to 'public' phase when pushing
>  - remote-hg: fix parsing of custom committer
>   (merged to 'next' on 2014-04-22 at fed170a)
>  + remote-helpers: move tests out of contrib
>  + remote-helpers: move out of contrib
>  + remote-helpers: squelch python import exceptions
> 
>  Move remote-hg and remote-bzr out of contrib/.  There were some
>  suggestions on the follow-up fix patches still not in 'next', which
>  may result in a reroll.
> 
>  Will merge to 'next' and keep it there for the remainder of the
>  cycle.

I'd like to register my opposition to moving git-remote-{bzr,hg} out of
contrib/.

I am not convinced that tools for interoperating with other VCSs need to
be part of core Git; as Junio has pointed out previously, while contrib/
was necessary for promoting associated tools when Git was young and had
not established mindshare, Git is now by far the most popular DVCS and
is rapidly catching up with centralized systems.  Associated tools can
therefore live on their own and do not need to be promoted as part of
Git itself (as git-imerge is doing successfully).

In the case of git-remote-hg specifically, the remote helper has to use
an interface that the Mercurial developers consider unstable [1]; the
version currently on 'pu' fails the test suite for me because I have
Mercurial 3.0:

	AttributeError: 'mqrepo' object has no attribute 'getbundle'

I do not want to end up in a situation where an update to Git is blocked
by a distribution because git-remote-hg is not updated to support newer
versions of Mercurial sufficiently quickly; this previously happened in
Gentoo due to git-svn and meant that was stuck on 1.7.8 until 1.7.13 was
released [2].

Since the remote helper interface is stable and the remote helpers do
not use any of the Git internals, I consider the risks of including them
in core Git to outweigh the benefits of wider distribution.  In fact,
the remote helpers may benefit from having their own release cadences
so that they can respond to changes in related projects more quickly
than the normal Git release cycle.


[1] http://mercurial.selenic.com/wiki/MercurialApi#Why_you_shouldn.27t_use_Mercurial.27s_internal_API
[2] https://bugs.gentoo.org/show_bug.cgi?id=418431
