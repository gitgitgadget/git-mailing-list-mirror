Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914CDC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 10:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJMKwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 06:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJMKwe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 06:52:34 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED0810565E
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 03:52:26 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 81so1566465ybf.7
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cgqkbadcr5Q9a5rJrUZyuIRNxRubPp62poVYu5oOUoM=;
        b=FqiL6GHy2mTkRmiCjlKyefayzwglXwvhUjLWenHlvMWVJCreRKsS6fGEBUgaG6M2fu
         aaL2KKOb//8ertnqImlUCi5JTOD163LatQYh9lq82/EyPAB+nvj0gitbt4/qedPPhvax
         2SQRXTEo/VjCXbO9Bi/c+W2UpQvTbxkiahvmDKIo3p7ZMfljgk5TcvmBhlivHcNL+3VU
         tsl1F41BOE2xONJo1e7C6iTndG0tojkUAzkAhweL6DMbqTUkMncGjDoHBx67MfhvGxYV
         P9LZ3Pyr6/SuI717gCwdaOpucvt7SVV9E6tOBr5jsctT26iJ4WzKB3OQH5TK6UMQTyhz
         ta+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cgqkbadcr5Q9a5rJrUZyuIRNxRubPp62poVYu5oOUoM=;
        b=H6+TInek7wX60gIdz/xn37RyuRNgzSbEzSZKOdqRZrj6azFjZs4sd5aCAzR48TK2gL
         V0I5XhccmfPVZYgu37MFiVAtLwePhShW0X6udBYPFd3Ca+E2IXjAWw6JPADVoefympjg
         lm4bGFcjFKAnI5nybakdVSSkK7IxGHQ2OZYcxGtsXnToiJSwTT2BIbJ0bNe8tc7+8js7
         PVU7IfSY4/00nRr9D0OjxdrLdR5Vh58XvUxszUirTfWbFwxcgJXnfnVOWCtXyCUqu5IE
         0eDd/Kku6wXA2PmDqzmX7/+eZ4Q2KIgSTimTBFUex5sFd9uYT9i28EjR9o/NVk0tRpfB
         x3XQ==
X-Gm-Message-State: ACrzQf09wZohQRxq8qYVuz4OKiU1YZOD4oTx33yx8hcNM7Hf5J856Qg4
        pLxqq/y0AhbYZ4+NeeWk37Ys+5Iwb0IrQGXEJkM=
X-Google-Smtp-Source: AMsMyM6rNzeTdwQzP+9ycDZuyMpFFvHrDlDGPbspGQ1WV/ROvaNAXQnnVU7v6i+eLFeqiMbsEvx4PyQWJRPuGb1Oy9Q=
X-Received: by 2002:a25:c8c4:0:b0:6c0:c896:1208 with SMTP id
 y187-20020a25c8c4000000b006c0c8961208mr20441415ybf.494.1665658345081; Thu, 13
 Oct 2022 03:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
 <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com> <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
 <CA+PPyiH8EPWpTuOJg1hSthFP1xBxurjN7J0J00g6xvFi_vbcYw@mail.gmail.com>
 <ae8a98d9-eec1-cdcd-67a3-695aaca7f5ae@github.com> <CA+PPyiFC0mjvY494AVZMB952Ux-TPyA-Uetu1xQ6FiHA_vaRaA@mail.gmail.com>
 <CA+PPyiEms=f7=rXkvfmaazNkxKS1-VA-XJZOrhieQEut8f7QWA@mail.gmail.com>
 <xmqqleplmz3n.fsf@gitster.g> <Y0Zig4XUePPhMaA3@danh.dev> <CA+PPyiGPo1j-2MxTvmV2jDYNVFV1q8+7TVX1uoEUpWc0o+Rkdw@mail.gmail.com>
 <Y0baxKPxHp7UdYTi@danh.dev> <CA+fEeODMVNrnFRbuNVgbBShSA2Juo8Ux5ahd2J8nCfmPetdpvA@mail.gmail.com>
In-Reply-To: <CA+fEeODMVNrnFRbuNVgbBShSA2Juo8Ux5ahd2J8nCfmPetdpvA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 13 Oct 2022 12:52:13 +0200
Message-ID: <CAP8UFD3PmuiXOVcDKC5ECrK_t69_9SLtxoAWSiiEGAGr7ikR8Q@mail.gmail.com>
Subject: Re: [Outreachy] internship contribution
To:     Ruqaiya Sattar <ruqaiya.sattar345@gmail.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Luna Jernberg <droidbittin@gmail.com>, git@vger.kernel.org,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ruqaiya,

On Wed, Oct 12, 2022 at 5:30 PM Ruqaiya Sattar
<ruqaiya.sattar345@gmail.com> wrote:
>
> Hi , this is Ruqaiya, outreachy applicant December 2022 to March 2023, I am in construction phase now! I have no C programming experience, but I would love to learn and contribute to git..

Thank you for being interested in an Outreachy internship working on Git!

It might be difficult to contribute if you have no C programming
experience though. You might want to start learning it using books,
tutorials or websites like https://exercism.org/

> can anyone help me how do a newbie get started contributing to git.

I would suggest reading the following pages:

- https://git.github.io/Hacking-Git/
- https://git.github.io/General-Microproject-Information/

Best,
Christian.
