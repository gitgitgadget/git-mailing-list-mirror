X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Bypass expensive content comparsion during rename
 detection.
Date: Thu, 14 Dec 2006 12:18:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141214440.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061214100746.GA31191@spearce.org>
 <Pine.LNX.4.63.0612141151220.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061214110858.GE1747@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 11:18:46 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061214110858.GE1747@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34316>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guobl-0004CM-Va for gcvg-git@gmane.org; Thu, 14 Dec
 2006 12:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932592AbWLNLSd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 06:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWLNLSd
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 06:18:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:48635 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932592AbWLNLSc
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 06:18:32 -0500
Received: (qmail invoked by alias); 14 Dec 2006 11:18:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp049) with SMTP; 14 Dec 2006 12:18:30 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Shawn Pearce wrote:

> My first version of the patch had the hash comparsion right after we 
> called diff_populate_filespec to get the size data.  But then I realized 
> that very often the sizes will be different and the src->size != 
> dst->size comparsion will tend to be true most of the time, thus saving 
> us a (relatively) expensive hash comparsion, which we know must fail 
> anyway if the sizes differed.

Ah! I misunderstood. Since the call to diff_populate_filespec was not 
visible in the hunk, I erroneously assumed that you meant to _check_ the 
sizes before checking the hashes.

But your explanation makes lots of sense to me. May I request a short 
comment above the new code, like "let diff_populate_filespec() do its 
thing since we need the filesize later on anyway, and having that, do the 
cheaper filesize check before the more expensive hashcmp()"?

Ciao,
Dscho
