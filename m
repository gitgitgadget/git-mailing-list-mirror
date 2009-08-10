From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix potential infinite loop given large unsigned
 integer
Date: Mon, 10 Aug 2009 14:24:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908101421340.8324@intel-tinevez-2-302>
References: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com>  <7v3a81a13z.fsf@alter.siamese.dyndns.org>  <40aa078e0908090525h7b4d6efeh658e2edcfbe16c7e@mail.gmail.com>  <200908100724.53345.chriscool@tuxfamily.org>
 <40aa078e0908100412l3c2afd1bnda9b10aaf1de383f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ryan Flynn <parseerror@gmail.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 14:24:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaTvk-00065y-JY
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 14:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbZHJMYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 08:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbZHJMYj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 08:24:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:58838 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754000AbZHJMYi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 08:24:38 -0400
Received: (qmail invoked by alias); 10 Aug 2009 12:24:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 10 Aug 2009 14:24:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/c5i4YnfPc7n6KXr4qSOFjeCaY87DbdWptDcuoTC
	EtB4xmkZMr0KbA
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <40aa078e0908100412l3c2afd1bnda9b10aaf1de383f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125438>

Hi,

On Mon, 10 Aug 2009, Erik Faye-Lund wrote:

> On Mon, Aug 10, 2009 at 7:24 AM, Christian
> Couder<chriscool@tuxfamily.org> wrote:
> >> log10() appears to be C99, but can be emulated on earlier C-versions by
> >> doing #define log10(x) (log(x) / log(10.0))
> >
> > That would mean linking with -lm?
> 
> I guess so. Are we currently trying to avoid linking to the math-parts 
> of libc?

Yes.

I guess we could fix the overflow thing very easily, though:

static unsigned int digits_of_number(unsigned int number) {
	unsigned int result;
	for (result = 1; number; number /= 10, result++)
		; /* do nothing */
	return result;
}

Ciao,
Dscho
