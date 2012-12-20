From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: $PATH pollution and t9902-completion.sh
Date: Thu, 20 Dec 2012 18:25:13 +0100
Message-ID: <50D349F9.9030100@web.de>
References: <20121217010538.GC3673@gmail.com> <20121220145519.GB27211@sigill.intra.peff.net> <CAOkDyE-J7sTJ-GefhteP1wy7WorqTRnj5nn0k6hd1dp0VJz5iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git mailing list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 18:25:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TljsP-0003nx-36
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 18:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367Ab2LTRZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 12:25:27 -0500
Received: from mout.web.de ([212.227.17.11]:58949 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab2LTRZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 12:25:26 -0500
Received: from [192.168.37.101] ([93.222.63.50]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LopMx-1T9f9e3mWp-00gKmc; Thu, 20 Dec 2012 18:25:14
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CAOkDyE-J7sTJ-GefhteP1wy7WorqTRnj5nn0k6hd1dp0VJz5iQ@mail.gmail.com>
X-Provags-ID: V02:K0:22mZkVz3MAjMJgdjq5IqtFH0WDpTmLsdUD/9HBavgZ1
 06NUoM0tu7j6O7faTBXWqftNYWUcxhSVu/Y7BmIXwh5rqG4v/7
 ASZpJQYSlokOhcx/su/0W+lpEvwYqBCK80H7/skiB/dMiIgPxj
 A3PkqgewwkL7Zsx2znyHHCz3FGELjXb7Gk4s6W9IaVA4vVUXzL
 Afy5t61pRmpUHavRA/sPg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211906>

On 20.12.12 16:13, Adam Spiers wrote:
> On Thu, Dec 20, 2012 at 2:55 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Dec 17, 2012 at 01:05:38AM +0000, Adam Spiers wrote:
>>> t/t9902-completion.sh is currently failing for me because I happen to
>>> have a custom shell-script called git-check-email in ~/bin, which is
>>> on my $PATH.  This is different to a similar-looking case reported
>>> recently, which was due to an unclean working tree:
>>>
>>>   http://thread.gmane.org/gmane.comp.version-control.git/208085
>>>
>>> It's not unthinkable that in the future other tests could break for
>>> similar reasons.  Therefore it would be good to sanitize $PATH in the
>>> test framework so that it cannot destabilize tests, although I am
>>> struggling to think of a good way of doing this.  Naively stripping
>>> directories under $HOME would not protect against git "plugins" such
>>> as the above being installed into places like /usr/bin.  Thoughts?
>>
>> I've run into this, too. I think sanitizing $PATH is the wrong approach.
>> The real problem is that the test is overly picky. Right now it is
>> failing because you happen to have "check-email" in your $PATH, but it
>> will also need to be adjusted when a true "check-email" command is added
>> to git.
>>
>> I can think of two other options:
>>
>>   1. Make the test input more specific (e.g., looking for "checkou").
>>      This doesn't eliminate the problem, but makes it less likely
>>      to occur.
>>
>>   2. Loosen the test to look for the presence of "checkout", but not
>>      fail when other items are present. Bonus points if it makes sure
>>      that everything returned starts with "check".
>>
>> I think (2) is the ideal solution in terms of behavior, but writing it
>> may be more of a pain.
> 
> I agree with all your points.  Thanks for the suggestions.
I volonteer for 1) (and we got for 2) later)
