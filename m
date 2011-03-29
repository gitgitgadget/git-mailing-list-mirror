From: Andreas Ericsson <ae@op5.se>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Tue, 29 Mar 2011 12:54:57 +0200
Message-ID: <4D91BA81.2020702@op5.se>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>	<AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>	<4D909DD1.2050904@viscovery.net>	<AANLkTinC9Lr9uCTUZSVxVR56+FQm2NGRpPu90fm9OHF5@mail.gmail.com>	<vpq62r3i1z4.fsf@bauges.imag.fr>	<AANLkTimT+WN2F-BmQzQrAs3uizHig9cCXDUdc7nQ-vC5@mail.gmail.com>	<vpqr59r6sg5.fsf@bauges.imag.fr>	<AANLkTinuH4Ut+jtdqRfFrNeXA6JmBK2i0ddCcz4vV6JC@mail.gmail.com>	<vpqvcz35cjk.fsf@bauges.imag.fr> <AANLkTikADLZvN0N==_H47O1vcrap1_Mcf7vW69d5sh0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andrew Garber <andrew@andrewgarber.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r?= =?ISO-8859-15?Q?=F0?= 
	<avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 12:55:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4WZs-0000k6-7L
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 12:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453Ab1C2KzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 06:55:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33075 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab1C2KzD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 06:55:03 -0400
Received: by wya21 with SMTP id 21so25412wya.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 03:55:01 -0700 (PDT)
Received: by 10.216.160.129 with SMTP id u1mr3802611wek.88.1301396101383;
        Tue, 29 Mar 2011 03:55:01 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id l5sm1874805wej.8.2011.03.29.03.54.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 03:54:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9 ThunderGit/0.1a
In-Reply-To: <AANLkTikADLZvN0N==_H47O1vcrap1_Mcf7vW69d5sh0d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170254>

On 03/28/2011 08:57 PM, demerphq wrote:
> On 28 March 2011 20:23, Matthieu Moy<Matthieu.Moy@grenoble-inp.fr>  wrote:
>> Andrew Garber<andrew@andrewgarber.com>  writes:
>>
>>> On Mon, Mar 28, 2011 at 1:55 PM, Matthieu Moy
>>> <Matthieu.Moy@grenoble-inp.fr>  wrote:
>>>
>>>> Then which commit do you specify as "good"?
>>>
>>> Any ancestral commit *on the same branch* which is know to be working.
>>
>> What is the point is finding manually a commit *on the same branch* when
>> the tool can do that for you? You don't know how old the breakage is, so
>> finding the first good commit will take some time. Knowing that the
>> other branch is good gives you a hint that the common ancestor between
>> branches should be good, so a good start would be to find the common
>> ancestor.
> 
> This doesn't make a lot of sense to me. It is just as likely NOT to be useful.
> 
> It could just as easily have been fixed in the other branch. So
> knowing its good wont tell you where it was broken.
> 
> This started off with:
> 
>        o--o--o--B
>       /
>    --o--o--o--o--G
> 
> So lets say that the reality of each node looks like this:
> 
>        B--B--B--B*
>       /
>    --B--B--B--G--G*
> 
> How does knowing that G* is good help us find what broke B* again?
> 

Because if G* is good and B* is bad, git-bisect knows to look for
the merge-base (the leftmost lower B in your graph) to know that
it's not looking at uninteresting commits.

> Your description matches the case of something like this:
> 
>        B--B--B--B*
>       /
>    --G--G--G--G--G*
> 
> But what about something like this:
> 
>        Bx--B--B--B*
>       /
>    --Gz--By--B--Gx--G*
> 
> How does knowing that G* is good help you to find that Bx broke the
> code in the B* branch again?
> 

Because it helps locate Gz as the common ancestor between G* and B*.

To bisect a problem with B*, you'd mark B* as bad and, assuming Gz is
a stable release from which the feature-branch B has arisen, you'd
mark Gz as good. Then bisect will quite quickly find that Bx is the
culprit.

Or, if G* works well but B* does not and you can't be arsed to locate
the common ancestor yourself, you mark G* as good and B* as bad and then
git-bisect will automatically reset the "good" mark from G* to Gz. This
ofcourse doesn't work when the two points in doesn't share a common
ancestor, although that should be a rare occasion indeed and won't
make much sense.

> Presumably 'By' broke the G* branch which was then fixed by Gx and
> none of this information helps you at all identify that Bx broke the
> B* branch.
> 

You're right. For that, you'd need two different bisects. If the two
breakages are identical (an unlikely situation, but still), you'd end
up with git-bisect finding a single commit when marking GB* (the merge
of G* and B*) as bad and Gz as good. Which one is hard to tell though.
But then again, git-bisect has never claimed to be able to locate all
bugs at once. It can just help you locate where a particular bug was
introduced.

There are some cases where it will fail quite gruesomely though. When
one bug is covered by another and fixing the first bug uncovers the
one you're bisecting for. Even then it will still cut down considerably
on time spent doing implemetation analysis (aka "staring at code").

> Whereas a plain binary search on the B* branch would eventually find
> that Bx was responsible.
> 

True, but a binary search would mean about a bazillion git-bisect runs
on large and complex history (such as the kernel, or git itself) when
the bug is located in an already merged feature-branch, but noone knows
which one.

>>> Perhaps you could give a concrete example of where you could use it
>>> for multiple branches simultaneously?
>>
>> Well, see my previous email.
> 
> Where you said "It's not uncommon in real life to face the "it works
> in branch foo but
> not in branch bar, where did it break?" problem. And one expects a great
> tool such as Git to be able to answer it."
> 
> Seems to me that this is trying to cram two questions into one:
> 
> A) where did branch foo diverge from branch bar and
> B) which commit between that ancestor and bar did things break.
> 

The only question git-bisect tries to answer is "which is the first
bad commit". If you want the implementation details, I suggest you
read the code, but naturally it knows how to walk the DAG it's
inspecting and naturally it tries to make life easier for the human
it inevitable serves.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
