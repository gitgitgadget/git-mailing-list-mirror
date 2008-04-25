From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Problem with git fetch over http://
Date: Fri, 25 Apr 2008 19:35:45 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804251842510.19665@iabervon.org>
References: <63F7B390-32D1-458A-8ED9-D5AC62F46745@newartisans.com> <alpine.LNX.1.00.0804251749390.19665@iabervon.org> <7vskx9o9ek.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Wiegley <johnw@newartisans.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 01:36:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpXT4-0002YA-GI
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 01:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932868AbYDYXft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 19:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbYDYXfs
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 19:35:48 -0400
Received: from iabervon.org ([66.92.72.58]:42073 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763333AbYDYXfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 19:35:47 -0400
Received: (qmail 4953 invoked by uid 1000); 25 Apr 2008 23:35:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Apr 2008 23:35:45 -0000
In-Reply-To: <7vskx9o9ek.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80353>

On Fri, 25 Apr 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > John mentioned on IRC that clone works.
> >
> > $ git-ls-remote http://newartisans.com/git/ledger.git
> > 96751442d9eda537480867e599e4c604663f4530        refs/heads/master
> > 365baca5174232cc35e4ed190fd8ce93c3611c84        refs/heads/v2.4.1
> > f972a89073843fdbb2a1bef969d9ca70509d4bfe        refs/heads/v2.5
> > 6a81d760dc4ab9028b27430124702c28c0b894ed        refs/tags/cvs-20040410
> > fed3956a310a2ea8c8595b7fde7aaa0623492ca6        refs/tags/v0.1
> > ...
> >
> > $ git-ls-remote git://newartisans.com/ledger.git
> > 96751442d9eda537480867e599e4c604663f4530        HEAD
> > 96751442d9eda537480867e599e4c604663f4530        refs/heads/master
> > 365baca5174232cc35e4ed190fd8ce93c3611c84        refs/heads/v2.4.1
> > f972a89073843fdbb2a1bef969d9ca70509d4bfe        refs/heads/v2.5
> > 6a81d760dc4ab9028b27430124702c28c0b894ed        refs/tags/cvs-20040410
> > fed3956a310a2ea8c8595b7fde7aaa0623492ca6        refs/tags/v0.1
> > ...
> >
> > Looks like either server-info.c:update_info_refs() needs to also list 
> > HEAD, or transport.c:get_refs_via_curl() needs to guess that $url/HEAD 
> > exists and fetch it to add to the list, or both.
> 
> Wait a minute.  How did "git fetch http://host/repo.git" work before C
> rewrite?
> 
> The reason I ask is because info/refs traditionally did not list HEAD and
> fetch either would have failed to start walking from HEAD (iow, the issue
> was very old), or it didn't care (iow, the issue is a regression after C
> rewrite).

I never managed to trace through the shell fetch code, but I suspect that 
it broke quite a long time ago (git-ls-remote.sh didn't list HEAD for 
http:// URLs, anyway). clone works because it uses entirely different 
code, and "git fetch origin" (when origin is an http URL) works, and "git 
fetch http://... branch" works (and is a workaround), and that's probably 
all that people use regularly. This only comes up because there's an 
automated fetch-and-build system that uses "<vcs> command <location>" to 
update, and it needed an actual quirk, rather than people just training 
their fingers to do things that work.

	-Daniel
*This .sig left intentionally blank*
