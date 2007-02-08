From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 15:46:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702081538160.8424@woody.linux-foundation.org>
References: <17866.27739.701406.722074@lisa.zopyra.com>
 <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
 <17867.40122.51865.575762@lisa.zopyra.com> <Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org>
 <17867.45437.922483.805945@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:46:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIy3-0001dq-U5
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbXBHXqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbXBHXqQ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:46:16 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45628 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161107AbXBHXqP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:46:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l18NkD3O006796
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Feb 2007 15:46:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l18NkChJ031068;
	Thu, 8 Feb 2007 15:46:12 -0800
In-Reply-To: <17867.45437.922483.805945@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.441 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39130>



On Thu, 8 Feb 2007, Bill Lear wrote:

> 
> With regard to the new version and old repos, am I correct in assuming
> that we can upgrade our old repo (a bare one) to the new git by first
> installing the new git, and then doing this:
> 
> % cd /repos/git
> % mv project project.old_git
> % git --bare clone project.old_git project
> 
> or is there something else we must do?

I would actually suggest against that. Why? Because it will set a new 
"origin" (pointing to your old repo), and if you had something else 
before, that's probably not what you want.

Anyway, for the *shared* repositories, the git-1.5 changes really don't 
tend to make any difference anyway (since they don't even tend to really 
_care_ about things like origin branches - they are just used to push and 
pull from).

It's much more noticeable for the actual *development* repositories, 
because they are the ones that have "origin" pointing to something else.

And yes, for those development repositories, it's usually a good idea to 
just do

	mv project old-project
	git clone /repos/git/project
	cd project 
	.. work work work ..

and be happy.

You can also set up the new configurations by hand in an old repository, 
but there really doesn't tend to be a lot of reason to do that. Just as an 
example: the above was _literally_ what I did myself, just because I was 
too lazy to start editing .git/config files and setting things up in other 
ways (renaming origin branches etc).

In fact, I just did it the other day for my "sparse" repository (which is 
another project I started, but that is maintained by others these days). 
So here's a snippet from my bash history:

  ...
  837  mv sparse old-sparse
  838  cat old-sparse/.git/config
  839  git clone master.kernel.org:/pub/scm/linux/kernel/git/josh/sparse
  ...

(that "cat old-sparse/.git/config" was just because I had forgotten 
exactly where the origin of that repo was, so I did that cat just to do a 
cut-and-paste for the subsequent "git clone" ;^).

And yes, I did that just to get the nicer branch layout, something that my 
old sparse git repo didn't have, because I had set it up with an old 
version of git (and done some minimal manual maintenance).

			Linus
