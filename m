From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 07/14] t7800-difftool.sh: Fix a test failure on Cygwin
Date: Sat, 18 Dec 2010 20:32:39 +0000
Message-ID: <4D0D1A67.4090000@ramsay1.demon.co.uk>
References: <4D07B724.8000901@ramsay1.demon.co.uk> <20101217023357.GA30083@gmail.com> <7vwrn8i31n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 23:09:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU4yE-00063k-LA
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 23:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab0LRWJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 17:09:35 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:33555 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751658Ab0LRWJe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Dec 2010 17:09:34 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PU4y4-0005WH-ex; Sat, 18 Dec 2010 22:09:33 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vwrn8i31n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163942>

Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
>>> diff --git a/git-difftool.perl b/git-difftool.perl
>>> index e95e4ad..ced1615 100755
>>> --- a/git-difftool.perl
>>> +++ b/git-difftool.perl
>>> @@ -52,6 +52,7 @@ sub generate_command
>>>  	my @command = (exe('git'), 'diff');
>>>  	my $skip_next = 0;
>>>  	my $idx = -1;
>>> +	my $prompt = '';
>> Would it be simpler to set $prompt = 1 and then
>> flip it to 0 when -y | or --no-prompt is supplied?
>> ...
>>
>> This would become:
>>
>> 	if ($prompt) {
>> 		...
>> 	}
>> 	else {
>> 		...
>> 	}
> 
> But that is not what the patch does, is it?
> 
> Isn't it more like initializing $prompt to undef and then the above
> condition becomes:
> 
> 	if (!defined $prompt) {
>         	; # nothing
>         elsif ($prompt) {
> 		setenv PROMPT true
> 	} else {
> 		setenv NO_PROMPT true
> 	}
> 
> no?

Yes. :-P
At least that is what I was aiming for.

In particular, if none of -y, --no-prompt or --prompt is passed on
the command-line, I don't want to set either key in the hash.
(Or, to put it another way, I don't want to change the behaviour
in this case, where neither variable is set in the environment
of the helper script)

ATB,
Ramsay Jones
