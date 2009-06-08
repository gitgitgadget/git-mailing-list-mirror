From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Expand the rename(2) workaround in mingw to cover case
 change in filename
Date: Mon, 8 Jun 2009 23:59:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906082355350.26154@pacific.mpi-cbg.de>
References: <20090608203248.GA22972@blimp.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDmrQ-0007j0-LV
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 23:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbZFHV6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 17:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbZFHV6W
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:58:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:58260 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752648AbZFHV6V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:58:21 -0400
Received: (qmail invoked by alias); 08 Jun 2009 21:58:21 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 08 Jun 2009 23:58:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183YFEPQCk3LGVCaINtGLaZz3mQE6qy0sgE1usV3J
	4rOCelh1jVGDr9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090608203248.GA22972@blimp.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121118>

Hi,

On Mon, 8 Jun 2009, Alex Riesen wrote:

> Windows, being a case-confused operating system, sometimes has
> problems renaming directory entries with only change in the case
> of their characters. Try to work the problem around by using an
> intermediate file.
> 
> ---
> 
> NOT TESTED. Can't. My Windows broke again. Not even compile-tested.

Yes, that is pretty easy to see as you first used pold/pnew and then 
src/dst.

I minimally fixed up your patch (it now uses strbuf), and added a 
test-case.

This test-case is actually crucial: it shows that your patch is not 
enough: the culprit is this code in builtin-mv.c:167--168:

                else if (lstat(dst, &st) == 0) {
                        bad = "destination exists";

Ciao,
Dscho
