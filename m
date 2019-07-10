Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4969F1F461
	for <e@80x24.org>; Wed, 10 Jul 2019 14:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfGJOqQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 10:46:16 -0400
Received: from mail.javad.com ([54.86.164.124]:60457 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfGJOqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 10:46:16 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 10:46:15 EDT
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id D57FB3E9AE;
        Wed, 10 Jul 2019 14:36:21 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=YjDV99Wd;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1562769382;
        bh=PnCT7t+SC1n9ILQ0eURI9lZvKbH4/P10ZxKCyxSicw4=; l=2286;
        h=Received:From:To:Subject;
        b=YjDV99WdW8J2g92NYpOSMcrmZ5qNngWDvzu7dDZ6K5bgOOWHcJR3+jw99OIq8T6ZZ
         kd573I7aYE+7mSswySW66K3Keon1s/6PUBFgb0tBXAGO9UM95yoOoAiynrKkapkZVw
         Ec/X+nB8wcAw2YT1FF5zwN9cBJnDXoWam/9sZmtc=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1hlDhk-0008AL-DI; Wed, 10 Jul 2019 17:36:20 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Roland =?utf-8?Q?J=C3=A4ger?= <eyenseo@mailbox.org>,
        Junio C Hamano <gitster@pobox.com>, usbuser@mailbox.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
References: <423596682.8516.1562665372094@office.mailbox.org>
        <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
        <1152121968.7459.1562688927235@office.mailbox.org>
        <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
Date:   Wed, 10 Jul 2019 17:36:20 +0300
In-Reply-To: <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 9 Jul 2019 09:35:09 -0700")
Message-ID: <87y316gdnf.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Elijah Newren <newren@gmail.com> writes:

> Hi Roland,
>
> On Tue, Jul 9, 2019 at 9:17 AM Roland Jäger <eyenseo@mailbox.org> wrote:
>>
>> Thanks for answering Junio.
>>
>> I get what git does. But I believe that either the documentation ist
>> wrong/ambiguous or --no-ff and --ff-only should be able to be
>> combined and either should be fixed - preferably the later. What I
>> want to say to git is "I never accept a real merge; please make a
>> merge commit, even if it is redundant/empty". And I believe that
>> github and gitlab allow to configure something like that.
>
> Please don't top-post on this list.
>
> I agree, the documentation is wrong or misleading and there is a
> wording change we could make to improve it.  But, in particular,
> --no-ff and -ff-only are completely incompatible.

They currently are compatible, but in a weird manner, see below.

I'd prefer they were perfectly compatible and orthogonal, as using both
would be the safe way to create cleanest possible merge -- the one that
introduces on the mainline the /exact/ changes made on side-branch:

--ff-only: tells git to refuse operation (actual merge) if FF is
impossible, that for this particular use-case would ensure the merge, when
actually created, is the "cleanest possible" one

and then

--no-ff: forces git to create actual (cleanest possible) merge commit,
that otherwise it wouldn't, as it defaults to --ff, and --ff-only above
ensures FF is possible.

Right now (in my git 2.10) it seems these options somehow cancel each
other, that is both useless and surprising:

When FF is possible:

$ git merge --ff-only --no-ff side_branch

Merge made by the 'recursive' strategy.
[...]

Good!

$ git reset --hard HEAD~1
[...]
$ git merge --no-ff --ff-only side_branch
Updating eafaed6..b83db07
Fast-forward    
[...]

??? I said --no-ff: how comes you did fast-forward?!

When FF is impossible:

$ git merge --ff-only --no-ff side_branch

Merge made by the 'recursive' strategy.
[...] 
??? I said --ff-only: how comes you didn't bail out?!

$ git reset --hard HEAD~1
[...]
$ git merge --no-ff --ff-only side_branch
fatal: Not possible to fast-forward, aborting.

Good!

-- Sergey

git version 2.10.0.1.g57b01a3
