From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Ad: fast-import problem importing dos format files under cygwin
Date: Wed, 3 Dec 2008 19:05:50 +0100
Message-ID: <20081203180550.GA5149@efreet.light.src>
References: <43827.194.138.12.144.1228290700.squirrel@artax.karlin.mff.cuni.cz> <43270.194.138.12.144.1228295417.squirrel@artax.karlin.mff.cuni.cz> <49367909.8070605@viscovery.net> <51143.194.138.12.144.1228311791.squirrel@artax.karlin.mff.cuni.cz> <20081203160446.GY23984@spearce.org> <alpine.DEB.1.00.0812031718350.28112@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 03 19:07:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7w7z-0000PU-EH
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 19:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbYLCSFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 13:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbYLCSFy
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 13:05:54 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:53176 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYLCSFy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 13:05:54 -0500
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by cuda1.bluetone.cz (Spam Firewall) with ESMTP
	id 36B5F37DB91; Wed,  3 Dec 2008 19:05:51 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by cuda1.bluetone.cz with ESMTP id iwWsTvOppB7Msf9R; Wed, 03 Dec 2008 19:05:51 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1L7w6g-0001MM-Vb; Wed, 03 Dec 2008 19:05:51 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812031718350.28112@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102274>

Hi,

On Wed, Dec 03, 2008 at 17:20:54 +0100, Johannes Schindelin wrote:
> Hi,
> On Wed, 3 Dec 2008, Shawn O. Pearce wrote:
> > Jan Hudec <bulb@ucw.cz> wrote:
> > > Dne 3 Prosinec 2008, 13:18, Johannes Sixt napsal(a):
> > > > Jan Hudec schrieb:
> > > >> On 3 December 2008, 08:51, Jan Hudec wrote:
> > > >>>
> > > >>> I have been playing with fast-import in cygwin and I have problems 
> > > >>> importing files with CR/LF line-endings. The size in data command 
> > > >>> is calculated including the CRs and than the file is copied binary 
> > > >>> to the fast-import input stream. However fast-import skips the CRs 
> > > >>> when reading, overreads by that number of bytes and fails when it 
> > > >>> tries to read the next command from the middle.
> >
> > [...] 
> > fast-import under-reading near CRs and getting misaligned on its input 
> > indicates that the stdio library has given us a FILE* for stdin which is 
> > converting CRLF pairs into LFs, even within an fread() call.
> > 
> > My guess here is fast-import's stdin is set in text mode, but it really 
> > needs to be in binary mode.  fast-import.c never attempts to correct 
> > that when it starts, so on DOS based systems we are probably totally 
> > screwed from the beginning...

Yes, it does indeed sound so. Strange thing is why it would be that way, when
it does not seem to be the case for any other process (eg. the shell will
complain loudly if I feed it a DOS formatted script). The standard input is
simple shell redirect from a file on a binary-mounted filesystem. I'll do
some more cross-checks tomorrow.

> I think you need to set the environment variable
> 
> 	CYGWIN=binmode

Will try. Thanks.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
