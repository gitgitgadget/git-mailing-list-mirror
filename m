Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E2B20248
	for <e@80x24.org>; Thu, 21 Mar 2019 05:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfCUFk4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 01:40:56 -0400
Received: from mail.javad.com ([54.86.164.124]:42159 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfCUFk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 01:40:56 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id B2EFC40E7C;
        Thu, 21 Mar 2019 05:40:54 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=awzuUKnS;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1553146855;
        bh=nA5q5bwmsjuwiPnfSZreJ9d74TrJ4D7zM0NAYmJP+/E=; l=1748;
        h=Received:From:To:Subject;
        b=awzuUKnSy7XvLx57wx7klGB2WXRy6/A/hsjLKkIwWz2ADf3kgP0ocoMOE1bR/H3VM
         BdxPbw09ZBuPUaPGTtMdrNrfPtCI60HgGSI/rVmja2I1uTXJf0uR9jNLPZ0uEtSV8S
         xTjj2cNjyvH67krJyj8oUFCaB4ol1RXZaf9ZPNXw=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1h6qRh-0003Me-8V; Thu, 21 Mar 2019 08:40:53 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "C.J. Jameson" <cjcjameson@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
        <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com>
        <871s31vjo7.fsf@javad.com>
        <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
        <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com>
        <xmqq4l7wuddk.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 21 Mar 2019 08:40:53 +0300
In-Reply-To: <xmqq4l7wuddk.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 21 Mar 2019 12:15:19 +0900")
Message-ID: <87pnqklr8a.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> This worries me that it'll lead to bad surprises.  Perhaps some folks
>>> cherry-pick merges around intentionally, but I would want that to be a
>>> rare occurrence at most.
>>
>> We can just reject this RFC patch and we'd be in a slightly safer
>> place.  You still need to tell us with "-m 1" on the command line
>> that you are picking a range with merges in it.  But then I am sure
>> that clueless people blindly would alias "pick = cherry-pick -m1" and
>> use "git pick" and blindly pick ranges here and there, so I am not
>> sure such a slightly-more safety buys us very much.
>
> To put it a bit differently, I share with you that picking merges
> should be deliberate and it is safer to make sure allowing it only
> when the told us that s/he knows the commit being picked is a merge,

Something like "--[no-]ban-merges" then [*], having "--ban-merges" as
default?

> but when we started allowing "-m 1" for non-merge commits in the
> current world where cherry-pick can work on a range, the ship has
> already sailed.

Except that it could be a different ship, provided we've got
"--ban-merges". Having "-m 1" as default stops to be an issue, and
explicit "-m 1" could then imply --no-ban-merges, that could be in turn
overwritten by explicit "--ban-merges", if necessary.

[*] "--[no]-merges" won't do, as one would expect merges to be silently
dropped from a range of cherry-picks, similar to what "git log" or "git
rev-list" does. BTW, is it a good idea for cherry-pick to start to use
"git rev-list" and support all the options available there?

-- Sergey
