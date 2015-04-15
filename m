From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Odd broken "--date=now" behavior in current git
Date: Wed, 15 Apr 2015 08:07:35 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1504150803370.8606@ds9.cixit.se>
References: <CA+55aFxvcN8Dz-t6fi6etycg+AiyR0crXv5AcfCdv8ji-iNBpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 09:07:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiHQO-00047I-Nd
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 09:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbbDOHHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 03:07:48 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:51391 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752492AbbDOHHr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 03:07:47 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id t3F77bbv018439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 15 Apr 2015 09:07:37 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id t3F77ZrZ018432;
	Wed, 15 Apr 2015 09:07:36 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <CA+55aFxvcN8Dz-t6fi6etycg+AiyR0crXv5AcfCdv8ji-iNBpw@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Wed, 15 Apr 2015 09:07:37 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267186>

Linus Torvalds:

> I can't be the only one seeing this? My guess is that there's a 
> missing initialization of tm.tm_isdst somewhere or whatever.

I can confirm it if I enable DST on my machine (I usually run my 
machines on CET all-year, to avoid these kind of issues):

   $ echo $TZ
   Europe/Oslo
   $ git commit -m b
   [master dee7ec1] b
    1 file changed, 1 insertion(+)
    create mode 100644 b.txt
   $ git show --pretty=fuller
   commit dee7ec1cda74a8abd7f26c60ee1e83f73bb31194 (HEAD -> master)
   Author:     Peter Krefting <peter.krefting@bridgetech.tv>
   AuthorDate: 2015-04-15 09:04:34 +0200
   Commit:     Peter Krefting <peter.krefting@bridgetech.tv>
   CommitDate: 2015-04-15 09:04:34 +0200
   [...]
   $ git commit --amend --date=now
   [...]
   $ git show --pretty=fuller
   commit b4561e5a077de7bbcaf9fc06350ea24407adcec0 (HEAD -> master)
   Author:     Peter Krefting <peter.krefting@bridgetech.tv>
   AuthorDate: 2015-04-15 08:05:04 +0100
   Commit:     Peter Krefting <peter.krefting@bridgetech.tv>
   CommitDate: 2015-04-15 09:05:04 +0200

So the datetime is correct, it's just the timezone that is wrong 
(08:05+0100 = 09:05+0200).

   $ git --version
   git version 2.4.0.rc1

-- 
\\// Peter - http://www.softwolves.pp.se/
