From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 09:21:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506280903510.19755@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506280049090.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506280846100.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 18:13:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnIi1-0003sD-O8
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 18:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVF1QUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 12:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVF1QUN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 12:20:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60853 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262142AbVF1QTq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 12:19:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5SGJRjA029403
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 09:19:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5SGJNmU011549;
	Tue, 28 Jun 2005 09:19:25 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.58.0506280846100.19755@ppc970.osdl.org>
X-Spam-Status: No, hits=0.667 required=5 tests=MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Linus Torvalds wrote:
> 
> Oh, you'd never just transfer the whole big pack-file at all: you'd just 
> create a new one. And creatign a new one is just a matter of finding the 
> common parent, and then doing
> 
> 	git-rev-list --objects common..HEAD | git-pack-file .git/tmp-pack
> 
> and then you send the result to the other side..

To clarify: this also works with objects that are already in another
pack-file (now that Junio fixed the "get size of a deltified packed
entry"), so you can have any number of unpacked objects in your objects
directory, _and_ a pack-file (or several), and you can generate a new
temporary pack-file just for sending somewhere else that contains
arbistrary parts of that (ie a mix of objects that are in your "main"
packfiles and objects that are unpacked).

You don't have to use "git-rev-list" to generate the objects, btw,
git-pack-file takes an arbitrary list of object ID's (plus a "packing
hint" in the form of a filename that is not required, but that can help
the packing heuristics, and that git-rev-list does provide).

I'll also fix up git-pack-file to be able to pack tag objects (and the
unpacking to understand them), so that any valid object can be packed. 
Right now it only handles the objects that git-rev-list knows about.

		Linus
