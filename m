From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "GIT_INDEX_FILE" environment variable
Date: Thu, 21 Apr 2005 11:37:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504211130480.2344@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Apr 21 20:32:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgSz-0007tC-7O
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVDUSgU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVDUSgU
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:36:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:4226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261654AbVDUSfx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 14:35:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3LIZns4015369
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:35:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3LIZmUC016820
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:35:49 -0700
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 21 Apr 2005, Linus Torvalds wrote:
> 
> You can also use it to test merges without screwing up your old index file 
> in case something goes wrong.

Btw, if it wasn't obvious, for the merge thing to work you need to first
copy the old index file _or_ generate a new temporary index file first, so
that doing the three-way merge has a previous index file to work with. Ie
it would look something like

	cp .git/index .tmp-index
	GIT_INDEX_FILE=.tmp-index read-tree -m $orig $branch1 $branch2

but this same approach can also be used to merge things _without_ actually
having any specific version checked out, in which case it would just be

	GIT_INDEX_FILE=.tmp-index read-tree $orig
	GIT_INDEX_FILE=.tmp-index read-tree -m $orig $branch1 $branch2

which allows you to create a merged index file that is totally independent 
on whatever (if anything) you happen to be working on right now.

Together with a SHA1_FILE_DIRECTORY, it allows you to do merges entirely
outside any real git tree, and without any other setup. That's quite nice
for the case where your actual working tree may be dirty, and you don't
want to mess around in it.

			Linus
