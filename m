X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fetching from a big repository is slow
Date: Fri, 15 Dec 2006 00:15:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612150013390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se>
 <Pine.LNX.4.63.0612141513130.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <4581685D.1070407@op5.se> <C287764F-6755-4291-A87A-3E8816E90B49@adacore.com>
 <20061214194636.GO1747@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 23:16:07 +0000 (UTC)
Cc: Geert Bosch <bosch@adacore.com>, Andreas Ericsson <ae@op5.se>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061214194636.GO1747@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34432>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guzo0-0008TT-Ho for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751851AbWLNXP3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbWLNXP3
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:15:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:51585 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751851AbWLNXP1
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 18:15:27 -0500
Received: (qmail invoked by alias); 14 Dec 2006 23:15:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp034) with SMTP; 15 Dec 2006 00:15:26 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Shawn Pearce wrote:

> Geert Bosch <bosch@adacore.com> wrote:
> > Such special magic based on filenames is always a bad idea. Tomorrow  
> > somebody
> > comes with .zip files (oh, and of course .ZIP), then it's .jpg's other
> > compressed content. In the end git will be doing lots of magic and  
> > still perform
> > badly on unknown compressed content.
> > 
> > There is a very simple way of detecting compressed files: just look  
> > at the
> > size of the compressed blob and compare against the size of the  
> > expanded blob.
> > If the compressed blob has a non-trivial size which is close to the  
> > expanded
> > size, assume the file is not interesting as source or target for deltas.
> > 
> > Example:
> >    if (compressed_size > expanded_size / 4 * 3 + 1024) {
> >      /* don't try to deltify if blob doesn't compress well */
> >      return ...;
> >    }
> 
> And yet I get good delta compression on a number of ZIP formatted files 
> which don't get good additional zlib compression (<3%). Doing the above 
> would cause those packfiles to explode to about 10x their current size.

A pity. Geert's proposition sounded good to me.

However, there's got to be a way to cut short the search for a delta 
base/deltification when a certain (maybe even configurable) amount of time 
has been spent on it.

Ciao,
Dscho
