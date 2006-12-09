X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 09 Dec 2006 04:16:24 -0500
Message-ID: <457A7EE8.80207@garzik.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org> <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org> <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org> <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org> <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org> <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net> <45798FE2.9040502@zytor.com> <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org> <457998C8.3050601@garzik.org> <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org> <4579FABC.5070509@garzik.org> <Pine.LNX.4.64.0612081640400.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 09:17:14 +0000 (UTC)
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0612081640400.3516@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33807>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsyKM-0004iJ-CX for gcvg-git@gmane.org; Sat, 09 Dec
 2006 10:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936553AbWLIJQo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 04:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936563AbWLIJQo
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 04:16:44 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:59255 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S936553AbWLIJQm
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 04:16:42 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1GsyJm-0002G2-1t; Sat, 09 Dec 2006 09:16:26 +0000
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 8 Dec 2006, Jeff Garzik wrote:
>> This is a bit cheesy, and completely untested, but since mod_cache never
>> worked for me either, I bet it works better ;-)
> 
> Ok, this doesn't do the locking either, so on cache misses or expiry, 
> you're still going to be that thundering herd.

Well, gdbm does reader/write locking.

You still bit a bit of a thundering herd, though.  I suppose I could 
open the gdbm db for writing before calling the CGI, which would 
effectively get what you're looking for.


> Also, if you want to be nice to clients, I'd seriously suggest that when 
> you hit in the cache, but it's expired (or it's close to expired), you 
> still serve the cached data back, but you set up a thread in the 
> background (with some maximum number of active threads, of course!) that 
> refreshes the cached entry and then you extend the expiration time so that 
> you won't end up doing this "refresh" _again_.
> 
> It's kind of silly to have people wait for 20 seconds just because a cache 
> expired five seconds ago. Much nicer to say "ok, we allow a certain 
> grace-period during which we'll do the real lookup, but to make things 
> _look_ really responsive, we still use the old cached value".

True, should work with gitweb data at least.

	Jeff

