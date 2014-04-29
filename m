From: Jeremy Morton <admin@game-point.net>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Tue, 29 Apr 2014 12:05:41 +0100
Message-ID: <535F8785.10302@game-point.net>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>	<20140406170204.15116.15559.chriscool@tuxfamily.org>	<xmqqmwfv3433.fsf@gitster.dls.corp.google.com>	<20140425.215619.2296838250398594645.chriscool@tuxfamily.org> <xmqq8uqptno9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 13:05:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf5rA-0006Lp-UH
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 13:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933727AbaD2LFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 07:05:44 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:60731 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933724AbaD2LFn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 07:05:43 -0400
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id 27C3C18A09AC;
	Tue, 29 Apr 2014 06:13:28 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <xmqq8uqptno9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247566>

On 28/04/2014 17:37, Junio C Hamano wrote:
> Christian Couder<chriscool@tuxfamily.org>  writes:
>
>> From: Junio C Hamano<gitster@pobox.com>
>>>
>>> Christian Couder<chriscool@tuxfamily.org>  writes:
>>> ...
>>
>>>> +	trailer. After some alphanumeric characters, it can contain
>>>> +	some non alphanumeric characters like ':', '=' or '#' that will
>>>> +	be used instead of ':' to separate the token from the value in
>>>> +	the trailer, though the default ':' is more standard.
>>>
>>> I assume that this is for things like
>>>
>>> 	bug #538
>>>
>>> and the configuration would say something like:
>>>
>>> 	[trailer "bug"]
>>>          	key = "bug #"
>>>
>>> For completeness (of this example), the bog-standard s-o-b would
>>> look like
>>>
>>> 	Signed-off-by: Christian Couder<chriscool@tuxfamily.org>
>>>
>>> and the configuration for it that spell the redundant "key" would
>>> be:
>>>
>>> 	[trailer "Signed-off-by"]
>>>          	key = "Signed-off-by: "
>>
>> Yeah, but you can use the following instead:
>>
>>   	[trailer "s-o-b"]
>>           	key = "Signed-off-by: "

One thing I'm not quite understanding is where the "Christian 
Couder<chriscool@tuxfamily.org>" bit comes from.  So you've defined the 
trailer token and key, but interpret-trailers then needs to get the 
value it will give for the key from somewhere.  Does it have to just be 
hardcoded in?  We probably want some way to get various variables like 
current branch name, current git version, etc.  So in the case of always 
adding a trailer for the branch that the commit was checked in to at the 
time (Developed-on, Made-on-branch, Author-branch, etc. [I think my 
favourite is Made-on-branch]), you'd want something like:

	[trailer "m-o-b"]
		key = "Made-on-branch: "
		value = "$currentBranch"

... resulting in the trailer (for example):
	Made-on-branch: pacman-minigame

Also, if there were no current branch name because you're committing in 
a detached head state, it would be nice if you could have some logic to 
determine that, and instead write the trailer as:
	Made-on-branch: (detached HEAD: AB12CD34)

... or whatever.  And also how about some logic to be able to say that 
if you're committing to the "master" branch, the trailer doesn't get 
inserted at all?

-- 
Best regards,
Jeremy Morton (Jez)
