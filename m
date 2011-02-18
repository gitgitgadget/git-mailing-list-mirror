From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Fri, 18 Feb 2011 06:33:07 -0600
Message-ID: <20110218123306.GA1428@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
 <20110218110810.GC7262@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 13:33:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqPWU-00019D-JQ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 13:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab1BRMdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 07:33:17 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61191 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab1BRMdP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 07:33:15 -0500
Received: by iwn9 with SMTP id 9so3577702iwn.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 04:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=K8YAMNECqnsszXVoYIfftyd5hcmcHWmDYbB/LJ61YrI=;
        b=uvojmg9lN2Y5UIbhrE1z6Y5WdN2QWLUuUfbgd6nLizNHGqjWNFxwGVz0qUbLJx7ExO
         Cf8wieb4IJVRAQh40jl8ymLimiIDEOGH9x8NhNqyRiPsBIX8bixdmSHNyvM5fpVkoTwR
         8WXHD2bdeBhiWN5bcJUbZZWHk5A6VKSjb4wVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Je3pI/vhhvf4iXOyUQTcSFrZVcHsIyl/+ABXCzAotYXb4Ppn0+5aGeaKmGAicjoyes
         sH/UYuK2inI6MZjQdMRksexWjEiY7PIivM9zKoEgHN3H2gG31BaxhjfgYjeTYTxuZgUe
         JSmyTETg3bfwN9prlz5e78spmQF81bTD5rwLk=
Received: by 10.231.35.68 with SMTP id o4mr468087ibd.118.1298032394495;
        Fri, 18 Feb 2011 04:33:14 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.ameritech.net [69.209.72.148])
        by mx.google.com with ESMTPS id i16sm1748636ibl.6.2011.02.18.04.33.12
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 04:33:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110218110810.GC7262@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167200>

Jeff King wrote:
> On Fri, Feb 18, 2011 at 03:25:18AM -0600, Jonathan Nieder wrote:

>>  - moved the http support mini-library to http/.
>
> Seems like a weird one-off to me, as it only has two files.

That was just to get the files out of the toplevel.  I suspect the
reason they are not part of libgit is to isolate the expat and curl
linkage.

Hmm, maybe an http/README explaining that would be nice.

> So I
> think python/git_remote_helpers would probably be a more appropriate
> name in case we ever grow more python code.

Good idea.  So the layout would be:

 python/
	Makefile
	git_remote_helpers/
		...

>        - There are a still a lot of directories. I wonder if we should
>          be going deeper. Like commands/builtin. Or lib/*.

For reference:

 Documentation/
 block-sha1/	fast, portable sha1 routine
 builtin/   	built-in (busybox style) commands
 commands/  	stand-alone commands
 compat/    	compatibility replacements, platform-specific code
 contrib/   	contributed software
 gitk-git/  	gitk
 gitweb/    	web interface
 git-gui/   	gui
 http/      	code for use in HTTP support commands (wraps curl and expat)
 libgit/    	code for use in multiple commands
 perl/      	Git.pm
 ppc/       	fast sha1 routine in powerpc assembler
 python/    	python-fastimport + a remote-helper protocol helper
 scripts/   	build scripts
 t/         	tests
 templates/ 	repository skeleton
 test-programs/	sample programs to exercise libgit, vcs-svn, and the sha1 lib
 xdiff/     	diff generator
 vcs-svn/   	svn interop

To give an extreme example :), this could be pruned to

 Documentation/
 commands/
 contrib/
 libgit/
 scripts/
 templates/
 testsuite/
 xdiff/

by

 - not distinguishing builtins from non-builtins by filename
 - dropping gitk, git gui, and gitweb from the tree
 - moving test programs into the testsuite
 - moving sha1 implementations and compatibility code under libgit
 - including http support files in libgit/ even though they are not
   part of libgit.a
 - moving perl and python libraries under libgit
 
>        - Some names seem funny. Like "gitk-git", which really should
>          just be "gitk".

I think it was originally to make the transition from file to
directory smoother.

>                          But I think that is a limitation of the subtree
>          merge.

Should work fine, no?  Since / in common ancestor matches gitk/ in
HEAD, that would be the detected shift.  (Caveat: I haven't tried it.)

>        - Before build, "ls | wc -l" reports 35 entries. Afterwards, it
>          reports 213, and any structure you uncovered in reorganization
>          is lost.

I think the best way to fix this is to provide support[1] for

 make O=build/

for those who want to maintain a clean source tree.

Thanks for some good ideas.
Jonathan

[1] There's a skeleton of such support here:
http://thread.gmane.org/gmane.comp.version-control.git/165720/focus=165850
I don't think I'm the right one to take it further, though, since I
don't really like to use "make O=elsewhere".
