From: Russ Allbery <rra@stanford.edu>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 11:10:38 -0700
Organization: The Eyrie
Message-ID: <87r7gs87a9.fsf@windlord.stanford.edu>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	<42730061.5010106@zytor.com>
	<Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	<Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
	<87zmvganq9.fsf@windlord.stanford.edu>
	<1114848175.24014.35.camel@localhost.localdomain>
	<20050430124048.79119cac.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 20:06:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRwLh-0008Bj-Fz
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 20:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVD3SLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 14:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVD3SLC
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 14:11:02 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:48059 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S261330AbVD3SKm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 14:10:42 -0400
Received: from windlord.stanford.edu (windlord.Stanford.EDU [171.64.19.147])
	by smtp3.Stanford.EDU (8.12.11/8.12.11) with SMTP id j3UIAdeI017471
	for <git@vger.kernel.org>; Sat, 30 Apr 2005 11:10:39 -0700
Received: (qmail 1080 invoked by uid 1000); 30 Apr 2005 18:10:39 -0000
To: Edgar Toernig <froese@gmx.de>
In-Reply-To: <20050430124048.79119cac.froese@gmx.de> (Edgar Toernig's
 message of "Sat, 30 Apr 2005 12:40:48 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Edgar Toernig <froese@gmx.de> writes:

> Oh btw, when we are about sucking time functions: the %s and %z
> strftime- sequences used further down are also non-standard (POSIX has
> no %s, old libc has neither %s nor %z).

> A possible workaround:

[...]

> 	tm = localtime(&now); /* get timezone and tm_isdst */
> 	tz = -timezone / 60;
> 	if (tm->tm_isdst > 0)
> 		tz += 60;

The global timezone variable isn't available on all systems.  :)

You really cannot get portable behavior in this area without something
akin to Autoconf probes, unfortunately.  Oh, and you can't assume daylight
savings time is an hour; it is sometimes two hours.  You have to instead
use the altzone variable to get the offset when you're in daylight savings
time, but this again isn't available on all systems.

I posted a pointer to the INN source a while back; I'm really not sure
that anything less is sufficient to get full portability, although I
certainly trust Paul Eggart's implementation.

BTW, the yacc-based thing is exactly what I wrote the INN code to get rid
of, since I didn't want a yacc dependency.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
