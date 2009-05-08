From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: Re: Tests in Cygwin
Date: Fri, 08 May 2009 10:19:42 -0400
Message-ID: <4A043F7E.5070702@SierraAtlantic.com>
References: <83prfbhasp.fsf@kalahari.s2.org>	 <4A01E64C.7050703@SierraAtlantic.com>	 <7vvdoet13g.fsf@alter.siamese.dyndns.org>	 <4A028A0A.5070003@viscovery.net> <4A030277.2000708@SierraAtlantic.com>	 <20090508020037.GA1264@coredump.intra.peff.net>	 <4A03CAFE.4060503@viscovery.net>	 <7v4ovwaygf.fsf@alter.siamese.dyndns.org> <81b0412b0905080228j6b114631p35395464c0c98540@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, Hannu Koivisto <azure@iki.fi>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 16:19:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2QvU-0002UB-Rw
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 16:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbZEHOTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 10:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbZEHOTj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 10:19:39 -0400
Received: from mail51.messagelabs.com ([216.82.241.99]:42589 "HELO
	mail51.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751481AbZEHOTi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 10:19:38 -0400
X-VirusChecked: Checked
X-Env-Sender: Don.Slutz@SierraAtlantic.com
X-Msg-Ref: server-10.tower-51.messagelabs.com!1241792378!28063897!1
X-StarScan-Version: 6.0.0; banners=sierraatlantic.com,-,-
X-Originating-IP: [206.86.29.5]
Received: (qmail 9488 invoked from network); 8 May 2009 14:19:39 -0000
Received: from seng.sierraatl.com (HELO USFREEX1.us.corp.sa) (206.86.29.5)
  by server-10.tower-51.messagelabs.com with SMTP; 8 May 2009 14:19:39 -0000
Received: from usbosex2.us.corp.sa ([192.168.17.38]) by USFREEX1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 8 May 2009 07:19:38 -0700
Received: from [192.168.15.51] ([76.119.170.128]) by usbosex2.us.corp.sa over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 May 2009 10:19:37 -0400
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <81b0412b0905080228j6b114631p35395464c0c98540@mail.gmail.com>
X-OriginalArrivalTime: 08 May 2009 14:19:37.0245 (UTC) FILETIME=[048C84D0:01C9CFE8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118605>

Here is some testing that does not require a sub-shell and does support 
options:

rhf2-1:~/tmp>foof() { local IFS='       ,+';local args="$*"; for i in 
$args; do echo i=$i; done; }
rhf2-1:~/tmp>foo1() { for i; do echo i=$i; done; }
rhf2-1:~/tmp>foo2() { for i in $*; do echo i=$i; done; }
rhf2-1:~/tmp>foo1 'a b c' d e+f g,h 'j  k'
i=a b c
i=d
i=e+f
i=g,h
i=j k
rhf2-1:~/tmp>foo2 'a b c' d e+f g,h 'j  k'
i=a
i=b
i=c
i=d
i=e+f
i=g,h
i=j
i=k
rhf2-1:~/tmp>foof 'a b c' d e+f g,h 'j  k'
i=a
i=b
i=c
i=d
i=e
i=f
i=g
i=h
i=j
i=k
rhf2-1:~/tmp>uname -a
CYGWIN_NT-5.1 rhf2-1 1.5.25(0.156/4/2) 2008-06-12 19:34 i686 Cygwin

Note: that should be IFS=$' \t+,' and $'j\tk' in case the mailer messes 
this up.   I did not use this bash special syntax.

So which should we go with? foo2() which does the original way or foof() 
which allows you to use ',' and '+', and spaces?
    -Don

-------- Original Message --------
Subject: Re: Tests in Cygwin
From: Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Date: 5/8/2009 5:28 AM
> 2009/5/8 Junio C Hamano <gitster@pobox.com>:
>   
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>     
>>>>   +for prerequisite in $(echo "$1" | tr , ' ')
>>>>         
>>> So, you dislike the space separator, but you also dislike the IFS games
>>> that save a few new processes? ;) (Think of Windows, where fork is expensive).
>>>       
>> You can play IFS=, game, then ;-)
>>
>> I have to admit that it feels so 80'ish, back when our UNIX machines were
>> so slow that we tried to shave every fork+exec from our shell scripts by
>> using built-ins when possible, though.
>>     
>
> Well, on Windows (at least with Cygwin), it is 80's still. My workstation
> (a 2.4GHz P4, 70C hot, 2Gb Dell monster) is about 100x slower than my
> old Asus laptop (a 384Mb, 1200Ghz Pentium-M) in starting a trivial program
> ("int main() { return 0; }").
>
> I'm trying to save where possible on cygwin, whatever cost.
>   


__________________________________________________________________________________________________________________
DISCLAIMER:"The information contained in this message and the attachments (if any) may be privileged and confidential and protected from disclosure. You are hereby notified that any unauthorized use, dissemination, distribution or copying of this communication, review, retransmission, or taking of any action based upon this information, by persons or entities other than the intended recipient, is strictly prohibited. If you are not the intended recipient or an employee or agent responsible for delivering this message, and have received this communication in error, please notify us immediately by replying to the message and kindly delete the original message, attachments, if any, and all its copies from your computer system. Thank you for your cooperation." 
________________________________________________________________________________________________________________
