X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fetch slow as molasses due to tag downloading
Date: Thu, 14 Dec 2006 17:05:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141701440.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <elrr8j$a02$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 16:05:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <elrr8j$a02$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34359>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gut5F-00038x-2y for gcvg-git@gmane.org; Thu, 14 Dec
 2006 17:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932826AbWLNQFS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 11:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932844AbWLNQFR
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 11:05:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:53095 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932826AbWLNQFQ
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 11:05:16 -0500
Received: (qmail invoked by alias); 14 Dec 2006 16:05:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp049) with SMTP; 14 Dec 2006 17:05:15 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Han-Wen Nienhuys wrote:

> just upgraded our autobuilder from 1.4.3 to 1.4.4.2.
> 
> Now, our standard download command comes to a complete halt.  Judging
> >from the "ps -ef" apparently, it does 
> 
>    git-show-ref --verify --quiet -- [TAG]
> 
> This is done for every one of the 1500 tags that are in my repository. 
> At approx 20 tags per second this takes an awful lot of time. 
> 
> 1. Is this necessary? 

Yes. The purpose is to check which tags have not yet been fetched.

> 2. Is this efficient?  Wouldn't doing all tags in a single git-show-ref 
> invocation be potentially quicker?

It is not efficient. But it cannot be solved like you propose, since it is 
inside a loop, and a "continue" is executed when the tag exists already.

IMHO this should be solved as a filter: "git-show-ref --stdin 
--show-invalid". Thus, git does not have to traverse _every_ ref for 
_every_ incoming tag.

Ciao,
Dscho
