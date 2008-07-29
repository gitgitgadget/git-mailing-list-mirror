From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Tue, 29 Jul 2008 23:17:23 +0200
Message-ID: <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no>
References: <488772BC.80207@workspacewhiz.com> <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com> <alpine.DEB.1.00.0807231956280.8986@racer> <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no> <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no> <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no> <20080725140142.GB2925@dpotapov.dyndns.org> <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no> <20080729134619.GB7008@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 23:18:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNwaS-0004iL-Uw
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 23:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbYG2VR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 17:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbYG2VR1
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 17:17:27 -0400
Received: from eyvind.bernhardsens.net ([84.49.228.97]:55732 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbYG2VR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 17:17:26 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.221])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 7E1941B3DF1;
	Tue, 29 Jul 2008 23:17:24 +0200 (CEST)
In-Reply-To: <20080729134619.GB7008@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90684>

On 29. juli. 2008, at 15.46, Dmitry Potapov wrote:

> On Fri, Jul 25, 2008 at 11:05:33PM +0200, Eyvind Bernhardsen wrote:
>
> You clearly want *enforcing* and versioning for you is just means to  
> do
> that. Regardless, what is the best way to achieve that, the *main*
> question is whether we want this enforcing and if yet then in what  
> form
> and to what degree...

The versioning has nothing to do with the enforcing per se, it just  
makes it possible to convert a repository with CRLFs to one that's LF- 
only without having to rewrite history.  See below.

>>> If we had core.autocrlf=input as default then clueless users will  
>>> not
>>> checkin files with the incorrect ending. But there is an objection  
>>> to
>>> that -- you penalize those who always have good endings. And even  
>>> the
>>> fact that is merely default value that you can easily change to  
>>> false
>>> does not convince everyone.
>>
>> That is an excellent argument for why setting "autocrlf=true" by
>> default on Windows was a bad idea.  Thanks! :)
>
> I am sorry, but I don't see connection here.

My point was that autocrlf penalises Windows users just as much as it  
does Linux users, so why should it be turned on by default on  
Windows?  But I've promised not to complain any more about this until  
I have cold, hard code to back me up.

> Again, why should people who do not use Windows and other CR-damaged
> tools be penalized? No one can prevent me from putting in *my* own
> repository whatever I want anyway. Thus, if we agreed having this
> conversion/check is useful, remaining questions are:
> 1. whether this check should be possible to turn off
> 2. whether this check should be turned off by default for people
>   who use Git on other system than Windows?
> The current status is:
> 1. Yes, it is possible to turn of this conversion
> 2. It is turned off by default for anyone but MSYS/GIT users.
>
> And the main argument for having that in this way is that people  
> with LF
> text files should be unnecessary penalized for Windows being  
> different.

I know, but my point is that I don't like to be unnecessarily  
penalised any more when I am using Windows than when I'm using Linux  
or OS X.  I would like the default to be "no conversion", and for  
conversion to be enabled not based on platform, but as a policy  
decision on the repositories where it actually matters.

You can have anything you like in _your_ repository, of course, but if  
you're not publishing it anywhere, who cares what your line endings  
are?  Your line endings only matter when you publish.  That's why I  
want a setting that is propagated: so that when you clone a repository  
with a LF-only policy, Git knows what to do.

>> As you say, the reason I want the setting to be per-repository is  
>> that
>> I don't think the cost is worthwhile for every repository.
>
> Side note: Personally, I am not very concerned about this cost, but  
> some
> people are...

Yeah :)

I think the real penalty is that with autocrlf enabled, Git no longer  
stores exactly what I committed.

>> The case
>> where it _is_ worthwhile is when the repository will be shared  
>> between
>> Windows users and Linux users, and the Windows users want CRLFs in
>> their working directories.  I think it's worthwhile to actually make
>> Git work right in that case.
>
> Windows users who want CRLF should set autocrlf=true
> Windows users who prefer LF should set autocrlf=input
> Non-Windows users who copy file directly from Windows should also
> set autocrlf=input
> All other users who do not touch Windows may have autocrlf=false.
>
> Files that do not need conversion (such as *.bat) should be marked as
> "-crlf" in .gitattributes.

Yes, and I see you checked that "crlf=input" does actually work when  
you want LF-only, sorry about that.  The syntax is _horrible_, though.

> Of course, those who are very careful and have good editors can set
> autocrlf=false even on Windows...

Right, or who know that the repository they're using will only be  
shared with other Windows users.  But with "autocrlf=false" in their  
config, they would have to remember to set "autocrlf=true" in .git/ 
config in any new repositories they want to share with Linux users.   
I'd like to make that per-repository configuration automatic.

>> As a side note, there's a lot of complaining about the cost of
>> enforcing LF-only input, but I can't remember seeing any actual
>> numbers.  Is it really that bad?
>
> No, it is not bad. In most practical cases, you will not notice any
> difference. I've posted some numbers in this thread. You can find
> them here:
> http://article.gmane.org/gmane.comp.version-control.git/89908

Oh, thanks!  I missed that post, and I agree that those numbers don't  
look particularly worrying.

[...]

>>> but there are people who do not want to pay any price for  
>>> conversion.
>>> Currently, "core.autocrlf=false" means to do nothing about end-of-
>>> lines,
>>> and even to ignore setting in .gitattributes. Should it be  
>>> possible to
>>> disable *any* conversion on checkin and checkout? Should this be  
>>> that
>>> value be the default, which most users use?
>>
>> Well, there's no reason why Git repositories used only on Windows
>> machines shouldn't store CRLFs, so why should all msysgit users pay
>> the cost on every checkin _and_ checkout?
>
> 1. You may want to use on other platforms later. In any case, it makes
>   much sense to have the default that compatible with other systems.

This is why I want the setting to be versioned.  If you decide to  
share with other platforms later, you just enable the setting and "git  
commit -a" (untested!  Recursive touching is probably required  
first).  No history has to be rewritten, and new checkouts will work  
properly (as will old checkouts, but for a slightly different value of  
"properly").

> 2. Conversion cost is not significant (I suppose much less than gzip
>   compression used for all objects) and it also saves some space.
> 3. Internally, Git considers only LF as true end of line. CR is just
>   like an extra space before end-of-line. Is any good reason to have
>   it inside of your repo anyway?

Internally, Git doesn't really care, does it?  The only reason to keep  
the line endings I committed is "because that's what I committed", but  
I think it's quite a good reason.

> 4. This is what other VCSes do on Windows. CVS converts all text files
>   on checkin. SVN does the same for files having svn:eol-style=native.

Heh.  Where I work, we hacked CVS for Windows to get away from that  
behaviour :)

> In fact, if you read the discussion we had here some time ago, you may
> find some other arguments too.

Yep, but I think I'm doing this backwards.  Instead of rehashing old  
arguments, I need to implement something that does what I want and let  
the list decide if it's useful or not.

>> This is the reason the setting needs to be a per-repository policy  
>> and
>> not a user configuration;
>
> What exactly?
>
>
>> users should not be able to configure away
>> correctness,
>
> Why not? *Every* user has him/her own repository, so he/she can do
> *anything* with it, in principle.
>
>> but they shouldn't be penalised unnecessarily for it,
>> either.
>
> The problem is how to determine when it is necessary and when it is
> not. If I never commit with wrong EOLs, I don't think it is necessary
> for me to have this conversion... On the other hand, I don't mind  
> having
> this check as default.  It does not really bother me much, and if I  
> can
> turn it off, it is fine with me. But I suppose other people may feel
> differently about this issue.

Well, what I want is to be able to say "it is necessary to do eol  
conversion in this repository", allowing the default to be "don't do  
eol conversion" on Windows, too.  For a setting like that to be  
useful, it has to be propagated when the repository is cloned.

I want it to be versioned because you might want to change it without  
messing with the content that's already in the repository.  This is  
actually my main motivation, since I have lots of CRLF-infused CVS  
history to deal with.

It should apply on Linux as well as Windows because there is always  
the chance that a user will manage to commit a CRLF on Linux (a  
colleague of mine once complained that CVS on Linux doesn't do eol  
conversion; he edited files on Windows, but checked them in on  
Linux).  It would probably be okay to have a setting that turns all  
conversion off, but wouldn't that be kind of rude?

Thanks, all, for your help in getting my ideas straight; now to find  
out if I'm coder enough to implement them.  If not, I'll just stick  
with setting "autocrlf=false" on Windows and stop whining.
-- 
Eyvind Bernhardsen
