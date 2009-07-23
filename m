From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 18:07:40 +0200
Message-ID: <20090723160740.GA5736@Pilar.aei.mpg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <7vtz146mgr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 18:09:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU0qr-0004ez-Kt
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 18:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbZGWQIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 12:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbZGWQIt
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 12:08:49 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:50376 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbZGWQIt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 12:08:49 -0400
Received: by bwz28 with SMTP id 28so917284bwz.37
        for <git@vger.kernel.org>; Thu, 23 Jul 2009 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qJpmJQMpLl81ngNmCOrTSFU3/+U6LfWzGM7osomFGxk=;
        b=LTIQq4qz6TXLkrtIT/DUGmeVmx7fdf512OgzrZ+L5UEv10wZ5H3iiNlYUfxMFO7BN5
         8ntQLZBvL5sOwkq9jgvyBH9ErgPeiB4yRs/GQKHh+x6JJFVFN7HRJFO1hCiqTCwUodhp
         mG1LFoAbKpudtXW6ZsAz2sFctCOU/I6fWRSfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j8mePlPWP9w35L1lZYO0R5YsU9KFIWkqXzQEodZMGfRyX5Bg6u9cYEZMAUesueUl6T
         FFzksS5Oz1guTxwAqexgTBJFzUdX4MVDmzNgdLNvQVbSDsB446PDcFUr8KGLtWgN7f3f
         q+i9/P+Tmt8p1zsqxmxTVGnh3tmAsv29dN2fk=
Received: by 10.103.12.19 with SMTP id p19mr1239371mui.66.1248365327794;
        Thu, 23 Jul 2009 09:08:47 -0700 (PDT)
Received: from Pilar.aei.mpg.de (dynamic.aei.mpg.de [194.94.224.254])
        by mx.google.com with ESMTPS id s11sm8404096mue.41.2009.07.23.09.08.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Jul 2009 09:08:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtz146mgr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123875>

On Wed 22.Jul'09 at 21:40:36 -0700, Junio C Hamano wrote:
> Is the cold cache performance of "git branch" to list your 
> local branches that important?

I simply felt like something not optimal was going on, and in
some sense I still feel it even with Linus' patch applied...

Don't get me wrong, I am super happy that Linus fixed it
so quickly and I am grateful for that, but I am surely missing
some git internal reason why 'git branch' is not instantaneous
as I _naively_ expected.

Having learned about .git/packed-refs last night, today I tried
this (with cold cache),

[mafra@Pilar:linux-2.6]$ time awk '{print $2}' .git/packed-refs |grep heads| awk -F "/" '{print $3}'
0.00user 0.00system 0:00.12elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (3major+311minor)pagefaults 0swaps
27-stable
28-stable
29-stable
30-stable
dev-private
master
option
sparse
stern

and notice how that makes my pitiful harddisc look like Linus' SSD! And the
result is the same. 

[ If some branches are not inside .git/packed-refs but are listed in .git/refs/heads 
(like some of them were last night), it would require some modification to the
script, but it would still be faster ]

However, I know that I am missing something here and I would be happy to 
learn what.

Thanks in advance,
Carlos
