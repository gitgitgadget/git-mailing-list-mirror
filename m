X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Wed, 6 Dec 2006 16:47:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612061642440.3542@woody.osdl.org>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com>
 <20061206192800.GC20320@spearce.org> <Pine.LNX.4.63.0612070025450.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 00:48:21 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612070025450.28348@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33540>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs7Qq-0004H0-Vl for gcvg-git@gmane.org; Thu, 07 Dec
 2006 01:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937848AbWLGAsI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 19:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937864AbWLGAsI
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 19:48:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60033 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937848AbWLGAsF
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 19:48:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB70ltID013154
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 6
 Dec 2006 16:47:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB70ls7B023154; Wed, 6 Dec
 2006 16:47:55 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Thu, 7 Dec 2006, Johannes Schindelin wrote:
> 
> Because, depending on what you do, the revision machinery is not 
> reentrable. For example, if you filter by filename, the history is 
> rewritten in-memory to simulate a history where just that filename was 
> tracked, and nothing else. These changes are not cleaned up after calling 
> the internal revision machinery.

Well, it really wouldn't be that hard to add a new library interface to 
"reset object state". We could fairly trivially either:

 - walk all objects in the object hashes and clear all the flags.
 - just clear all objects _and_ the hashes.

Yes, it implies a small amount of manual "management", but considering 
that the reason it needs to be manual is that the functions simply _need_ 
the state, is that such a big deal?

