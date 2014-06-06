From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 5/5] Win32: Thread-safe windows console output
Date: Fri, 6 Jun 2014 22:29:12 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1406062224530.17391@ds9.cixit.se>
References: <1402062173-9602-1-git-send-email-kasal@ucw.cz> <1402062173-9602-6-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>, Karsten Blees <blees@dcon.de>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:29:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt1hT-0005RV-9F
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 23:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbaFFV3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 17:29:19 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:54492 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752061AbaFFV3T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 17:29:19 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s56LTDMr019639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 6 Jun 2014 23:29:13 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s56LTCdw019635;
	Fri, 6 Jun 2014 23:29:12 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1402062173-9602-6-git-send-email-kasal@ucw.cz>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 06 Jun 2014 23:29:13 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250971>

Stepan Kasal:

> +	/* only called from console_thread, so a static buffer will do */
> +	static wchar_t wbuf[2 * BUFFER_SIZE + 1];

Wouldn't BUFFER_SIZE + 1 (or even BUFFER_SIZE) do here? If you convert 
from up to BUFFER_SIZE octets of UTF-8 input, you should never get 
back more than BUFFER_SIZE code units of UTF-16 output. Worst case 
would be ASCII, which is one UTF-16 code unit per UTF-8 octet, 
everything else is less (non-BMP is four UTF-8 octets mapping to two 
UTF-16 code units).

-- 
\\// Peter - http://www.softwolves.pp.se/
