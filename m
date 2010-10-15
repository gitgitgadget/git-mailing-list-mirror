From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Can I checkout a single file without altering index?
Date: Fri, 15 Oct 2010 18:40:08 -0500
Message-ID: <20101015234008.GC25624@burratino>
References: <loom.20101012T114900-532@post.gmane.org>
 <AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com>
 <loom.20101014T095743-275@post.gmane.org>
 <i9a6kn$d7o$1@dough.gmane.org>
 <7viq13avn0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 01:43:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6tw8-00072a-IT
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 01:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763Ab0JOXnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 19:43:39 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44274 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab0JOXni (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 19:43:38 -0400
Received: by gyg13 with SMTP id 13so184127gyg.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 16:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rQa7a1T7j+x+v6Qa+jQuwMxw8/xkY0x9uk+QQxqGYgc=;
        b=dM9WUNXkM6boGL3sbjDX8+yhRjRGXGjOycMXN8cP79oDvOJEyolzB8YGRKGJa+5nD/
         nqKxicfPU0HZyWUkwIl+SG9uWUlo76TSXM1cfCM8ZL+YZCGcZ2VbX5iQ/qHYlAxocfT4
         gQn8SCSkv+nVnDqUR9XRfYAjSARfPEJezVmxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HyT81q4PhEDTtke/ZS0dbnZRlEWpRCQ1R2ykS1ZKS4F8v5C+euvAn9Nd0mCRXxqo4n
         JZVpZ82t5TL3NVHF2rRI2kDxO9rOplEvX0/nAl9zMSyVdlaf8ndnt7MuFeek0ch3WiEi
         l3zFZe2x0vlM1fST7gfKmuwkNlqfW6UxPzB7E=
Received: by 10.236.110.178 with SMTP id u38mr597490yhg.19.1287186218358;
        Fri, 15 Oct 2010 16:43:38 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id i9sm9478612yha.42.2010.10.15.16.43.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 16:43:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7viq13avn0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159150>

Junio C Hamano wrote:

>                                                           If somebody
> can write a convincing use case that shows why it is useful, such an
> option shouldn't be very hard to add.  But I don't think of any.  For
> example, this is not it:
> 
>     I start from a clean slate and start working.
> 
>     $ git checkout
>     $ edit; git diff; compile; test; git add path ;# repeat
> 
>     At this point I have some cooked contents added for the next commit
>     in the index for path.  But I realize that the contents of that path
>     in another branch might be even better.  But I do not want to lose
>     the state I arrived at, which might be better than that alternative.
>     I cannot decide, so I'll keep that in the index for now.

To be a devil's advocate (because I am not convinced yet), here is one:

    I start from a clean slate and start working.

    $ git checkout
    $ edit; git diff; compile; test; git add path ;# repeat

    At this point I have some cooked contents added for the next commit
    in the index for path.  Illustrating the new change is a new test,
    and I want to "test the test" by trying it out against the inferior
    previous state.

    $ git checkout --no-index HEAD path
    $ test; edit test; git diff; compile; test; git add test ;# repeat

    Now one last test run with the improved state

    $ git checkout path
    $ compile; test
    $ git commit
