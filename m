X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: fetching packs and storing them as packs
Date: Thu, 26 Oct 2006 20:50:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610262038320.11384@xanadu.home>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
 <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home>
 <45413209.2000905@tromer.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 27 Oct 2006 01:13:16 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <45413209.2000905@tromer.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30269>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdFvN-0000Av-Sq for gcvg-git@gmane.org; Fri, 27 Oct
 2006 02:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423733AbWJ0AuO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 20:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423736AbWJ0AuO
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 20:50:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49579 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1423733AbWJ0AuN
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 20:50:13 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7R0043XRNOQNI0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Thu,
 26 Oct 2006 20:50:12 -0400 (EDT)
To: Eran Tromer <git2eran@tromer.org>
Sender: git-owner@vger.kernel.org

On Fri, 27 Oct 2006, Eran Tromer wrote:

> Hi,
> 
> On 2006-10-26 17:08, Nicolas Pitre wrote:
> > On Thu, 26 Oct 2006, Eran Tromer wrote:
> >> This creates a race condition w.r.t. "git repack -a -d", similar to the
> >> existing race condition between "git fetch --keep" and
> >> "git repack -a -d". There's a point in time where the new pack is stored
> >> but not yet referenced, and if "git repack -a -d" runs at that point it
> >> will eradicate the pack. When the heads are finally updated, you get a
> >> corrupted repository.
> > 
> > And how is it different from receiving a pack through git-unpack-objects 
> > where lots of loose objects are created, and git-repack -a -d removing 
> > those unconnected loose objects before the heads are updated?
> 
> git-repack -a -d does not touch unconnected loose objects.
> It removes only unconnected packed objects.

Right.

> Only git-prune removes unconnected loose objects, and that's documented
> as unsafe.

Well, the race does exist.  Don't do repack -a -d at the same time then.

This race should be adressed somehow if it is really a problem.  Now 
that I've used index-pack in place of unpack-objects for a while, I 
don't think I'll want to go back.  It is simply faster to fetch, faster 
to checkout, faster to repack, wastes less disk space, etc.


