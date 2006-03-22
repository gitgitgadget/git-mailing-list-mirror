From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Wed, 22 Mar 2006 15:39:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
References: <20060322133337.GU20746@lug-owl.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 00:39:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMCv0-0007vt-RD
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 00:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWCVXjH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 18:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbWCVXjH
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 18:39:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54462 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932622AbWCVXjF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 18:39:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2MNd1DZ017561
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Mar 2006 15:39:01 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2MNd0Ol032766;
	Wed, 22 Mar 2006 15:39:00 -0800
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20060322133337.GU20746@lug-owl.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17833>



On Wed, 22 Mar 2006, Jan-Benedict Glaw wrote:
> 
> I'm currently working a lot with Binutils and GCC and wanted to import
> those two projects into GIT trees, but both of them failed. If anybody
> wants to have access to the half-finished GIT trees, please let me
> know:

Well, I can re-create your error..

> Switching from origin to gdb-4_18-branch
> usage: git-read-tree (<sha> | -m [--aggressive] [-u | -i] <sha1> [<sha2> [<sha3>]])
> read-tree failed: 33024

That's a horrible error message, and the reason for it is that no 
"gdb-4_18-branch" exists.

There's a _tag_ called "gdb-4_18", and there's a branch called "GDB_4_18", 
and they actually point to two _different_ commits (both "Initial creation 
of sourceware repository"). The commits actually have identical trees, but 
they're different, because they have different times - by 50 seconds. 

Gaah.

Looking at cvsps output (from

	cvsps --norc -u -A -v -d --cvsdirect
		--root :pserver:anoncvs@sourceware.org:/cvs/src
		src > cvsps.out 2> cvsps.err

it's "PatchSet 104" (well, for me it is, I have a hacked cvsps, so it 
might not be that for you), which creates the "gdb-4_18-branch", but it 
appears that cvsps hasn't actually figured out any "Ancestor branch" for 
that commit.

What a crock.

Anyway, it's clearly a cvsps bug (mentioning a new branch without the 
_source_ of that branch). Equally clearly, "git cvsimport" is being an ass 
about then failing so totally on it.

I'll try to take a look at why cvsps does that.

		Linus
