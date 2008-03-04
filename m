From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on
 maxsize reached
Date: Tue, 04 Mar 2008 17:19:18 +0100
Message-ID: <47CD7686.9040501@viscovery.net>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <20080304140930.GA23335@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michal Rokos <michal.rokos@nextsoft.cz>, GIT <git@vger.kernel.org>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:20:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZs0-0002dl-NN
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764698AbYCDQTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764886AbYCDQTW
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:19:22 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12121 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764573AbYCDQTW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:19:22 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JWZqi-0004rO-Pj; Tue, 04 Mar 2008 17:18:41 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0DDDE546; Tue,  4 Mar 2008 17:19:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080304140930.GA23335@pvv.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76116>

Finn Arne Gangstad schrieb:
> On Tue, Mar 04, 2008 at 02:59:28PM +0100, Michal Rokos wrote:
> 
>> +	while ( ret == -1 )
>> +	{
>> +		maxsize = (maxsize*3)/2;
>> +		s = realloc(s, maxsize);
>> +		if (! s) return -1;
>> +		ret = vsnprintf(s, maxsize, format, ap);  /* <--- UNSAFE! */
>> +	}
> 
> This is not generally safe, you cannot call vsnprintf multiple times
> with the same ap on all architectures. You need va_copy (or __va_copy,
> or VA_COPY, differs a bit between different architectures, especially
> one the ones with a broken vsnprintf I guess..)

True. But...

This replacement of vsnprintf will not be needed on all architectures, but
only on some. And on these we can test in advance whether we can get away
without va_copy (et.al.). A note next to the configuration setting about
this would be in order, I think.

Furthermore, on systems where vsnprintf is broken in this way, va_copy is
likely not available.

-- Hannes

