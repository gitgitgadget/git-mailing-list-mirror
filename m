From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-branch, older repos and more confusion
Date: Thu, 12 Apr 2007 18:00:30 +1200
Message-ID: <46a038f90704112300k3abd66d0nc4372962dbee8616@mail.gmail.com>
References: <46a038f90704112114t520374b2qea4f860575c21bce@mail.gmail.com>
	 <20070412042308.GA22539@coredump.intra.peff.net>
	 <46a038f90704112205g53ab4750s673f449ee40165b4@mail.gmail.com>
	 <20070412052118.GA30459@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 08:00:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbsML-0007Xh-L0
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 08:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945891AbXDLGAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 02:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945894AbXDLGAc
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 02:00:32 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:60627 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945891AbXDLGAb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 02:00:31 -0400
Received: by wx-out-0506.google.com with SMTP id h31so450091wxd
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 23:00:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EFY9RmY/O5WC/Sk9TWrUb7lpzpLuhqDSvdNJGH9w5vE/hpTq4qOUKDxkQK2L06rfF6+eXK3CqN61JmVlqwz3Inhx4urEzc7jFUkAoIlEeF/os2B3U1dCt4jNsx1/p7HHFkymvS0hqnai3Hn7Lmrt8ER6fFKHdD1uwTvYEJ7ayx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EWcmW4c5sh7IwgLYVulZ46q/CUaffOEqS2CsnH4OZRUAofB8uP1PWlLY4QzJpQs72B6XlDb+srWxxRB5NpdP1yJGK0YT8s0q9shPd7lImcW4hS+vjPG9nV5XgzBpUpVWgncrQyrMDNoeyvBGKLyP16W37Cyt+PweoucBPAQBu0U=
Received: by 10.90.30.20 with SMTP id d20mr1351175agd.1176357630812;
        Wed, 11 Apr 2007 23:00:30 -0700 (PDT)
Received: by 10.90.120.11 with HTTP; Wed, 11 Apr 2007 23:00:30 -0700 (PDT)
In-Reply-To: <20070412052118.GA30459@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44325>

On 4/12/07, Jeff King <peff@peff.net> wrote:
> > Any hints as to how to run such workflow on v1.5.x?
>
> This will seem like repetition, but it's like this:

Thanks for bearing with me ;-)

>   git-clone <repo> mydir
>   cd mydir
>   git-checkout --track -b v1.9-clientname origin/v1.9-maint
>   git-push origin v1.9-clientname    # to create the new head remotely
>
> When you do a git-pull without arguments from the v1.9-clientname
> branch, it will first do a fetch of origin (grabbing the entire state,
> including the v1.9-maint branch) and then merge in origin's v1.9-maint.

Almost what I am after, but not quite. In my Cogito workflow,
cg-update will by default pull from  v1.9-clientname, which is what
you want most of the time (collaborating with other developers on that
branch). We do cg-update/cg-push all the time, and cg-update
<maintbranch> is a less frequent operation.

On my own I had gotten almost to the same sequence you show above, but
couldn't get it right. With what you are showing me now, I'd say

 git-clone <repo> mydir
 cd mydir
 git-checkout -b tmpbranch origin/v1.9-maint
 git-push origin v1.9-clientname    # to create the new head remotely
 git-checkout --track -b v1.9-clientname origin/v1.9-clientname
 git-deletebranch tmpbranch # this command doesn't exist!

And then git-pull / git-push will "do the right thing". And `git-pull
origin/v1.9-maint` will trigger a fetch & merge.

> When you do a push without arguments, it will push every head you have
> in common with origin.

That's interesting!

cheers,


m
