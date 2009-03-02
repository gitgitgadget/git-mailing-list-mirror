From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Refspec patterns with * in the middle
Date: Mon, 2 Mar 2009 18:00:57 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903021746140.19665@iabervon.org>
References: <alpine.LNX.1.00.0903011820590.19665@iabervon.org> <7viqmrn98i.fsf@gitster.siamese.dyndns.org> <76718490903021001h16009570p7ac8c66a8e8e1f90@mail.gmail.com> <alpine.LNX.1.00.0903021323180.19665@iabervon.org> <76718490903021407u215fb769g656a8fdc20e622e5@mail.gmail.com>
 <7v1vtfmtwj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-2022065131-1236034857=:19665"
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 00:02:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeH9Z-0005zu-CU
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 00:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbZCBXBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 18:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbZCBXBA
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 18:01:00 -0500
Received: from iabervon.org ([66.92.72.58]:43381 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860AbZCBXBA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 18:01:00 -0500
Received: (qmail 26369 invoked by uid 1000); 2 Mar 2009 23:00:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Mar 2009 23:00:57 -0000
In-Reply-To: <7v1vtfmtwj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111973>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-2022065131-1236034857=:19665
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 2 Mar 2009, Junio C Hamano wrote:

> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > On Mon, Mar 2, 2009 at 1:25 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >>> But the following is not:
> >>>
> >>>  - foo/bar*/baz
> >>>
> >>> IOW, '*' can only appear as a non-terminating symbol if it is bounded
> >>> by '/' on each side.
> >>
> >> You have my criterion right, but I want that to be valid, but only match
> >> things like "foo/bar-something/baz", not "foo/bar-a/b/baz".
> >
> > Ah, that makes sense. Perhaps use "**" to mean matching across path
> > components which is what rsync does:
> >
> >  o  a '*' matches any non-empty path component (it stops at slashes).
> >  o  use '**' to match anything, including slashes.
> >
> > ?
> 
> I personally do not think that makes much sense (and I find ** ugly, too).
> 
> We traditionally supported '*' only at the end, and it always has meant
> "match through the end, including slashes".
> 
> Requiring 'match including slashes' to be spelled as '**' only when it is
> not at the end is unnecessarily confusing.
> 
> Is there a valid use case when * wants to match across directory
> boundaries when it is not at the end?  I offhand do not think of a sane
> one.

Maybe:

/refs/imported/$GROUP/$USER/project -> $GROUP/$USER

or

/refs/imported/sandbox/$USER/$TOPIC/project -> $USER/$TOPIC

The issue, in my case, is importing from a system where branches contain 
projects instead of projects containing branches (and everything is a 
single namespace). So I want to match an insane (for us) LHS with a sane 
RHS to get stuff into reasonable shape. I don't really care about any 
patterns where the branch identifier is multiple components, but I 
wouldn't be surprised if somebody did.

Oh, and it looks like "?" is reserved and currently unused, so we could 
have * match one or more full path components, and ? match partial path 
components.

	-Daniel
*This .sig left intentionally blank*
--1547844168-2022065131-1236034857=:19665--
