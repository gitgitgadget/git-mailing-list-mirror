From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Thu, 12 Oct 2006 18:04:02 -0700 (PDT)
Message-ID: <20061013010402.99837.qmail@web31814.mail.mud.yahoo.com>
References: <7vzmc1jcz0.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 03:05:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYBT8-0003yH-Av
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 03:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWJMBEG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 21:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWJMBEG
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 21:04:06 -0400
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:39803 "HELO
	web31814.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751431AbWJMBED (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 21:04:03 -0400
Received: (qmail 99839 invoked by uid 60001); 13 Oct 2006 01:04:02 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=l19o2OdsW1ZxuFd5pl6WPJeOS83bufpyxnv3bSWqWzYtYPFhddVUR0bfB63U70+ynmvsl1/+h9lmYGjxMLjxxX6r9UFFFzcgJLXEYYjHqn3t0v3HVJDjsw2FldGVIxuACMxhEucHUcdSlLGB85zbiSsJLMDaHr+47negR6r7k/o=  ;
Received: from [64.215.88.90] by web31814.mail.mud.yahoo.com via HTTP; Thu, 12 Oct 2006 18:04:02 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmc1jcz0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28825>

--- Junio C Hamano <junkio@cox.net> wrote:
> > ---cut---
> > The porcelain format is as follows:
> >
> > <SHA-1> <orig line> <line> [<num lines>
> 
> This is misleading.  <num lines> is always shown for the group
> head, even if there was another group earlier from the same
> commit (otherwise the Porcelain has to buffer the chunk, which

Completely understood and always agreed upon.

> you did not like).  Second and subsequent lines in the same
> group do not have <num lines>.

Completely understood and always agreed upon.

> 
> > author <name>
> > author-mail <email format>
> >...
> > committer-tz <TZ>
> > filename <string>
> > summary <string>]
> > <TAB><line data>
> >
> > Where
> >   <SHA-1> is the SHA-1 of the commit which introduces this line.
> >   <orig line> it the line number where this line is introduced.
> >   <line> is the line number of the final file (at SHA-1 commit)
> >
> > Then, if <SHA-1> is different from the previous line's SHA-1 (if no
> > previous then always different), a header follows.  It starts by the
> > number of lines that this <SHA-1> commit introduces,...
> 
> So this description is wrong; <num lines> is not part of the
> "extra".

So, it is possible to print

<SHA-1> <orig lineno> <this lineno> <num lines>
TAB<data line>

?

> I deliberately left it vague so that we can add things later to
> the header.  Porcelains should ignore the fields that they do
> not understand, and should not expect these fields listed above
> come in the order the above list shows.

If the format changes, then porcelains should change their parsing
algorithms.

> Also I deliberately left it vague so that Porcelains can get the
> header for the same SHA-1 more than once.  This is needed when

For different blocks separated by at least one different commit, yes.
But the opposite should not be true.

That is, you start a group, only when the previous commit differs
from this commit.

It would be prudent to print a <num lines> iff a group is started.

> we add "ciff" to pick more than one paths from the same commit.
> In such a case, most likely we are better off not to repeat
> header fields from author...committer-tz and summary but we
> would need filename.  The expectation to the Porcelains is:
> 
>    Read one line, which begins with commit object name and two
>    or three numbers; if it has three numbers, it is the
>    beginning of a group.

And if it doesn't have three numbers?

    Luben
