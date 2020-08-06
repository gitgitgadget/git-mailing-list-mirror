Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D67C49EC9
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6896923109
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV4e8/cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgHFIes (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgHFIeq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 04:34:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9882C061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 01:34:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w25so15353030ljo.12
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xofzxzygn5tdUk7PfWL2/VIeg0L+1B22SuGjHAWmrvE=;
        b=qV4e8/cBr/FnbFHJyLQPvhG+Lxc3KgbiOT6ONAS/0ge3OYG0uYDtHtJCJvTdwQy5U6
         VeoE/dMoBJGODTx4vsAPyakJkR1xj6Nhqqx7ZIfyf7XA2jg6bkekOAyA8QjW/1L3OFdz
         aVnAkn0Ucjyprix+cTaCNNMWSBTKh3dTr7PLyhzFEjhxtOhhBBmezwISDYGat6ciNMra
         TH1K9lnCvQpJW81AuPJJ+RIZ00VQkrivPP0axraRh+ef9q4rMp65Z8/RsEalzTHQdWML
         bAKWe0rXAaP6QOwFXJnLYBmlcUPz5gPH/usJyzlb1ikEq+/clDRgG0aJa8jkkiGwjZOZ
         ob9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=xofzxzygn5tdUk7PfWL2/VIeg0L+1B22SuGjHAWmrvE=;
        b=B7scadx3k0sKxHFp9XqtA9gjmiWIsiooWSuGTAVWR4H1mi/s2YlISdxITYRLGLxf5M
         D0qDH2e5GiuaaNq7C45RgOhu8aI16KQO5K29XggKysQBf6J9PtsLpkRGUNqDznhyQmPx
         nDVBRgUyYZFlTtGcWpea0d5H81cQtFZOjpyTRV0C8GBP2WIdkpoadr6EKjgjZHtyWNPS
         kni1v9gEYjHjNX3aHSzxzS/my1KLWopaT5dduozCnV+P1ILz2PrlN/e1tEYdumAj0B6M
         exk62agGyghTp3cOUaPhf/NpAFIaEpiFn7tbdQgektXoDpSqAyLeAuBTtKJXJcoCwjQI
         hzRA==
X-Gm-Message-State: AOAM531OYle8AidBA8hD0ys2jvQh234GI962LNOLojQtZQmgzYnjFcMZ
        oLCm813rEdm6zkGEbQEMSVp0zqhd
X-Google-Smtp-Source: ABdhPJy78TOZer7mw6FYiK4aKfraimFQRY5+gRUP79gOrXn/qpitcQRDUXdcaiRhl6w34gxwk3SMNQ==
X-Received: by 2002:a2e:8710:: with SMTP id m16mr2333733lji.401.1596702883639;
        Thu, 06 Aug 2020 01:34:43 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w19sm2084714ljd.112.2020.08.06.01.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 01:34:40 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH  3/3] t/t4013: add test for --diff-merges=off
References: <20200805220832.3800-1-sorganov@gmail.com>
        <20200805220832.3800-4-sorganov@gmail.com>
        <xmqq3650n2rc.fsf@gitster.c.googlers.com> <87lfisk915.fsf@osv.gnss.ru>
        <xmqqy2msllz0.fsf@gitster.c.googlers.com>
        <xmqqtuxglksy.fsf@gitster.c.googlers.com>
Date:   Thu, 06 Aug 2020 11:34:39 +0300
In-Reply-To: <xmqqtuxglksy.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 05 Aug 2020 16:44:45 -0700")
Message-ID: <87ft90uq8w.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Dunno, why original Jeff series didn't need 
>>>
>>>      log --first-parent --no-diff-merges -p master
>>>
>>> then?
>>
>> Who said it didn't need it?
>
> To elaborate a bit more, we are all humans, and even reviewers
> should be given the second chance to suggest improvements to things
> that can use them, which s/he previously missed.  If we keep saying
> "you say this is wrong, but the other guy did the same wrong thing
> last week", we can never make the world better.

I asked because I thought you see some essential difference between two
tests, as you didn't suggest to add similar permutation test to the
original. I think this reply resolves my doubt.

I still think this additional test not needed unless we are going to
test all the permutations, and there are already 6 of them even for this
simple test, so we'd need to add 10 more tests to the 2 originals. If
somebody is willing to implement machinery to test all the option
permutations automatically... But that's out of scope of these patches.

To be honest, if we don't test all the permutations anyway, I'd rather
test most "human" variant only, that to me is:

  log --first-parent -p --no-diff-merges master

because --first-parent tells how to travel in history, and the rest
tells how to represent results, starting from generic "show me diffs"
and followed by "oh, but don't bother me with merge diffs, please".

And now we are back to my original suggestion to invert the order of
parameters in these tests, but approached from another direction ;)

Overall, I can obviously add such a test to the series if you insist,
but to me it still looks pointless. What doesn't look pointless is
replacing the original with the version you suggested, for the reasons
that I've already explained in preliminary discussions of these patches.

Finally, if you still insist on additional test(s), please also tell if
I should add similar permutation to the original --no-diff-merges test.

Thanks,
-- Sergey
