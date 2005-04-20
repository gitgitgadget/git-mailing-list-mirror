From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 23:43:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504191708.23536.mason@suse.com>
 <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org> <200504192049.21947.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 08:38:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO8qV-0000w6-Ch
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 08:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVDTGmE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 02:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVDTGmE
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 02:42:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:15314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261338AbVDTGmA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 02:42:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3K6fus4027141
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 23:41:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3K6fsku022625;
	Tue, 19 Apr 2005 23:41:55 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504192049.21947.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Chris Mason wrote:
> 
> I'll finish off the patch once you ok the basics below.  My current code works 
> like this:

Chris, before you do anything further, let me re-consider.

Assuming that the real cost of write-tree is the compression (and I think
it is), I really suspect that this ends up being the death-knell to my
"use the sha1 of the _compressed_ object" approach. I thought it was
clever, and I was ready to ignore the other arguments against it, but if
it turns out that we can speed up write-tree a lot by just doing the SHA1
on the uncompressed data, and noticing that we already have the tree
before we need to compress it and write it out, then that may be a good
enough reason for me to just admit that I was wrong about that decision.

So I'll see if I can turn the current fsck into a "convert into
uncompressed format", and do a nice clean format conversion. 

Most of git is very format-agnostic, so that shouldn't be that painful. 
Knock wood.

			Linus
