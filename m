From: Jeff King <peff@peff.net>
Subject: Re: How do I run tests under Valgrind?
Date: Fri, 21 Sep 2012 16:49:07 -0400
Message-ID: <20120921204907.GA22977@sigill.intra.peff.net>
References: <20120917172022.GA1179@sigill.intra.peff.net>
 <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
 <20120917173531.GB1179@sigill.intra.peff.net>
 <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
 <20120917174439.GD1179@sigill.intra.peff.net>
 <CALkWK0mkBbY7dUyaZAqqKE3ZMfE_xU6em_KCOKM9nsTjUP-9pA@mail.gmail.com>
 <20120917182957.GF1179@sigill.intra.peff.net>
 <CALkWK0=nMxNfmAaBTmXeADQubTayC_2_ut5Nq3QXba9yfQr9yA@mail.gmail.com>
 <CALkWK0kWvrirPjXXzBBBQxKDcwpd_+nQ2eeT6SE8gDFW5T7WFQ@mail.gmail.com>
 <505CCA55.6030609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:49:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFAA3-00045H-NW
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 22:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757912Ab2IUUtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 16:49:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53683 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757744Ab2IUUtK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 16:49:10 -0400
Received: (qmail 6616 invoked by uid 107); 21 Sep 2012 20:49:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 16:49:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 16:49:07 -0400
Content-Disposition: inline
In-Reply-To: <505CCA55.6030609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206161>

On Fri, Sep 21, 2012 at 10:13:09PM +0200, Stefano Lattarini wrote:

> On 09/21/2012 09:58 PM, Ramkumar Ramachandra wrote:
> > Hi again,
> > 
> > Ramkumar Ramachandra wrote:
> >> I was able to reproduce the problem on all my machines, and I consider
> >> this very disturbing.  However, I was successfully able to corner the
> >> issue. I have an overtly long $PATH that's not getting split properly
> >> by `IFS=:` in one corner case -- in other words, this shell script
> >> fails to execute properly when called with `--tee` (just set a really
> >> long $PATH and try):
> > 
> > Oops.  Looks like it has nothing to do with an overtly long $PATH.  It
> > has something to do with $SHELL being zsh though, because other shells
> > work.  Looking deeper into this.
> > 
> Zsh doesn't do word-splitting by default on variable expansions:
> 
>     $ zsh -c 'v="1 2 3"; for x in $v; do echo "$x"; done'
>     1 2 3
> 
> unless you set the SH_WORD_SPLIT option, or put Zsh in Bourne-compatibility
> mode somehow:

Oh. It sounds like setting $SHELL to zsh is really the problem, then. If
it is not Bourne-compatible when called as "zsh", then it really should
be called in a way that turns on compatibility mode (bash will do this
when called as "sh", but you can also do it with "bash --posix").

-Peff
