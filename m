From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Wed, 7 May 2014 09:05:58 +0100
Message-ID: <20140507080558.GH23935@serenity.lan>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqd2fqcv7s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 10:06:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whwrt-0003we-Eg
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 10:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbaEGIGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 04:06:15 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:45017 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbaEGIGK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 04:06:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id BB6A9CDA5F2;
	Wed,  7 May 2014 09:06:09 +0100 (BST)
X-Quarantine-ID: <vVoLHiGHYewn>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vVoLHiGHYewn; Wed,  7 May 2014 09:06:08 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 13818CDA580;
	Wed,  7 May 2014 09:06:00 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqd2fqcv7s.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248290>

On Tue, May 06, 2014 at 05:01:59PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > I'd like to register my opposition to moving git-remote-{bzr,hg} out of
> > contrib/.
> >
> > I am not convinced that tools for interoperating with other VCSs need to
> > be part of core Git; as Junio has pointed out previously, while contrib/
> > was necessary ... Associated tools can
> > therefore live on their own and do not need to be promoted as part of
> > Git itself (as git-imerge is doing successfully).
> 
> Another thing to keep in mind is that we need to ensure that we give
> a good way for these third-party tools to integrate well with the
> core Git tools to form a single toolchest for the users.  I would
> love to be able to do
> 
>     $ (cd git.git && make install)
>     $ (cd git-imerge.git && make install)
> 
> and then say "git imerge", "git --help imerge", etc.  The same for
> the remote helpers that we may be splitting out of my tree into
> their own stand-alone projects.

This can already work given suitable installation.  With
git-integration[1] I can type `git help integration` and it shows me the
man page in the same way that `git help commit` does.  When I manually
linked the HTML file to the right place `git help -w integration` worked
as well.

> I _think_ it probably is OK for git-imerge.git/Makefile to peek into
> our Makefile, e.g.
> 
>     $ cd git-imerge.git
>     $ make GIT_SOURCE_DIR=../git.git install
> 
> to learn where imerge should install its subcommand implementation
> and documentation.  It might even want to borrow the test framework
> by using $GIT_SOURCE_DIR/t/test-lib.sh or somesuch.  There may be
> some changes the third-party tool authors would want to have in our
> Makefile to help them better when building their tools this way; I
> dunno.
> 
> I also think that there should be a way to make it really easy to
> install these third-party tools to augment the installed version of
> Git without having the source tree of Git.  We have ways for them to
> ask us where things are expected to be, e.g.
> 
>     $ git --html-path
>     $ git --man-path
>     $ git --exec-path
> 
> but I am not sure if these are enough, or if it would help them to
> add a bit more, then what these "a bit more" are.

I think this is enough - now I need to go and make git-integration's
Makefile use them by default rather than just using the same defaults as
git.git.

Perhaps it would be useful to have a skeleton "external Git utility"
project under contrib/ which could demonstrate best practice for
installing utilties that augment Git.

[1] http://johnkeeping.github.io/git-integration/
