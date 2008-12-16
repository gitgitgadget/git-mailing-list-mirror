From: Jeff King <peff@peff.net>
Subject: Re: git-clone --how-much-disk-space-will-this-cost-me? [--depth n]
Date: Mon, 15 Dec 2008 19:43:40 -0500
Message-ID: <20081216004339.GA3679@coredump.intra.peff.net>
References: <878wqhxaex.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Dec 16 01:45:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCO3b-0004FC-9W
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 01:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbYLPAnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 19:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755256AbYLPAnn
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 19:43:43 -0500
Received: from peff.net ([208.65.91.99]:3241 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018AbYLPAnn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 19:43:43 -0500
Received: (qmail 9232 invoked by uid 111); 16 Dec 2008 00:43:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 15 Dec 2008 19:43:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Dec 2008 19:43:40 -0500
Content-Disposition: inline
In-Reply-To: <878wqhxaex.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103223>

On Tue, Dec 16, 2008 at 07:53:42AM +0800, jidanni@jidanni.org wrote:

> The git-clone manpage should mention how to determine how much disk
> space will be used.

OK. Do you have a suggestion for how to figure that out?

> Let's take a look at those messages while were at it,
> $ git-clone --depth 1 git://git.sv.gnu.org/coreutils/
> Initialized empty Git repository in /usr/local/src/jidanni/coreutils/.git/
> remote: Counting objects: 26240, done.
> remote: Compressing objects: 100% (14001/14001), done.
> remote: Total 26240 (delta 21577), reused 15354 (delta 12095)
> Receiving objects: 100% (26240/26240), 15.76 MiB | 26 KiB/s, done.
> Resolving deltas: 100% (21577/21577), done.
> $ du -sh
> 27M  .
> Nope, nowhere does it directly say "You Holmes, are in for 27
> Megabytes (on your piddly modem)". There obviously is math involved to
> figure it out... math!

That's because we don't know that it will be 27 megabytes. That progress
counter is counting the number of _objects_, not bytes. So you can make
a rough estimate, but only after receiving some objects, and even then
it can be wildly off (because you are assuming the size of the objects
still to get averages the same as the size of the objects you have
already gotten).

AFAIK, nowhere in the sent data is there an indication of how many bytes
are in the resulting pack (and in many cases, the pack is generated on
the fly and the information not only is not sent, but is not available
anywhere).

-Peff
