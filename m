From: Jeff King <peff@peff.net>
Subject: Re: Invalid dates in git log
Date: Wed, 12 Dec 2007 04:23:04 -0500
Message-ID: <20071212092304.GA20799@coredump.intra.peff.net>
References: <34660cca0712120111k3f11769fk1a8cefda3b82683e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eirik =?iso-8859-1?Q?Bj=F8rsn=F8s?= <eirbjo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 10:23:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2NoS-00078k-Kr
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 10:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757767AbXLLJXK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 04:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757787AbXLLJXJ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 04:23:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2119 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757641AbXLLJXI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 04:23:08 -0500
Received: (qmail 356 invoked by uid 111); 12 Dec 2007 09:23:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Dec 2007 04:23:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2007 04:23:04 -0500
Content-Disposition: inline
In-Reply-To: <34660cca0712120111k3f11769fk1a8cefda3b82683e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68021>

On Wed, Dec 12, 2007 at 10:11:12AM +0100, Eirik Bj=F8rsn=F8s wrote:

> My questions are:
>=20
> 1) Is this a problem in the Git software?

No. Whoever made the commit probably just didn't have their clock set
right. Git doesn't generally care about the timestamp for its
operations; it just records it as a historical note.

> 2) Or is it a data corruption issue in the repository?

No. You can check for corruption with git-fsck, but these commits were
actually created with bad dates.

> 3) Can it be fixed and should I contact anyone to get it fixed?

Changing the date will change the commit id (since the id is the sha1 o=
f
the commit contents). Which would mean rewriting all of the history tha=
t
follows it. You could do it in your own repository, but then you might
have some trouble merging with Linus later on. Linus could do it, but I
doubt he will think it is worth the trouble.

> $ git  log  a27ac38efd6dc6dccebfc9bcc475ab4aa5fc4a56 -1
> commit a27ac38efd6dc6dccebfc9bcc475ab4aa5fc4a56
> Author: Len Brown <len.brown@intel.com>
> Date:   Fri Apr 5 00:07:45 2019 -0500

Your best guess is probably the committer information. Try this:

  git log a27ac38 -1 --pretty=3Dformat:'Author: %an %ad%nCommitter: %cn=
 %cd'

-Peff
