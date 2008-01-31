From: Jeff King <peff@peff.net>
Subject: Re: git-push: forced update of tag shows unabbreviated SHA1
Date: Thu, 31 Jan 2008 05:06:25 -0500
Message-ID: <20080131100625.GB25546@coredump.intra.peff.net>
References: <47A1948F.6080308@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 11:07:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKWKM-0004II-Mz
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 11:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766009AbYAaKG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 05:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765127AbYAaKG2
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 05:06:28 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3892 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815AbYAaKG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 05:06:27 -0500
Received: (qmail 28040 invoked by uid 111); 31 Jan 2008 10:06:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 31 Jan 2008 05:06:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2008 05:06:25 -0500
Content-Disposition: inline
In-Reply-To: <47A1948F.6080308@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72117>

On Thu, Jan 31, 2008 at 10:27:43AM +0100, Johannes Sixt wrote:

> When a tag is changed to point to a new commit, then the tag is pushed to
> a repo that still has the old tag, it is correctly pushed, but the old
> SHA1 is reported with all 40 digits:

As Junio noted, this is because find_unique_abbrev returns NULL for
objects we don't have. Actually, it is somewhat worse -- we return an
erroneous abbreviation in the rare case that we are trying to find the
abbreviation for something we don't have, but for which we do have a
matching abbreviation. For example, if we have

  1234567890123456789012345678901234567890

then for every 12345678* that we don't have, we will claim the correct
abbreviation is 1234568.

In practice, I doubt this is a problem.

But getting back to your point: yes, I agree it is a little ugly.
Rewriting find_unique_abbrev would be necessary for fixing it, and I'm
not sure it is worth the trouble.

-Peff
