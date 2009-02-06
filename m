From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Fri, 6 Feb 2009 11:54:53 -0500
Message-ID: <20090206165453.GA19026@coredump.intra.peff.net>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net> <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu> <7v7i4692p4.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0902032217380.25760@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Fri Feb 06 17:56:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVU09-0000VB-Pg
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbZBFQy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 11:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbZBFQy5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 11:54:57 -0500
Received: from peff.net ([208.65.91.99]:55285 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbZBFQy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 11:54:57 -0500
Received: (qmail 23397 invoked by uid 107); 6 Feb 2009 16:55:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 06 Feb 2009 11:55:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2009 11:54:53 -0500
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0902032217380.25760@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108760>

On Tue, Feb 03, 2009 at 10:36:48PM -0800, Keith Cascio wrote:

> There are indeed two layers of masks (and there can be as many as
> needed).  In my current patch, the shell command line becomes "master"
> and primer becomes "slave".  Both layers exist independently of each
> other, in two separate diff_option structs, until just before "go
> time", when I flatten them (but that does not destroy the slave, it is
> reused).

We have had trouble in the past figuring out exactly when "go time" is
(not specifically for diff options, but for things like color config).
That is, there is code which wants to munge the options based on some
other input much later than the setting of most options, and so any
finalizing work you do ends up happening too early. And maybe you can
argue that such code is wrong or bad, but it does get written and it
does cause problems.

So as I mentioned in another mail I just sent, I think you are best to
stop thinking of it as a general flattening, and think of it more as a
set of accessors that do the flattening Just In Time.

-Peff
