From: Matthijs Melchior <mmelchior@xs4all.nl>
Subject: Re: [PATCH] Add option -L to git-tag.
Date: Sun, 03 Jun 2007 02:04:06 +0200
Message-ID: <f3t0hn$siq$1@sea.gmane.org>
References: <1180773465209-git-send-email-mmelchior@xs4all.nl>	<7vfy5avf89.fsf@assigned-by-dhcp.cox.net> <46616C19.4020800@xs4all.nl> <7vvee6qkr4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 02:04:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HudaR-0005Y8-6a
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 02:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbXFCAEj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 20:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762288AbXFCAEj
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 20:04:39 -0400
Received: from main.gmane.org ([80.91.229.2]:32804 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420AbXFCAEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 20:04:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Huda6-0001PV-QF
	for git@vger.kernel.org; Sun, 03 Jun 2007 02:04:26 +0200
Received: from zwaan.xs4all.nl ([213.84.190.116])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 02:04:26 +0200
Received: from mmelchior by zwaan.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 02:04:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zwaan.xs4all.nl
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <7vvee6qkr4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48961>

Junio C Hamano wrote:
> Matthijs Melchior <mmelchior@xs4all.nl> writes:
> 
>> Junio C Hamano wrote:
>> ...
>>> I dunno; I've never been very good at the user interfaces.
>>>   
>> Yes, since I have this command and have seen the tag annotations in the
>> git repository, I think we need this extra parameter.
>> I propose to give the number of lines you want to see, with 0 gives all.
>> So it will be --pretty=<max-number-lines> to limit the output and be
>> able to find interesting stuff before looking at the complete message.
> 
> Please do not use the same word used elsewhere ('pretty') and
> make it mean something different (they are 'short', 'oneline', etc.
> in other places).
> 
> Regardless of how we might do a single-liner output, I suspect that
> Instead of showing them like this (your patch):
> 
> 	$ git tag -L v2.6.1* | head -n 6
> 	v2.6.11
>             This is the 2.6.11 tree object.
> 	v2.6.11-tree
>             This is the 2.6.11 tree object.
> 	v2.6.12
>             This is the final 2.6.12 release
> 
> showing them in this way might be more pleasant:
> 
> 	$ git tag -L v2.6.1* | head -n 3
> 	v2.6.11      This is the 2.6.11 tree object.
> 	v2.6.11-tree This is the 2.6.11 tree object.
> 	v2.6.12      This is the final 2.6.12 release
> 
> This matches the way "git branch -v" without other arguments,
> which I think is the moral equivalent for branches to your "git
> tag -L", shows a bit more information than the usual (we could
> even say "git tag -l -v" but -v is already taken -- we could
> still do "git tag --list --verbose" and leave the short '-v' to
> mean 'verify' but I dunno).

Yes, this is a good idea.
I have dropped the -L option, and in stead introduced the -n option.
The -n option specifies how many lines of annotation you want to see.
Not using -n gives the old -l behavior, just -n gives the tag and
first annotation line together, and -n 9999 gives the full annotation.

I think this is better than having two different list options.

> 
> This is a slightly related tangent, but I've been wanting to
> extend the "the first line is special 'one-line summary',
> separated by a blank line from the rest of the more descriptive
> message" convention used in the commit log message formatter.
> When somebody asks for --pretty=oneline, instead of showing the
> "first line", we would give the first paragraph, with LFs
> replaced with SPs to make it a single line.  This would not
> affect commit log messages that follow the above convention.
> 
> If your tags have a few lines to describe what the commits are
> about, it might make it easier to get the overview by applying
> the same "first paragraph squashed down to a single line" logic,
> grab the first paragraph, present it as a one-liner" in the
> format shown above.

I will leave this for another time...

> 
>>>>  - Sorting the tag names resulting from git-rev-parse is not nessecary since
>>>>    the list of tags is already deliverd in sorted order.
>>> This I am a bit reluctant about, as that sorting done by
>>> rev-parse is purely by accident (i.e. it is an implementation
>>> detail).
>>>   
>> This accident can be repaired by documenting it.... :)
> 
> That would cast the implementation in stone, avoidance of which
> was the point of my comment.
> 

Yes, I understand. It would be good if the manual page for rev-parse
said something about the order in which the arguments are processed or
generated. Currently this is not mentioned, so I was not surprised
to find the generated names were sorted.

>>> What does this command exit with now?  It used to be that
>>>
>>> 	$ git tag -l no-such-tag-at-all ; echo $?
>>>
>>> said "1", I think, because grep did not match.
>>>   
>> It will always exit 0, either from sed or git-cat.
>>
>> ...
>>
>>  (maybe the exit code is not worth the added complexity...).
> 
> That's 40% satisfactory answer.
> 
> I do not speak for others, but when I comment on a patch, saying
> "This might be better done this other way", or "This change
> might be bad", I do not necessarily expect/want you to agree
> with me on all counts.  I would very much be happier to get a
> counter argument back -- that's how we both learn things and
> make progress.
> 
> Unlike Linus, I am not always right ;-)
> 
> But more seriously, I sometimes deliberately make suggestions
> that I know are not optimal, because I want to involve other
> people (not necessarily the author of the patch, but others on
> the list) in the process of making improvements.
> 
> The "40%" satisfactory part comes from that you correctly
> answered that your version now always exits zero while the
> original diagnosed the "no such tag whatsoever" situation with
> non-zero exit, with a slight hint that you think it might be
> better not to differenciate the "no match" case.
> 
> What I would prefer to see is to make that "slight hint" more
> explicit.  As you say, "is not worth the added complexity" is a
> possible justification, but in this particular case, I think we
> could (and probably should) even argue that the current exit
> code is not so useful.  It might go like this...
> 
>     Although "git tag -l <pattern>" currently signals non-match
>     with its exit code, "git tag -l do-i-have-this-tag" is not
>     the right way to ask that question to begin with, because
>     the tagname parameter is always taken as a pattern.  For
>     that, "git show-ref --verify refs/tags/do-i-have-this-tag"
>     is much better.  I do not think the current exit status from
>     "git-tag -l <pattern>" is useful, and we should change it to
>     exit with 0 unless we see other errors (e.g. "not a git
>     repository"), regardless of the addition of -L option.
> 
> and you would have got the remaining 60% ;-).
> 
> I care about documenting the change in behaviour and justifying
> why we changed the behavikour in the commit log.
> 

Take 3 of the patch is forthcoming.
 - A new -n option is introduced, specifying the number of
   annotation lines to print. The default value is 0.
 - The <pattern> is now a shell pattern, and not a list if grep
   parameters. It is called a pattern and not re, after all.
 - The -l <pattern> may be repeated with a different <pattern>
 - The exit code for -l is now always 0.


Thanks.

Regards,
	Matthijs Melchior.
