From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Bug: t5813 failing on Cygwin
Date: Sun, 8 Nov 2015 13:21:37 +0000
Message-ID: <563F4C61.5040500@ramsayjones.plus.com>
References: <563DEA71.1080808@dinwoodie.org>
 <20151107184527.GA4483@sigill.intra.peff.net>
 <20151107192029.GW14466@dinwoodie.org>
 <1446930165.16957.9.camel@kaarsemaker.net>
 <20151108051059.GB19191@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Sun Nov 08 14:21:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvPun-0003yw-NP
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 14:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbbKHNVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 08:21:45 -0500
Received: from avasout04.plus.net ([212.159.14.19]:56594 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbbKHNVo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2015 08:21:44 -0500
Received: from [10.0.2.15] ([146.199.93.105])
	by avasout04 with smtp
	id f1Me1r0042GQ2gJ011Mf6V; Sun, 08 Nov 2015 13:21:42 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=CvRCCSMD c=1 sm=1 tr=0
 a=SWxm+s7FAPvPP0IAAWI2og==:117 a=SWxm+s7FAPvPP0IAAWI2og==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=mrKfVvcapvGXeMQbqeAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151108051059.GB19191@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281037>



On 08/11/15 05:10, Jeff King wrote:
> On Sat, Nov 07, 2015 at 10:02:45PM +0100, Dennis Kaarsemaker wrote:
> 
>> Looks like lib-proto-disable.sh's fake SSH doesn't strip double leading
>> /'es from the path. Try this patch:
>>
>> diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable
>> -ssh.sh
>> index ad877d7..a954ead 100755
>> --- a/t/t5813-proto-disable-ssh.sh
>> +++ b/t/t5813-proto-disable-ssh.sh
>> @@ -14,7 +14,7 @@ test_expect_success 'setup repository to clone' '
>>  '
>>  
>>  test_proto "host:path" ssh "remote:repo.git"
>> -test_proto "ssh://" ssh "ssh://remote/$PWD/remote/repo.git"
>> -test_proto "git+ssh://" ssh "git+ssh://remote/$PWD/remote/repo.git"
>> +test_proto "ssh://" ssh "ssh://remote$PWD/remote/repo.git"
>> +test_proto "git+ssh://" ssh "git+ssh://remote$PWD/remote/repo.git"
>>  
>>  test_done
> 
> Good catch. It's a shame that the resulting URL becomes a little less
> readable, but given that the damage is limited to this one test, I think
> we can live with it. Working around it in the fake ssh script would
> probably end up unnecessarily complex.
> 
> We may want to have git itself remove extra slashes from URLs, as Ramsay
> suggested elsewhere, but I would worry about regressions. Let's solve
> this test portability problem by itself, and we can consider the other
> as a separate topic if anybody wants to pursue it.

Yep, this is essentially what I decided to do in a similar situation
back in 2011 (see commit 3a81f33c5).

Until I looked into that bug, I hadn't given any thought to whether
cygwin (let alone git) supported the UNC notation. At that time, I did
spend a little time trying to determine if it worked, but for some
reason I just couldn't get a network share configured properly.
It kept on giving me 'permission denied' errors - even using windows
only commands. :(

Since I have no need for network shares on cygwin, I didn't try too
hard ... I will leave it to people more motivated than me! ;-)

ATB,
Ramsay Jones
