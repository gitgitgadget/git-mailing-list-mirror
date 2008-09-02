From: Jeff King <peff@peff.net>
Subject: Re: pack count on repo.or.cz [was "Medium term dreams"]
Date: Mon, 1 Sep 2008 21:14:33 -0400
Message-ID: <20080902011433.GA12682@coredump.intra.peff.net>
References: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org> <20080902000037.GA11869@coredump.intra.peff.net> <20080902010410.GI10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 02 03:19:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaKY3-0001aM-1P
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 03:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbYIBBOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 21:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbYIBBOg
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 21:14:36 -0400
Received: from peff.net ([208.65.91.99]:2057 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbYIBBOf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 21:14:35 -0400
Received: (qmail 9657 invoked by uid 111); 2 Sep 2008 01:14:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Sep 2008 21:14:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Sep 2008 21:14:33 -0400
Content-Disposition: inline
In-Reply-To: <20080902010410.GI10360@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94635>

On Tue, Sep 02, 2008 at 03:04:10AM +0200, Petr Baudis wrote:

> Unfortunately, I'm not aware how to decreate the packs count with
> current Git without losing _any_ objects. So yes, you could say that
> this is an artifact of the forking infrastructure - we just can't afford
> to lose objects.

Hmm, I thought that was the point of adding the "-A" flag to git-repack.

Though an even simpler solution, since you control all of the repos, is
to just temporarily add references from the "parent" of the fork to
every ref of every forked child. Then do the repack in the parent, which
should then contain all of the objects for all of the children, delete
the temporary references, and prune in the children (who should see most
of their objects now in the parent).

The only downside I can think of is that anyone grabbing the parent's
packs via dumb transport will grab a few unnecessary objects for the
forks. But presumably they are not all that big, being forks (i.e.,
there will only be a few commits, and they will be delta'd anyway).

-Peff
