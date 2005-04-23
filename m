From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [patch] fixup GECOS handling
Date: Sun, 24 Apr 2005 01:38:21 +0200
Message-ID: <20050423233821.GN13222@pasky.ji.cz>
References: <1113820589.16288.5.camel@nosferatu.lan> <1113827713.5286.13.camel@localhost.localdomain> <1114179795.29271.18.camel@nosferatu.lan> <1114186599.31076.409.camel@axer.marchex.com> <1114189105.29271.36.camel@nosferatu.lan> <20050422171818.GE7173@pasky.ji.cz> <1114192702.31076.428.camel@axer.marchex.com> <1114196803.29271.52.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kyle@marchex.com, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 01:33:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPU88-0004YV-Aj
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 01:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVDWXi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 19:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVDWXi1
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 19:38:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27832 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262177AbVDWXiW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 19:38:22 -0400
Received: (qmail 1609 invoked by uid 2001); 23 Apr 2005 23:38:21 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1114196803.29271.52.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 09:06:43PM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> @@ -311,6 +296,17 @@
>         if (!pw)
>                 die("You don't exist. Go away!");
>         realgecos = pw->pw_gecos;
> +       /*
> +        * The GECOS fields are seperated via ',' on Linux, FreeBSD, etc,
> +        * and ';' on AIX.
> +        */
> +#if defined(__aix__)
> +       if (strchr(realgecos, ';'))
> +               *strchr(realgecos, ';') = 0;
> +#else
> +       if (strchr(realgecos, ','))
> +               *strchr(realgecos, ',') = 0;
> +#endif
>         len = strlen(pw->pw_name);
>         memcpy(realemail, pw->pw_name, len);
>         realemail[len] = '@';

I'm confused, what does this has to do with AIX? Do we even have / can
expect to have any major AIX users?

I'm not too happy with this, I have to say. It seems it won't do always
the right thing anyway. I would still favour the approach when you cut
off everything after ';', and everything after ',' if no ';' is found.
Seems simplest, safest, etc.

Tell me about anyone who has a semicolon in his realname.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
