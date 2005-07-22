From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH 1/2] GIT: Try all addresses for given remote name
Date: Fri, 22 Jul 2005 17:26:29 -0400 (EDT)
Organization: USAGI/WIDE Project
Message-ID: <20050722.172629.73295196.yoshfuji@linux-ipv6.org>
References: <20050721.091036.01119516.yoshfuji@linux-ipv6.org>
	<20050722210913.GH11916@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Fri Jul 22 23:34:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw547-0005r0-Dh
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVGVV17 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVGVVZ5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:25:57 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:61956 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S262192AbVGVVZn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 17:25:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 0AFF733D27; Sat, 23 Jul 2005 06:26:30 +0900 (JST)
To: pasky@suse.cz
In-Reply-To: <20050722210913.GH11916@pasky.ji.cz>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In article <20050722210913.GH11916@pasky.ji.cz> (at Fri, 22 Jul 2005 23:09:13 +0200), Petr Baudis <pasky@suse.cz> says:

> > -}
> > +#define STR_(s)	# s
> > +#define STR(s)	STR_(s)
> 
> Uh-huh? Why two macros? Well, why any macros at all?
> 
:
> > +	char *colon, *end;
> > +	char *port = STR(DEFAULT_GIT_PORT);
> > +	struct addrinfo hints, *ai0, *ai;

The macro is used here.
This is trick.

After preprocess,

/* --- cut here --- */
#define TEST 12345
#define STR_(s) # s
#define STR(s) STR_(s)

test(STR(TEST));
test(STR_(TEST));
test(# TEST);
/* --- cut here --- */

becomes

test("12345");
test("TEST");
test(# 12345);


> >  	if (sockfd < 0)
> >  		die("unable to create socket (%s)", strerror(errno));
> > -	if (connect(sockfd, (void *)&addr, sizeof(addr)) < 0)
> > -		die("unable to connect (%s)", strerror(errno));
:
> You are saying that you were unable to create socket while you just were
> unable to connect.  Not any biggie, but it saves the user the trouble of
> one strace after being confused by an error message. :-)

In fact, I don't think it is really worng, because it says that
it could not create (connected) socket or endpoint of connection.

Anyway, I agree that it would be confusing.
Better ideas / wordings?

--yoshfuji
