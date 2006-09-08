From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Change set based shallow clone
Date: Fri, 8 Sep 2006 15:54:11 +1200
Message-ID: <46a038f90609072054u5ec8bc46x9878a601953b2c5d@mail.gmail.com>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
	 <7vpse7tjp0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 05:54:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLXRa-0003j1-LH
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 05:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbWIHDyO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 23:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbWIHDyO
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 23:54:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:15781 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752058AbWIHDyN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 23:54:13 -0400
Received: by nf-out-0910.google.com with SMTP id o25so581640nfa
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 20:54:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D+t2c3MDQwTJAH0ngO/5sW8FYaDM0Qs3IILzDSEn0TbH+xlu+Yeu7C2Xk4nSM8wld6SmdkFfoc9qFK09JXxj1WaMx78awPJo9+UJFZ3lQYvUB+hTR/R9iBnfN1M5wClmlxFYhIsTJp5tznkjwrFNTks86U493lg6RpnTTNUTfCI=
Received: by 10.48.230.18 with SMTP id c18mr3588405nfh;
        Thu, 07 Sep 2006 20:54:11 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Thu, 7 Sep 2006 20:54:11 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vpse7tjp0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26674>

On 9/8/06, Junio C Hamano <junkio@cox.net> wrote:
...
> Anyway, it is a useful feature, an important operation, and
> it involves a lot of thinking (and hard work, obviously).
>
> I will not think about this anymore, until I have absolutely
> nothing else to do for a solid few days, but you probably
> haven't read this far ;-).

For when you come back, then. I agree this is rather complicated, so
much so that I suspect that we may be barking up the wrong tree.

People who want shallow clones are actually asking for a "light"
clone, in terms of "how much do I need to download". If everyone has
the whole commit chain (but may be missing olden blobs, and even
trees), the problem becomes a lot easier.

On the wire, all the client needs to say from root commit X to later
commits A, B, C, D, can I have all the relevant blobs? (Some may end
up being resent, but that's a tradeoff).

On the server side, keeping commits (and/or trees) in a segregated
pack makes sense as an optimization. On the client side, a similar
segregated pack for the 'known blobless' commits/trees may make sense
to be able to be able treat ops on the blobless part of history
differently.

{From a user interaction point of view, it is also easier to error out
saying "don't have it, but you'll get it if you ask for history from
[SHA1] onwards".}

just my .2


m
