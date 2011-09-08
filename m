From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Thu, 8 Sep 2011 09:14:20 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109080753460.12564@debian>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com> <7v1uvta97o.fsf@alter.siamese.dyndns.org> <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com> <4E676F6A.3060906@drmicha.warpmail.net>
 <CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com> <7vk49k48q4.fsf@alter.siamese.dyndns.org> <CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 15:14:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1eR5-0002i3-Qo
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 15:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724Ab1IHNO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 09:14:26 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:37292 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932708Ab1IHNOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 09:14:25 -0400
Received: by vws10 with SMTP id 10so1163778vws.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=D+Nse3sZZmtM/JnHyN3CLgler7Q4v6+Dv3QTMnZ80CY=;
        b=sASclDdrhtj04Tr+LMq5cMItyCdrGuIpTvdEdhPXgJJrh4VX6A2+7DreNJFz/1uKr8
         Iy89IepBmnt29GciI1qREwYXJufTtmfbtlNdq71kmj7CKZK2d21hmHkRPKejkb+9FMiS
         DLNFeBsA8Cxs2GhBn1PhF2Afi/H7s/uWYn7/4=
Received: by 10.52.28.204 with SMTP id d12mr618426vdh.359.1315487664848;
        Thu, 08 Sep 2011 06:14:24 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id bd20sm2560228vdc.8.2011.09.08.06.14.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Sep 2011 06:14:22 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180968>

On Thu, 8 Sep 2011, Francis Moreau wrote:

> On Wed, Sep 7, 2011 at 6:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Francis Moreau <francis.moro@gmail.com> writes:
> >
> >> If I start the rebase process with : "git rebase -i -p master foo"
> >> then the filtering is happening. Here 'foo' has been created with
> >> v2.6.39 tag as start point and contains some patches cherry-picked
> >> from the upstream.
> >>
> >> However if I call git-rebase this way: "git rebase -i -p --onto master
> >> v2.6.39 foo", then it seems that no filtering is done.

Patches that are in both sides of v2.6.39...foo will be filtered, but
as Junio said, what is in master is not considered. In your case,
since foo was created from the tag, there should of course be no
commits in foo..v2.6.39.

> I'm using "git rebase --onto A B C" because I want to simplify git's
> work.

What work? Calculating mege-base and patch-ids? But that's exactly
what you said you don't want to avoid, no?

> I know that any commits between A..B are already in A history

Did you mean "B..A" here?

> and I'm not interested in rebasing them anyways.

They wouldn't be rebased by running "git rebase A C" either... Maybe
I'm misunderstanding something.

> Hmm I dont understand why "rebase --onto A B C" wouldn't try to find
> the merge base between A and B. If it doesn't (which is quite uncommon
> I guess) then don't do the filtering as we're currently doing but if
> there's a merge base (common case) then do the filtering.

It could do that. I think that's what Junio meant by "justifiable--- I
dunno". In your case, though, it seems like "git rebase master foo"
would do exactly what you want.

Somewhat related, I think "git rebase --onto A B C" should NOT filter
out patches that also appear both sides of "B...C", because when
"--onto" is used, "B" is only used as a way to calculate the
merge-base. I think it would make more sense to filter out from
appears in both "B..C" what also appears in "C..A". This has been on
my todo list for way too long. Some day I'll send out a patch for it
and we'll see what others think.


Martin
