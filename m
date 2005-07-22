From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/2] GIT: Try all addresses for given remote name
Date: Fri, 22 Jul 2005 23:37:53 +0200
Message-ID: <20050722213753.GK11916@pasky.ji.cz>
References: <20050721.091036.01119516.yoshfuji@linux-ipv6.org> <20050722210913.GH11916@pasky.ji.cz> <20050722.172629.73295196.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 23:39:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw5EA-0008UJ-Io
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVGVViU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVGVViU
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:38:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:8 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262196AbVGVVh7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 17:37:59 -0400
Received: (qmail 28218 invoked by uid 2001); 22 Jul 2005 21:37:53 -0000
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Content-Disposition: inline
In-Reply-To: <20050722.172629.73295196.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 22, 2005 at 11:26:29PM CEST, I got a letter
where "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org> told me that...
> In article <20050722210913.GH11916@pasky.ji.cz> (at Fri, 22 Jul 2005 23:09:13 +0200), Petr Baudis <pasky@suse.cz> says:
> 
> > > -}
> > > +#define STR_(s)	# s
> > > +#define STR(s)	STR_(s)
> > 
> > Uh-huh? Why two macros? Well, why any macros at all?
> > 
> :
> > > +	char *colon, *end;
> > > +	char *port = STR(DEFAULT_GIT_PORT);
> > > +	struct addrinfo hints, *ai0, *ai;
> 
> The macro is used here.
> This is trick.
> 
> After preprocess,
> 
> /* --- cut here --- */
> #define TEST 12345
> #define STR_(s) # s
> #define STR(s) STR_(s)
> 
> test(STR(TEST));
> test(STR_(TEST));
> test(# TEST);
> /* --- cut here --- */
> 
> becomes
> 
> test("12345");
> test("TEST");
> test(# 12345);

I see, I didn't know about this. Well, I didn't actually use the #
stringificator many times. Perhaps a short comment would be due.

> > >  	if (sockfd < 0)
> > >  		die("unable to create socket (%s)", strerror(errno));
> > > -	if (connect(sockfd, (void *)&addr, sizeof(addr)) < 0)
> > > -		die("unable to connect (%s)", strerror(errno));
> :
> > You are saying that you were unable to create socket while you just were
> > unable to connect.  Not any biggie, but it saves the user the trouble of
> > one strace after being confused by an error message. :-)
> 
> In fact, I don't think it is really worng, because it says that
> it could not create (connected) socket or endpoint of connection.

It uses only two words ("create socket") from that, though. ;-)

> Anyway, I agree that it would be confusing.
> Better ideas / wordings?

	if (connect() < 0) sockfd = -2;
	...
	if (sockfd == -1) die("unable to create socket");
	else die("unable to connect")

or I'd prefer the second error message "unable to connect", which is
perhaps more descriptive regarding what effectively happened.

BTW, could the close() on the socket ever fail (read as "modify errno")
here?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
