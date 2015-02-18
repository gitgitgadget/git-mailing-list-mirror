From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Should "git log --decorate" indicate whether the HEAD is detached?
Date: Wed, 18 Feb 2015 11:15:17 +0100
Message-ID: <54E46635.4060009@drmicha.warpmail.net>
References: <CACdBeKmNazMtzK4hdd7WXMPDr7HdPe+EFpyd3M-TPBAUEY+HpA@mail.gmail.com>	<xmqqa90d4fdp.fsf@gitster.dls.corp.google.com> <CACdBeKnWJvUmFaHNrzcX7LtovOLu3PFaeTyoUAUeC7wmYUboDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julien Cretel <j.cretel@umail.ucc.ie>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 11:15:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO1fB-00037a-Uy
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 11:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbbBRKPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 05:15:22 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56931 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751050AbbBRKPU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2015 05:15:20 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id EFA2020E04
	for <git@vger.kernel.org>; Wed, 18 Feb 2015 05:15:19 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 18 Feb 2015 05:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=GkQXuJ8zmWdaBLGX/9H/iw
	z7PCE=; b=ja8GtU41Vit/r9Cq+x6Aa2n10rPOfPff2yV95kP+Z+AvwmTosLVxw+
	m0Xv2yTrmIlGonG1yxksrjjBuCEuyuDpyBsqphD0voPKKzKiAY2vctiosntS/eix
	CEay9WuTUYfbcv58o+YlU0ROfwJfwzFqvdLs7MF+b2oPrUifqPEyA=
X-Sasl-enc: OO+szXXPreCYTPfhbFt/ISGY5q/uQh4AkSKTXJqi6x4s 1424254519
Received: from localhost.localdomain (unknown [88.70.121.210])
	by mail.messagingengine.com (Postfix) with ESMTPA id E61F5C002A7;
	Wed, 18 Feb 2015 05:15:18 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CACdBeKnWJvUmFaHNrzcX7LtovOLu3PFaeTyoUAUeC7wmYUboDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264013>

Julien Cretel venit, vidit, dixit 17.02.2015 00:40:
> On Mon, Feb 16, 2015 at 11:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Julien Cretel <j.cretel@umail.ucc.ie> writes:
>>
>>> As of Git 2.3.0, the output of "git log --decorate" is ambiguous as to
>>> whether the HEAD is detached or not.
>>
>> It sounds as if you are reporting some regression, but has any
>> version of Git ever done so, or is this just a new feature that
>> does not exist yet?
> 
> Apologies; I should have explained myself better. I'm not reporting a
> regression;
> as far as I can tell, "git log --decorate" has always been ambiguous
> in that way.
> 
>>
>>> More specifically, consider the following output of "git log --decorate":
>>>
>>>     4d860e9 (HEAD, master, dev) Remove trailing whitespace
>>>
>>> Whether the HEAD is attached to master or detached, the output is the same.
>>> Could/should "git log --decorate" be modified to provide this information?
>>> Perhaps something along the lines of
>>>
>>>     4d860e9 (HEAD -> master, dev) Remove trailing whitespace
>>>
>>> or
>>>
>>>     4d860e9 (HEAD = master, dev) Remove trailing whitespace
>>>
>>
>> I personally do not see a need for such a differenciation.  Why does
>> one even need to know, and is it worth the cost of computing at the
>> runtime?
> 
> I believe the "--decorate" flag to be quite popular. I personally like to run
> "git log --decorate --graph --oneline --all" to quickly get an idea of the state
> of a repo. In my experience, many users do the same, to the point that they
> feel the need to define an alias for this command; see the top answers to
> http://stackoverflow.com/q/1057564/2541573.
> 
> My problem with the current output of "git log --decorate" is the asymmetry,
> so to speak. If the HEAD is detached but pointing at a commit that isn't any
> branch's tip, then the user can be sure the HEAD detached; however, if at
> least one branch points to the current commit, there is no way to tell.
> 
> I must admit I haven't given much thought about the cost involved, but I can't
> imagine performance would take a big hit. Would it?
> 
>>
>> Most of the time when I am on detached HEAD it is either a few
>> commits behind a tip, or a few commits ahead of a tip.

"git branch" will tell you your branches and which one is checked out
(or HEAD); "git status" will tell you the latter.

"git log" is about the DAG which has absolutely nothing to do with what
you have currently checked out.

Your expectation may come from the fact that the default argument to
"git log" is HEAD; or from what "gitk" and other ui tools do.

On the other hand, our decorations can be considered "wrong" in the
following sense: if HEAD is a symref it really points to a (branch) ref,
not a commit. In this situation, "HEAD" should be the decoration of the
branch ref, not of the commit which the branch ref resolves to.

But that would apply to annotated tags, as well: they point to tag
objects (and should decorate them by the logic above) rather than commit
objects.

So, what "log --decorate" really and consistently does is resolving
("peeling") any decorating reference until it points to a commit object,
and decorate that.

A --decorate-detailed mode which does without the peeling could be
elucidating - that would need markers for (branch) refs and tag objects
in addition to commit objects, though (and an extension of the machinery).

Michael
