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
Date: Thu, 14 Dec 2006 11:53:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141151220.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061214100746.GA31191@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 10:53:22 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061214100746.GA31191@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34311>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuoDC-0000tW-MI for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932106AbWLNKxL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWLNKxL
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:53:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:47544 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932106AbWLNKxK
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 05:53:10 -0500
Received: (qmail invoked by alias); 14 Dec 2006 10:53:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp037) with SMTP; 14 Dec 2006 11:53:08 +0100
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Shawn O. Pearce wrote:

> When comparing file contents during the second loop through a rename 
> detection attempt we can skip the expensive byte-by-byte comparsion if 
> both source and destination files have valid SHA1 values.  This improves 
> performance by avoiding either an expensive open/mmap to read the 
> working tree copy, or an expensive inflate of a blob object.
> 
> Unfortunately we still have to at least initialize the sizes of the 
> source and destination files even if the SHA1 values don't match. 
> Failing to initialize the sizes causes a number of test cases to fail 
> and start reporting different copy/rename behavior than was expected.

It has a wrong feel to it when you say we have to check the sizes first. 
After all, we are heavily relying on the hashes being different, including 
the case when the sizes are different. So, the order of the checks should 
_not_ matter. I suspect that somewhere sha1_valid should be set to 0, but 
isn't.

Ciao,
