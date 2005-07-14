From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git daemon"
Date: Wed, 13 Jul 2005 20:11:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507131956580.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507131946540.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 05:11:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dsu7y-0006QL-6R
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 05:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVGNDLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 23:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVGNDLF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 23:11:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1219 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262865AbVGNDLE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 23:11:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6E3B3jA014698
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Jul 2005 20:11:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6E3B277022098;
	Wed, 13 Jul 2005 20:11:02 -0700
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507131946540.17536@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Jul 2005, Linus Torvalds wrote:
> 
> Anyway, this would be a _wonderful_ interface for read-only updates, ie 
> people pulling from my (and other peoples) git repositories.

I guess I should say what the interface is, so that people don't have to 
read the sources to find out..

On the server side:

	# mark all repositories you want to export with the
	# "git-daemon-export-ok" file in the .git directory..
	#
	# .. and let the port (9418) through any firewalls etc,
	# of course

	git-daemon >& logfile &

(NOTE! "git-daemon" will not disassociate from any tty's or anything fancy 
like that.)

On the client side:

	git pull git://servername/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

And you're done.

(or "git clone", for that matter - I just fixed a one-liner that caused
"clone" to not work, so make sure that you have a commit that says 'Fix
the "close before dup" bug in clone-pack too').

If you want to use a different port number (maybe 9418 is some really 133t 
port, and google just doesn't know about it), you can give git-daemon a 
"--port=x" command line argument, and you can use

	git://servername:port/pathname

on the client side. At least that was my intention, I didn't actually test 
whether that worked (but the default port has been tested).

			Linus
