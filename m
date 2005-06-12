From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [zooko@zooko.com: [Revctrl] colliding md5 hashes of human-meaningful
 documents]
Date: Sun, 12 Jun 2005 10:03:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506120949150.2286@ppc970.osdl.org>
References: <20050612082555.GB6620@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 19:01:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhVlp-0007iW-PH
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 18:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVFLRBi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 13:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVFLRBi
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 13:01:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58318 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262647AbVFLRB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2005 13:01:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5CH1OjA030382
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Jun 2005 10:01:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5CH1NLQ006125;
	Sun, 12 Jun 2005 10:01:23 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050612082555.GB6620@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 12 Jun 2005, Petr Baudis wrote:
>
> I expected the two postscript files differing in some huge binary blob,
> but it turns out the binary part is very small (about 256 bytes) and
> only few (about nine) bytes are different, contrary to how people have
> predicted the collisions. This is much more close to finding a collision
> between similar pure C files, I think. Rather unsettling.

This is not close at all. The "small" binary blob (256 bytes) only encodes 
one single bit of information.

In other words, they've really changed _one_ bit of information by doing a
256-byte random binary blob. Anybody who calls that "small" didn't really
look closely.

Is it clever? Yes. But it isn't about making one C file look like another,
it's using the property of controlling _both_ of the files, and making
them contain all the information, and then making the the single-bit
change collapse the output into two different modes by using a postscript
interpreter to make it print out the same.

Is it a real problem? Yes, because a _lot_ of document formats are
structured and are amenable to things like this. But the problem here is
the fact that you can fool somebody into signing something without
realizing that it has a lot of hidden information thanks to having formats
that can hide the blobs.

So the problem is totally different from the way git uses a hash. In the 
git model, an attacker by definition cannot control both versions of a 
file, since if he controls just _one_ version, he doesn't need to do the 
attack in the first place!

Put another way: you could use this exact example for a version of git
that uses md5-sums instead of sha1's, but it wouldn't show anything at all 
about a git vulnerability even so.

The one thing it does show is that you should probably never sign anything 
but a nice human-readable ASCII file that you actually opened in your own 
editor.

		Linus
