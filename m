From: Linus Torvalds <torvalds@osdl.org>
Subject: git-diff-tree updates..
Date: Wed, 18 May 2005 13:28:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505181316330.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed May 18 22:27:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYV6n-0000kP-TT
	for gcvg-git@gmane.org; Wed, 18 May 2005 22:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVERU0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 16:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVERU0N
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 16:26:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:26242 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262341AbVERU0C (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 16:26:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4IKQ1U3006927
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Wed, 18 May 2005 13:26:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4IKPw8s016943
	for <git@vger.kernel.org>; Wed, 18 May 2005 13:26:00 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I've just fixed two annoyances of mine with git-diff-tree, which sadly 
caused me to break some syntax.

In particular, diff-tree for some unfathomable reason (probably incipient 
braindamage in yours truly) used a single dash "-" to mark the end of 
command line arguments, rather than the "--" that everybody else uses.

I hope nobody depended on it, because I fixed it.

The other thing I did was to allow a single SHA1, and then consider that 
to be equivalent to a one-line "--stdin" thing. Ie you can now do

	git-diff-tree -v -p HEAD

and it will do what you'd expect it to do, ie it should be equivalent to

	cat .git/HEAD | git-diff-tree -v -p --stdin

(apart from a silly bug which I'll fix shortly).

The latter means that if you actually want to track a _file_ named HEAD
(or anything else that might trigger as a reference), you'd need to do

	git-rev-list HEAD | git-diff-tree -v -p --stdin -- HEAD

but I'm considering making the single-dash thing be equivalent to 
the combination "--stdin", and not allow SHA1 naming after it, so that 
this could be shortened to just be

	git-rev-list HEAD | git-diff-tree -v -p - HEAD

(but I wanted to make the "-" semantics change be a two-phase thing).

		Linus
