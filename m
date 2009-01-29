From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 06:37:36 -0500
Message-ID: <20090129113735.GA6505@coredump.intra.peff.net>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129035138.GC11836@coredump.intra.peff.net> <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 12:39:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSVEy-0003RQ-V2
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 12:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674AbZA2Lhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 06:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbZA2Lhk
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 06:37:40 -0500
Received: from peff.net ([208.65.91.99]:58586 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbZA2Lhj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 06:37:39 -0500
Received: (qmail 6755 invoked by uid 107); 29 Jan 2009 11:37:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 06:37:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 06:37:36 -0500
Content-Disposition: inline
In-Reply-To: <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107658>

On Thu, Jan 29, 2009 at 12:27:23PM +0100, Sverre Rabbelier wrote:

> I thought instead we wanted to support the following workflow:
> 
> $ (cd child && echo content >file && git add file && git commit -m one)
> [normal commit output]
> 
> Which is what the testcase tests. E.g., we want to support cloning an
> empty repo so that the user can then _push_ to that repository to make
> it non-empty, no?

True, that is probably going to be more common (otherwise, why would the
person who is going to push into the empty repo advertise it to you
before they have put any content in it).

But it will probably still be surprising not to have the branch merging
setup:

  mkdir parent && (cd parent && git init) &&
  git clone parent child && cd child &&
  echo content >file && git add file && git commit -m one &&
  git push origin master ;# note we have to explicitly mention the branch

  ... time passes ...

  git pull

produces the "you haven't asked me which branch to merge" message.

Which does make some sense, given how tracking configuration is set up.
It's just that it's a little sad that cloning an empty repository and
then later getting commits out of it (whether commits you put in or
somebody else) does not behave the same as cloning a repository with
commits.

Which I thought was sort of the point, that this would work seamlessly.
Otherwise, there is not much advantage over:

  mkdir parent && (cd parent && git init) &&
  mkdir child && cd child && git init &&
  echo content >file && git add file && git commit -m one &&
  git push origin master ;# note we have to explicitly mention the branch

With the empty clone, you get your "origin" remote set up, but in both
cases you are missing the branch tracking.

I don't know if there is a good solution, though. Perhaps it's best to
just let what's there get released and see if people complain.

-Peff
