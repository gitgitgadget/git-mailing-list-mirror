From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] show color hints based on state of the git tree
Date: Mon, 15 Oct 2012 11:13:37 +0200
Message-ID: <507BD3C1.4040807@drmicha.warpmail.net>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org> <20121005211030.GA5414@simaj.xs4all.nl> <507BC7F1.3080506@drmicha.warpmail.net> <507BD0EE.5000107@nieuwland.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	spearce@spearce.org, artagnon@gmail.com, schwab@linux-m68k.org
To: Simon Oosthoek <soosthoek@nieuwland.nl>
X-From: git-owner@vger.kernel.org Mon Oct 15 11:13:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNgkB-0000st-5f
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 11:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab2JOJNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 05:13:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43246 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751359Ab2JOJNj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 05:13:39 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 351B420753;
	Mon, 15 Oct 2012 05:13:39 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 15 Oct 2012 05:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=JIl9UzkArybJLuH1g+MTyu
	FJCVE=; b=AzUCfC8fihV8Dz+9FJiTJd5tpnl+JBxMG/VYqvvXVC0LXCeO73beI3
	HzJp48+sOJmlXW7XLxX6dgQ0G9sRWhyldhzJgS3JecyFkc/PokIMnRGjl9zFbItk
	MJU3NUxVaGzvB2RllDyehngYdNuNS10Jey/fxY1b0rqgh/92H4Xc0=
X-Sasl-enc: 1CH46sa+VEGMWeuXSyy+MPhfipUEe521dxRy/0lsa1nE 1350292418
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 16ADE4827EE;
	Mon, 15 Oct 2012 05:13:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <507BD0EE.5000107@nieuwland.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207728>

Simon Oosthoek venit, vidit, dixit 15.10.2012 11:01:
> On 10/15/2012 10:23 AM, Michael J Gruber wrote:
>> Sorry for being late ($DAYJOB and such), but I just noticed this is on
>> next already:
>>
>>> +			if [ -n "${GIT_PS1_SHOWCOLORHINT-}" ]; then
>>
>> You're missing the "S" here (HINTS).
> 
> indeed, well spotted!
> My test setup was apparently configured without the S and the commented 
> uses all had HINTS...
> 
> 
>>
>>> +				local c_red='\e[31m'
>>> +				local c_green='\e[32m'
>>> +				local c_yellow='\e[33m'
>>> +				local c_lblue='\e[1;34m'
>>> +				local c_purple='\e[35m'
>>> +				local c_cyan='\e[36m'
>>> +				local c_clear='\e[0m'
>>> +				local branchstring="$c${b##refs/heads/}"
>>> +				local branch_color="$c_green"
>>> +				local flags_color="$c_cyan"
>>> +
>>> +				if [ "$w" = "*" ]; then
>>> +					branch_color="$c_red"
>>> +				elif [ -n "$i" ]; then
>>> +					branch_color="$c_yellow"
>>> +				fi
>>> +
>>> +				# Setting PS1 directly with \[ and \] around colors
>>> +				# is necessary to prevent wrapping issues!
>>> +				PS1="$PS1\[$branch_color\]$branchstring\[$c_clear\]"
>>> +				if [ -n "$f" ]; then
>>> +					PS1="$PS1 \[$flags_color\]$f\[$c_clear\]"
>>> +				fi
>>> +			else
>>> +				PS1="$PS1$c${b##refs/heads/}${f:+ $f}$r$p"
>>> +			fi
>>> +			PS1="$PS1)$ps1pc_end"
>>> +		else
>>> +			# NO color option unless in PROMPT_COMMAND mode
>>>   			printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
>>>   		fi
>>>   	fi
>>>
>>
>> I'm afraid I don't like this coloring style at all because it is
>> inconsistent with the color usage of "git status -sb". First of all, the
>> colors are different, and second, the fact *what* is colored is
>> different. I had suggested following "git status -sb" for a good reason.
>> It colors a branch green and a detached head red. It colors "change"
>> (A/D/M/R) as red/green depending on non-cached/cached, so that's how */+
>> should be. Your call for $/% (I'd leave them uncolored).[*][**]
> 
> This way works for me. The coloring scheme itself is probably quite 
> personal and can, and probably should, be modified by end-users.
> (Whether the current code is suitable for user-modification is another 
> matter)

It really doesn't matter much what works for you, and it doesn't matter
what works for me either. The point is: What works for most users?

> I'm quite unfamiliar with the color coding of git (I hadn't enabled that 
> option), I suppose consistency would be better, but then you'd have to 
> add some code to figure out which color is used for what in git's output 
> and convert that to the code setting the colors here.

As a starter, you could use the default colors which git uses. Querying
git for the colors could be the next, optional step.

> As for the characters used, I think there's a good reason not to use the 
> ones git uses in the prompt. The characters in git status output are put 
> in front of the files they apply to, in the prompt you only get a 
> summarized output. And perhaps that argument could be extended to the 
> use of the colors as well, I prefer to know whether I have uncommitted 
> changes and in that category I want to know whether I already staged 
> them or not.

Well, sure. The prompt could show any of AMCRD if you have any of those
changes. * + are shortcuts saying you have any of those.

> If I want to know which files are unstaged/uncommitted I do git status 
> to see that.

Sure. I don't propose putting file names in the prompt ;)

>>
>> I think it's very confusing to have completely different schemes (not
>> just themes) for two versions of the same information: concise status
>> information.
>>
>> So, please try and follow "git status -sb".
> 
> I think there are different levels of conciseness. And I see "git status 
> -sb" uses green for staged modified files, which would be confusing to me.

...only because you don't know the color coding scheme. It's green
because those changes are saved somewhere (in the index) and would even
survice a branch switch.

>> Michael
>>
>> [*] Really, there's nothin "red" about a branch when there are cached or
>> non-cached changes. They are changes wrt. to what's in HEAD resp. the
>> index, no matter what HEAD is.
> 
> Do you mean that red (unstaged) and yellow (staged) are both "red" to you?

No, I said red for unstaged, green for staged for the characters, i.e. a
* would always be red if present, a + always green if present.

For the "branch name", it would be red for detached head and green for
checked out branch.

>> [**] Also, coloring the status characters opens the way to even using
>> the same characters as "status -sb" (ADM).
>>
> 
> Perhaps, but that would be confusing to me ;-)

If that is case, you can try and propose changing that scheme...

But there's really a good reason for it. Cached (staged) changes are
"safe" because they are saved in the index, and also they are "good to
go into the next commit", i.e. the commit traffic lights are green!

Michael
