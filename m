From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFC: Renaming "git rebase --onto"
Date: Thu, 02 Apr 2015 18:40:26 +0200
Message-ID: <551D70FA.7010708@drmicha.warpmail.net>
References: <05D9209E-FAA2-44C8-9B98-B00997AF5779@JonathonMah.com> <xmqqk2xyw5p3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Max Kirillov <max@max630.net>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 18:40:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdiAc-0004nS-6f
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 18:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbbDBQkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 12:40:37 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34643 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876AbbDBQkg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2015 12:40:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id F23FE208CA
	for <git@vger.kernel.org>; Thu,  2 Apr 2015 12:40:31 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 02 Apr 2015 12:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=7bQOR6xUzOsZTbyV+tw3oZKQcJc=; b=C1mQE3
	TChkZVle8mooMjnaN+naNOxnYoOXvQlLRXEkNyOF3kp/5jnEIMwfoF4/CdxpY2/M
	PDIwfBZnDaKHa35do6HSlgdMo6hoSvWFRzx0WE8N1OTBqw7pdTGgl1Dmkr32jH6l
	KjHmjXSSwkCaFNIvtcu0FbWWmA8rFyFu3Nkbw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=7bQOR6xUzOsZTby
	V+tw3oZKQcJc=; b=KZnv/3Zb6PKJZAuSjOpOd8yykvrvB0YEDItk5DESij/qmpZ
	soVK6rElnxljgUMQ1DgpV7w6gVhD3mqIYYoVYncrHA735wOwUs9w9RWL3BSXpRzb
	T6V9HgLcbcAvq0CvvDqSeg8o/LkicsX+rEPov7lZzby6ZsxIzEkws0wktWbI=
X-Sasl-enc: xVwss1z9xx+ywDAE5K7/mETiWobsvdRovKa6SmZrM4zl 1427992828
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id CBDB8C00027;
	Thu,  2 Apr 2015 12:40:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqk2xyw5p3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266648>

Junio C Hamano venit, vidit, dixit 30.03.2015 23:12:
> Jonathon Mah <me@JonathonMah.com> writes:
> 
>> During a few years of discussing git operations with colleagues, I’ve
>> found the “git rebase --onto” operation particularly ambiguous. The
>> reason is that I always describe a rebase operation as “onto”
>> something else (because of the English phrase “A is based on
>> B”). For example:
>>
>> $ git rebase new-base  # “Rebase HEAD onto new-base (from merge-base of HEAD and new-base)"
>> $ git rebase new-base my-branch # “Rebase my-branch onto new-base
>> (from merge-base of my-branch and new-base)”
>>
>> Personally, I understand “git-rebase --onto new-base old-base” as
>> meaning “rebase from old-base to new-base”. Some prepositions that
>> might make this clearer:
>>
>> $ git rebase --from old-base new-base  # “Rebase HEAD onto new-base, from old-base"
>> $ git rebase --after old-base new-base # “Rebase commits on HEAD
>> after old-base HEAD onto new-base"
>> $ git rebase --excluding old-base new-base # “Rebase HEAD onto
>> new-base, excluding commit old-base (and its parents)"
>>
>> In all cases this would change the order of the arguments compared to
>> --onto, making it more consistent with the no-option rebase.
> 
> The bog-standard rebase is
> 
>     git rebase U
> 
> which rebases the current history that has diverged from the history
> leading to U on to U.
> 
> Or
> 
>     git rebase U BRANCH
> 
> which rebases BRANCH that has diverged from the history leading to U
> on to U.  In both of these invocations, these arguments define which
> part of the local history is replayed.
> 
> Now,
> 
>     git rebase [--onto O] $other_args
> 
> is just a way to say $other_args still define which part of the
> local history is replayed, but you are replaying on something that
> is different from the usual default case (which is U).
> 
> Which feels very consistent between the cases with and without the
> extra --onto parameter, at least to me.  Hence, if you change order
> in any way, I would think you would break the existing consistency.
> 
> I suspect that this thread is a symptom of something unrelated,
> though.  There might be something wrong in your workflow if you find
> yourself using --onto too often, for example, and that may be the
> issue we should be focusing on, not on how "rebase --onto" is
> spelled.
> 
>> What do others think? Is my view of “onto” common or unusual?
> 
> "common or unusual" is a question we cannot answer, I would say.
> People who are used to "rebase" may be so used to it that it might
> feel natural to them but cannot tell if that is only because they
> already know how "rebase" spells its arguments, or they would still
> find it natural if they did not know anything about "rebase".
> 

The basic confusion comes from the natural desire to read a command as a
sentence, and the lack of the rebase UI in that respect:

"git rebase foo" does not "rebase foo"!

"git rebase foo bar" does not "rebase foo" either!

I think it's a UI design mistake that comes from making the common
use-case as short as possible.

In the invocations above, "foo" is neither the ref that is being rebased
nor a rev notation for the affected commits. That would have been foo..
or ^foo.

I seem to recall that we've talked about range notations for rebase.
Maybe we can start accepting them, and once we start teaching "git
rebase ^foo" or "git rebase foo.." it will become clearer that that
argument is not the ref being rebased, but a description of the commits
being rebased. And then it would be natural to talk about "onto foo" for
these cases, as well as leave the "--onto" argument named the way it is
(since it defaults to foo, or rather the fork-point).

Michael
