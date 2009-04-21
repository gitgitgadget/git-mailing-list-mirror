From: Jeff King <peff@peff.net>
Subject: Re: GPG signing for git commit?
Date: Tue, 21 Apr 2009 16:27:11 -0400
Message-ID: <20090421202711.GB12891@coredump.intra.peff.net>
References: <1238793954.19982.14.camel@hyperair-laptop> <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain> <49D99BB2.2090906@vilain.net> <20090415185554.GG23644@curie-int> <20090415192054.GE23604@spearce.org> <20090415T220710Z@curie.orbis-terrarum.net> <20090416142728.GG23604@spearce.org> <slrngufuke.1am.sitaramc@sitaramc.homelinux.net> <20090417120110.GC29121@coredump.intra.peff.net> <slrnguhj1o.usr.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 22:28:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwMaJ-00084L-Vw
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 22:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbZDUU1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 16:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbZDUU1P
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 16:27:15 -0400
Received: from peff.net ([208.65.91.99]:60459 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbZDUU1P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 16:27:15 -0400
Received: (qmail 11395 invoked by uid 107); 21 Apr 2009 20:27:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 21 Apr 2009 16:27:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2009 16:27:11 -0400
Content-Disposition: inline
In-Reply-To: <slrnguhj1o.usr.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117154>

On Fri, Apr 17, 2009 at 06:36:40PM +0000, Sitaram Chamarty wrote:

> On 2009-04-17, Jeff King <peff@peff.net> wrote:
> >> If you set GIT_COMMITTER_*, won't it change the SHA of the
> >> commit itself?  I always thought so...
> >
> > No. Pushing will never create a new commit, so there are no new SHA-1s
> > calculated. But the reflog entry will contain GIT_COMMITTER_*, and is a
> > simple text file.
> 
> cool -- I didn't know this.  Thanks!
> 
> One last question: where do you set it, in the pre-commit
> hook on the server?

No, for two reasons:

  1. The pre-commit hook is run when making a local commit. For pushing,
     you would want the pre-receive hook.

  2. Hooks are executed as child processes of receive-pack, so they
     can't impact the environment it sees.

I think you would need to intercept the call to receive-pack (e.g., by
replacing it with a wrapper script), set the variables based on ssh keys
used (or whatever criteria you want), and then exec receive-pack.

-Peff
