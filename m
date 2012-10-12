From: Jeff King <peff@peff.net>
Subject: Re: filter-branch IO optimization
Date: Fri, 12 Oct 2012 13:20:36 -0400
Message-ID: <20121012172036.GB21409@sigill.intra.peff.net>
References: <878vbc21f3.fsf@pctrast.inf.ethz.ch>
 <9de87aac-7e15-48d9-832a-e9a030c5ed43@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git list <git@vger.kernel.org>
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Fri Oct 12 19:20:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMiuo-0006jx-MQ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 19:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933875Ab2JLRUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 13:20:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51131 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932587Ab2JLRUj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 13:20:39 -0400
Received: (qmail 5186 invoked by uid 107); 12 Oct 2012 17:21:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Oct 2012 13:21:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2012 13:20:36 -0400
Content-Disposition: inline
In-Reply-To: <9de87aac-7e15-48d9-832a-e9a030c5ed43@zcs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207561>

On Fri, Oct 12, 2012 at 04:49:54PM +0200, Enrico Weigelt wrote:

> > The usual advice is "use an index-filter instead".  It's *much*
> > faster
> > than a tree filter.  However:
> 
> I've tried the last example from git-filter-branch manpage, but failed.
> Seems like the GIT_INDEX_FILE env variable doesnt get honoured by
> git-update-index, no index.new file created, and so mv call fails.
> 
> My second try (as index-filter command) was:
> 
> git ls-files -s > ../_INDEX_TMP
> cat ../_INDEX_TMP |
>     sed "s-\t\"*-&addons/-" |
>     git update-index --index-info
> rm -f ../_INDEX_TMP

I didn't look closely at your individual problem, but that example has
proven flaky before.  There were some simpler formulations given in this
thread:

  http://thread.gmane.org/gmane.comp.version-control.git/195492

In particular, Junio suggested:

  git filter-branch --index-filter '
    rm -f "$GIT_INDEX_FILE"
    git read-tree --prefix=newsubdir/ "$GIT_COMMIT"
  ' HEAD

-Peff
