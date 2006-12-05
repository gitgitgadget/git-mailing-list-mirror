X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 4 Dec 2006 21:33:12 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612042053080.20138@iabervon.org>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de>
  <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org> 
 <200612012306.41410.Josef.Weidendorfer@gmx.de>  <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
  <4570AF8F.1000801@stephan-feder.de>  <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
  <4570BFA4.8070903@stephan-feder.de> <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com>
 <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 02:33:21 +0000 (UTC)
Cc: Torgil Svensson <torgil.svensson@gmail.com>,
	sf-gmane@stephan-feder.de, sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33286>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrQ7S-0004NM-AN for gcvg-git@gmane.org; Tue, 05 Dec
 2006 03:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968033AbWLECdP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 21:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937277AbWLECdP
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 21:33:15 -0500
Received: from iabervon.org ([66.92.72.58]:4087 "EHLO iabervon.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937212AbWLECdO
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 21:33:14 -0500
Received: (qmail 8607 invoked by uid 1000); 4 Dec 2006 21:33:12 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 4
 Dec 2006 21:33:12 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Sat, 2 Dec 2006, Linus Torvalds wrote:

> So that's where I come from. And maybe I'm totally wrong. I'd like to hear 
> what people who actually _use_ submodules think.

I think you'd rather hear from people who _would_ use submodules; I've 
worked on a number of projects that would have benefitted from that 
general functionality, but nobody trusted the implementation enough to 
actually use it.

At my work, we're doing a bunch of stuff with microcontrollers. We've got 
about a dozen different boards with microcontrollers, and each of them has 
different firmware. We also have a bunch of code that can go on any of the 
boards.

The way things are organized currently is that each board has its own 
project, and there's a "common-micro" project with the common code. This 
sort of works, but it means that when you change things in common-micro, 
you never know what effect this will have on boards other than the one 
you're actually working on. What I'd like to have is that each project has 
a "common-micro" subdirectory, and changes to each of these can be merged 
into each other, but that doesn't happen automaticly, and each board's 
revisions include the common-micro revision they were created with.

A few notes: 

I'd never work on common-micro in isolation. Nothing in there even 
compiles by itself, because the compiler needs to know the target 
microcontroller type, which depends on the board it's for. It only makes 
sense to prepare a new revision of "common-micro" in the context of some 
particular board, at least if you want to test it at all.

I'd sometimes want to include temporary hacks in the common-micro for a 
particular board, when things are late and I need to change some library 
behavior in a way that I know works for the board I'm working on, but I 
don't have time to think about all of the other boards (each of which is 
special in some way).

I'd often make some change that I know improves the cleanliness of 
common-micro, but which requires changes to every board to compensate. I 
don't want to make all of the changes at once; I'll update each board 
appropriately the next time I work on it. But, of course, until I update 
each board, that board needs to keep using the version of common-micro 
without the changes.

I don't want to have repository states where stuff doesn't work, which 
means I can't do it as one big tree; I need to be able to make a commit 
with board1 and a common-micro change without having a version of board2 
that would use the changed common-micro, because I haven't come up with a 
board2 version that works with it yet.

	-Daniel
