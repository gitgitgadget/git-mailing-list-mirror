From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Thu, 8 Sep 2011 09:10:08 +0200
Message-ID: <CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com>
	<7v1uvta97o.fsf@alter.siamese.dyndns.org>
	<CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com>
	<4E676F6A.3060906@drmicha.warpmail.net>
	<CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com>
	<7vk49k48q4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 09:10:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Yke-0002br-Vl
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 09:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079Ab1IHHKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 03:10:10 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:51897 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab1IHHKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 03:10:09 -0400
Received: by vws10 with SMTP id 10so743916vws.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 00:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ppGgxDYsX4JiIl3lKLcqj+asJvrxVwghDkWr+MSY7mw=;
        b=R3t3jU0RW/c8zLRubTK84n+u+BBmjfKF8BchTqLyOUbUkQHrbIPyEEsYjTI3+ELJP4
         /B7GbetVyOI/N5BLsubYTMkQmz6Rh8Q+iN9ujbaMx767dCz9JxJ0UzdKwkFA7ihsq+ob
         wl2NRbi5W7Em9MzuY1vwInY6YxBjqhgqFCoXA=
Received: by 10.52.74.105 with SMTP id s9mr338302vdv.347.1315465808175; Thu,
 08 Sep 2011 00:10:08 -0700 (PDT)
Received: by 10.52.108.227 with HTTP; Thu, 8 Sep 2011 00:10:08 -0700 (PDT)
In-Reply-To: <7vk49k48q4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180945>

On Wed, Sep 7, 2011 at 6:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Francis Moreau <francis.moro@gmail.com> writes:
>
>> If I start the rebase process with : "git rebase -i -p master foo"
>> then the filtering is happening. Here 'foo' has been created with
>> v2.6.39 tag as start point and contains some patches cherry-picked
>> from the upstream.
>>
>> However if I call git-rebase this way: "git rebase -i -p --onto master
>> v2.6.39 foo", then it seems that no filtering is done.
>>
>> Is that expected ?
>
> Because "rebase --onto A B C" has to be usable when commit A does not have
> any ancestry relationship with the history between B and C,

But is it the common case ? That would mean that A and B are part of
totaly independant branches which is not that common I think.

I'm using "git rebase --onto A B C" because I want to simplify git's
work. I know that any commits between A..B are already in A history
and I'm not interested in rebasing them anyways.

> I wouldn't be
> surprised if the command does not look at commits on the history that lead
> to A that _might_ be related to the ones between B and C. It does not know
> how far to dig from A and stop, and obviously you do not want to dig down
> to the beginning of the history. "rebase A B" on the other hand can safely
> stop digging the history back from A down to where the history leading to
> B forked (i.e. merge base between A and B).

Hmm I dont understand why "rebase --onto A B C" wouldn't try to find
the merge base between A and B. If it doesn't (which is quite uncommon
I guess) then don't do the filtering as we're currently doing but if
there's a merge base (common case) then do the filtering.

No ?
-- 
Francis
