X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: weird strncmp usage?
Date: Thu, 2 Nov 2006 10:15:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611021008180.1670@wbgn013.biozentrum.uni-wuerzburg.de>
References: <eibhga$tpg$1@sea.gmane.org> <45494D84.2060402@shadowen.org>
 <20061102065127.GA23105@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 2 Nov 2006 09:15:37 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>, hanwen@xs4all.nl,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061102065127.GA23105@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30694>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfYfR-0005qG-Ls for gcvg-git@gmane.org; Thu, 02 Nov
 2006 10:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752765AbWKBJPR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 04:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbWKBJPQ
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 04:15:16 -0500
Received: from mail.gmx.de ([213.165.64.20]:45971 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1752766AbWKBJPP (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 04:15:15 -0500
Received: (qmail invoked by alias); 02 Nov 2006 09:15:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp044) with SMTP; 02 Nov 2006 10:15:13 +0100
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 2 Nov 2006, Jeff King wrote:

> On Thu, Nov 02, 2006 at 01:44:36AM +0000, Andy Whitcroft wrote:
> 
> > That said if you know its constant you can also use sizeof("foo") and
> > that is done at compile time.  Something like:
> > 
> > #define strxcmp(x, y)	strncmp((x), (y), sizeof((y))
> 
> You would, of course, need to use sizeof(y)-1 to avoid comparing the NUL
> termination. :)
> 
> This is a slightly dangerous macro, because it _only_ works for string
> literals, but not pointers (which is fine in this case, but its
> limitations need to be documented).

It would be even better to avoid these errors by doing something like

	#define starts_with(x, y) !strncmp((x), #y, sizeof(#y) - 1)

which would be used like this:

	if (starts_with(arg, --abbrev=))

However, in this case, you would need another macro, which automatically 
extracts the argument, and soon you will end up with yet another getopt 
package.

Ciao,
Dscho
