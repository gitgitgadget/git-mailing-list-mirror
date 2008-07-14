From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Mon, 14 Jul 2008 13:44:50 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20080713011512.GB31050@spearce.org> <1216001267-33235-1-git-send-email-spearce@spearce.org> <alpine.LFD.1.10.0807132220570.12484@xanadu.home> <20080714031242.GA14542@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 13:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIMV7-0007zr-2l
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 13:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbYGNLoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 07:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYGNLoy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 07:44:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:54139 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752804AbYGNLox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 07:44:53 -0400
Received: (qmail invoked by alias); 14 Jul 2008 11:44:51 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp057) with SMTP; 14 Jul 2008 13:44:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Ckys07itCS8tWAzoTOPf1FIjsuOH9aU03hiwdwF
	y7b8BaphAucUXs
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080714031242.GA14542@spearce.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88411>

Hi,

On Mon, 14 Jul 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Sun, 13 Jul 2008, Shawn O. Pearce wrote:
> > 
> > > This should resolve the obscene memory usage of index-pack when
> > > resolving deltas for very large files.
> > 
> > I don't like this.  Not your patch, but rather the direction this whole 
> > thing took in the first place, and now we have to bolt extra complexity 
> > on top.
> > 
> > I have the feeling this is not the best approach, especially since many 
> > long delta chains are going deep and all those intermediate objects are 
> > simply useless once the _only_ delta child has been resolved and 
> > therefore could be freed right away instead.
> 
> I thought about trying to free a base object if this is the last 
> resolve_delta() call which would require that data, but I realized this 
> is just a "tail-call optimization" and doesn't work in the more general 
> case.

However, for cases like Stephan's I assume this is the rule.  If you 
think of it, most use cases for such a big blob are one-user, 
append-only.

> The only other alternative I can come up with is to change pack-objects 
> (or at least its defaults) so we don't generate these massive delta 
> chains.  But there are already packs in the wild that use these chains, 
> resulting in performance problems for clients.

But the long chains make the pack actually as efficient as it is...

Ciao,
Dscho
