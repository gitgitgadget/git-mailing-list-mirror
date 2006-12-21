From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Thu, 21 Dec 2006 13:24:32 +0100
Message-ID: <38b2ab8a0612210424o4ec5fcd5kb5086c52ccd76491@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jay Cliburn" <jacliburn@bellsouth.net>, git@vger.kernel.org,
	"Jeff Garzik" <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Thu Dec 21 13:24:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxMyX-0001dF-Fr
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 13:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWLUMYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 07:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWLUMYe
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 07:24:34 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:14756 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030265AbWLUMYd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 07:24:33 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2367114wxd
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 04:24:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i43x5jQlU22C7/wBy5oOVCGoGgLQvNBsrqHcsAk29RaS6wxO1q5EwlyOuTxkbOh1gjkM6r/AtJOUqkgy/uQpwhP8SifPyRPBW3Bn+0JtI2TNF1AcBLjEeArtQiEHt4Jy0BX8sk1DQH33IR7kVkaXkYUZpY4I3BCklPHxAG4O870=
Received: by 10.90.78.9 with SMTP id a9mr8422434agb.1166703872688;
        Thu, 21 Dec 2006 04:24:32 -0800 (PST)
Received: by 10.90.106.16 with HTTP; Thu, 21 Dec 2006 04:24:32 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35061>

Hi,

[ sorry for breaking up the thread but I'd like to fully
  understand that point and I just subscribed to git mail
  list... ]

Linus Torvalds wrote:
>
> On Wed, 20 Dec 2006, Jay Cliburn wrote:
>> $ git diff $(git merge-base master driver)..driver
>
> Be careful. This ONLY works if you don't have criss-cross merges etc, so
> you need to be somewhat careful about it. If you end up having a complex
> merge history between the origin branch and your development tree, things
> will stop working
>
> So it's actually worth understanding what the above does.
>
> Here's the picture to keep in mind: you started off with something like
> this:
>
> 	<- older			newer ->
>
> 	..--A---B---C---D
>
> where the top commit was D, and you started doing your own work off there.
> However, the tree you are tracking (doing "git fetch origin" or somethng)
> ALSO continues, so soon enough you'll have a history that looks like
>
> 	<- older			newer ->
>
> 	..--A---B---C---D---E---F---G---H <-"origin"
> 	                 \
> 	                  --X---Y---Z <- your "driver" branch"
>
> where your work is the "X-Y-Z" sequence.
>
> How, the reason you must NOT do
>
> 	git diff origin..driver
>
> or something like that, is that it will LITERALLY do a diff between those
> two heads. And while that is a perfectly normal diff, it's not what you
> want: it's the diff between the up-stream work and yours, and it will show
> that a lot of work has _not_ happened in your branch (all the E-F-G-H
> stuff), and then you've added some work (X-Y-Z).

I must really miss something but is a diff between origin and driver heads
achieved by:

	$ git diff driver origin

instead of:

	$ git diff origin..driver

?

>From the git-rev-list documentation I can read that:

	git-rev-list origin..driver == git-rev-list driver ^origin

I assume it's still true for git-diff. And the documentation says that
the above command "lists all the commits which are included in driver,
but not in origin".

So all commits included in driver are: (A-B-C-D-X-Y-Z)
all commits included in origin are: (A-B-C-D-E-F-G-H)

All the commits which are included in driver, but not in origin are:
(X-Y-Z), which is definitely not what you claimed.

I know that I'm wrong, so please shed some light in my stupid brain.

-- 
Francis
