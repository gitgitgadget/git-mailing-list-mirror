From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 14:09:03 -0500
Message-ID: <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ATv-0005hC-8z
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbXLKTJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbXLKTJH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:09:07 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:52538 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbXLKTJG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:09:06 -0500
Received: by py-out-1112.google.com with SMTP id u77so481862pyb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 11:09:05 -0800 (PST)
Received: by 10.142.76.4 with SMTP id y4mr1186050wfa.1197400143543;
        Tue, 11 Dec 2007 11:09:03 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Tue, 11 Dec 2007 11:09:03 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67907>

On 12/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 11 Dec 2007, Daniel Berlin wrote:
> >
> > This seems to be a common problem with git. It seems to use a lot of
> > memory to perform common operations on the gcc repository (even though
> > it is faster in some cases than hg).
>
> The thing is, git has a very different notion of "common operations" than
> you do.
>
> To git, "git annotate" is just about the *last* thing you ever want to do.
> It's not a common operation, it's a "last resort" operation. In git, the
> whole workflow is designed for "git log -p <pathnamepattern>" rather than
> annotate/blame.
>
I understand this, and completely agree with you.
However, I cannot force GCC people to adopt completely new workflow in
this regard.
The changelog's are not useful enough (and we've had huge fights over
this) to do git log -p and figure out the info we want.
Looking through thousands of diffs to find the one that happened to
your line is also pretty annoying.
Annotate is a major use for gcc developers as a result
I wish I could fix this silliness, but i can't :)

> That said, I'll see if I can speed up "git blame" on the gcc repository.
> It _is_ a fundamentally much more expensive operation than it is for
> systems that do single-file things.

SVN had the same problem (the file retrieval was the most expensive op
on FSFS). One of the things i did to speed it up tremendously was to
do the annotate from newest to oldest (IE in reverse), and stop
annotating when we had come up with annotate info for all the lines.
If you can't speed up file retrieval itself, you can make it need less
files :)
In GCC history, it is likely you will be able to cut off at least 30%
of the time if you do this, because files often have changed entirely
multiple times.
