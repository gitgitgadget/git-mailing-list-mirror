From: Bob Portmann <bportmann@yahoo.com>
Subject: Re: git-log produces no output
Date: Fri, 21 Apr 2006 12:38:08 -0700 (PDT)
Message-ID: <20060421193808.57328.qmail@web60314.mail.yahoo.com>
References: <Pine.LNX.4.64.0604211223561.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 21 21:38:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FX1SI-00040J-HO
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 21:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWDUTiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 15:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWDUTiK
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 15:38:10 -0400
Received: from web60314.mail.yahoo.com ([209.73.178.137]:15953 "HELO
	web60314.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932376AbWDUTiI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Apr 2006 15:38:08 -0400
Received: (qmail 57330 invoked by uid 60001); 21 Apr 2006 19:38:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fsPU26XtEVRmrk4yzZxtPIs7kPrxkaaIQSV1DuHQzZr6HwaGFW1uYIHFpQffoiInyPrclanL8EbEnvFMiOX+xoc1vpfx7lWl1trr4qfD+/4DV8T5li49oy+1grgm0jlYsbCxiy7bGihh9skp43OtOd7z6cU6i+nBbCxYx+iIfk0=  ;
Received: from [140.172.241.92] by web60314.mail.yahoo.com via HTTP; Fri, 21 Apr 2006 12:38:08 PDT
To: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604211223561.3701@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19029>

Yes, that fixes it, even with the crazy PAGER (which is going to be
plain 'more' from now on:-)

Thanks,
Bob

--- Linus Torvalds <torvalds@osdl.org> wrote:

> On Fri, 21 Apr 2006, Linus Torvalds wrote:
> > 
> > This patch would have made things a lot more obvious.
> 
> Actually, scratch that one, and use this one instead. Much better,
> and 
> actually allows Bob's crazy PAGER environment variable to work,
> rather 
> than just reporting an error about it.
> 
> 		Linus
> ---
> diff --git a/pager.c b/pager.c
> index b063353..9a30939 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -8,6 +8,7 @@ #include "cache.h"
>  static void run_pager(const char *pager)
>  {
>  	execlp(pager, pager, NULL);
> +	execl("/bin/sh", "sh", "-c", pager, NULL);
>  }
>  
>  void setup_pager(void)
> @@ -47,5 +48,6 @@ void setup_pager(void)
>  
>  	setenv("LESS", "-S", 0);
>  	run_pager(pager);
> +	die("unable to execute pager '%s'", pager);
>  	exit(255);
>  }
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
