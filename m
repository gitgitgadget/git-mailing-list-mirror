From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add git-find-new-files to spot files added to the tree,
 but not the repository
Date: Sat, 23 Jul 2005 10:48:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507231043330.6074@g5.osdl.org>
References: <20050723074219.GB3255@mythryan2.michonline.com>
 <Pine.LNX.4.58.0507231039290.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 19:49:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwO7K-0008Bt-Dr
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 19:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVGWRsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 13:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVGWRsr
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 13:48:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262385AbVGWRsn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 13:48:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6NHmejA008374
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Jul 2005 10:48:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6NHmdZp031057;
	Sat, 23 Jul 2005 10:48:39 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <Pine.LNX.4.58.0507231039290.6074@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Jul 2005, Linus Torvalds wrote:

> 
> 
> On Sat, 23 Jul 2005, Ryan Anderson wrote:
> >
> > Add git-find-new-files to find files that are in the tree, but not checked into the repository.
> > 
> > Most users will probably want to "make clean" before using this for real
> > significant changes, as it does such a good job that it finds binaries that
> > just got built.
> 
> You really want to run "file" on the files. We almost certainly don't want 
> to add binary executables, object files etc etc to the tree, so why even 
> show them?
> 
> You should also filter the list by the "ignore" file. And I'd suggest
> ignoring dot-files by default, for example (maybe add a "-a" flag to 
> disable that, the same way "ls" does).

Oh, and btw, maybe you didn't realize that "git-ls-files --others" already 
basically does what your script does? Without any filtering - it was meant 
to be run from a script, so something like

	for i in $(git-ls-files --others)
	do
		if [ ! match_ignore "$i" ]; then
			case $(file -b $i)
			ELF*)
				;;
			*)
				echo $i
				;;
			esac
		fi
	done

was what I was thinking of.

		Linus
