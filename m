Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F66C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E72D6120D
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhJVOMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:12:15 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:15232 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhJVOMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 10:12:14 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2021 10:12:13 EDT
Received: from [79.233.238.25] (helo=[192.168.2.202])
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <test2@mfriebe.de>)
        id 1mdv9a-0003pZ-Gw; Fri, 22 Oct 2021 16:04:14 +0200
Subject: Re: changing the experimental 'git switch' (was: [Summit topic]
 Improving Git UX)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
 <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
From:   martin <test2@mfriebe.de>
Message-ID: <9c6b3041-a5c0-6fe1-860e-7bfcb292ae81@mfriebe.de>
Date:   Fri, 22 Oct 2021 16:04:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/10/2021 18:45, Ævar Arnfjörð Bjarmason wrote:
> E.g. the "-n" option to "git fetch" comes to mind, which isn't
> a synonym for "--dry-run", as in most other places.
>

-n
is only used very few times for dry run. I found
git add
git rm
git mv

But
cherry-pick => no commit
pull => no stat
rebase => no stat
merge => no stat
fetch => no tags
clone => no checkout

In any case, "-n" has always a "no" meaning (even dry run, mean "no 
changes to be recorded").

So IMHO -n is a really bad idea for "new"


About "-b" branch:
That does give no indication something is created. I find it highly 
confusing for checkout already,
because the word "branch" could also mean "check out to existing branch" 
rather than doing a detached checkout.
However, others may be perfectly fine with -b only referring to branches 
that will be created.

-c of course is also used for config in clone.... :)

If 2 letters could be used, then -c could be given twice for "create copy"
-c  => create
-c -c  => create copy
-cc  => create copy

----------
Also, will move/copy for switch actually be the same as for "git branch"?

I haven't used them, but from the docs, I take it that a 
[new/replacement] branch will be created, and this branches tip points 
to the same commit as the origin branch.

But in "git switch" a new commit for the top is given. So that differs.
Maybe someone can educate me ?
- For move, where is the diff between
   git switch --move existing_branch  commit
   git switch --force-create existing_branch  commit
Afaik only that the reflog will be copied/kept?

For copy what does it mean at all?
   git switch --copy existing_branch  commit
Does not make any sense at all.
Because "copy" means that "existing_branch" is to be kept. So copy needs 
a name for the new branch.
I see 2 possible copies
   git switch --copy existing_branch  new_branch commit
   git switch --copy existing_branch  target_branch
For the latter, it switches to the existing "target_branch", but 
replaces its reflog.

Unless there is more, than the copying of the reflog, wouldn't it be 
better to add an option "--copy-reflog"
Then you could do
git switch --copy-reflog=branch   target_branch  # replace reflog of 
existing target branch
git switch --copy-reflog=branch  -c new_branch  target_branch  # 
new_branch will get the reflog / this is "copy"
git switch --copy-reflog=branch  -C new_branch  target_branch  # 
new_branch will get the reflog
git switch --copy-reflog  -C existing_branch  target_branch  # 
existing_branch will keep the reflog. / this is "move"

