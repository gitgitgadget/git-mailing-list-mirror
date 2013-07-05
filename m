From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH v2 1/2] commit: reject invalid UTF-8 codepoints
Date: Fri, 5 Jul 2013 13:51:03 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1307051345260.11814@ds9.cixit.se>
References: <cover.1372957719.git.sandals@crustytoothpaste.net> <20130704171943.GA267700@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>, gitster@pobox.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Jul 05 14:51:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv5Ts-0008EQ-81
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743Ab3GEMvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:51:16 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:39286 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757405Ab3GEMvP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:51:15 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r65Cp3wT029477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 5 Jul 2013 14:51:03 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r65Cp3Cl029474;
	Fri, 5 Jul 2013 14:51:03 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20130704171943.GA267700@vauxhall.crustytoothpaste.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 05 Jul 2013 14:51:03 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229663>

brian m. carlson:

> +		/* U+FFFE and U+FFFF are guaranteed non-characters. */
> +		if ((codepoint & 0x1ffffe) == 0xfffe)
> +			return bad_offset;

I missed this the first time around: All Unicode characters whose 
lower 16-bits are FFFE or FFFF are non-characters, so you can re-write 
that to:

   /* U+xxFFFE and U+xxFFFF are guaranteed non-characters. */
   if ((codepoint & 0xfffe) == 0xfffe)
    return bad_offset;

Also, the range U+FDD0--U+FDEF are also non-characters, if you wish to 
be really pedantic.

$ grep '^[0-9A-F].*<not a' NamesList.txt
FDD0	<not a character>
FDD1	<not a character>
FDD2	<not a character>
FDD3	<not a character>
FDD4	<not a character>
FDD5	<not a character>
FDD6	<not a character>
FDD7	<not a character>
FDD8	<not a character>
FDD9	<not a character>
FDDA	<not a character>
FDDB	<not a character>
FDDC	<not a character>
FDDD	<not a character>
FDDE	<not a character>
FDDF	<not a character>
FDE0	<not a character>
FDE1	<not a character>
FDE2	<not a character>
FDE3	<not a character>
FDE4	<not a character>
FDE5	<not a character>
FDE6	<not a character>
FDE7	<not a character>
FDE8	<not a character>
FDE9	<not a character>
FDEA	<not a character>
FDEB	<not a character>
FDEC	<not a character>
FDED	<not a character>
FDEE	<not a character>
FDEF	<not a character>
FFFE	<not a character>
FFFF	<not a character>
1FFFE	<not a character>
1FFFF	<not a character>
2FFFE	<not a character>
2FFFF	<not a character>
3FFFE	<not a character>
3FFFF	<not a character>
4FFFE	<not a character>
4FFFF	<not a character>
5FFFE	<not a character>
5FFFF	<not a character>
6FFFE	<not a character>
6FFFF	<not a character>
7FFFE	<not a character>
7FFFF	<not a character>
8FFFE	<not a character>
8FFFF	<not a character>
9FFFE	<not a character>
9FFFF	<not a character>
AFFFE	<not a character>
AFFFF	<not a character>
BFFFE	<not a character>
BFFFF	<not a character>
CFFFE	<not a character>
CFFFF	<not a character>
DFFFE	<not a character>
DFFFF	<not a character>
EFFFE	<not a character>
EFFFF	<not a character>
FFFFE	<not a character>
FFFFF	<not a character>
10FFFE	<not a character>
10FFFF	<not a character>

-- 
\\// Peter - http://www.softwolves.pp.se/
