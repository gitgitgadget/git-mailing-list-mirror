From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Mon, 14 Jul 2008 13:58:34 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807141357430.8950@racer>
References: <20080713011512.GB31050@spearce.org> <1216001267-33235-1-git-send-email-spearce@spearce.org> <alpine.LFD.1.10.0807132220570.12484@xanadu.home> <20080714031242.GA14542@spearce.org> <alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de>
 <m31w1wu1hc.fsf@localhost.localdomain> <487B439F.8040902@op5.se> <alpine.DEB.1.00.0807141322140.8950@racer> <487B4BD8.5030208@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Jul 14 14:59:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KINeP-0002hy-9p
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 14:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbYGNM6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 08:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbYGNM6f
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 08:58:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:53358 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753186AbYGNM6e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 08:58:34 -0400
Received: (qmail invoked by alias); 14 Jul 2008 12:58:33 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp052) with SMTP; 14 Jul 2008 14:58:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rbx4rbMorx4LOawoDaHE73Ur41Lk8Lmn8lcBopl
	QC4poIVGpcQO/g
X-X-Sender: gene099@racer
In-Reply-To: <487B4BD8.5030208@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88427>

Hi,

On Mon, 14 Jul 2008, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> > On Mon, 14 Jul 2008, Andreas Ericsson wrote:
> > 
> > > Sorry for being clueless here, but why does the older versions need
> > > to be kept in-memory anyway? Aren't we applying the delta each time
> > > we find one, repeatedly creating a new base-object in-memory for
> > > each delta? If we aren't doing that, why do we need more than just
> > > a small amount of memory just for keeping the delta?
> > 
> > Think of a delta chain of 49 delta objects, 1 base object.  Now reconstruct
> > all of the objects.
> > 
> > If you do it one by one, not storing the intermediate results, you end up
> > applying 1 delta for the first, 2 for the second (first the first, then the
> > second), and so on, in total 1 + 2 + 3 + ... + 49 = 49 * 50 / 2 = 1225
> > times.
> > 
> > Compare that to the 49 times when reusing the intermediate results.
> > 
> 
> [...]
>
> while (pop_delta(patch_stack))
> 	apply_delta(base_object, delta);
> 
> where "apply_delta" replaces the base_object->blob with the delta 
> applied, releasing the previously used memory?

Delta chains are not (necessarily) independent.

Ciao,
Dscho
