From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH] compat/mingw.c: MSVC build must use ANSI Win32 API's
Date: Tue, 22 Sep 2009 09:23:23 +0200
Message-ID: <4AB87B6B.1070808@gmail.com>
References: <d2e97e800909212110w423e3b2fm85ac6f76439e0591@mail.gmail.com> <4AB869EE.1020200@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Wookey <michaelwookey@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 22 09:29:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpzoG-0003gt-5k
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 09:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbZIVH3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 03:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754765AbZIVH3E
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 03:29:04 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:40341 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749AbZIVH3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 03:29:01 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2009 03:29:00 EDT
Received: by ewy7 with SMTP id 7so141479ewy.17
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=CRoOuKny7yTC1SALtW+3xy1RDgSb+AYg58JHoPw1wQ4=;
        b=lvxAt97cls6FeQWk0s7kAKJUmspfJbrshGGxKyovI46j/Jc0D1rAgtlLQzP8JdIKYH
         gFICCK0gfSoUtWYnPeczpGqqWurJ2yGNjZDMex2wxX7xmvf6EHBfDH2EgMSDWCwgcz2b
         DoIeQ3NPaz15EpwQ5X77OnkUUdlO0YtOL6TIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=m5+5F99kGYstbT/kDNLy+JsWSvO/gZa5OCDf4/hDhx/spko57kuNwbJc4LOEeALGNc
         aJCrv98OPG0Hq5eqItGhweKsbmGe8mj5M97+e4fsKRzybjc4ivWPFApRB4BTuMy4emal
         lwTz+j+M2XjdWrx92CiPj80QzGO/hvp3qVJ3E=
Received: by 10.211.157.7 with SMTP id j7mr626492ebo.2.1253604236507;
        Tue, 22 Sep 2009 00:23:56 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 28sm1461554eyg.41.2009.09.22.00.23.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Sep 2009 00:23:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <4AB869EE.1020200@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128923>

Johannes Sixt said the following on 22.09.2009 08:08:
> Michael Wookey schrieb:
>> MSVC builds define UNICODE which results in the "WIDE" variation of
>> Win32 API's being used.
>>
>> Explicitly use the ANSI variation of the API's for compatibility with
>> msysgit.
>>
>> Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
> 
> Marius,
> 
> I would like to understand why you did not have this issue.
> 
> The patch itself looks fine.

I never added the UNICODE define to the Git compile
process with MSVC (Check the Makefile), so then the
windows API should use the ANSI version by default.
And the following patch proved my point (sorry, will
probably wrap):
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1201,6 +1201,12 @@ struct mingw_DIR
        char                    dd_name[1];     /* given path for dir with search pattern (struct is extended) */
 };

+#ifdef UNICODE
+#pragma message("We have UNICODE defined")
+#else
+#pragma message("Nope, UNICODE is not defined here")
+#endif
+
 struct dirent *mingw_readdir(DIR *dir)
 {
        WIN32_FIND_DATAA buf;


> make MSVC=1
    CC compat/msvc.o
msvc.c
d:\msvc\git\compat\mingw.c(223) : warning C4133: 'function' : incompatible types - from '_stati64 *' to '_stat64 *'
d:\msvc\git\compat\mingw.c(636) : warning C4090: 'initializing' : different 'const' qualifiers
d:\msvc\git\compat\mingw.c(637) : warning C4090: 'initializing' : different 'const' qualifiers
d:\msvc\git\compat\mingw.c(787) : warning C4090: 'function' : different 'const' qualifiers
d:\msvc\git\compat\mingw.c(797) : warning C4090: 'function' : different 'const' qualifiers
Nope, UNICODE is not defined here
    AR libgit.a
Microsoft (R) Library Manager Version 9.00.21022.08
Copyright (C) Microsoft Corporation.  All rights reserved.

Michael, how are you trying to compile git? With the IDE or
the GNU Make? Which version of MSVC? If you use the IDE, can
you make sure it doesn't contain the UNICODE define in the
compiler section of the properties of the projects?

In general though, I'm ok with patches which specifies the
correct API, so we won't have the problem, should we decide
to add UNICODE in the future.

--
.marius
