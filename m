From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's not in 'master' but should be
Date: Fri, 18 Jan 2008 12:34:14 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801181226130.5731@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>  <47893E1A.5020702@gmail.com>  <7v4pdislrf.fsf@gitster.siamese.dyndns.org>  <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>  <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
  <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>  <8c5c35580801180215s2c980b4kbc66fbb05778ff67@mail.gmail.com>  <7vwsq7fn2e.fsf@gitster.siamese.dyndns.org>  <8c5c35580801180253x9022e62qf1ec515e101fb294@mail.gmail.com>  <7vzlv3e6fy.fsf@gitster.siamese.dyndns.org>
 <8c5c35580801180354w74774fe2u1d96a8d12f513811@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 13:35:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFqR3-0005uM-FW
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 13:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757641AbYARMeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 07:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757584AbYARMeW
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 07:34:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:49669 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756895AbYARMeV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 07:34:21 -0500
Received: (qmail invoked by alias); 18 Jan 2008 12:34:19 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp051) with SMTP; 18 Jan 2008 13:34:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+H0qsFZheHgodamJRyaytV8rmo4mUt8/SwCXty2A
	HmhwvzBx0yHJLh
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580801180354w74774fe2u1d96a8d12f513811@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71009>

Hi,

On Fri, 18 Jan 2008, Lars Hjemli wrote:

> On Jan 18, 2008 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > "Lars Hjemli" <hjemli@gmail.com> writes:
> >
> > > Hmm, isn't a nonfunctional libgit considered breakage? Without 
> > > something like this patch it is no longer possible to use 
> > > write_tar_archive()/write_zip_archive() in libgit.a.
> >
> > Sorry, but libgit.a is not part of what we deliver.  We do not support 
> > linking random stuff against libgit.a.  We never did. It is not a 
> > "library".
> 
> I kind of expected this reply, and I know libgit isn't supposed to be a 
> stable API aginst git internals, but it still feels like a regression: 
> cgit has been linking against libgit for over a year now (initial 
> snapshot support added feb 8, 2007), and git-1.5.4 looks like the first 
> git release which cgit cannot use.

So you did something that is unsupported, and now it breaks for you.

I'd almost say: you should have expected that.  HOWEVER, this makes you 
the perfect guy to actually do something about libification (which has 
been on my mind for some time, with the prospect of GitCheetah), and 
therefore you deserve a little help, IMHO.

> > The code movement you did _should_ not hurt so it may be a fine 
> > material for post 1.5.4, but I haven't carefully compared what other 
> > change might have accidentally snuck in that patch, and I would rather 
> > not have to during the rc cycle.

I have.  The 80 lines that were removed are _exactly_ the 80 lines that 
were added (prepended with some #includes).

Like Lars said, the prototype of the only non-static function, 
sha1_file_to_archive(), was in archive.h, which is included from 
builtin-archive.c (where the big hunk was moved from), so there is no 
possibility of a breakage there.

It is no _functional_ change, but if Lars _uses_ the function in cgit, I'd 
say it would be a "courtesy fix" before 1.5.4.

Mind you, I would not propose to make libgit.a fully functional as a 
standalone library before 1.5.4.

But Lars contributed a lot, and did a very good job of collecting git 
patches back in October.  Therefore I think that he deserves a little 
extra attention, even if it does not fix a bug in git proper.

Ciao,
Dscho
