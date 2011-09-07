From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Wed, 07 Sep 2011 15:19:38 +0200
Message-ID: <4E676F6A.3060906@drmicha.warpmail.net>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com> <7v1uvta97o.fsf@alter.siamese.dyndns.org> <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 18:57:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1LRE-0008DL-Vl
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab1IGQ5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:57:18 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58817 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750844Ab1IGQ5R (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 12:57:17 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DF07829CBD;
	Wed,  7 Sep 2011 09:19:39 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 07 Sep 2011 09:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=562dmYlZWME8EiELkGLNe4
	0K2Do=; b=mWa8hzvbKbhr+9p8fFrZ5yFNt+CpNU7X0zb2wFR/vzHtA1Qhokfpsx
	V5OiyOXeNfo01cDtQTsGrBTsfjTHswt0IFjZZ9SbEr20uVWc2e5woTjsORiwxGyH
	5rqCTMDR/gjSymMZyufMZhjKES1Z49RdzKOt0MVDU/+JkIeNcoYg8=
X-Sasl-enc: sQ9YVXMIjRzF/RFQuAIld3UhZ26ofUA9PI1r9589crGM 1315401579
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 46FA3A003E9;
	Wed,  7 Sep 2011 09:19:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180870>

Francis Moreau venit, vidit, dixit 06.09.2011 21:28:
> Hello Junio,
> 
> On Tue, Sep 6, 2011 at 7:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Our assumption has always been that it is a notable event that a patch
>> that does not get filtered with internal "git cherry" (which culls patches
>> that are textually identical to those that are already merged to the
>> history you are rebasing onto) becomes totally unneeded and is safe to ask
>> for human confirmation in the form of "rebase --skip" than to ignore it
>> and give potentially incorrect result silently.
> 
> Ok then I think this "git cherry" filtering is not working in my case
> since it seems to me that commit that I cherry-picked are not
> filtered, please see below.
> 
>>
>> Obviously you do not find it a notable event for some reason. We would
>> need to understand why, and if the reason is sensible, it _might_ make
>> sense to allow a user to say "git rebase --ignore-merged" or something
>> when starting the rebase.
> 
> My use case is the following: I'm maintaining a branch from an
> upstream project (the kernel one). While the upstream project follows
> its development cycle (including some fixes), my branch is stuck. I
> sometime want to includes (or rather backport) some commits that
> happened later in the development cycle. To do that I use "git
> cherry-pick".
> 
> After some period, I'm allowed to rebase to a more recent commit from
> the upstream project and  this rebase 'cancel' the previous 'git
> cherry-pick' I did. But for some reasons, git telling me "nothing
> added to commit ...", which is expected in my case, well I think,
> hence my question.
> 
> Thanks.

Unless you had to resolve a conflict when cherry-picking, the picked
commit should be patch-equivalent to the original one, and thus dropped
by rebase automatically.

How do the two patches compare:

git show $picked >a
git show $original >b
git patch-id <a
git patch-id <b
git diff --no-index a b

Michael
