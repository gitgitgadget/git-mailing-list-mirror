From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] ignore SIGINT while editor runs
Date: Sun, 11 Nov 2012 11:31:00 -0500
Message-ID: <20121111163100.GB13188@sigill.intra.peff.net>
References: <20121109192336.GA9401@sigill.intra.peff.net>
 <87a9uq5tql.fsf@Niukka.kon.iki.fi>
 <20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us>
 <871ug15k5c.fsf@Niukka.kon.iki.fi>
 <20121110220811.DC6A42E8B68@grass.foxharp.boston.ma.us>
 <87wqxs4o6f.fsf@Niukka.kon.iki.fi>
 <20121111154846.GA13188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:35:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXaVR-0003eY-68
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab2KKQbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:31:04 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43910 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559Ab2KKQbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:31:03 -0500
Received: (qmail 426 invoked by uid 107); 11 Nov 2012 16:31:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 11:31:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 11:31:00 -0500
Content-Disposition: inline
In-Reply-To: <20121111154846.GA13188@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209395>

On Sun, Nov 11, 2012 at 10:48:46AM -0500, Jeff King wrote:

> Silly me. When I thought through the impact of Paul's patch, I knew that
> we would notice signal death of the editor. But I totally forgot to
> consider that the blocked signal is inherited by the child process. I
> think we just need to move the signal() call to after we've forked. Like
> this (on top of Paul's patch):
> [...]
> Note that this will give you a slightly verbose message from git.
> Potentially we could notice editor death due to SIGINT and suppress the
> message, under the assumption that the user hit ^C and does not need to
> be told.

Here's a series that I think should resolve the situation for everybody.

  [1/5]: launch_editor: refactor to use start/finish_command

The cleanup I sent out a few minutes ago.

  [2/5]: launch_editor: ignore SIGINT while the editor has control

Paul's patch rebased on my 1/5.

  [3/5]: run-command: drop silent_exec_failure arg from wait_or_whine
  [4/5]: run-command: do not warn about child death by SIGINT
  [5/5]: launch_editor: propagate SIGINT from editor to git

Act more like current git when the editor dies from SIGINT.

-Peff
