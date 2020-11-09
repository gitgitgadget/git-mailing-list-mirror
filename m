Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2761CC388F7
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 11:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC29B206C0
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 11:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="KSZwFdNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgKILxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 06:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbgKILxM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 06:53:12 -0500
X-Greylist: delayed 384 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Nov 2020 03:53:12 PST
Received: from forward104o.mail.yandex.net (forward104o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4F6C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 03:53:12 -0800 (PST)
Received: from mxback27g.mail.yandex.net (mxback27g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:327])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 98F76941BB9;
        Mon,  9 Nov 2020 14:46:42 +0300 (MSK)
Received: from sas8-6bf5c5d991b2.qloud-c.yandex.net (sas8-6bf5c5d991b2.qloud-c.yandex.net [2a02:6b8:c1b:2a1f:0:640:6bf5:c5d9])
        by mxback27g.mail.yandex.net (mxback/Yandex) with ESMTP id PUoxS6Y9bH-kgZ8oiRo;
        Mon, 09 Nov 2020 14:46:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1604922402;
        bh=qDPsiZfM7bFzjYajSNn8BPTsL74Uw6Vbj2uiSs4ja9o=;
        h=In-Reply-To:Subject:CC:To:From:References:Date:Message-ID;
        b=KSZwFdNyfcylZOVgx6HOhOa/Tf4UDqyymvZPbmV+h75/Dr8C82ByYoGmVH6/xEP2E
         kMEs73VYrV2OGLwrcbTr0BvCb3Cc1oyONk5X+BWF2Vz9WUt2lu4zhI8zMZIX3vb6lN
         L1Qmceo/gidUNVvDRnNy+Hs3Xn0J/MtOrwUcY5EI=
Authentication-Results: mxback27g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas8-6bf5c5d991b2.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id gjFfRh6s3C-kem8njpB;
        Mon, 09 Nov 2020 14:46:41 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Mon, 9 Nov 2020 13:46:40 +0200
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <16910030549.20201109134640@yandex.ru>
To:     Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rebase/git rebase --abort cause inconsistent state
In-Reply-To: <43de6950-a33c-f3da-2a76-72719fef5af3@kdbg.org>
References: <1526558917.20201106203213@yandex.ru> 
  <CABPp-BGAJiaU5aeC3sGvp3znQw1esrn9c19gyOZQBymYvNFCaw@mail.gmail.com>
  <43de6950-a33c-f3da-2a76-72719fef5af3@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

Saturday, November 7, 2020, 1:13:04 AM, you wrote:

> Am 06.11.20 um 21:27 schrieb Elijah Newren:
>> On Fri, Nov 6, 2020 at 10:41 AM Eugen Konkov <kes-kes@yandex.ru> wrote:
>>> I try to rebase, get conflicts. So I decide to --abort
>>>
>>> After --abort I expect state before rebasing, but I get conflicts.
>>>
>>> I  suppose this  is  because `git rebase` switches to not branch and
>>> --abort can not return to branch I was on before rebasing
>>>
>>> Is this a bug?
>>>
>>>
>>>
>>>
>>> kes@work ~/t/lib/MaitreD $ git rebase dev local/dev
>>> Created autostash: 566876c8
>>> warning: Cannot merge binary files: share/ChangeAgreement.docx (HEAD vs. f2442d9a... Update Docs.pm)
>>> Auto-merging share/ChangeAgreement.docx
>>> CONFLICT (content): Merge conflict in share/ChangeAgreement.docx
>>> error: could not apply f2442d9a... Update Docs.pm
>>> Resolve all conflicts manually, mark them as resolved with
>>> "git add/rm <conflicted_files>", then run "git rebase --continue".
>>> You can instead skip this commit: run "git rebase --skip".
>>> To abort and get back to the state before "git rebase", run "git rebase --abort".
>>> Could not apply f2442d9a... Update Docs.pm
>>> kes@work ~/t/lib/MaitreD $ git rebase --abort
>>> Applying autostash resulted in conflicts.
>> ^^^^^^
>> 
>> Looks like you have rebase.autostash set to true and have some
>> uncommitted changes before your rebase started; it looks like it was
>> the reapplying of that stash at the time you abort is the thing that
>> failed.
>> 
>> According to the rebase docs for the --abort flag:
>> "If <branch> was provided when the rebase operation was started, then
>> HEAD will be reset to <branch>"
>> which suggests that the abort should switch you back to the original
>> branch, where the application of your local changes should be safe.

> Unfortunately, that is not always the case, for example, in this one.

>>> Your changes are safe in the stash.
>>> You can run "git stash pop" or "git stash drop" at any time.
>>>
>>> Here is a tree before rebasing:
>>>> a9597aaa (HEAD -> dev) Use DateTime with correct timezone >>> 822ff801 Add link to Podio into mail
>>>> 65575afe Update Docs.pm
>>> | < e0003861 (local/dev) Update podio.t - test person contacts
>>> | < 28ab8630 Create docdate if agreement is new and update test for that
>>> | < 208ead68 Specified checking of person
>>> | < f2442d9a Update Docs.pm
>>> |/
>>> o 6d9c2159 (xtucha/test, xtucha/dev) Leave only one example in month

> You start at branch dev. Then you use the two argument form

>      git rebase dev local/dev

> and when you later

>      git rebase --abort

> then you are not warped back to dev, but to local/dev:

I suppose `git rebase --abort` should return me back to `dev`, because
this is the state I was before the command. hmm... suppose it will not
return to original branch when [branch] parameter is specified for git
rebase


>> history after --abort:
>> * e0003861 (HEAD, local/dev) Update podio.t - test person contacts
>> * 28ab8630 Create docdate if agreement is new and update test for that
>> * 208ead68 Specified checking of person
>> * f2442d9a Update Docs.pm
>> * 6d9c2159 (xtucha/test, xtucha/dev) Leave only one example in month

> and at this point, your stashed changes, which were snapshot when you 
> were on branch dev, are obvously in conflict with branch local/dev.

> I'm not saying that that the behavior should be like this, I'm just 
> explaining what was going on. I hate this behavior, BTW.
I also get inconsisten results https://stackoverflow.com/q/64592489/4632019
This depends on the remote history:
1)  when  there is changes to branch on remote server (sorry, it is named local
on pictures) and local changes to this branch
2)  when there is changes only to branch on remote server and no local
changes, so fast forward is possible


> Is this bug repeatable?
Yes

>Can you find steps to reproduce and/or share your repository?
do for commits.
push them to remote server
on  second  machine  fetch  this  branch  and  change the history. For
example the first made commit
push force back to server
fetch changes history from remote server on first machine
Then try to rebase remote history locally: git rebase dev local/dev
***local is name for local server, but this is remote history

This occur:
> and at this point, your stashed changes, which were snapshot when you
> were on branch dev, are obvously in conflict with branch local/dev.

Actually  here  I  this  of  `git  rebase  dev  local/dev`  as synonym
(probably incorrect) for `git pull --rebase`
Probably  here I am requred an option to drop those local commits that
were pushed to remote and which was changed on remote,
like this is done when `git pull --rebase`

I  prefer do `git fetch/git rebase` manually to keep thins in control.
`git pull` to my mind makes too many magic =(


>Can you verify that you don't get this bug when rebase.autostash is off?
This has no matter


>What do your local changes before the rebase
>look like and what are the nature of the conflicts afterwards (how
>does a "git diff" before the rebase compare to a "git diff" after)?
changes  was  at  binary  .docx  files.  Hope  I repeat upper those steps to
reproduce problem.


> -- Hannes



-- 
Best regards,
Eugen Konkov

