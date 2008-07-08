From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH v2 2/4] Add git-sequencer prototype documentation
Date: Tue, 8 Jul 2008 13:49:07 +0200
Message-ID: <20080708114907.GG6726@leksak.fem-net>
References: <1214879914-17866-3-git-send-email-s-beyer@gmx.net> <1215277204-20926-1-git-send-email-s-beyer@gmx.net> <200807081237.51456.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 13:50:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGBi3-00071V-4i
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 13:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbYGHLtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 07:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbYGHLtR
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 07:49:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:39240 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753653AbYGHLtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 07:49:16 -0400
Received: (qmail invoked by alias); 08 Jul 2008 11:49:15 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp009) with SMTP; 08 Jul 2008 13:49:15 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX185r3xWlgk5M2jC1Xbkkny5KVNY278WJc0o57Byes
	RCIv6RAEI+okVg
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KGBgx-0003bU-69; Tue, 08 Jul 2008 13:49:07 +0200
Content-Disposition: inline
In-Reply-To: <200807081237.51456.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87754>

Hi,

On Tue, Jul 08, 2008, Jakub Narebski wrote:
> 1. Splitting a patch
[...]
> Currently I don't see easy way to do this with git-sequencer.

I've needed this, too, and I've added this use case in the EXAMPLES
section that will be included in the next patchset.
Basically it is the same as the rebase documentation says:
during a pause (by "edit" or "pause" insn) reset to HEAD^, add only
those parts to the index you want to have in the first patch and commit
and then repeat this.

When I've experienced this need the first time, I thought about how
sequencer could ease that.
A first idea was something like "take only files X, Y, Z from commit ..."
or a --exclude as patch has.
But often splitting a patch is not done file-wise, but hunk-wise or even
line-wise.
So my second idea was to add an option to "pause" that just invokes
the "reset HEAD^". That makes it easy, I think.
How should this option be called?

> 2. Patch based rebase
> 
> git-rebase by default, and for speed, uses git-format-patch / git-am
> pipeline (utilizing '--rebasing' option to git-am to avoid changing
> commit messages, even if they do not follow commit message conventions).
> If you want for plain "git rebase" to use git-sequencer, it should be
> easy to support this "engine"; therefore perhaps it would be good
> to add some equivalent of "git format-patch" to the TODO file format.

Imho the patch generation should be done by git-rebase.

> 3. Checking rebase
> 
> Usually when you are interacting with upstream by sending patches by
> email, the last part before sending series of patches is git-rebase
> on top of current work.  It would be nice if there were some way to
> have "git rebase" (via git-sequencer) to check that all commits
> (perhaps with some explicitly stated in TODO file exceptions) passes
> pre-commit hook (checking for whitespaces and conflict markers), and
> if possibly also either test suite, or relevant parts of test suite.
> 
> So perhaps extending TODO format by "check <script>" or
> "check-all <script>"?

That seems to be useful indeed and reminds me of
"git bisect run <script>".
Perhaps it's also better to call it "run" so that it is a generic
way of running scripts from sequencer and if they fail, sequencer
will pause, if they pass, everything goes on.

What about this?


run [--dir=<path>] [--] <cmd> <args>...::
	Run command `<cmd>` with arguments `<args>`.
	Pause (conflict-like) if exit status is non-zero.
+
If `<path>` is set, sequencer will change directory to `<path>`
before running the command and change back after exit.



Regards,
  Stephan


-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
