From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 14:19:45 +0200
Message-ID: <81b0412b0705100519i3028fbc4y25e7c407c7c8216@mail.gmail.com>
References: <20070506195230.GA30339@mellanox.co.il>
	 <7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
	 <20070510095156.GC13655@mellanox.co.il>
	 <81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
	 <20070510120802.GG13655@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu May 10 14:19:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm7ce-0003rv-DC
	for gcvg-git@gmane.org; Thu, 10 May 2007 14:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbXEJMTr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 08:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757956AbXEJMTr
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 08:19:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:26924 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbXEJMTp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 08:19:45 -0400
Received: by wx-out-0506.google.com with SMTP id h31so514665wxd
        for <git@vger.kernel.org>; Thu, 10 May 2007 05:19:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lLETnXcWzhmLrjdIR548gyowk1uEY5nzZpC4tEb1jG1wlaFHsvY73GE0smiFP03BY+Cgmfy5FdgBUOVEg249I+zWAIcaC/cXZUv+l1fDW0twGR25CELxfv66u/IC/SnFboDV2WnzwIFMX3Unrup8i5ZtcarDezW5egdtV7Zpkek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YD7XooIKp3DSqhhxkb5ypwNYnJn/JpHjORPGt1pRcEksGiqOjjCVn5hUAJerUtaod+jIb2unUZadNweoT4IcfVj+fcc/ckCpNmvP50A/IZnr/0MUlakSeQqXCkX6TTg8dvSrZal6MchzguoOeQy5hG4wV784BFNxpGMfWDvgmPU=
Received: by 10.100.91.6 with SMTP id o6mr1190376anb.1178799585286;
        Thu, 10 May 2007 05:19:45 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Thu, 10 May 2007 05:19:45 -0700 (PDT)
In-Reply-To: <20070510120802.GG13655@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46863>

On 5/10/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> > Quoting Alex Riesen <raa.lkml@gmail.com>:
> > Subject: Re: [PATCHv2] connect: display connection progress
> >
> > On 5/10/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> > >-static int git_tcp_connect_sock(char *host)
> > >+static int git_tcp_connect_sock(char *host, int flags)
> >
> > There is only one bit of flags ever used. What are the others for?
>
> Hmm, I thought it's easier to read
> git_tcp_connect_sock(host, NET_QUIET)

It is easier to read. "int flags" isn't easier to understand.

> > Why use negative logic?
> > What was wrong with plain "int verbose"?
>
> I want the default to report connections, and -q
> to silence them. Maybe "int quiet"?

It depends. "Quiet" is negative, which automatically
makes the logic harder to follow (for humans, at least),
and you had to put negations all over git_tcp_connect,
exactly because the meaning is exactly the opposite to
what you need.

> > What addresses were tried by connect?
>
> You are speaking about your patch reporting the IP on failure?

Yes. Not on failure (not only). Every time an address is tried
to connect.

> I think it makes sense, but it's a separate issue, isn't it?

You are just about to make git_tcp_connect verbose,
are you not?
