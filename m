From: Jeff King <peff@peff.net>
Subject: Re: [spurious parallel build bug] make -j fails with: "mv: mv:
	cannot stat `perl.mak': No such file or directory"
Date: Mon, 27 Apr 2009 16:19:20 -0400
Message-ID: <20090427201920.GD4067@coredump.intra.peff.net>
References: <20090427094843.GA5849@elte.hu> <7vk5563ua8.fsf@gitster.siamese.dyndns.org> <20090427183451.GA23862@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Apr 27 22:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyXIh-0005jb-1n
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 22:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbZD0UTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 16:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbZD0UTY
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 16:19:24 -0400
Received: from peff.net ([208.65.91.99]:56071 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbZD0UTX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 16:19:23 -0400
Received: (qmail 22388 invoked by uid 107); 27 Apr 2009 20:19:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 27 Apr 2009 16:19:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Apr 2009 16:19:20 -0400
Content-Disposition: inline
In-Reply-To: <20090427183451.GA23862@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117710>

On Mon, Apr 27, 2009 at 08:34:51PM +0200, Ingo Molnar wrote:

> > I've seen this a few times on the master machine at k.org but 
> > haven't seen it elsewhere, perhaps because I do not have an access 
> > to 8-way parallelism anywhere else.
> 
> btw, this happened on a plain dual-core box. But i couldnt reproduce 
> after that.

I've seen it occasionally on a dual-core, as well, but was never able to
track it down. I suspect it is caused by the fact that there are two
rules which recurse into the perl subdir: perl/perl.mak, if needed, will
recurse, as will "all".  So I think we are losing the usual parallelism
guard there, and we have two makes running inside "perl" at the same
time, both of which then try to make perl.mak and step on each other.

But I still can't reproduce it at will, so it is hard to test.

-Peff
