From: Jeff King <peff@peff.net>
Subject: Re: post-checkout hook not run on clone
Date: Mon, 2 Mar 2009 23:28:49 -0500
Message-ID: <20090303042848.GC18136@coredump.intra.peff.net>
References: <20273.1236033817@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 05:30:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeMH3-0007iW-3y
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 05:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbZCCE26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 23:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbZCCE26
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 23:28:58 -0500
Received: from peff.net ([208.65.91.99]:45037 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbZCCE25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 23:28:57 -0500
Received: (qmail 12213 invoked by uid 107); 3 Mar 2009 04:28:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 02 Mar 2009 23:28:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Mar 2009 23:28:49 -0500
Content-Disposition: inline
In-Reply-To: <20273.1236033817@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111993>

On Mon, Mar 02, 2009 at 02:43:37PM -0800, layer wrote:

> I realize this might be a feature, but when I switch to the master
> branch with "git checkout master" it is, and I would think that a
> clone that gets the master branch would also does a sort of "checkout
> master" and would run the hook.

Right. Hooks are not cloned with the repo.

> In any case, I'd be happy of there was a post-clone hook, instead, but
> there isn't.

The general wisdom on the list is that it's a bad idea to run remote
code arbitrarily for security reasons (i.e., "git clone
git://host/foo.git" should not automatically run code from "host"). Even
if you are going to build and run the contents of "foo.git", you at
least have a chance to inspect the changes via git.

However, for situations where you are OK implicitly trusting the remote,
it is obviously less convenient.

> Any suggestions?

Most suggestions I have seen involve shipping the hooks in your repo,
and then having users copy them to their .git/hooks directory (and you
can even provide a script for that).

Unfortunately, there is a chicken-and-egg problem there with the initial
checkout. You could do something like (assuming the hooks are in "hooks"
in the repo) to bootstrap:

  git clone -n <repo.git>
  cd repo
  git archive --format tar HEAD hooks | tar -C .git/hooks -xf -
  git checkout master

-Peff
