X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: lockfiles & fork()
Date: Fri, 27 Oct 2006 18:52:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610271851130.3849@g5.osdl.org>
References: <Pine.LNX.4.63.0610280319250.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 28 Oct 2006 02:01:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0610280319250.26682@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30357>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GddNN-0007Cc-ER for gcvg-git@gmane.org; Sat, 28 Oct
 2006 03:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751550AbWJ1BwY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 21:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWJ1BwY
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 21:52:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38039 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1751550AbWJ1BwX (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 21:52:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9S1qKPo007169
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 27
 Oct 2006 18:52:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9S1qJhD011522; Fri, 27 Oct
 2006 18:52:19 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Sat, 28 Oct 2006, Johannes Schindelin wrote:
> 
> when you setup a lockfile, and then fork(), you could easily end up with 
> atexit() kicking in to remove the lockfile, before the main process has a 
> chance to commit. (Yes, I need to hold the lock long before the fork()).

The easiest way to handle this would be for the lockfile logic to just 
save the pid associated with each lockfile... And for the atexit function 
to just ignore it if the pid doesn't match. 

