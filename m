From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: merging problems with Linus' kernel tree.
Date: Tue, 21 Feb 2006 12:03:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602211153570.30245@g5.osdl.org>
References: <20060221183306.GC22988@redhat.com> <Pine.LNX.4.64.0602211052360.30245@g5.osdl.org>
 <20060221191948.GE22988@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 21:03:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBdjH-00087q-LT
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 21:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWBUUDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 15:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWBUUDU
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 15:03:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2759 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932559AbWBUUDT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 15:03:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1LK38DZ005995
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 21 Feb 2006 12:03:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1LK35Bk000749;
	Tue, 21 Feb 2006 12:03:07 -0800
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060221191948.GE22988@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16545>



On Tue, 21 Feb 2006, Dave Jones wrote:
> 
> For some reason, that shows that file being deleted.
> 
> diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
> deleted file mode 100644
> index e71bc6c..0000000
> --- a/Documentation/cpu-hotplug.txt
> +++ /dev/null
> @@ -1,373 +0,0 @@

If that file didn't exist in your index, "git diff" wouldn't even show it. 
So it exists in your index, but not in your working tree.

> Hmm, this tree is on NFS.   The server was 2-3 seconds ahead of the client
> (for some reason ntp wasn't running), but I wouldn't expect such chaos
> to ensue from this?

No, that won't matter. git shouldn't ever look at the current time (well, 
except when it creates a new commit object, of course), just the normal 
file time, which will be determined by the server.

> Hmm. git status shows a ton of modified files, that I know I've never touched.
> (arch/frv is somewhere I'd rather not venture)

Sounds like you might have had a partial merge at some point that you 
^C'd or that just failed, and you did "git reset" on it without the 
"--hard" flag?

> Spooky.  I'm seriously questioning myself whether or not I have
> done something to this tree, but I'm 99.999% sure it's unmodified
> (by me at least).
> 
> git diff on any of the modified files shows no output, which
> could be explained by your modified timestamp theory, but
> how about the deleted/new files ?

Those really are different in the working tree than the index (or the git 
tree: the difference between "git diff" and "git diff HEAD" - and "git 
status" does both - is obviously what you compare to).

Since it's in the "will commit" section, it means that it's in your index 
but not in your HEAD tree. Which in turn implies that your index seems to 
not actually match your HEAD.

That, in turn, is usually due to an aborted merge.

Do a "git checkout -f".

		Linus
