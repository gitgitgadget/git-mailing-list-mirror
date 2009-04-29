From: Augie Fackler <durin42@gmail.com>
Subject: Re: [PATCH] Workaround for ai_canonname sometimes coming back as null
Date: Wed, 29 Apr 2009 16:56:08 -0500
Message-ID: <6B7EA51D-8412-4E6A-BA7B-156FD5B755E8@gmail.com>
References: <9C355DCC-0240-4B9E-83CA-083B51C2E34C@gmail.com> <81b0412b0904291455n47f83e9ftcbdec0ff1c0ea03@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:57:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHmj-00050I-6q
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758860AbZD2V4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754129AbZD2V4i
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:56:38 -0400
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:33251 "EHLO
	spunkymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757146AbZD2V4h (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 17:56:37 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2009 17:56:37 EDT
Received: from [192.168.50.170] (unknown [12.116.117.150])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by spunkymail-a12.g.dreamhost.com (Postfix) with ESMTP id 0D2197FA8;
	Wed, 29 Apr 2009 14:56:36 -0700 (PDT)
In-Reply-To: <81b0412b0904291455n47f83e9ftcbdec0ff1c0ea03@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117961>


On Apr 29, 2009, at 4:55 PM, Alex Riesen wrote:

> 2009/4/29 Augie Fackler <durin42@gmail.com>:
>> @@ -459,7 +459,10 @@ static void parse_extra_args(char *extra_args,  
>> int
>> buflen)
>>                                inet_ntop(AF_INET, &sin_addr- 
>> >sin_addr,
>>                                          addrbuf, sizeof(addrbuf));
>>                                free(canon_hostname);
>> -                               canon_hostname = xstrdup(ai- 
>> >ai_canonname);
>> +                               if (ai->ai_canonname)
>> +                                       canon_hostname =
>> xstrdup(ai->ai_canonname);
>> +                               else
>> +                                       canon_hostname = "unknown";
>
> This last line will crash some lines down, when canon_hostname is  
> free'd:
>
> 		inet_ntop(hent->h_addrtype, &sa.sin_addr,
> 			  addrbuf, sizeof(addrbuf));
>
> 		free(canon_hostname); /* CRASH */
> 		canon_hostname = xstrdup(hent->h_name);
> 		free(ip_address);


Odd, because I'm running with that exact code and not seeing the  
problem. Should I resubmit an updated patch that xstrdup's unknown  
into canon_hostname?
