From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: whomto.pl -- finding out whom to send patches to
Date: Sat, 31 May 2008 12:33:58 +0200
Message-ID: <19f34abd0805310333s270ab8e5pec3396a4539fd797@mail.gmail.com>
References: <20080529210018.GA5508@damson.getinternet.no>
	 <7vr6bkofct.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	"Jan Engelhardt" <jengelh@computergmbh.de>,
	"Sverre Rabbelier" <alturin@gmail.com>,
	"Joe Perches" <joe@perches.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 31 12:35:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2OQL-0001vD-O4
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 12:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYEaKeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 06:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbYEaKeB
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 06:34:01 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:36358 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbYEaKd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 06:33:59 -0400
Received: by rv-out-0506.google.com with SMTP id l9so247620rvb.1
        for <git@vger.kernel.org>; Sat, 31 May 2008 03:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BtszMtC+BcdJ0L1cGFMaf213GUV23nPxGqoLobEZpk8=;
        b=EgPfgkv0R7Sv8/Cpyqec1lEVWfCuOPz6WroB+6/akQCgQuC1AUUFoQprywVrdPHwN6U2Bp72rE6q8k5NZOWi9geih0cIPbaQllOTH58xgnJg3caOZP2a5Xj/PUOw2UB4kFVgUHpvIePcWC5H46QCcC80Dz0KuKVJeYs0Rfyu6/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=swnPJG5+fMErEwNfQEn8DIkpsix3uDG1kkA+BFYR+1XPtYTpZ2LoZvGSosevFpICo/GQ1G4JXMgG4lMLw22Clv9KxYPt2uWxU9CPrL3xXC1LNmvmji1qvIasmRJ57v4jCVCyM9ShL1XccLld3u8tnEx4a4QRl22hS8D+q4EGnTs=
Received: by 10.141.113.6 with SMTP id q6mr3669407rvm.135.1212230039034;
        Sat, 31 May 2008 03:33:59 -0700 (PDT)
Received: by 10.141.145.9 with HTTP; Sat, 31 May 2008 03:33:58 -0700 (PDT)
In-Reply-To: <7vr6bkofct.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83374>

Hi,

On 5/30/08, Junio C Hamano <gitster@pobox.com> wrote:
> Vegard Nossum <vegard.nossum@gmail.com> writes:
>
>  > I've written this perl script that takes a patch as input and prints the
>  > authors/committers of the affected lines, using git-blame as the back end.
>  >
>  > (The purpose of this is of course to find out whom to send patches to.)
>  >
>  > There are some caveats:
>  >
>  > - If I've understood correctly, git-blame incremental output doesn't split
>  >   commits when a newer one is found, so we currently possibly take into
>  >   account more than just the last patch to touch a line. This might not be
>  >   a disadvantage, however...
>
>
> "git blame" does not give irrelevant commits in its output, with or
>  without --incremental.  Perhaps you were thinking about the "oops, earlier
>  one was wrong, here are the corrections" behaviour of "git log
>  --early-output", which is an unrelated mechanism in a different command.
>

This comment was based on my observation that several (sometimes
different) commits would span the same line numbers. Though it seems
to also happen that no line is spanned by any commit at all. I
probably misunderstood the output format of the incremental mode.

>  But I have to wonder why you used --incremental and not --porcelain
>  format, the latter of which is more compact and is designed for parsing by
>  tools.
>

There were some different reasons. I found --incremental easier to
parse, and I didn't really want the actual lines of the file. Maybe I
should rewrite to use porcelain instead :-)

>  I also have to wonder why you did not use -M, -C, and/or -w, if you used
>  blame to find the true origin of lines that are involved.
>

I haven't used these options before and didn't know if it would really
make sense to use them in this context. I guess I could allow them to
pass through from the command line to git-blame...

>  Unless the patch is truly about a narrow region of a handful files
>  (e.g. micro-optimizing the implementation of a single function without
>  changing its external interface at all, or fixing an off-by-one error in a
>  group of functions that do similar things), I suspect that it would make
>  more sense to use "git shortlog --no-merges -- paths" to get the list of
>  people who are involved in the general area, even though they may not have
>  been involved in particular _lines_ that the patch touches.  For example,
>  if a patch changes the lines in a function's implementation, you would
>  want input not only from the people who improved the implementation of the
>  function over the years, but more from the people who care about the
>  calling sites of that function the patch is touching.

Yes, it seems that log/shortlog is the most common (and probably
faster) way of doing what I'm trying to do, based on all the feedback
I had :-) However, I use git-blame myself and so I wanted to automate
that task in particular.

I did not intend for the tool to be fully automatic, however; it
outputs a ranked list of names and e-mails. The user (well, me ;-)) is
still expected to pick the sensible entries and leave out the rest.
For instance, I bet half the patches run through the script on the
linux kernel sources would turn Linus up, even though you don't want
to send patches directly there in most of the cases. And this is
simply because he did the initial commit and a lot of code may not
have changed since that...

Thanks for the comments.


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
