From: Andreas Ericsson <ae@op5.se>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Tue, 22 Nov 2005 14:58:01 +0100
Message-ID: <438323E9.3050809@op5.se>
References: <20051122132144.24691.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Nov 22 15:01:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeYeu-0006KA-P1
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 14:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVKVN6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 08:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVKVN6E
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 08:58:04 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:5771 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S964940AbVKVN6D (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 08:58:03 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id F28EB6BCFF; Tue, 22 Nov 2005 14:58:01 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: linux@horizon.com
In-Reply-To: <20051122132144.24691.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12548>

linux@horizon.com wrote:
>>So, would this be considered legal or would it barf on baz?
>>
>>foo		# No prefix
>>	bar	# tab prefix
>>        baz     # 8 spaces prefix
> 
> 
> It would barf on baz.  "\t" is not a prefix of "        ".
> 

But to the human eye they are the same. This is just a backwards way of 
making the computer think it's smart by recognizing a difference that, 
for all human purposes, aren't there. Like Linus said some posts ago; 
software should conform to humans. Not the other way around.

> 
>>Real fun would be if the mta sends tabs as spaces. Then there'd
>>be no way at all of telling if the config *is* valid or not.
> 
> 
> We have this problem already with whitespace damage in the "before"
> parts of patches.  Are you suggesting that the user will be confused
> because some third party edited their config using an editor that
> messed up the leading whitespace and then just left it broken?
> 

This is supposed to be edited by git config-set (or at least editable). 
When that breaks or when someone finds it inconvenient people will start 
using their editors. The logical way for a user to align new text to 
text 8 spaces away is to use the tab key. Depending on the editor (and 
the settings of that editor), the user will seem to have made perfectly 
correct changes that git will barf on, which brings us back to "software 
should conform to humans".

In short; This proposed format is just one step above a binary-format 
config file from the user-friendliness perspective.


> There's a certain level of "evil gremlins came in during the night and
> added bugs to my code" that I bloody well expect to be confusing!
> 

Can't help you there. I only do the cuddly mogwais.

> You might have problems inserting a line that suffers mailer damage,
> mailer sends you, but if you had sent it as a context diff, the patch
> process would have choked on the whitespace anyway.
> 

git only does unified diffs (but doesn't allow any fuzz, so it would 
break those too).

> I'm not particularly agitating for an indent-based syntax, but it
> is moderately popular and successful, and anyone criticising it should
> at least know how it works.
> 
> The standard interpretation of leading whitespace accepts basically
> that subset of "looks right" that is insensitive to tab setting.
> 
> 
>>Excellent error messages aren't good enough. It's ok for Python, since 
>>that's a programming language. We can expect infinitely more from 
>>programmers than we can from users.
> 
> 
> We're talking about git users here, right?
> More specifically, we're talking about git users who are pulling from
> multiple remote trees, no?
> 
> Perhaps you could clarify how this set of people is not a strict
> subset of the set of programmers...
> 

Package maintainers, tech-doc writers. Not really suits, but with a hint 
of tie nonetheless.

> 
>>That's not the point. If everything looks good it should work good, 
>>regardless of which editor or tab-setting one's using.
> 
> 
> Unfortunately, that's provably impossible, because it will look
> different to different people.
> 
> Proof by example:
> 
> header1
>     header2	# 4 spaces
>         body3	# 8 spaces
> 	body4	# one tab
> 
> That looks good to me, with 8-space tabs:
> 
> header1 {
>     header2 {
>         body3
>         body4
>     }
> }
> 
> But it also looks great to someone with 4-space tabs:
> 
> header1 {
>     header2 {
>         body3
>     }
>     body4
> }
> 
> Too bad it doesn't work the same.
> 
> The standard whitespace-parsing algorithm rejects "body4" on the grounds
> that it's ambiguous.


What I conclude from these examples are that;
1. Any brace-parsing algorithm does the right thing for every case.
2. Indentation-level parsing doesn't, so it's less robust.

Indentation-level parsing is nice-ish in a programming language because 
it enforces strong typing so others that read your program can easily do 
so. I personally disagree with that, but I can see the point.

How important is it that others can easily read your configuration file?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
