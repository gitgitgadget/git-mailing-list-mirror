From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Newbie question:  equiv of:  cvs co -p <filename>  ?
Date: Tue, 9 Aug 2005 17:36:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508091725120.3258@g5.osdl.org>
References: <ddb8vl$ifq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 02:36:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2eZs-0007xL-Bl
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 02:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVHJAgN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 20:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVHJAgN
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 20:36:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751004AbVHJAgN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 20:36:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7A0aAjA007229
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 Aug 2005 17:36:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7A0a9tP021552;
	Tue, 9 Aug 2005 17:36:10 -0700
To: John Ellson <ellson@research.att.com>
In-Reply-To: <ddb8vl$ifq$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.41__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 9 Aug 2005, John Ellson wrote:
> 
> I hacked this:
> 
> 	#!/bin/bash
> 	ID=`git-ls-files -s | grep $1 | cut -d ' ' -f 2`

No. "git-ls-files" shows the latest _index_ state, not the latest 
committed state.

Use "git-ls-tree HEAD pathname" to get the latest committed state for the 
pathname, and then pick out the SHA1 from there, use

	git-cat-file blob <sha1>

to cat the result.

Of course, this will work with any revision, not just HEAD. So you could 
do something like

	git-ls-tree $(git-rev-parse --default HEAD "$@") |
		while read mode type sha name
		do
			case "$type" in
			blob)
				git-cat-file blob "$sha"
				;;
			tree)
				git-ls-tree "$sha"
				;;
			*)
				exit 1
		done

(totally untested)

		Linus
