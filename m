Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B17C6FD19
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 18:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCLS1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjCLS1S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 14:27:18 -0400
Received: from marcos.anarc.at (marcos.anarc.at [64.18.183.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F557D14
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
        s=marcos-debian.anarcat.user; t=1678644844;
        bh=uJJA3x2wUovlgyi/vPbBmR5CG4jgKL/ZfHg8PwglZnk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GCvXhdRqGWBdUaMZUzklYK4nRWHmql4keN6hLvllbu9mJh8rLBnc+q/d1PM1Z4S5f
         YfGuukBnWeNcfezFiQP9/rffXcaaBpy6bgVleqjfOGA7ZWL5KGGodjuH3lNyDXo/Ou
         60osSBiAuza+uztObO7uTtgztnYOOPdBZ5lz8tJ44FS0He0uJoactU1upbWxL+Zcj4
         Oa1BIGK9sAhDrFvojvjPws68v4B1QeIdRdzbkS0UUBo0wQ77Mxj6bTfIltK6mF5gNO
         BmpaAT4Q3Qlee4y/emiamLTtxC7uaYIUow6NkkeHOSX3xzHih7B5iSnELLdXX/Uj0J
         Z+8o2FUJqDL/Q==
Received: by marcos.anarc.at (Postfix, from userid 1000)
        id CED1710E5CF; Sun, 12 Mar 2023 14:14:04 -0400 (EDT)
Received: by angela.localdomain (Postfix, from userid 1000)
        id 3C494DF90E; Sun, 12 Mar 2023 14:14:04 -0400 (EDT)
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] hooks--pre-push.sample: identify branch point
In-Reply-To: <CAMP44s30GBC7PFovzgaORMLLGYW=1mFVG4WH-dUfUW5-1sMd1Q@mail.gmail.com>
Organization: Debian
References: <20230309220405.219212-1-anarcat@debian.org>
 <CAMP44s2=qzmF1Odc_auCaKQmTBYD53YYtaJv_LGwvoFDmTxPSA@mail.gmail.com>
 <87356ctvta.fsf@angela.anarc.at>
 <CAMP44s30GBC7PFovzgaORMLLGYW=1mFVG4WH-dUfUW5-1sMd1Q@mail.gmail.com>
Date:   Sun, 12 Mar 2023 14:14:04 -0400
Message-ID: <87lek1suqb.fsf@angela.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-03-10 16:09:43, Felipe Contreras wrote:
> On Fri, Mar 10, 2023 at 10:28=E2=80=AFAM Antoine Beaupr=C3=A9 <anarcat@de=
bian.org> wrote:
>>
>> On 2023-03-09 17:22:55, Felipe Contreras wrote:
>> > Hi Antoine,
>> >
>> > On Thu, Mar 9, 2023 at 4:34=E2=80=AFPM Antoine Beaupr=C3=A9 <anarcat@d=
ebian.org> wrote:
>> >

[...]

>> > It's interesting how we keep coming back to the same problems; right
>> > now there's a discussion in the git-users mailing list precisely about
>> > the same topic: how to find the branch point, in particular so `git
>> > name-rev` shows the correct branch a commit belongs to (which is
>> > otherwise just a bad guess).
>>
>> Well, it's a need people certainly seem to have. :)
>>
>> I feel we are letting perfection be the enemy of good here. No, there
>> are no solutions that work for the general case, you always find a
>> corner case that breaks it. But what if we could have a simple solution
>> that works for *most* cases and then *fails* gracefully for the corner
>> cases?
>
> I did propose such a solution, I wrote extensive tests to make sure it
> worked properly, but it was largely ignored [2].
>
> The solution with --exclude-first-parent-only fails my tests in a very
> complex case:
>
>    X (master)
>     \
>      A (topic)
>
> Sure, it's probably easy to fix, but the point is that a reliable and
> robust solution everyone agrees with doesn't exist.

Hm... that's odd, I'm surprised that doesn't work. But that's certainly
a "special" (!) case that should be handled properly.

[...]

>> Or they could even have a per-branch .git/config entry to map the branch
>> to an upstream branch, and *that* could even "default" to "main" or
>> whatever that setting is called now. :)
>
> Sounds like you are talking about the upstream tracking branch [3].
> Are you familiar with that?

No, I'm not refering to branch.NAME.upstream here, sorry if my use of
"upstream" here was confusing. I mean "the branch this branch has been
forked from" not "the upstream equivalent to this local branch".

a.

--=20
Science knows still practically nothing about the real nature of
matter, energy, dimension, or time; and even less about those
remarkable things called life and thought. But whatever the meaning
and purpose of this universe, you are a legitimate part of it.
                        - Gene Roddenberry
