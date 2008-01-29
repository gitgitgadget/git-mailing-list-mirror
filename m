From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH/PATCH] prefix_path(): disallow absolute paths
Date: Tue, 29 Jan 2008 02:37:59 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801290234590.23907@racer.site>
References: <47975FE6.4050709@viscovery.net> <1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com> <alpine.LSU.1.00.0801272043040.23907@racer.site> <7v3asiyk2i.fsf@gitster.siamese.dyndns.org> <20080128003404.GA18276@lintop> <7vodb6wtix.fsf@gitster.siamese.dyndns.org>
 <479D805E.3000209@viscovery.net> <7vprvmuykw.fsf@gitster.siamese.dyndns.org> <479D9ADE.6010003@viscovery.net> <alpine.LSU.1.00.0801281210440.23907@racer.site> <7vwspts9vj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 03:39:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgNP-0007Up-Bi
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 03:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbYA2CiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 21:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbYA2CiX
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 21:38:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:50203 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752672AbYA2CiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 21:38:22 -0500
Received: (qmail invoked by alias); 29 Jan 2008 02:38:20 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO [192.168.1.69]) [86.138.198.40]
  by mail.gmx.net (mp047) with SMTP; 29 Jan 2008 03:38:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1871pAYK6s71hNl0REl9961Zyl/7e02AqRjdmGrqd
	hxUlaLwW0pSZGK
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwspts9vj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71919>

Hi,

On Mon, 28 Jan 2008, Junio C Hamano wrote:

> If we are touching the prefix_path(), I think we should try to make its 
> "ambiguous path rejection" more complete.

I should have made more clear that I tried to avoid exactly that before 
1.5.4, I guess.

> This is not to be applied (especially before auditing the callers), but 
> to be thought about.  Although it passes all the tests...

It certainly is tempting.


> +			while (c == '/')
> +				c = *src++;
> +			src--;

This is ugly.  I would like this better:

			while (src[1] == '/')
				src++;

> +const char *prefix_path(const char *prefix, int len, const char *path)
> +{
> +	const char *orig = path;
> +	char *sanitized = xmalloc(len + strlen(path) + 1);

There _has_ to be a way to avoid malloc()ing things that will _never_ be 
free()d again with every second patch ;-)

Ciao,
Dscho
