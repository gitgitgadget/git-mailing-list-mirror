From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge problems.
Date: Sat, 4 Feb 2006 16:13:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602041604290.3854@g5.osdl.org>
References: <43E52FD3.20202@f2s.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 01:13:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5XXF-00034P-FR
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 01:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWBEANn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 19:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWBEANm
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 19:13:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932593AbWBEANm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 19:13:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k150DcDZ009528
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 4 Feb 2006 16:13:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k150DbG8012665;
	Sat, 4 Feb 2006 16:13:38 -0800
To: Ian Molton <spyro@f2s.com>
In-Reply-To: <43E52FD3.20202@f2s.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15612>



On Sat, 4 Feb 2006, Ian Molton wrote:
>
> Doing the following:
> 
> git checkout -b mywork v2.6.12
> # work, work, work
> git commit -a
> git merge "Merging happily." mywork v2.6.15
> 
> At theat point I get a merge failure - I assume that means I've
> got conflicts. I forgot to not the exact error.

It would be interesting to hear what the error is, but yes, it sounds like 
file-level conflicts. However, the fact that you get them for files you 
haven't even touched:

> so I can see unmerged files using git ls-files --unmerged which lists a
> lot of SHA1 hashes and paths. but most of the files in the list I havent
> touched! why would they have any conflicts? surely they would simply
> update 2.6.12->2.6.15 ?

You really shouldn't get any conflicts for anything you haven't touched, 
since your starting point and the thing you are mergeing to are related, 
so they shouldn't have any issues.

One common error people have is that the "merge" binary isn't in their 
path, and the actual error is that the first path you _did_ touch failed 
to do a three-way merge, and the merge simply has never happened.

If you do _just_ "merge" (no "git", no aguments, no _nothing_), do you get 
a message like

	merge: not enough arguments
	merge: usage: merge [-AeEpqxX3] [-L lab [-L lab [-L lab]]] file1 file2 file3
	merge aborted

(which is ok) or do you get a message like

	bash: merge: command not found

(which means that you don't have a three-way merge at all)?

If you don't have the merge command, install the rcs package.

> The SHA1 hashes are all listed at least twice per file too, eg.
> 
> 100644 d058e65daf19f4bb8c257e2273f4c935ccee5121 1 Documentation/DocBook/scsidrivers.tmpl
> 100644 d058e65daf19f4bb8c257e2273f4c935ccee5121 2 Documentation/DocBook/scsidrivers.tmpl

That's the "stage1" and "stage2" results. The SHA1's are identical, so it 
should merge beautifully, and it does sound like the merge was never even 
really attempted. 

So
 - do a "git reset --hard" to undo the partial (undone) merge
 - do "yum install rcs" (or apt get, or whatever) to make sure that you 
   have the three-way merge binary.
 - if it still doesn't work, please make sure to save all the error 
   messages so that we can see them..

Thanks,

		Linus
