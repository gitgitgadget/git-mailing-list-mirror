X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 08:57:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612190855300.3479@woody.osdl.org>
References: <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
 <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
 <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
 <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org>
 <20061219063930.GA2511@spearce.org> <20061219161919.GA16980@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 16:58:07 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061219161919.GA16980@thunk.org>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34835>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwiHt-0005UU-SB for gcvg-git@gmane.org; Tue, 19 Dec
 2006 17:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932839AbWLSQ5l (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 11:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932840AbWLSQ5l
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 11:57:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45638 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932839AbWLSQ5k
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 11:57:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBJGvVoQ017729
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 19
 Dec 2006 08:57:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBJGvTkU003531; Tue, 19 Dec
 2006 08:57:30 -0800
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org



On Tue, 19 Dec 2006, Theodore Tso wrote:
> 
> So the main reason to use mamp, as Linus puts it, is if the management
> overhead of needing to read lots of small bits of the file makes the
> use of malloc/read to be a pain in the *ss, then go for it.

An example of this in git is the regular pack-file accesses. We're MUCH 
better off just mmap'ing the whole pack-file (or at least big chunks of 
it) and not having to maintain difficult structures of "this is where I 
read that part of the file into memory", or read _big_ chunks when 
quite often we just use a few kB of it.

So mmap for pack-files does make sense, but probably only when you can 
mmap big chunks, and are going to access much smaller (random) parts of 
it.

