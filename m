From: Jeff King <peff@peff.net>
Subject: Re: [PATCH master] expand "<branch>" in format.subjectprefix
Date: Wed, 13 Jan 2010 15:29:31 -0500
Message-ID: <20100113202930.GC23018@coredump.intra.peff.net>
References: <1263402988-925-1-git-send-email-rep.dot.nop@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:29:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9qa-0005WG-Qu
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472Ab0AMU3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754945Ab0AMU3l
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:29:41 -0500
Received: from peff.net ([208.65.91.99]:49291 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753681Ab0AMU3l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:29:41 -0500
Received: (qmail 27707 invoked by uid 107); 13 Jan 2010 20:34:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 13 Jan 2010 15:34:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2010 15:29:31 -0500
Content-Disposition: inline
In-Reply-To: <1263402988-925-1-git-send-email-rep.dot.nop@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136876>

On Wed, Jan 13, 2010 at 06:16:28PM +0100, Bernhard Reutner-Fischer wrote:

> Replace "<branch>" with the current branch name for
> [format]
>         subjectprefix = PATCH <branch>
> 
> A subject-prefix given on the command-line overrides the one given in
> the config.

I don't have a big opinion on whether this feature is useful (it
wouldn't be to me, but I can see workflows where it could be).

I'm not sure that "current branch" makes sense, though.  format-patch is
about showing commits, and the current branch is not a property of that
commit.  It is about where you happen to be currently. So doing:

  git checkout X
  git format-patch Y..Z --subject-prefix "PATCH <branch>"

shows "X" which is not really useful information. Something like git
log's "--source" would be more useful; it shows the command-line ref
that was used to reach a given commit.

Also, please don't introduce a new substitution syntax. We already have
code to do %-expansion. In fact, if you are going to do something like
this, maybe it would be best as two patches:

  1. Support '%B' as a user-format expansion for the --source branch.

  2. Support user-format expansions in the subject prefix.

But I don't know if people would find any of the other substitutions
useful in the subject line.

-Peff
