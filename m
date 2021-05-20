Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9ADC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 13:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394A661002
	for <git@archiver.kernel.org>; Thu, 20 May 2021 13:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbhETNPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhETNPm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 09:15:42 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B71C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 06:14:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r5so24423087lfr.5
        for <git@vger.kernel.org>; Thu, 20 May 2021 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mIFC73nB9vAm/q/yhrDN4OGFBLhvD26l3Hgrk5jnBh0=;
        b=smHl6RJWVKujb27x6zGKWtAdiBUJtREmx8SHy0wNXLiPMSqe+UwMhhmea19CzN/bOo
         VCOCfHpyvsOkfRIr99bUwr0F/wajhb6zsDG/wZfYoQ+asaQO2v77RAD4btR0n673drBB
         PV11eZJTzMvW79HB+mwn2j5qrwmpnUPU8C7z6xMuJQD+jgxMHVzjUaysFMYH/u0D1l1b
         Yqmz+6HX6EJAvp0PVFN4bF9bcXoY6eKLvy49zUeYPaJi34M1TO+Zyn0fwIojs3CXa5f+
         XAw61iHj0dtuKW+ezu+m/0zG4TKuCIL0r287rs6ZHi6GwuKzf9YYUDKeuKVZ2cul7ntp
         ULgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=mIFC73nB9vAm/q/yhrDN4OGFBLhvD26l3Hgrk5jnBh0=;
        b=jHpiNGl5tW4jJvqkd6uvKE1BLOYze2+uEJGrwAU+l60hnLXaNKgLtwSck6Kcu+RfET
         pKM3yIMKyQnrhIJBVm42otSAwdt/XajLf7Whq5w0xRnLxAmoU8sI7xU9R5OzM2aJW2OM
         aMF5lI5gKA+7poNd2oZTkIUyR/3dKJXh7CEDM+MCrXvnC+L7lQtA/56QRNdTzZQR8+w4
         MBKfuTeRD+CNqj0aVp01geLjnbE4yjSOjKDPA4Rt+pGLJcz2kHpKd00q0dPbC5jRdBhI
         uQPuZNAqY63H3JguITgizhvt5sM9tMxe6P+yCbgjbhSUPZkPeaH5UpMhS74HNPJxfU4G
         MsPA==
X-Gm-Message-State: AOAM530f6ssdv+D0KQLliJX1x4LbAjK0UbYzkgdytdiPStaOkbpAYNaA
        0Qn5QSMiVCT5+zWkodBkMvnYDJIJ6cA=
X-Google-Smtp-Source: ABdhPJzwuHG2hONhS6yf0bIU1KNnaBIptkwHyedR0UnMwB5HZ9MgOhLQCEW1gVW7f38RmZhqcIE65Q==
X-Received: by 2002:a19:df45:: with SMTP id q5mr3308095lfj.523.1621516457670;
        Thu, 20 May 2021 06:14:17 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z11sm297785lfu.135.2021.05.20.06.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:14:16 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <YKWHo9gZNp+i3fH9@google.com> <xmqqmtsqwb9g.fsf@gitster.g>
Date:   Thu, 20 May 2021 16:14:15 +0300
In-Reply-To: <xmqqmtsqwb9g.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        20 May 2021 08:32:11 +0900")
Message-ID: <87v97dfsyg.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Sergey Organov wrote:
>>
>>> Fix long standing inconsistency between -c/--cc that do imply -p, on
>>> one side, and -m that did not imply -p, on the other side.
>>>
>>> After this patch
>>>
>>>   git log -m
>>>
>>> will start to produce diffs without need to provide -p as well,
>>
>> Personally I don't ever use -m without -p and --first-parent, so in
>> that sense this feels like a change in the right direction.
>>
>> Does this also affect the plumbing command "git diff-tree"?  I'm
>> guessing "no" because diff-tree already generates a diff by default,
>> but it seems worth spelling out in the commit message to prevent
>> worries about the effect on scripts that expect stable plumbing
>> behavior.
>
> This is about "log" from the "rev-list" family, not "diff" to
> compare two endpoints, so "git diff" won't be affected, and "git
> diff-tree" is not affected, either.

You are right. I've added a test for "git diff-tree -m", and the changes
don't break it.

Can easily re-roll if you think the test worth it.

Thanks,
-- Sergey Organov
