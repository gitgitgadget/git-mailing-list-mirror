From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: Buffer overflows
Date: Thu, 30 Aug 2007 22:35:19 +0100
Message-ID: <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com>
References: <1188502009.29782.874.camel@hurina>
	 <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org>
	 <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Timo Sirainen" <tss@iki.fi>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 23:35:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQrgA-0004kc-J4
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 23:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761328AbXH3VfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 17:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760259AbXH3VfX
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 17:35:23 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:42963 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbXH3VfU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 17:35:20 -0400
Received: by rv-out-0910.google.com with SMTP id k20so252681rvb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 14:35:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UOPkiCrQzVLPiqPC/6qOnwDDvMKuSv/RXoApOoZjlvK/iGp22+erSej6MbRiYmx+tFe4Hy3vlLYwKtvTVyOOcc9RZxIkMk6O9jXfSPJ5fQyOnBHcokbnYf9ya+lgWFI3bhircDSjjqoByJB0uVWBwdl9DSqAoHo7JO8mIhe0NWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VMsKJcYMrW843NJq8L6Mcsd4/RxKUu+2N2rR9yxiNjtVZ4bVKA3Yh4vxWtswCuJhPdUmij5t/RrScwju0XhyUv3q4n9vHnPqgAMWc82X0gBWRWudLZjTX+hwETgmCSizCgNnX9+KRWj1IvpkoMeojWfqEDi/zauPvQFCft6yxSg=
Received: by 10.141.52.5 with SMTP id e5mr406644rvk.1188509719141;
        Thu, 30 Aug 2007 14:35:19 -0700 (PDT)
Received: by 10.141.32.14 with HTTP; Thu, 30 Aug 2007 14:35:19 -0700 (PDT)
In-Reply-To: <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57074>

On 30/08/2007, Timo Sirainen <tss@iki.fi> wrote:
> On 30.8.2007, at 23.46, Linus Torvalds wrote:
>
> > On Thu, 30 Aug 2007, Timo Sirainen wrote:
> >>
> >> Looks like nothing has happened since my last mail about this
> >> (http://marc.info/?l=git&m=117962988804430&w=2).
>
> > If you were to send in a patch that simply just fixed some random case
> > without introducing the other stuff in forms that nobody is used to,
> > people would probably react more.
>
> The problem is that the git code is full of these random cases. It's
> simply a huge job to even try to verify the correctness of it. Even
> if someone did that and fixed all the problems, tomorrow there would
> be new ones because noone bothers to even try to avoid them. So there
> really isn't any point in trying to make git secure until the coding
> style changes.

You don't want a manual check to do these kinds of checks. Not only is
it a huge job, you have the human factor: people make mistakes. This
is (in part) what the review process is for, but understanding how to
identify code that is safe from buffer overruns, integer overflows and
the like is a complex task. Also, it may work on 32-bit which has been
verified, but not on 64-bit.

It would be far better to specify the rules on how to detect these
issues into a static analysis tool and have that do the checking for
you. Therefore, it is possible to detect when new problems have been
added into the codebase. Does sparse support identifying these issues?

> The code should be easy to verify to be secure, and with some kind of
> a safe string API it's a lot easier than trying to figure out corner
> cases where strcpy() calls break.

Why is it easier? If you have a fixed-size buffer, why not use
strncpy, which is what a safe string API is essentially doing anyway?

In this case, detecting strcpy usage can be done via grep. This is
quick, simple and easy to repeat. Other things are more complicated,
which is where automated verification tools help.

- Reece
