From: Jeff King <peff@peff.net>
Subject: Re: need to create new repository initially seeded with several
 branches
Date: Wed, 31 Aug 2011 12:54:05 -0400
Message-ID: <20110831165405.GB4356@sigill.intra.peff.net>
References: <1314804325568-6746957.post@n2.nabble.com>
 <sDZ5pnWzh3ZbFYS6GK-NcPdn09kF53MJ2eRkBnzInzdL8-cvCiF5beUw2k9Pz6BTq-Y3i_XwpYfgTOvXNlP1vPjLSHJ6FIzxL0jN1W0d0M8@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "ryan@iridiumsuite.com" <ryan@iridiumsuite.com>,
	git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 31 18:54:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyo3M-0005DM-DD
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 18:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756872Ab1HaQyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 12:54:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58937
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756808Ab1HaQyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 12:54:09 -0400
Received: (qmail 4627 invoked by uid 107); 31 Aug 2011 16:54:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Aug 2011 12:54:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2011 12:54:05 -0400
Content-Disposition: inline
In-Reply-To: <sDZ5pnWzh3ZbFYS6GK-NcPdn09kF53MJ2eRkBnzInzdL8-cvCiF5beUw2k9Pz6BTq-Y3i_XwpYfgTOvXNlP1vPjLSHJ6FIzxL0jN1W0d0M8@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180487>

On Wed, Aug 31, 2011 at 11:14:48AM -0500, Brandon Casey wrote:

>    git checkout -b devel &&  # make a new branch named "devel"
>                              # which has the same state as the
>                              # currently checked out branch: "master"
>                              # i.e. devel and master point to the
>                              # same tip commit.
>    rm -rf * &&               # remove the files in the working dir
>    cp -a $devel_dir/* . &&   # cp devel source code to working dir
>    git add -A . &&           # add new/removed files to the index
>                              # to be committed on next 'git commit'
>    git commit
>    # use editor to give descriptive commit message
> 
> Repeat for your topic branch based off of devel.

I am probably just going to confuse the original poster more, but here
is how I would do it. It's slightly more efficient, as it doesn't
involve removing and copying files for the intermediate states:

  # make a repo and switch to it
  git init repo && cd repo

  # and now add everything from the "master" version, and
  # make a commit out of it
  GIT_WORK_TREE=/path/to/master git add -A
  git commit

  # now make the devel branch and do the same
  git checkout -b devel
  GIT_WORK_TREE=/path/to/devel git add -A
  git commit

  # and then check out the result in the working tree of
  # your newly created repo
  git checkout -f

-Peff
