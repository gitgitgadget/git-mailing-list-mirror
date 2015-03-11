From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Wed, 11 Mar 2015 21:30:47 +0100
Message-ID: <5500A5F7.1000503@kdbg.org>
References: <54F88684.3020905@alum.mit.edu>	<xmqqwq2v14iv.fsf@gitster.dls.corp.google.com>	<54F9422D.2020800@web.de> <54F9E907.4040703@alum.mit.edu>	<54FA1C7B.3040906@web.de> <54FF450F.7040506@alum.mit.edu>	<xmqq385c1v13.fsf@gitster.dls.corp.google.com>	<54FF6D23.4060301@alum.mit.edu> <xmqqsidcxy2q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	=?ISO-8859-15?Q?Torsten_B=F6?= =?ISO-8859-15?Q?gershausen?= 
	<tboegi@web.de>, git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 21:31:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVnHR-0001Wy-9P
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 21:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbbCKUa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 16:30:56 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:21663 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751423AbbCKUaz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 16:30:55 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.107])
	by bsmtp4.bon.at (Postfix) with ESMTPS id 3l2Q0Y1Zzpz5ts5
	for <git@vger.kernel.org>; Wed, 11 Mar 2015 21:30:52 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3l2Q0S0sBbz5tlG;
	Wed, 11 Mar 2015 21:30:47 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 4DD5451E0;
	Wed, 11 Mar 2015 21:30:47 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqsidcxy2q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265335>

Am 10.03.2015 um 23:54 schrieb Junio C Hamano:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> Well, that's true, but the "eol" attribute can regain its effect if
>> "binary" is followed by "text" or "text=auto". So I guess the simplest
>> question is as follows. Suppose I have the following .gitattributes:
>>
>>      a.foo eol=crlf
>>      a.foo binary
>>      a.foo text
>>
>> It is obvious in this case that a.foo should be treated as a text file.
>> Should it be processed with "eol=crlf", or should the intervening
>> "binary" imply "-eol"?
>
> I would say former.  You find out what attributes apply to a path
> and then consider the collective effect of these attributes that
> survived.
>
> So the second "No it is not text" which is overruled by the "oops,
> no that is text" later should not get in the picture, I would say.
>
> As binary is not just -text and turns other things off, those other
> things will be off after these three.

Is that how attribute lookup works? I.e., given a path, all attributes 
are collected?

Isn't it more like: Here we are interested in the "eol" attribute of 
this file named "a.foo". And the lookup would find the first line that 
says "eol=crlf". Elsewhere, we are interested in the "binary" attribute 
of the file named "a.foo", and lookup would find the second line that 
sets the "binary" attribute. And again elsewhere, we ask for the "text" 
attribute, and we find the last line that sets the "text" property.

Am I totally off track?

-- Hannes
