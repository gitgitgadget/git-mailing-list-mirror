From: Patrick Sabin <patrick.just4fun@gmail.com>
Subject: Re: git workflow - merging upwards
Date: Fri, 17 Aug 2012 10:14:48 +0200
Message-ID: <CAGATVH7kjm--CEDjNrLuaTgqrm6P7yD1X_iCMN_NwY_QNqqHzQ@mail.gmail.com>
References: <502D4EAE.9010704@gmail.com>
	<7vboia1sb8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 10:15:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Hhz-0005uz-IQ
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 10:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383Ab2HQIO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 04:14:56 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:38832 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240Ab2HQIOt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 04:14:49 -0400
Received: by qcro28 with SMTP id o28so2869433qcr.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DZdfv2515ffD67LJt5l8q2WZ60rDYYo/LZB8ULUZCWU=;
        b=qbokJ6gwdXbI3b5W9avr9EDUuKxLo2ArsfLWadGHyVmKu8feMx2kkS0Sgy0LYtO36Z
         KZFOU9G2BfpC0pE13aPWgDRih2TmnesyENQQ5i4I7NjVm+xffCbA9SMxYTf4imeQJQAZ
         sr5VSVeFjakGjILeQTfkLpjL4dSUnarNtakeheijFpxf1hxjXQkG+QUQ0kdTDJ//M+3t
         UYkR3H5Kh9HT9u+Mnc1A5yPwtsuhQSCWlF5ePR6fkiZLpUJu1B/aO3Q5SRkG3wi0mfnj
         loLIG7B8x2p7CX62bZ7gxZiSSFRf0cFgfC1yIhfLp1lnlOJRC6ezfv6GHr7ubVwmT5lT
         byMA==
Received: by 10.229.135.83 with SMTP id m19mr3006141qct.78.1345191288236; Fri,
 17 Aug 2012 01:14:48 -0700 (PDT)
Received: by 10.229.70.145 with HTTP; Fri, 17 Aug 2012 01:14:48 -0700 (PDT)
In-Reply-To: <7vboia1sb8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, for the great answer.

What I am still concerned about is that in my project I plan to make bigger
structural changes (let's say in 1.2) while still developing in the
older branch
(let's say 1.1 with the old structure. I expect that there will be many changes
which I think that they can't be easily merged from 1.1 to 1.2.

Do you think it is better to have a heavily used 1.1.1 branch which
contains all
the changes for 1.1.* only, use many revert commits, or should I avoid merging
from 1.1 to 1.2 and go for cherry-picking instead?

On Thu, Aug 16, 2012 at 10:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Patrick Sabin <patrick.just4fun@gmail.com> writes:
>
>> I read through gitworkflows and want to use the Merge Upwards rule in
>> my projects:
>>
>> "Always commit your fixes to the oldest supported branch that require
>> them. Then (periodically) merge the integration branches upwards into
>> each other."
>>
>> This looks great but I have some trouble in the case if I want to have
>> a change in an older branch and don't want to propagate the change to
>> the newer branches. Let's say I have a v1.1 and a v1.2 and now a have
>> a bug fix/workaround which only affects version v1.1 but not v1.2. If
>> I commit to v1.1 then the periodical merge would merge the change to
>> v1.2 which is what I don't want.
>>
>> Any ideas/workarounds for that problem?
>
> The document may describe the "upwards" in a bit too simplified way
> for readability.  If you have two fixes to 1.1, one applicable only
> to 1.1 and the other applicable to both, you would fork them from
> tip of maint-1.1, like so:
>
>     git checkout -b fix-1.1-only maint-1.1; do your work and commit
>     git checkout -b fix-1.1-onwards maint-1.1; do your work and commit
>
> and when they are proven to be good, you would merge both of them to
> maint-1.1 branch:
>
>     git checkout maint-1.1
>     git merge fix-1.1-only
>     git merge fix-1.1-onwards
>
> But merging the resulting maint-1.1 into maint-1.2 will pull the
> history and the change of fix-1.1-only that you do not want to have
> in maint-1.2.  You want the history so that later merge will not
> pull it to maint-1.2, but you do not want the change.
>
> The first thing to think about is if fix-1.1-only is really a "fix
> that only should go to maint-1.1".
>
> If the change is only for 1.1.x release (e.g. update version number
> from 1.1.4 to 1.1.5), you may not even want to have such a change
> directly on the maint-1.1 branch in the first place.  You would
> rather want to have release-1.1 branch that is forked from maint-1.1
> branch, that contains the whole of maint-1.1 branch, and also
> contains the "update version number from 1.1.x to 1.1.y" changes
> that are not in the maint-1.1 branch [*1*].
>
> That arrangement may be sufficient to allow you merge maint-1.1 to
> maint-1.2 sanely.
>
> Otherwise, you would fork another branch after merging fix-1.1-*
> branches to maint-1.1 to merge it upwards.  After these two merges
> illustrated above, while still on maint-1.1, you would do:
>
>     git checkout -B merge-1.1-to-1.2 maint-1.1
>     git revert -m 1 maint-1.1~1 ;# revert the fix-1.1-only merge
>
> which would result in a state as if you merged fix-1.1-onwards but
> not fix-1.1-only to the original maint-1.1 branch.  But the history
> of this branch contains both fix-1.1-only and fix-1.1-onwards.
>
> And merge that result to maint-1.2, i.e.
>
>     git checkout maint-1.2
>     git merge merge-1.1-to-1.2
>     git branch -d merge-1.1-to-1.2
>
> That way, future merges from maint-1.1 to maint-1.2 will not drag
> the change of fix-1.1-only.
>
>
> [Footnote]
>
> *1* This principle applies not just to "release numbers". If you
> want both maint-1.1 and maint-1.2 as generic two codebases, tweaks
> meant only for customers of maint-1.1 track should *not* go to
> maint-1.1, but customer-1.1 branch that forks from maint-1.1. That
> way, you can keep the generic branches clean from "this is only for
> that branch" kind of changes.
