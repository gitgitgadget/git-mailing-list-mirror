From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list: proper lazy reachability
Date: Tue, 31 May 2005 17:58:45 +1000
Message-ID: <2cfc4032050531005820979ca7@mail.gmail.com>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 09:56:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd1bb-0002Sy-Qu
	for gcvg-git@gmane.org; Tue, 31 May 2005 09:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVEaH6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 03:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVEaH6s
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 03:58:48 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:15510 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261276AbVEaH6p convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 03:58:45 -0400
Received: by rproxy.gmail.com with SMTP id i8so1694636rne
        for <git@vger.kernel.org>; Tue, 31 May 2005 00:58:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WkywO6NPngt63Atr/QchLn9YrbRa9fTqu0dUAfPTlMfvgpzmW3qPL9v+Q2Joo2lMJsGaeAg3sVsh2kQ+kveNAN4ky1O0EKSGMyb8ZtqGfU5LZefRSE6OjecCV35+VTmsl6suO16wymQb6ZqiobPnJOE4CEaRmVrVAXKdCpuWrXc=
Received: by 10.38.11.27 with SMTP id 27mr1804706rnk;
        Tue, 31 May 2005 00:58:45 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 31 May 2005 00:58:45 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/31/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> Somebody should probably take a look at my simplistic algorithm, since it
> can probably be improved upon and/or fixed for corner-cases.

Seems reasonable, though I think that in a graph like this:

    A 
  /  |  \ 
B  C  D
|  /   /
E
| \ 
F G

and searching for git-rev-list A ^B

it would actually be better to stop at E (printing A,B,C,D,E), rather
than B because the contemporaneously parallel edits C and D and the
common base E are relevant to evaluating B since they got merged with
B into A from the common starting point E.

In the lingo of my epoch theory, this is searching to the next nearest
epoch boundary past B.

My merge-order patch to rev-list which incorporates epoch theory is
still on its way - it turned out that incrementally finding epoch
boundaries was not quite as simple as I thought it would be. I expect
I'll have a respectable looking patch available this weekend. The
patch I have now works quite well for smaller graphs but fails on
larger graphs because it relies on rational numbers with large
numerators and denominators and these end up overflowing even 64 bit
integers. I think I know how to fix it, but it will take me a few more
days yet.

jon.

-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
