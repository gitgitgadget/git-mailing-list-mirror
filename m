From: Jeff King <peff@peff.net>
Subject: Re: "git stash" is not known to git
Date: Mon, 30 Jul 2007 06:04:08 -0400
Message-ID: <20070730100408.GA8829@coredump.intra.peff.net>
References: <86bqduutz4.fsf@lola.quinscape.zz> <vpqwswi2pkw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 12:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFS6o-0004p2-OF
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 12:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbXG3KEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 06:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbXG3KEL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 06:04:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1421 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbXG3KEK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 06:04:10 -0400
Received: (qmail 12205 invoked from network); 30 Jul 2007 10:04:11 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 Jul 2007 10:04:11 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2007 06:04:08 -0400
Content-Disposition: inline
In-Reply-To: <vpqwswi2pkw.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54216>

On Mon, Jul 30, 2007 at 11:44:31AM +0200, Matthieu Moy wrote:

> > One has to use git-stash rather than "git stash".  Oversight?
> 
> This looks like an incorrect installation, with git-stash in your
> $PATH, but not in the place git looks for its commands (I don't
> remember the exact mechanism).

On a related note, is it just me, or is the following comment and related code
in git.c (introduced by Linus in 231af832) totally bogus:

  /*
   * We search for git commands in the following order:
   *  - git_exec_path()
   *  - the path of the "git" command if we could find it
   *    in $0
   *  - the regular PATH.
   */

We never actually look in the regular PATH since we call execv_git_cmd
(although we do still munge the PATH, apparently so shell scripts can
use git-foo syntax; see 77cb17e9). This means you can't drop "git-foo"
into your PATH and have it work as "git foo".

What is the desired behavior?

-Peff
