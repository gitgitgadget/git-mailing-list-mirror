From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git rebase behaviour changed?
Date: Tue, 17 Jan 2006 21:33:23 +1300
Message-ID: <46a038f90601170033y334d111fjed277fc787a2e523@mail.gmail.com>
References: <43CC695E.2020506@codeweavers.com>
	 <7vslrnh080.fsf@assigned-by-dhcp.cox.net>
	 <43CC89DC.5060201@codeweavers.com>
	 <46a038f90601162252y7e2d9227p4eb4091b653d5c6d@mail.gmail.com>
	 <7v8xtfclyx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 09:33:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EymHP-00021G-N8
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 09:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWAQIdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 03:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWAQIdZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 03:33:25 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:23245 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751218AbWAQIdY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 03:33:24 -0500
Received: by wproxy.gmail.com with SMTP id 70so1274269wra
        for <git@vger.kernel.org>; Tue, 17 Jan 2006 00:33:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jubqVNLF1Uoq5BE9SFT/nECAW6ZvXEownQaVEPr4oREmN/DeGoFbERUxBlFmnckv3lbd936ndqLuZTZFprQsFDmdXMJybCDjJlk+tTeR65JEopH2wf/zNSlzRFHqNYxDZAUHl3CdMRsvYah/UAJMo5Vitm1wq3vyPZB0tG5TRXA=
Received: by 10.54.98.15 with SMTP id v15mr7384339wrb;
        Tue, 17 Jan 2006 00:33:23 -0800 (PST)
Received: by 10.54.127.13 with HTTP; Tue, 17 Jan 2006 00:33:23 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xtfclyx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14788>

On 1/17/06, Junio C Hamano <junkio@cox.net> wrote:
> Sorry I am always slow but I am a bit slower than I usually am
> tonight, and do not understand this part without an
> illustration:


My fault. I did have a few bits of paper here on my lap, but gmail's
textbox sucks at ascii art...

>
>         master    1---2---3---4---5---A
>                  /           /
>         origin  0---6---7---B
>
>
>                 A = master head
>                 B = origin head == merge base
>
>         rev-list B..A = 1 2 3 4 5
>         rev-list A..B = 6 7

Yep, exacly the example I was thinking about.

(...)
> Among the first list of commit, there is #4 which is a merge.
> So we reject.  Is that what you meant?

Exactly. We refuse to reset the head and begin the rebase operation,
because it looks like operator error.

> By the way, the longer I think about this, the more I agree with
> the conclusion of the earlier thread: "if you rebase, do not
> merge; if you merge, do not rebase".  It is really about picking
> the right workflow.

Definitely. But errors and misunderstandings are frequent, and people
who haven't thought the process through or aren't that familiar with
the internals are very likely to try it.

Refusing to rebase, with a good error msg gives the user a chance to
evaluate what to do with the commits. Right now, if I read the
situation right, there's a good chance commits 1,2 and 3 will be
"lost" once the rebase is complete.

GIT won't literally lose them,  someone could run git-fsck and fish
out the dangling heads from the repo, and after a bit of spelunking
recover them, but it's suddenly a really tricky operation.

cheers,


martin
