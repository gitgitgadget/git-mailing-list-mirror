From: Jeff King <peff@peff.net>
Subject: Re: git add -u nonexistent-file
Date: Mon, 8 Feb 2010 19:39:58 -0500
Message-ID: <20100209003958.GA4065@coredump.intra.peff.net>
References: <20100208182929.GB14355@neumann>
 <a038bef51002081112s2d552835m4b34973f797ab4f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 01:40:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nee96-0003fO-L7
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 01:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359Ab0BIAj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 19:39:58 -0500
Received: from peff.net ([208.65.91.99]:49123 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab0BIAj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 19:39:57 -0500
Received: (qmail 11831 invoked by uid 107); 9 Feb 2010 00:40:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 08 Feb 2010 19:40:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2010 19:39:58 -0500
Content-Disposition: inline
In-Reply-To: <a038bef51002081112s2d552835m4b34973f797ab4f8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139341>

On Mon, Feb 08, 2010 at 02:12:41PM -0500, Chris Packham wrote:

> > $ git add -u nonexistent-file
> > $ echo $?
> > 0
> [...]
> It looks like in the case you've highlighted git is ignoring the extra
> non-option parameters on the command line. I'll let other people argue
> whether this is by design or omission.

It's not ignoring the extra parameters. They limit the scope of the
operation. So:

  $ git init
  $ touch file && mkdir subdir && touch subdir/file
  $ git add . && git commit -m one
  $ echo changes >file && echo changes >subdir/file
  $ git add -u subdir
  $ git status
  # On branch master
  # Changes to be committed:
  #       modified:   subdir/file
  #
  # Changed but not updated:
  #       modified:   file
  #

That being said, you noticed that the regular add case notes unused
pathspecs on the command line:

  $ git add bogus
  fatal: pathspec 'bogus' did not match any files

We could probably do the same here.

-Peff
