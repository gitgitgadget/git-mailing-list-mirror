From: Jeff King <peff@peff.net>
Subject: Re: Problem with git bundle.
Date: Wed, 30 Mar 2011 16:18:19 -0400
Message-ID: <20110330201819.GB30663@sigill.intra.peff.net>
References: <1301488591248-6222619.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: mav007ar <mav007ar@yahoo.com.ar>
X-From: git-owner@vger.kernel.org Wed Mar 30 22:18:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q51qh-0004Ne-Dq
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 22:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894Ab1C3USY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 16:18:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52222
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932884Ab1C3USX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 16:18:23 -0400
Received: (qmail 21429 invoked by uid 107); 30 Mar 2011 20:19:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Mar 2011 16:19:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2011 16:18:19 -0400
Content-Disposition: inline
In-Reply-To: <1301488591248-6222619.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170421>

On Wed, Mar 30, 2011 at 05:36:31AM -0700, mav007ar wrote:

> Hi everyone. I am using git-svn and I want transfer a repository using git
> bundle create ...
> Does anyone has the right steps to perform this task?
> Currently I'm doing the following.
> 
> 1- git bundle create  --all
> 2- git clone 
> 3- cd into repository's directory just created.
> 4- Add [svn-remote "svn"]
>         url = https://svn.swacorp.com/svn/commerce/trunk/commerce-project
>         fetch = :refs/remotes/git-svn
> into the .git/config file.
> 5- git svn fetch svn.
> 
> The problem is when I do the last step, I get ALL revisions with out
> considering the revision included into the bundle.

Clone will only clone what's in refs/heads of the bundle. In your case,
you also want the refs/remotes/git-svn branch (which is probably the
same as the "master" you bring across in the bundle).

So you could do this in the cloned repo:

  git update-ref refs/remotes/git-svn master

And then your svn fetch should be much faster.

But note that git-svn also keeps some magic cache in .git/svn. If you
bring that information across, too, the initial fetch would probably be
faster. So I really wonder if what you want instead of bundle is to
simply tar up the .git directory of the original repo and copy the whole
thing to your destination.

-Peff
