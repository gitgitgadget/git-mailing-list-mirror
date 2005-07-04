From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: expensive local git clone
Date: Mon, 4 Jul 2005 13:39:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507041327580.3570@g5.osdl.org>
References: <20050704.125744.59481768.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 22:40:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpXjD-0002BJ-8P
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 22:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVGDUjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 16:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVGDUjd
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 16:39:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261639AbVGDUjP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 16:39:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j64KdAjA019084
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 4 Jul 2005 13:39:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j64Kd9Sa002818;
	Mon, 4 Jul 2005 13:39:10 -0700
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050704.125744.59481768.davem@davemloft.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 4 Jul 2005, David S. Miller wrote:
> 
> I can't be the only person in the world seeing this :-)
> It usually grows to around 88MB and runs for 8 minutes before
> it finishes.

I'm making something based on pack-files.

git-local-pull is indeed walking the whole tree and copying one file at a
time. We shouldn't use "git-fetch-script" in "git clone" (it's really
designed for doing one file at a time and for small updates),

That said, the pack-file thing I'm working on won't be perfect either, and
the main advantage is that it should work over ssh. The fastest way to do
a clone is really to do a recursive hardlinked tree, so you may well want
to just do

	#!/bin/sh
	mkdir "$2" && cp -rl "$1/.git" "$2/.git"

and it should be about a million times faster and equally effective.

Untested, of course.

		Linus
