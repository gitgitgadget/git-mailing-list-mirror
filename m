From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Ad: fast-import problem importing dos format files under
 cygwin
Date: Wed, 3 Dec 2008 17:20:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812031718350.28112@intel-tinevez-2-302>
References: <43827.194.138.12.144.1228290700.squirrel@artax.karlin.mff.cuni.cz> <43270.194.138.12.144.1228295417.squirrel@artax.karlin.mff.cuni.cz> <49367909.8070605@viscovery.net> <51143.194.138.12.144.1228311791.squirrel@artax.karlin.mff.cuni.cz>
 <20081203160446.GY23984@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Hudec <bulb@ucw.cz>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 17:22:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7uUh-0005uq-9Y
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 17:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbYLCQVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 11:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbYLCQVO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 11:21:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:59865 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751098AbYLCQVN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 11:21:13 -0500
Received: (qmail invoked by alias); 03 Dec 2008 16:21:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp029) with SMTP; 03 Dec 2008 17:21:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+FmAMzaJ+evZ3fsAwrGz4P3HWh2JW+yl2El5QdA
	aLBbxf2yb0cOQc
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20081203160446.GY23984@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102270>

Hi,

On Wed, 3 Dec 2008, Shawn O. Pearce wrote:

> Jan Hudec <bulb@ucw.cz> wrote:
> > Dne 3 Prosinec 2008, 13:18, Johannes Sixt napsal(a):
> > > Jan Hudec schrieb:
> > >> On 3 December 2008, 08:51, Jan Hudec wrote:
> > >>>
> > >>> I have been playing with fast-import in cygwin and I have problems 
> > >>> importing files with CR/LF line-endings. The size in data command 
> > >>> is calculated including the CRs and than the file is copied binary 
> > >>> to the fast-import input stream. However fast-import skips the CRs 
> > >>> when reading, overreads by that number of bytes and fails when it 
> > >>> tries to read the next command from the middle.
> > >
> > > Do you happen to have core.autocrlf set in some way and could it 
> > > make a difference for fast-import? I have it unset.
> > 
> > I have it set to false explicitly in global config. Tried with not 
> > having it set at all and gives the same problem. Since the previous 
> > version of MSys Git worked for me, I suspect it's somehow 
> > cygwin-related.
> 
> Huh.  So fast-import *never* does auto-CRLF conversion, even if the 
> property is set.  It just doesn't make those calls internally. It 
> blindly copies data from the input stream into the pack. No exceptions.
> 
> fast-import under-reading near CRs and getting misaligned on its input 
> indicates that the stdio library has given us a FILE* for stdin which is 
> converting CRLF pairs into LFs, even within an fread() call.
> 
> My guess here is fast-import's stdin is set in text mode, but it really 
> needs to be in binary mode.  fast-import.c never attempts to correct 
> that when it starts, so on DOS based systems we are probably totally 
> screwed from the beginning...

I think you need to set the environment variable

	CYGWIN=binmode

Hth,
Dscho
