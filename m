From: Chris Ridd <chris.ridd@isode.com>
Subject: Re: [PATCH] Improve sed portability
Date: Thu, 12 Jun 2008 09:29:27 +0100
Message-ID: <4850DE67.703@isode.com>
References: <1213189759-11565-1-git-send-email-chris.ridd@isode.com>
            <484FDB5D.7060606@viscovery.net> <484FEF71.2030909@isode.com>
            <4850D45E.8000802@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 10:30:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6iCP-0004C0-BQ
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 10:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbYFLI3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 04:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbYFLI3a
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 04:29:30 -0400
Received: from rufus.isode.com ([62.3.217.251]:38698 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296AbYFLI33 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 04:29:29 -0400
Received: from [172.16.0.138] (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPSA 
          id <SFDeaABZBB9G@rufus.isode.com> for <git@vger.kernel.org>;
          Thu, 12 Jun 2008 09:29:28 +0100
User-Agent: Thunderbird 2.0.0.14 (X11/20080507)
In-Reply-To: <4850D45E.8000802@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84735>

Johannes Sixt wrote:
> Chris Ridd schrieb:
>> Johannes Sixt wrote:
>>> Chris Ridd schrieb:
>>>> @@ -73,7 +73,7 @@ resolve_relative_url ()
>>>>  module_name()
>>>>  {
>>>>      # Do we have "submodule.<something>.path = $1" defined in
>>>> .gitmodules file?
>>>> -    re=$(printf '%s' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
>>>> +    re=$(printf "%s\n" "$1" | sed -e 's/[].[^$\\*]/\\&/g')
>>> You change sq into dq. Is this not dangerous? Shouldn't backslash-en be
>>> hidden from the shell so that printf can interpret it?
>> It is necessary to use double quotes. This:
>>
>>     printf '%s\n' foobar
>>
>> prints a literal \, a literal n, and no newline:
>>
>>     foobar\n
>>
>> Not desirable :-(
> 
> On both Linux and AIX 4.3 I see:
> 
> $  printf 'x\ny'; echo z
> x
> yz
> 
> The printf turns the \n into LF.

Yes, and I don't know *what* I did yesterday, but Solaris 8, 10, (every 
OS I mentioned before) behave the same as your test.

I did actually have my eyes tested later on yesterday :-)

> I mentioned this in the first place because I don't know what various
> shells do with \n when they see "%s\n". But one way or the other, the \n
> will be turned into LF, either by the shell or by printf. So it's not a
> big deal.

I agree.

>> Of course, using a plain old:
>>
>>     echo "$1"
>>
>> should work well too. Why is printf being used here and not echo, anyway?
> 
> Because the "$1" could contain character sequences that some 'echo'
> implementations mangle.

Indeed. If $1 started with -n that might cause problems on some platforms.

Should I revise my commit to use single quotes again?

Cheers,

Chris
