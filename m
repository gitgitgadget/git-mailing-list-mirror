From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] submodule: Demonstrate known breakage during recursive
	merge
Date: Wed, 24 Aug 2011 21:46:18 +0200
Message-ID: <20110824194618.GD45292@book.hvoigt.net>
References: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com> <20110824191438.GA45292@book.hvoigt.net> <7vty96obo9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 21:46:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwJP7-0004s5-Kf
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 21:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab1HXTqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 15:46:21 -0400
Received: from darksea.de ([83.133.111.250]:59563 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750767Ab1HXTqU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 15:46:20 -0400
Received: (qmail 5383 invoked from network); 24 Aug 2011 21:46:18 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 24 Aug 2011 21:46:18 +0200
Content-Disposition: inline
In-Reply-To: <7vty96obo9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180030>

On Wed, Aug 24, 2011 at 12:24:22PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > ... Its a
> > little bit workaroundish so if anymore has an idea how to fix this in
> > nicer way, please tell me.
> >
> > [1]--8<----
> > From: Heiko Voigt <hvoigt@hvoigt.net>
> > Subject: [PATCH] protect submodule merge search against multiple calls for
> >  the same path
> >
> > When multiple merge-bases are found for two commits to be merged the
> > merge machinery will ask twice for a merge resolution. Currently its not
> > possible to use the revision-walking api for walking the same commits
> > multiple times.
> 
> I have been suspecting that most of this should be done in a separate
> helper program that is run via run_command() interface, without
> contaminating the object pool the main merge process has with data from
> the submodule object store to begin with (i.e. add_submodule_odb() and
> everything below should go). Wouldn't it be a lot cleaner solution?

Hmm, I would like to keep it in process. Since there are platforms where
spawning new processes is very slow. If just the revision-walking is an
issue: I am currently working on extending it to be able to walk again,
because we also need that for the recursive push series.

But even if we are able to search twice or more (in or out process) we
would give the advice that there are multiple possible resolutions
for each merge base. For the merge search we do not take the bases into
account so the outcome will not change. So what I think would be
cleaner (also UI wise) is to remember whether we already gave advice and
not do it a second time.

Cheers Heiko
