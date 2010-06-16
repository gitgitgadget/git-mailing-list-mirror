From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Wed, 16 Jun 2010 02:28:15 -0400
Message-ID: <20100616062814.GA13481@sigill.intra.peff.net>
References: <4C0E6810.3070301@viscovery.net>
 <AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
 <4C0E932B.3010702@viscovery.net>
 <AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com>
 <4C0EB741.9020905@op5.se>
 <AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com>
 <20100610082916.GA5559@coredump.intra.peff.net>
 <AANLkTinLt3p0q-q5oDFk5CWzdhqQ2lwkWuvpdPzKZvYe@mail.gmail.com>
 <20100610085952.GA8269@coredump.intra.peff.net>
 <gJV0lM_e77LzoiHR7moWdAApSZ7yI38lZ-w8kZwc97unWqtBc94nfg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tor Arntsen <tor@spacetec.no>, Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>,
	Dario Rodriguez <soft.d4rio@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>, gary@thewrittenword.com
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 16 08:28:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOm6q-0001Nq-0T
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 08:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621Ab0FPG2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 02:28:21 -0400
Received: from peff.net ([208.65.91.99]:54024 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791Ab0FPG2S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 02:28:18 -0400
Received: (qmail 904 invoked by uid 107); 16 Jun 2010 06:29:04 -0000
Received: from adsl-99-133-187-56.dsl.bltnin.sbcglobal.net (HELO sigill.intra.peff.net) (99.133.187.56)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Jun 2010 02:29:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jun 2010 02:28:15 -0400
Content-Disposition: inline
In-Reply-To: <gJV0lM_e77LzoiHR7moWdAApSZ7yI38lZ-w8kZwc97unWqtBc94nfg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149251>

On Tue, Jun 15, 2010 at 11:11:35AM -0500, Brandon Casey wrote:

> So, I think it's appropriate to set DEFAULT_PAGER on IRIX.  There can't
> be many users anyway.  It's probably appropriate to set it on Solaris
> too, if 'less' is not a commonly installed component on modern systems.
> I wonder how surprised existing git users will be, for those on Solaris
> platforms that have 'less' installed, when Solaris's crappy 'more'
> becomes their pager.

I'm a little worried about that, too. On the other hand, wouldn't people
who actually care about less have set PAGER already, to use it for
things like "man"?

> But, I also think it would be nice if git fell back to the 'cat'
> behavior when it fails to spawn the pager, because the following error
> is not very informative:
> 
>    casey@<a_solaris_box> # git log
>    sh: less: not found
>    Broken Pipe

The pager command is executed by the shell these days. Perhaps we should
simply set DEFAULT_PAGER on these platforms to "less || more || cat",
which seems to work from my simple tests. If that is too hack-ish (e.g.,
we really care about "does less exist", not "did it fail"), we can do a
more invasive patch (or even provide a "git-pager" shell script helper
to do a more thorough job).

-Peff
