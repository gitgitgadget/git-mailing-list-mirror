From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] http-backend: Don't infinite loop during die()
Date: Wed, 24 Mar 2010 16:24:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003241623370.694@xanadu.home>
References: <51569EE6-A926-45DB-A588-B659750BA643@catherman.org>
 <20100322142204.GB8916@spearce.org> <7vvdclk1y9.fsf@alter.siamese.dyndns.org>
 <20100324200658.GA22505@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Brady Catherman <brady@catherman.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 24 21:24:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuX7p-0001G3-L4
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330Ab0CXUYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 16:24:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40989 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313Ab0CXUYT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 16:24:19 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZS007ERZCIW010@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 24 Mar 2010 16:24:19 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100324200658.GA22505@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143117>

On Wed, 24 Mar 2010, Shawn O. Pearce wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > 
> > > If stdout has already been closed by the CGI and die() gets called,
> > > the CGI will fail to write the "Status: 500 Internal Server Error" to
> > > the pipe, which results in die() being called again (via safe_write).
> > > This goes on in an infinite loop until the stack overflows and the
> > > process is killed by SIGSEGV.
> > >
> > > Instead set a flag on the first die() invocation and perform no
> > > action during recursive die() calls.  This way failures to write the
> > > error messages to the stdout pipe do not result in an infinite loop.
> > 
> > Hmm.  I would need something like this on top, but there must be a better
> > way.  Ideas?
> 
> Ick.
> 
> Just exit(0) if dead is true.

Do you really want the exit code to be 0 if you're dying?


Nicolas
