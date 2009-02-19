From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] Change output "error: " to "Error: " etc
Date: Thu, 19 Feb 2009 03:17:25 -0500
Message-ID: <20090219081725.GB7774@coredump.intra.peff.net>
References: <200902190736.49161.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 09:19:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La47T-0007Up-V4
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 09:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbZBSIR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 03:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbZBSIR2
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 03:17:28 -0500
Received: from peff.net ([208.65.91.99]:55277 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899AbZBSIR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 03:17:27 -0500
Received: (qmail 20782 invoked by uid 107); 19 Feb 2009 08:17:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Feb 2009 03:17:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2009 03:17:25 -0500
Content-Disposition: inline
In-Reply-To: <200902190736.49161.johnflux@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110644>

On Thu, Feb 19, 2009 at 07:36:49AM +0000, John Tapsell wrote:

> All the error messages starting "Error: " begin with a captial E, except
> in one place.  This commit fixes this, making the output look more
> consistent.  At the moment a failed push, say, looks like:
> 
> Error: cannot lock existing info/refs
> error: failed to push some refs to 'some repository'

I think this commit message is a little misleading. True, there is only
one place where "error:" appears, but it is the place that is called by
almost every piece of code. So by far the majority of errors are "error:
".

http-push seems to be the odd man out. It contains one fprintf(stderr,
"Error: ...") and one totally bogus error("Error: ..."), which will
print "error: Error: ...". Perhaps it would be better to scan through
the code and switch to using error() and warning() as appropriate.

That will make things consistent, which addresses your complaint.  And
then there can be a discussion if people want about whether "Error:" or
"error:" is better (personally I like lowercase).

-Peff
