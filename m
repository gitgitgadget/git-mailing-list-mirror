From: Florian Weimer <fw@deneb.enyo.de>
Subject: sbuild (or whatever) integration
Date: Sat, 19 May 2007 15:17:04 +0200
Message-ID: <87sl9t6jhr.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 15:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpOo6-00005U-Fv
	for gcvg-git@gmane.org; Sat, 19 May 2007 15:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374AbXESNRK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 09:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757465AbXESNRK
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 09:17:10 -0400
Received: from mail.enyo.de ([212.9.189.167]:2796 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756374AbXESNRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 09:17:09 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1HpOny-000334-Am
	for git@vger.kernel.org; Sat, 19 May 2007 15:17:06 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1HpOnw-0004ls-I6
	for git@vger.kernel.org; Sat, 19 May 2007 15:17:05 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47749>

I'd like to build something that integrates a Debian autobuilder
(sbuilder probably) with GIT.  The intent is to get rid of a
designated integrator (our team is of a size where this seems a
reasonable thing to do[1]) and ensure predictable builds, independent
of what developers happen to have installed on their local
workstations.

Basically, what I want to do is this:

  1. Perform a checkout from a specific branch.

  2. Synthesize a new version number that is bigger than the previous
     one.  (This needs to keep a bit of extra-repository state.  At
     this stage, it's probably a good idea to ensure that the previous
     commit built on this branch is an ancestor of the current HEAD.)

  3. Generate a fake Debian changelog entry giving the HEAD commit and
     the branch name, using the generated version number.

  4. Build the whole thing in a controlled environment.

  5. Store the build log for later review.

  6. If the build was successful, transfer the packages to some
     repository (based on the branch that was used).

The GIT repository in step one is a shared one, with an update hook
that that ensures fast-forward merges, as in:

<http://www.kernel.org/pub/software/scm/git/docs/howto/update-hook-example.txt>

The idea is that this means that features are monotonic along a
branch.  Ideally, I would like to have something which can assign
meaningful version numbers across two branches, but this is of course
impossible to automatically.  I hope to work with a single release
branch anyway, and use at most two (one for testing, one for
production).

Does this sound reasonable?  Has anybody built something similar?

[1] This is for internal development, and due to various constraints,
    we haven't got developer-specific integration testing
    environments.  That's why we need to linearize before actual
    deployment.
