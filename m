From: Jeff King <peff@peff.net>
Subject: Re: diffcore-rename performance mode
Date: Tue, 18 Sep 2007 04:54:13 -0400
Message-ID: <20070918085413.GA11751@coredump.intra.peff.net>
References: <20070918082321.GA9883@coredump.intra.peff.net> <7vsl5cwe6p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:54:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYqc-0001A8-DF
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbXIRIyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbXIRIyQ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:54:16 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4206 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbXIRIyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:54:16 -0400
Received: (qmail 26091 invoked by uid 111); 18 Sep 2007 08:54:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 18 Sep 2007 04:54:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2007 04:54:13 -0400
Content-Disposition: inline
In-Reply-To: <7vsl5cwe6p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58547>

On Tue, Sep 18, 2007 at 01:49:50AM -0700, Junio C Hamano wrote:

> > However, keeping around _just_ the
> > cnt_data caused only about 100M of extra memory consumption (and gave
> > the same performance boost).
> 
> That would be an interesting and relatively low-hanging optimization.

OK, I will work up a patch. Is it worth making it configurable? Since it
is a space-time tradeoff, if you are tight on memory, it might actually
hurt performance. However, I have only looked at the numbers for my
massive data set...I can produce memory usage numbers for the kernel,
too.

> I think it was just a hash table with linear overflow (if your
> spot is occupied by somebody else, you look for the next
> available vacant spot -- works only if you do not ever delete
> items from the table) but sorry, I do not recall the rationale
> for picking that data structure.  I vaguely recall I did some
> measurement between that and the usual "an array that is indexed
> with a hash value that holds heads of linked lists" and pointer
> chasing appeared quite cache-unfriendly to the point that it
> actually degraded performance, but did not try very hard to
> optimize it.

I thought we were holding counts of hashes, in which case there _is_ no
overflow. We only care if you hit the hash fingerprint or not. But
perhaps I am mistaken...I will have to look more closely at the code.

-Peff
