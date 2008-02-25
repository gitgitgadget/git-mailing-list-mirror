From: Jeff King <peff@peff.net>
Subject: Re: git-email automatic --to detection?
Date: Mon, 25 Feb 2008 13:34:14 -0500
Message-ID: <20080225183413.GA15131@sigill.intra.peff.net>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:35:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTiAZ-0001uk-8p
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 19:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130AbYBYSeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 13:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756331AbYBYSeT
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 13:34:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4884 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756130AbYBYSeS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 13:34:18 -0500
Received: (qmail 11583 invoked by uid 111); 25 Feb 2008 18:34:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 25 Feb 2008 13:34:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2008 13:34:14 -0500
Content-Disposition: inline
In-Reply-To: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75040>

On Sun, Feb 24, 2008 at 04:29:56PM -0600, John Goerzen wrote:

> This will look at the repo the local copy was cloned from, find all
> local changesets that aren't on the remote, and email off a set of
> patches to the remote maintainer.  It finds the email address to send
> to by looking at _darcs/prefs/email *on the remote*, which is roughly
> the same as setting an option in .git/config.

There is not (currently) a way to read the remote config using the git
protocol. There was some discussion on a protocol extension a few months
back to do so, but I don't recall whether any patches came out of it.

> There are a couple of nice things about this:
> 
> 1) Patch submitters don't have to keep track of where to send patches
> for each project they work on
> 
> 2) Potential submitters don't have to be notified if the submission
> address changes

There was some discussion about this a while back for the kernel. Some
relevant points that I recall:

  - there's more than _one_ maintainer for the repo; in fact, who you
    email depends on what part of the code you are touching

  - this information could be shipped as part of the repo (i.e., under
    version control like the rest of the project, as it changes with the
    project)

  - this information can potentially be inferred from git shortlog
    and/or blame; this addresses the problem of data becoming stale

See this thread:

  http://mid.gmane.org/1187110824.32555.76.camel@localhost

> As far as I can tell from looking at git-send-email(1),
> git-format-patch(1), and git-config(1), git doesn't have this
> capability.  Is that correct?  If so, is it possible to add something
> like this?  Would it also be possible to unify git-format-patch and
> git-send-email into a single command that generates and sends the
> patch(es)?

You could make a wrapper script around the two commands that pieces them
together. Though I'm not sure how likely that would be to get accepted
upstream; there are already complaints of too many commands, and this
one would likely be specific to your workflow (many of us have our own
such wrapper scripts already).

-Peff
