From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [PATCH] Stgit - gitmergeonefile.py: handle removal vs. changes
Date: Wed, 16 Nov 2005 15:44:12 +0100
Message-ID: <200511161544.13825.blaisorblade@yahoo.it>
References: <20051113194225.20447.57910.stgit@zion.home.lan> <b0943d9e0511150154y2d2af24ck@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 15:38:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcONw-00011v-IA
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 15:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbVKPOfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 09:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbVKPOfh
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 09:35:37 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:17585 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030344AbVKPOfg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 09:35:36 -0500
Received: (qmail 48423 invoked from network); 16 Nov 2005 14:35:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=dxwUr1dHq2DoZSVTxbke2lQ7y/PIvKkVRaP1nFh7OJ/detmax1sDyCHv07WifeF1DsYfYB0do6t2W0/q/1yI5MiSOJWFrZa4zTwTEgmPNlnnRPhZ1vZ8aTOPWtOM9kFQBWd1hBYq7RPMXI+QsIoahEs89oBFdjH8mOVZ1kY10DE=  ;
Received: from unknown (HELO zion.home.lan) (blaisorblade@82.61.34.215 with login)
  by smtp005.mail.ukl.yahoo.com with SMTP; 16 Nov 2005 14:35:34 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: KMail/1.8.3
In-Reply-To: <b0943d9e0511150154y2d2af24ck@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12025>

On Tuesday 15 November 2005 10:54, Catalin Marinas wrote:
> On 13/11/05, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> wrote:
> > I just got a "removal vs. changed" conflict, which is unhandled by StGit.
> > That is taken from git-merge-one-file resolver, but is bad, as stg
> > resolved does not handle unmerged entries (and probably it should be
> > fixed too).

> I think it 'stg resolved' should be fixed as well (in case there are
> unmerged entries for other reasons).

Yep, I was thinking that too but was too lazy to implement.

Actually, with .git/commits we are reimplementing handling of "unmerged" 
entries... it could be better to use the "unmerged entry" stgit idea. So "stg 
resolved" should modify the entries by itself.

> My initial idea was to make 
> gitmergeonefile not to leave any unmerged entries in the index. As you
> could see, there are cases where it failed.

Yep... it seems you took examples from git-merge-one-file, but that's lacking 
(but it's low-level so it's appropriate for it - it must leave unmerged 
entries when there are conflicts).

> I can see the following scenarios for a file:

In both cases, we're going to have a conflict, so we leave file.
{older,remote,local} as appropriate and already done.

> 1. deleted in the base and modified by the patch. It should leave the
> file in the tree together with file.older.

Why not leaving file.remote? We already do that in general, so we have a 
duplicate, but it's easier to understand.

> Another option would be to 
> remove the file and leave both file.older and file.remote in the tree
> (here .remote means the version in the patch)

I remember that at times, but .remote is very confusing... I see that's the 
mishandling is induced by various sources, maybe including "merge" itself, 
but that program (and possibly others) supports changing the labels, and this 
should probably be done (using "original", "patched" and "upstream" 
probably).

> but I would prefer the 
> first one.

> 2. changed in the base but deleted by the patch. It should remove the
> file from the tree but leave file.older and file.local. The other
> option is to leave the file in the tree but, as above, I prefer the
> first one.

The policy about when to remove the file and when to leave it is very 
personal... the user must anyway solve the conflict in some smart way... 
about the defaults, anything would do, but if we really care we could leave 
the user the choice.

For the Linux kernel, my experience is that when a file is removed it's either 
because it's renamed, it's refactored, or it's removed. In all these cases, 
there's often little interest in reviving it in the patch... However it's 
just a slight preference.

> Maybe StGIT should try to track the renaming as well but I haven't
> played with this feature in GIT at all.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
