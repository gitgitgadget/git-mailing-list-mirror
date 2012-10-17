From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] notes: mention --notes in more places
Date: Wed, 17 Oct 2012 01:51:37 -0400
Message-ID: <20121017055136.GA12301@sigill.intra.peff.net>
References: <1350443975-19935-1-git-send-email-eblake@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 07:52:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOMXr-0002QU-Rs
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 07:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab2JQFvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 01:51:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55799 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832Ab2JQFvo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 01:51:44 -0400
Received: (qmail 23289 invoked by uid 107); 17 Oct 2012 05:52:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Oct 2012 01:52:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2012 01:51:37 -0400
Content-Disposition: inline
In-Reply-To: <1350443975-19935-1-git-send-email-eblake@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207894>

On Tue, Oct 16, 2012 at 09:19:35PM -0600, Eric Blake wrote:

> Every so often, I search 'git send-email --help' to remember some
> option I've used in the past, only to discover that the option is
> documented instead in 'git format-patch --help'.  Worse, even that
> command didn't document the option I was looking for today, which
> was how to include 'git notes' in the body of the commits I was
> mailing.  Reading 'git notes --help' didn't mention this either,
> and I had to resort to searching the source code.  It can't hurt
> to add some documentation to make this option less obscure.

I think this is a good direction, but...

> * git-notes.txt: Mention that --notes option exists in many
> commands to override defaults.
> * git-format-patch.txt: Include pretty-options, for things like
> --notes.

There are many things in pretty-options that would not be appropriate
for format-patch. We should probably wrap them like this:

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 5e49942..a0f1d15 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -1,3 +1,4 @@
+ifndef::git-format-patch[]
 --pretty[=<format>]::
 --format=<format>::
 
@@ -27,6 +28,7 @@ people using 80-column terminals.
 --oneline::
 	This is a shorthand for "--pretty=oneline --abbrev-commit"
 	used together.
+endif::git-format-patch[]
 
 --encoding[=<encoding>]::
 	The commit objects record the encoding used for the log message

It may also make sense to show notes differently when outputting the
"email" format as format-patch does. E.g., using a triple-dash would
keep them separate from the commit message when using "git am". Like:

  your commit message

  Signed-off-by: You
  ---
  your notes go here

We've talked about it several times, but it's never happened (probably
because most people don't actually use notes).

-Peff
