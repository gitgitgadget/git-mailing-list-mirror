From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 7 May 2006 19:42:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605071939291.3718@g5.osdl.org>
References: <e3fqb9$hed$1@sea.gmane.org> <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
 <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
 <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net> <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
 <20060507075631.GA24423@coredump.intra.peff.net> <20060508003338.GB17138@thunk.org>
 <Pine.LNX.4.64.0605071744210.3718@g5.osdl.org> <20060508012632.GD17138@thunk.org>
 <Pine.LNX.4.64.0605071853290.3718@g5.osdl.org> <20060508022432.GA26076@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 04:42:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcvi1-0006os-Lq
	for gcvg-git@gmane.org; Mon, 08 May 2006 04:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWEHCmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 22:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWEHCmu
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 22:42:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36291 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932259AbWEHCmu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 22:42:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k482gjtH026541
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 May 2006 19:42:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k482gi4V032282;
	Sun, 7 May 2006 19:42:44 -0700
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20060508022432.GA26076@thunk.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19753>



On Sun, 7 May 2006, Theodore Tso wrote:
> 
> That brings up an interesting question though --- why not skip
> compressing files that are under 4k (or whatever the filesystem
> blocksize happens to be) if they are unpacked?  It burns CPU time;
> maybe not enough to be human-noticeable, but it's still not buying you
> anything.

Well, other filesystems don't have 4kB issues. Reiser can do smaller 
things iirc, and you might obviously have a ext3 filesystem with a 1kB 
blocksize too. And with tails on FFS, you might have a filesystem with a 
8kB blocksize, but despite that it might lay out <1kB files well.

Anyway, packing makes all this basically a non-issue. There are no block 
boundaries in a pack-file, and you only use a single inode. And you'd 
obviously want to pack for other reasons anyway (ie the delta compression 
will makea huge difference over time).

		Linus
