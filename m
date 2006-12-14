X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid accessing a slow working copy during diffcore
 operations.
Date: Thu, 14 Dec 2006 16:37:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141633340.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061214111557.GA24297@spearce.org> 
 <81b0412b0612140557u225ca00du5b15823d05fda4b9@mail.gmail.com> 
 <Pine.LNX.4.63.0612141511110.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0612140649i71643aaar847460ca9e4cea48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 15:37:51 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0612140649i71643aaar847460ca9e4cea48@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34351>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuseT-0006q2-IH for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932177AbWLNPhj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932806AbWLNPhi
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:37:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:59283 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932177AbWLNPhi
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 10:37:38 -0500
Received: (qmail invoked by alias); 14 Dec 2006 15:37:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp045) with SMTP; 14 Dec 2006 16:37:36 +0100
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Alex Riesen wrote:

> On 12/14/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > It is usually cheaper to just read the file, especially if it is still 
> > cached, because the alternative means unpacking the loose object, or 
> > worse, unpacking the packed object _along_ with the objects in its 
> > delta chain.
> 
> But you have to read less, and even that could be in cache as well and 
> unpacking in userspace could be faster than open/write temporary/ read 
> temporary/close/unlink temporary file on a normal system

You have to unpack anyway, since even the loose objects are packed. But to 
reconstruct a deltified object, you have to reconstruct possibly many 
objects.

So yes, if you have it in the working directory (unpacked), it should be 
faster to just read it, especially if it is still in the filesystem cache.

> > Not every OS sucks cache-wise, and you should not make others suffer 
> > for Redmond's shortcomings.
> 
> I'm just do not understand why avoiding temporary file wouldn't help all 
> OSes, even if they do not suck cache-wise.

Ah! But it is not temporary! It is the "working copy", which means the 
file you have in the working directory. IOW it is an unpacked blob, which 
happens to be already unpacked anyway.

Ciao,
Dscho
