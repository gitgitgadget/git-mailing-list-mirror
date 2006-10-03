From: Junio C Hamano <junkio@cox.net>
Subject: Re: pull-fetch-param.txt
Date: Tue, 03 Oct 2006 13:01:01 -0700
Message-ID: <7v64f1np8i.fsf@assigned-by-dhcp.cox.net>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>
	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>
	<452211C2.8020402@s5r6.in-berlin.de>
	<7vven1rfpj.fsf@assigned-by-dhcp.cox.net>
	<45222B18.1090305@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, srackham@methods.co.nz
X-From: git-owner@vger.kernel.org Tue Oct 03 22:02:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUqS8-0002dr-CO
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 22:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWJCUBG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 16:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWJCUBF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 16:01:05 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:1924 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030287AbWJCUBD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 16:01:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003200101.FQUT16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Oct 2006 16:01:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vw0v1V00Q1kojtg0000000
	Tue, 03 Oct 2006 16:00:55 -0400
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <45222B18.1090305@s5r6.in-berlin.de> (Stefan Richter's message of
	"Tue, 03 Oct 2006 11:19:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28293>

Stefan Richter <stefanr@s5r6.in-berlin.de> writes:

> Junio C Hamano wrote:
>> It's a bit sad that asciidoc's nicer quoting features
>> are not backward compatible.
>
> Yes, this is awkward. Here comes the next candidate for quoting.

[Stuart Rackham CC'ed]

At this point I have to say

	What the h*ck AsciiDoc people are thinking?

Heck, I thought we were one of the more important customers of
asciidoc project and not breaking us meant at least something to
them; our name is at the top of "Project using AsciiDoc" section
of their website, http:/www.methods.co.nz/asciidoc/.  Apparently
I was delusional.

Introducing nicer new features is a good thing, but you do not
break existing documents without a good reason and an escape
hatch.

Put it more mildly, I think we need to find out what their
policy on backward compatibility is, and if it is "screw it --
you should re-mark-up your documents to match the newer rule
every time we have a new release.  By the way, you always have
the option to stay at older releases of ours", then we should
seriously consider switching the documentation format to
something else.  I honestly hope it does not have to come to
that.

> In pull-fetch-param.txt:
>
> ----8<----
> <refspec>::
> 	The canonical format of a <refspec> parameter is
> 	`+?<src>:<dst>`; that is, an optional plus `+`, followed
> 	by the source ref, followed by a colon `:`, followed by
> 	the destination ref.
> +
> The remote ref that matches <src>
> is fetched, and if <dst> is not empty string, the local
> ref that matches it is fast forwarded using <src>.
> Again, if the optional plus `+` is used, the local ref
> ---->8----
>
> "man git-fetch" and "man git-pull" show:
> ----8<----
>        <refspec>
>               The  canonical  format of a <refspec> parameter is ?<src>:<dst>;
>               that is, an optional plus, followed by the source ref,  followed
>               by a colon :, followed by the destination ref.
>
>               The  remote  ref  that matches <src> is fetched, and if <dst> is
>               not empty string, the local ref that matches  it  is  fast  for-
>               warded  using  <src>. Again, if the optional plus + is used, the
> ---->8----
>
> I.e. the first and second + were swallowed, but not the third one.
> This is the fix for asciidoc 8.0.0:
> 	`$$+$$?<src>:<dst>`; that is, an optional plus `+`, followed

Without looking at asciidoc 8.0 source, my guess is that it
treats _anything_ that has two pluses on the same input line as
quoted by some magical '+'-pair quote.   Can you try
reformatting the original

> <refspec>::
> 	The canonical format of a <refspec> parameter is
> 	`+?<src>:<dst>`; that is, an optional plus `+`, followed
> 	by the source ref, followed by a colon `:`, followed by
> 	the destination ref.

to something like

> <refspec>::
> 	The canonical format of a <refspec> parameter is
> 	`+?<src>:<dst>`; that is, an optional plus
>	`+`, followed
> 	by the source ref, followed by a colon `:`, followed by
> 	the destination ref.

and verify that conjecture?

We already had to deal with this with your patch for tilde.
Arguably tilde and caret are rare enough in plain text so we can
live with having to spell it as {caret} and {tilde}, but if my
guess is correct, that means we have to spell plus '+' as {plus}
with an appropriate entry in asciidoc.conf (or "\+" if it works
in both older and newer versions).  As more ordinary characters
are taken for special mark-up purposes, we would need to keep
adding them to our list.  Where does the madness end?

Fortunately AsciiDoc 8.0 is still young.  Maybe they can find a
fix for this in a way that does not break documents written for
(at least recent versions of) AsciiDoc 7; it might have to break
documents written for early betas and the initial release of
8.0, but that is _much_ better than breaking existing documents,
in my extremely biased opinion as a very unhappy user.
