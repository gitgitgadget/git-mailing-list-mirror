From: "Don Zickus" <dzickus@gmail.com>
Subject: Re: Fix "git log -z" behaviour
Date: Wed, 7 Feb 2007 17:53:22 -0500
Message-ID: <68948ca0702071453i3c4d1b66hcf173fc17919acd6@mail.gmail.com>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
	 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0702070919320.8424@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0702071139090.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 23:54:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvfY-0007Zf-IP
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422812AbXBGWxZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 17:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422815AbXBGWxZ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:53:25 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:55566 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422812AbXBGWxX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:53:23 -0500
Received: by nz-out-0506.google.com with SMTP id s1so312340nze
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 14:53:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qJRXo9gUd+N70K7KLS64zkaq/8wmiKnQUMlSanucdq9rsN1g4PcbItvctqJeSD38VZphlcfzgwXP3B7NKfUoeKbmAr6NcMbUiURAUmChD90bqXPePtHT6IN/QVevWBNu49HLPHfX501q1xtqtq08Amj7NCHJ2BlI7NbL1qX8q0k=
Received: by 10.65.119.14 with SMTP id w14mr14360281qbm.1170888802445;
        Wed, 07 Feb 2007 14:53:22 -0800 (PST)
Received: by 10.65.189.12 with HTTP; Wed, 7 Feb 2007 14:53:22 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702071139090.8424@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38987>

>
> For commit messages, we should really put the "line_termination" when we
> output the character in between different commits, *not* between the
> commit and the diff. The diff goes hand-in-hand with the commit, it
> shouldn't be separated from it with the termination character.
>
> So this:
>  - uses the termination character for true inter-commit spacing
>  - uses a regular newline between the commit log and the diff
>
> We had it the other way around.
>
> For the normal case where the termination character is '\n', this
> obviously doesn't change anything at all, since we just switched two
> identical characters around. So it's very safe - it doesn't change any
> normal usage, but it definitely fixes "git log -z".
>
> By fixing "git log -z", you can now also do insane things like
>
>         git log -p -z |
>                 grep -z "some patch expression" |
>                 tr '\0' '\n' |
>                 less -S
>
> and you will see only those commits that have the "some patch expression"
> in their commit message _or_ their patches.
>
> (This is slightly different from 'git log -S"some patch expression"',
> since the latter requires the expression to literally *change* in the
> patch, while the "git log -p -z | grep .." approach will see it if it's
> just an unchanged _part_ of the patch context)
>
> Of course, if you actually do something like the above, you're probably
> insane, but hey, it works!
>
> Try the above command line for a demonstration (of course, you need to
> change the "some patch expression" to be something relevant). The old
> behaviour of "git log -p -z" was useless (and got things completely wrong
> for log entries without patches).
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> On Wed, 7 Feb 2007, Linus Torvalds wrote:
> >
> > Also, I just checked, and we have a bug. Merges do not have the ending
> > zero in "git log -z" output. It seems to be connected to the fact that we
> > handle the "always_show_header" commits differently (the ones that we
> > wouldn't normally show because they have no diffs associated with them).
> >
> > The obvious fix for that failed. I'll look at it some more.
>
> Actually, the obvious fix was right, I just did the *wrong* obvious fix at
> first ;)

Works for me.  :)
And I thought I had a handle on a lot of the Unix commands.  That -z
stuff just threw me for a loop.  It's pretty neat to be able to grep
commits and have the output display the whole commit and diff.

Cheers,
Don
