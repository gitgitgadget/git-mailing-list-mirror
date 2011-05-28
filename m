From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: Re: [msysGit] [PATCH] Embed an application manifest on MinGW
Date: Sat, 28 May 2011 18:07:36 -0300
Message-ID: <4DE16418.4020002@cesarb.net>
References: <1306612707-29748-1-git-send-email-cesarb@cesarb.net> <alpine.DEB.1.00.1105282241510.11411@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 28 23:08:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQQjx-0000Nd-6f
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 23:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121Ab1E1VIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 17:08:04 -0400
Received: from smtp-02.mandic.com.br ([200.225.81.133]:47386 "EHLO
	smtp-02.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab1E1VIB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 17:08:01 -0400
Received: (qmail 20119 invoked from network); 28 May 2011 21:07:56 -0000
Received: from unknown (HELO cesarb-inspiron.home.cesarb.net) (zcncxNmDysja2tXBptWToZWJlF6Wp6IuYnI=@[200.157.204.20])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-02.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <Johannes.Schindelin@gmx.de>; 28 May 2011 21:07:55 -0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10
In-Reply-To: <alpine.DEB.1.00.1105282241510.11411@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174678>

Em 28-05-2011 17:44, Johannes Schindelin escreveu:
> On Sat, 28 May 2011, Cesar Eduardo Barros wrote:
>> [...]
>> @@ -1551,6 +1554,11 @@ ifdef USE_NED_ALLOCATOR
>>          COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
>>   endif
>>
>> +ifdef APPLICATION_MANIFEST
>> +	# Cannot be in LIB_OBJS because it must always be linked in
>> +	RESOURCE_OBJS += compat/win32/resource.o
>> +endif
>> +
>>   ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
>>   	export GIT_TEST_CMP_USE_COPIED_CONTEXT
>>   endif
>> [...]
>>
>> -git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
>> +git$X: git.o $(BUILTIN_OBJS) $(RESOURCE_OBJS) $(GITLIBS)
>> [...]
>>
>> -git-%$X: %.o $(GITLIBS)
>> +git-%$X: %.o $(RESOURCE_OBJS) $(GITLIBS)
>> [...]
>
> Is it possible that adding the resource object to GITLIBS would reduce the
> patch and be "more correct", too?

I thought about it, but it felt wrong. It is not a library, it is an object.

Also, while adding it to GITLIBS would add the object to all the right 
rules (in fact, I did a search for GITLIBS to find all the places to add 
the new object to), I believe it would get the object linked twice in 
some of the rules (the ones which do a $(filter %.o,$^) would get it 
both from GITLIBS via the filter and from GITLIBS via $(LIBS) on the 
command line).

-- 
Cesar Eduardo Barros
cesarb@cesarb.net
cesar.barros@gmail.com
