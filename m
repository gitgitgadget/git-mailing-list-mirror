From: Jeff King <peff@github.com>
Subject: Re: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Tue, 22 Mar 2011 14:47:37 -0400
Message-ID: <20110322184737.GB22534@sigill.intra.peff.net>
References: <op.vsm1yszq2m56ex@localhost.localdomain>
 <AANLkTi=Fu5v-5E2dSAA74f0juUQNjNjus5XFWqMb9v9k@mail.gmail.com>
 <20110320234420.GA1919@sigill.intra.peff.net>
 <op.vsq9o4mz2m56ex@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>, git@vger.kernel.org
To: Pavel Raiskup <xraisk00@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:47:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q26cL-0000aa-A8
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 19:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab1CVSrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 14:47:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38177
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704Ab1CVSrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 14:47:39 -0400
Received: (qmail 27337 invoked by uid 107); 22 Mar 2011 18:48:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Mar 2011 14:48:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Mar 2011 14:47:37 -0400
Content-Disposition: inline
In-Reply-To: <op.vsq9o4mz2m56ex@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169762>

On Tue, Mar 22, 2011 at 06:32:54PM +0100, Pavel Raiskup wrote:

> >Yeah, I would be happy to mentor or co-mentor with Vicent on a project
> >like that. Not only might it be useful to actually _use_, but my secret
> >motive is that I'd like to start testing libgit2 using some of the
> >regular git tests, both for interoperability and for performance.
> 
> Do you mean git tests in directory "/t"?

Yes.

> Could you give me a list of possible reusable unit tests? After a quick
> overview of test suite in git it looks quite complex to reuse. I haven't
> spent a lot of time studying test-suite, but calling:
> 
> test_expect_success 'plain' 'command && command && ..'
> 
> reinterprets chain of commands given in (2nd) string and in this
> commands is often called git as utility with arguments. Even in this
> very easy test feature is expected some command-line-interface behavior
> from tested utility.. Is this the way how do you want to test this new
> libgit2-like tool? So this standalone utility is going to have the
> same interface as git has -- kind of substitution of git with "git2"
> inside test suite?

Exactly. My plan was to implement a few of the simpler git commands (or
at least the basic parts of them) using libgit2, and then test them with
unmodified scripts from git's t/ directory.

Of course, many of the tests won't pass because of obscure features that
we haven't implemented. But that's OK. Even getting a partial list of
passing tests will be useful. And tests known not to work because of
unimplemented features can often be skipped (see the description of
GIT_SKIP_TESTS in t/README). Part of the project would be sorting out
which tests will be useful.

It may also be necessary to use a mixture of git and libgit2 commands to
finish tests. For example, a test which is really about checking "log"
might use "commit", but "commit" hasn't been implemented yet. But it is
still useful information if we cheat and use regular git's "commit", but
test the libgit2 log command.

As far as which commands to start with, I would start with plumbing
commands like "update-index", "commit-tree", "update-ref", "rev-list",
etc.  Those are basic building blocks that have reasonably simple
interfaces, and they're easy to test. And once you start, I think it
will become more obvious where to go next (because some of the commands
build on the results of others).

> This probably will lead to some test suite changes, is it truth?

There may be modifications necessary to the test suite to make this
easier to do. But rather than forking the test suite and changing the
tests, I would much rather see whatever support is needed done in a
generalized way and merged to regular git.

-Peff
