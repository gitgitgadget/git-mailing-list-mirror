From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: An idea: maybe Git should use a lock/unlock file mode for
 problematic files? [Was: Re: after first git clone of linux kernel repository
 there are changed files in working dir]
Date: Tue, 20 Jan 2009 15:11:28 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901201441480.19665@iabervon.org>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com> <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com> <83ocy3fmez.fsf@kalahari.s2.org> <20090120105228.xbo3gyc0odwcgcsc@webmail.fussycoder.id.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Hannu Koivisto <azure@iki.fi>, rdkrsr <rdkrsr@googlemail.com>,
	git@vger.kernel.org
To: thestar@fussycoder.id.au
X-From: git-owner@vger.kernel.org Tue Jan 20 21:13:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPMyS-0000rW-AB
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 21:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762375AbZATULd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 15:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763113AbZATULa
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 15:11:30 -0500
Received: from iabervon.org ([66.92.72.58]:35249 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760070AbZATULa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 15:11:30 -0500
Received: (qmail 10552 invoked by uid 1000); 20 Jan 2009 20:11:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Jan 2009 20:11:28 -0000
In-Reply-To: <20090120105228.xbo3gyc0odwcgcsc@webmail.fussycoder.id.au>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106515>

On Tue, 20 Jan 2009, thestar@fussycoder.id.au wrote:

> Quoting Hannu Koivisto <azure@iki.fi>:
> <snip>
> > Kernel source contains pairs of files whose names differ only by
> > case.  Windows cannot store such pairs (at least by default) and
> > apparently there is no support for such a situation in git so
> > you'll only get one file from each pair to your workspace and the
> > other file is shown as modified.
> 
> Could git be modified to allow such repositories to be used on windows  
> by locking files that are problematic, for example, a given repository  
> could have files 'AAA' and 'aAa'.
> 
> The one that correctly represents the on-disk file would be 'open for  
> edit', while the other file would be locked.  To edit the other file,  
> the existing file would need to be locked, and then the other file  
> would then need to be open for edit.
> 
> This could even be extended to allow one to "open file AAA for edit as  
> aAa.v2', giving the file an alternate name.
> 
> Such a workflow would only need to be used for such files, and could  
> also be used when there are incompatible file names for that given  
> partition type.

The hard part is actually identifying what the user's filesystem has done. 
There's pretty good internal support for git knowing that, for a 
particular entry, the filesystem should not be consulted for information. 
I don't think anyone's come up with a suitably cross-platform and 
automatic way to figure out what's happened when git tries to write to a 
particular filename and the system decides it is the same as some other 
filename or it decides to use a different filename instead.

Of course, it is reasonably likely that a project whose files can't all be 
checked out can't be dealt with anyway on that platform (IIRC, the Linux 
kernel build system assumes that it can create both .S and .s files, so it 
won't build on FAT). So nobody's been sufficiently motivated to try to 
implement a fix.

	-Daniel
*This .sig left intentionally blank*
