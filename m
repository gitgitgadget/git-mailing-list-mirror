From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix the remote note the fetch-tool prints after storing a fetched reference
Date: Wed, 6 Jun 2007 10:42:15 +0200
Message-ID: <81b0412b0706060142h2df41f11pa0157a360831736@mail.gmail.com>
References: <81b0412b0706060045k4098eb05tc596214f8d9673bf@mail.gmail.com>
	 <7v3b157b4j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 10:42:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvr63-000538-GF
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXFFImU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbXFFImU
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:42:20 -0400
Received: from hu-out-0506.google.com ([72.14.214.239]:2292 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbXFFImT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:42:19 -0400
Received: by hu-out-0506.google.com with SMTP id 19so29883hue
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 01:42:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ar06nC+/exzMg3UA4U6ymOV33mpZAfLV63r9uJi8Bh4D8cvx8TG+4EwW/joywKoHpr3h5Y3XTFop9EuRZkjRGxMYpiYVLzBii84eDAD09bpwqCpmMMIeTVtqVBB7kFjaGnfLPlTWkWwwWBNiNgVIyc6KLYrSCfTHtjHSPQ6BBTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m/9DZwZ1L/w7F2GHbbPzbvriVMQjSD1wiS2wqzMyM2Ql5SK9mtfHhOuWqyaXjcD6ve2l3h/f2cESz48uDGhcikMUhIAS5/gBWqDfNMZgqCTuvYNYknjLNG7kIzUpKHo9/6G8Er9BhmrXJm5PZ8jJuB2JbGrcaDjE0V4u+U2pj3Q=
Received: by 10.78.204.7 with SMTP id b7mr80253hug.1181119335956;
        Wed, 06 Jun 2007 01:42:15 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 6 Jun 2007 01:42:15 -0700 (PDT)
In-Reply-To: <7v3b157b4j.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49268>

On 6/6/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> > Otherwise ".git" is removed from every remote name which has it:
> >
> >  $ git fetch -v
> >    * refs/heads/origin: same as branch 'master' of /home/user/linux
> >      commit: 5ecd310
> >  $ ls /home/user/linux
> >  ls: /home/user/linux: No such file or directory
> >  $ ls /home/user/linux.git
> >  HEAD  objects  packed-refs  ...
>
> I suspect the above misses the point.

Depends on the point. I mean to say: the path in the output
of the command does not exist anywhere.

> The test "ls /home/user/linux" is not relevant.  Ability to say
> "git fetch /home/user/linux" is.

This is still ambiguous:

$ git fetch -v /home/user/a
* fetched /home/user/a
  commit: b85c140
$ git fetch -v /home/user/a.git
* fetched /home/user/a
  commit: b85c140

Which one was fetched when? /home/user/a or /home/user/a.git?
No imagine you don't see the command (as if git fetch is called
in some frontend). Would you be able to distinguish the sources?

Besides, I just noticed git-clone is broken WRT the .git
as well: I can clone a "a.git" into "b" (and it ignores -l and -s!),
but I can't fetch the "a" (aka "origin") being in "b". And of
course, "origin" in "b" is setup as "/path/a", not "/path/a.git".
