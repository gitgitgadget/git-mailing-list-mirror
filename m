From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Wed, 9 Jul 2014 11:46:14 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1407091142030.22132@ds9.cixit.se>
References: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com> <20140709051040.GB2318@sigill.intra.peff.net> <CAFT+Tg8HZTsbWK2WHHg_q04LY5Vm7cjfNkfHGBEdbKjf1==rKw@mail.gmail.com> <20140709061853.GA6731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Yi, EungJun" <semtlenori@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 09 12:46:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4pOL-0006Qq-CL
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 12:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbaGIKqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 06:46:21 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:49067 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751183AbaGIKqV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 06:46:21 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s69AkEgE026421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 Jul 2014 12:46:14 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s69AkEka026418;
	Wed, 9 Jul 2014 12:46:14 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20140709061853.GA6731@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Wed, 09 Jul 2014 12:46:15 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253112>

Jeff King:

> I did some digging, and I think the public API is setlocale with a 
> NULL parameter, like:
>
>  printf("%s\n", setlocale(LC_MESSAGES, NULL));
>
> That still will end up like "en_US.UTF-8", though;

And it only yields the highest-priority language, I think.

> I couldn't find any standard functions for parsing that. It seems 
> like it would be pretty straightforward to do so, though.

RFC 5646 is the current specification on language tags, btw.

>  From my brief reading of rfc2616, that should probably become 
> "en-us", and any time we add "x-y", we may want to add "x" as a 
> fallback (that is certainly true for English; I don't know about 
> other languages with dialects).

Yes, adding the generic fallback is necessary, as "en-US" on the server 
matches a client's "en", but not vice versa. So if you request "en-US" 
and "de" and the server only has "en-GB" and "de", you'd get the 
"de" version.

Debian's website has a nice writeup on the subject: 
http://www.debian.org/intro/cn#howtoset

-- 
\\// Peter - http://www.softwolves.pp.se/
