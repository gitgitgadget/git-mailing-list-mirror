From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/4] add pre-auto-gc hook for git-gc --auto (try2)
Date: Tue, 1 Apr 2008 13:38:55 +0200
Message-ID: <cover.1207049697.git.vmiklos@frugalware.org>
References: <7vsky6jhz3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 13:39:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgeq4-0001w9-M0
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 13:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020AbYDALi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 07:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757014AbYDALi5
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 07:38:57 -0400
Received: from virgo.iok.hu ([193.202.89.103]:18394 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756760AbYDALi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 07:38:57 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DB04C1B25A3;
	Tue,  1 Apr 2008 13:38:55 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D961C44659;
	Tue,  1 Apr 2008 13:35:45 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1EBC71190A3B; Tue,  1 Apr 2008 13:38:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsky6jhz3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78646>

On Mon, Mar 31, 2008 at 09:51:12PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > +   return run_command(&hook);
> > +}
>
> Don't we want to distinguish between the case where start_command()
> failed, wait_or_whine() failed on waitpid(), the command was killed
> with
> signal, or the command actually ran correctly and decided that you
> should
> not run "git gc --auto" by exiting non-zero?
>
> I think it is prudent to refrain from running "git gc --auto" in any
> of
> the failure cases I listed above, but shouldn't the cases other than
> the
> last one at least issue a warning?

Ok, there are 3 cases here to handle. When wait_or_whine() fails on
waitpid() it already prints an error, so that's already handled. I've
added two warnings for the other 2 cases.

Other changes:

- try to use on_ac_power when it's available, as suggested by Joey Hess

- mention in the commend of the example pre-auto-gc hook that it's
  Linux-specific, as suggested by Brian Gernhardt

- removed mentioning what the default hook does from hooks.txt, as it's
  an example and it's under contrib/

- moved the battery example to contrib/ and added a minimal example to
  templates/

- removed unnecessary stdout_to_stderr from builtin-gc.c::run_hook()

- removed unnecessary --no-verify option

I hope I haven't missed anything you suggested.

Miklos Vajna (4):
  git-gc --auto: add pre-auto-gc hook
  Documentation/hooks: add pre-auto-gc hook
  templates: add an example pre-auto-gc hook
  contrib/hooks: add an example pre-auto-gc hook

 Documentation/hooks.txt           |    7 +++++
 builtin-gc.c                      |   30 ++++++++++++++++++++++++
 contrib/hooks/pre-auto-gc-battery |   45 +++++++++++++++++++++++++++++++++++++
 templates/hooks--pre-auto-gc      |    9 +++++++
 4 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 contrib/hooks/pre-auto-gc-battery
 create mode 100644 templates/hooks--pre-auto-gc
