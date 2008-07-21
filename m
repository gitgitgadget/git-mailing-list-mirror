From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: Re: [PATCH v2] Ensure that SSH runs in non-interactive mode
Date: Mon, 21 Jul 2008 15:04:09 +0200
Message-ID: <1216645452.3673.29.camel@pc7.dolda2000.com>
References: <1216598432-18553-1-git-send-email-fredrik@dolda2000.com>
	 <alpine.DEB.1.00.0807210310330.3305@eeepc-johanness>
	 <1216604693.3673.20.camel@pc7.dolda2000.com>
	 <m3fxq3ws16.fsf@localhost.localdomain>
	 <alpine.DEB.1.00.0807211255010.3305@eeepc-johanness>
	 <20080721110436.GA8395@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807211221310.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 15:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKv5J-0008NB-Dj
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 15:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbYGUNEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 09:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbYGUNEb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 09:04:31 -0400
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:59516 "EHLO
	nerv.dolda2000.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYGUNEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 09:04:30 -0400
Received: from [IPv6:2002:52b6:8514:200:21d:7dff:fea1:197] ([IPv6:2002:52b6:8514:200:21d:7dff:fea1:197])
	(authenticated bits=0)
	by nerv.dolda2000.com (8.13.8/8.13.8/Debian-3) with ESMTP id m6LD4D3c011507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jul 2008 15:04:13 +0200
In-Reply-To: <alpine.DEB.1.00.0807211221310.8986@racer>
X-Mailer: Evolution 2.22.3.1 
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (nerv.dolda2000.com [IPv6:2002:52b6:8514:200::1]); Mon, 21 Jul 2008 15:04:13 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89354>

On Mon, 2008-07-21 at 12:22 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 21 Jul 2008, Jeff King wrote:
> 
> > On Mon, Jul 21, 2008 at 12:56:14PM +0200, Johannes Schindelin wrote:
> > 
> > > > or syntax used in RPM spec macros
> > > > 
> > > >   %{?p:-P %p}
> > > > 
> > > > (and there is complementing %{!?<var>:<expansion>} in RPM spec macro
> > > > language).
> > > 
> > > Yes, this is overkill.  I would even have passed the port argument 
> > > _always_, since the port 22 for ssh is as likely to change as hell will 
> > > not freeze over.  Actually, I am not so sure about the latter.
> > 
> > But keep in mind that "-p 22" on the command line _overrides_ what the
> > user has in their ssh config, so it is not a good idea to pass it all
> > the time.
> 
> Oh, good point.  So we might need something distasteful as what Jakub 
> proposed... Hrmpf.

Two suggestions:

 * Use %P as I suggested. I know it is kind of ugly, but I might still
   consider it less ugly than adding full shell-style substitution to
   the code. Especially considering that it would almost only have to be
   used inside of Git. Users outside of the Git source would only very
   seldomly have to touch it. (It would essentially only be those users
   who both use alternative SSH ports *and* has an non-standard default
   in their ssh_config *and* use a custom SSH command...)
 * Put the SSH port number and host name in the environment and call
   "/bin/sh -c" with the textual concatenation of the SSH command and
   the command that Git wants to call. While a bit more ugly than
   handling word splitting internally, I don't really think that it has
   any real ill effects, seeing how the Git command is word-split on the
   remote side anyhow (I think that has to be SSH's most stupid
   "feature").

Fredrik Tolf
