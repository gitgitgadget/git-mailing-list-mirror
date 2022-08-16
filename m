Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B9BC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 12:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiHPMOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiHPMOM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 08:14:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541E2857F5
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660651763;
        bh=QU8daFjNVE9YzQvROjuNsPZ53dMmNl6t7XCch8QOPxo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FClHj8R89JCwG3vuwiLXQYJ7rZ0uz8LTvSX+2YLPDObr4SDflzWEahFxJvi2Jmx2Y
         RTtq6wnF6gfEm7l7nU0muB71fho4ka4/AVDvLDgmvtfJLTk9KEvBerY4BZSKhvryPh
         iTTSUnPqtKJmk+YfDKkJBdKxgCYMKkNjSwPUjlM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsQ4-1oF9wR1HWa-008tj8; Tue, 16
 Aug 2022 14:09:23 +0200
Date:   Tue, 16 Aug 2022 14:09:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
In-Reply-To: <xmqqilmzkd7p.fsf@gitster.g>
Message-ID: <qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr>
References: <20210317204939.17890-1-alban.gruin@gmail.com> <20220809185429.20098-1-alban.gruin@gmail.com> <20220809185429.20098-9-alban.gruin@gmail.com> <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com> <xmqqilmzkd7p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JbQlgBKgfMRGwZZQlDN/irjvWMC8/BYMzWnSwhgyne4vfAXJyhA
 rjm1fBQUfWAh7gS46lpXxAJVMD+C8TAfNXI2lrteyRO6u9/Yf/kSuJbZhr+5RDMwxr8yriH
 HGaQqrRmh7yY1i02T034MSQqiT1NaLn3gj9x9nA4fLDSS83YFQiqsV+M4igMEbxW8BhFCZD
 HfFIWC7IeZzugJiZ01qng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s6M7Nk4Q3gY=:jxdEFRHNCScOB8BWiL/Zga
 QCcfhJJ3SPfZSCtdESy5Tjy36qcFAsRqTYMkbRXNy+4PFU1kUG0Kg24/EB2aDgQUWfRUPboml
 whJfirSH/hPd27rPha8mmUWbai0kejSoeq0uiOxfMoa5yCsYMrHUKNgafImLnFRENG+hEle2t
 S9szfI1Q9YAB95i/dOPqe9YuTM0A8BtliUTqD7Ucy2mfdxTo1f1hD7teB01e9JIi+YUlkLJ2U
 wFnQWW9rTLlNbr6MAxLxGUIZOS1DqRCBS3MlbQOrW2mKgvpHhoUGg22wZugfelho8RlyaBb8S
 VXu1sfQ2UTgPMJagLW1DbwnxTHTX1trHjT3NDZvHIRo7hz0O1WAhCIzCpQlBb3ExYXRfK52CY
 W8vYG/vK6uNgdgXZNHz7btpcw3g1QVimHy+D+sA/sYCxWPfINm4+O92MVW0wNnB8UhWRGIHpU
 Sh+A7x904mpp5kmey3+QRLLF+7h0IKyeUXqsnGhatgMtxA5LY4S0on67fEqSt4xciXhUM7Vd2
 lfqRWf6JEjPZbI1h9vFEydDp7RA7Fml/uOjU7yMNANTcVG4dJY8IvCigWIZGBg7/syNlJqzYq
 6SsFGxmByPTg90/rdoQyaABssvayfDZ0rROJYL2Xpouz9zmDaekLKi9eqwr5LIADR3txW/yXC
 KoFTGC4xA52Qk8I/re+Begg7nqTXW2YgkFuP1ZHnq7jw6SopAm3bImsIu7BJ5wcvDwytkDToz
 Ky2Gv5GbM1ZnXkhubDC9J6XGnZN7WwqyAR5ZrWofuEDuRnYywAkpqVZ+cY7RXETkgkPZ+6kK7
 UR9Iqt6B1+s5x9UYLUBrHRT68ENn370ZVtoD4dndCKdmCRrfMJzJXHGoUvyqvThawbjrQkFFJ
 YPtWLSYZDjOoI5tDMT2PXkiB0TNJYKlbuyhOSkbsNaygXNqTCw/Iyko4rdiq9tbu9E7TZBxKk
 fGIE9FXukdW60O+0j49Mb8i+0iXJ87KwkIYiA43oLa6Aar3LChpuutZbz3bJ2RU9Et5eiu6R0
 pY0ZFyiBwa1d9lm77WogC2cOkmgeKls9go+mS8sePqSAqJHUY1Y/B/T4vAoOEJwYZgi2f6XDD
 TEotCKirq2o8XkWV7I5Shn3xNR/S6fyhzxaw+TryYWZ/Q4NwFHLNRrcsQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Aug 2022, Junio C Hamano wrote:

> While I agree that it would make sense to rewrite some strategies in
> C, I do not quite see the point of redoing this particular one.  Its
> simplicity is one of the only few remaining shining points in the
> "resolve" strategy, and it can serve as an easy-to-understand
> example to demonstrate what a merge-strategy implementation should
> look like.

I am sure we can do much better than

	https://github.com/git/git/blob/v2.37.2/git-merge-resolve.sh

when it comes to demonstrating a script to implement a custom merge
strategy. The really nice thing about a custom merge strategy, after all,
is that you can forgo pretty much all error handling and command-line
parsing because you know precisely how you are going to use it.

> I however doubt with improvements to the "recursive" and more recently
> the "ort" strategy, I do not know how much "real" use there is to it.  I
> even suspect that the users do not mind if a platform does not ship this
> strategy by default if it has so much problem running a shell script.
>
> By rewriting it to C, we would lose an easy-to-understand example that
> the users can easily run to see how it works, but what we gain in
> exchange is not clear, at least to me.

We reduce Git's reliance on POSIX shell scripting, we reduce the number of
programming languages contributors need to be familiar with, we open up to
code coverage/static analysis tools that handle C but not shell scripts,
just to name a few.

If you want to have an easy example of a custom merge strategy, then let's
have that easy example. `git-merge-resolve.sh` ain't that example.

It would be a different matter if you had commented about
`git-merge-ours.sh`:
https://github.com/git/git/blob/v2.17.0/contrib/examples/git-merge-ours.sh
That _was_ a simple and easy example.

I would also have understood a lament about the absence of any good
example in https://git-scm.com/docs/git-merge#_merge_strategies to help
users develop their own custom merge strategies.

I'm all in favor of adding such a good example there, but there is no
reason to hold back `git merge-resolve` from being implemented in C.

Ciao,
Dscho
