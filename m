From: Jeff King <peff@peff.net>
Subject: Re: Minor bug report
Date: Wed, 3 Jun 2015 02:20:05 -0400
Message-ID: <20150603062005.GA20580@peff.net>
References: <CAMOUyJ_2snCaKcWNoOgH7aoHrdbUsCucqu_W_J3aH9_QQe1jEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tummala Dhanvi <dhanvicse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:20:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z022M-0007RH-BJ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbbFCGUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:20:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:40186 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753753AbbFCGUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:20:09 -0400
Received: (qmail 5605 invoked by uid 102); 3 Jun 2015 06:20:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 01:20:08 -0500
Received: (qmail 16467 invoked by uid 107); 3 Jun 2015 06:20:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 02:20:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 02:20:05 -0400
Content-Disposition: inline
In-Reply-To: <CAMOUyJ_2snCaKcWNoOgH7aoHrdbUsCucqu_W_J3aH9_QQe1jEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270630>

On Wed, Jun 03, 2015 at 11:24:19AM +0530, Tummala Dhanvi wrote:

> When we do create a new empty git repo using git init or create a
> orphan branch and do a git log then I am getting an error saying that
> fatal: bad default revision 'HEAD'
> 
> Well the error should have been something like no commits to show
> either the branch is orphan / you didn't make any commits in the new
> repo
> 
> I would like to fix the trival bug myself can some one point me in the
> right direction to fix it

Here are some prior discussions:

  http://thread.gmane.org/gmane.comp.version-control.git/75692

  http://thread.gmane.org/gmane.comp.version-control.git/200504

I just skimmed through them, but I expect the most desirable solution
would involve:

  1. We still die(), but just improve the error message (so we don't
     have any regressions for people expecting "git log" to fail).

  2. We use the message only when pointing to an unborn branch, and not
     on other errors. The simplest way to do this is probably to make an
     extra call to resolve_ref() in the error code-path.

-Peff
