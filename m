From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Fri, 20 Jan 2006 11:07:09 +0100
Message-ID: <cda58cb80601200207g7c3495ddx@mail.gmail.com>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>
	 <cda58cb80601170932o6f955469y@mail.gmail.com>
	 <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
	 <7virsf7lb9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 20 11:07:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EztAp-00015G-0u
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 11:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWATKHL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 05:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWATKHL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 05:07:11 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:31808 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750784AbWATKHK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 05:07:10 -0500
Received: by zproxy.gmail.com with SMTP id 14so427632nzn
        for <git@vger.kernel.org>; Fri, 20 Jan 2006 02:07:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EbK26HmB95WqIUXDsqbMWthSNEySeVQTDqgoSD6sQLmgKbNzMRKYtTFS4CRe4nT+EutBuoWth/WSfQnnmGjvIVWHbpIdKklsSKd1WGeRJsPV3D6258RUgm90l5m4yLXuYWy4ayMroxzhepxftAhxZDl+13jlvN8QjqjVkTVpXZQ=
Received: by 10.36.224.34 with SMTP id w34mr1270560nzg;
        Fri, 20 Jan 2006 02:07:09 -0800 (PST)
Received: by 10.36.47.7 with HTTP; Fri, 20 Jan 2006 02:07:09 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virsf7lb9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14958>

2006/1/20, Junio C Hamano <junkio@cox.net>:
> Junio C Hamano <junkio@cox.net> writes:
>
> > It _might_ work if you tell your downloader to have a proper
> > graft file in his repository to cauterize the commit ancestry
> > chain _before_ he pulls from you, though.  I haven't tried it
> > (and honestly I did not feel that is something important to
> > support, so it might work by accident but that is not by
> > design).
>
> I just tried it and it actually works.
>
>         $ git clone git.git junk
>         $ cd junk ;# I am not brave enough to risk the real thing ;-)
>         $ git rev-parse master~4 >.git/refs/info/grafts
>         $ cd ..
>         $ mkdir cloned
>         $ cd cloned
>         $ git init-db
>         $ cp ../junk/.git/info/grafts .git/info/
>         $ git clone-pack ../baz
>         $ git fsck-objects --full
>         $ git log --pretty=short | cat
>

Just to be sure, what you call baz is actually junk ?

> This "only the tip of the git.git" repository has about 450
> objects in it, fully packed because of clone-pack, with one 680K
> packfile.

I tried that but I don't have same results. Did you delete all branchs
except master before running clone-pack ? In my case I cloned the
whole thing. So junk and cloned repos are the same size

> I think the true full history of git.git/ packed into
> one is aruond a 5MB packfile.  I suspect a bigger repository
> would not see that much size reduction, as Linus already
> explained here.

sorry, but I didn't understand his explaination, surely because of my
very limited knowledge about git internals...

>
> You could emulate what I just did above to prepare the
> equivalent of "baz" above, and make it available over git://
> protocol, say at git://franck.example.com/franck.git/.
>

does the git protocol is really needed in your example ? or can rsync
work fine too since "franck.git" repo is cautorized so every objects
of this repo shouldn't be part of old history, so they should be
usefull, no ?

Thanks.
--
               Franck
