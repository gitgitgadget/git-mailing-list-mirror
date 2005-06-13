From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Unset TZ in t5000
Date: Mon, 13 Jun 2005 17:54:53 +0200
Message-ID: <42ADAC4D.7050408@lsrfire.ath.cx>
References: <20050613002444.80848.qmail@web41213.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 17:50:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhrCf-0003PE-II
	for gcvg-git@gmane.org; Mon, 13 Jun 2005 17:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVFMPzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 11:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVFMPzA
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 11:55:00 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:1968 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261611AbVFMPy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 11:54:57 -0400
Received: from [10.0.1.3] (p508E336C.dip.t-dialin.net [80.142.51.108])
	by neapel230.server4you.de (Postfix) with ESMTP id C8DFB150;
	Mon, 13 Jun 2005 17:54:56 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <20050613002444.80848.qmail@web41213.mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Mark Allen schrieb:
> Unset TZ in t5000 and remove GNU awkism
> 
> The t5000 test script fails at test #4 on my box because my copy of 
> tar adjusts the time in the tarfile for local time if TZ is set. 
> Explicitly unset TZ so that it reports GMT time.

Good idea.

> Additionally, my version of AWK doesn't like the "length" directive, 
> so this patch removes it.

What kind of AWK is that?  The One True AWK certainly has a length
function for strings and POSIX mandates it, too, so it's not a GNUism.

The expression

   length($5)<7 ? $5":00" : $5

(where $5 is a time value) is there to cope with tars that format the
time like hh:mm instead of the expected hh:mm:ss.  If you have to remove
the call to "length", please replace the thing with something
equivalent, like

   match($5, /:.*:/) ? $5 : $5":00"

or similar, instead of simply dropping that test.

Thanks,
Rene
