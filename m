Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5521BC05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 21:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBQViv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBQVit (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 16:38:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3AC60A48
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:38:48 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cn2so9301505edb.4
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLTGjf9wqlQF7C4kf5b7pTzt/Jvc7N4OKSy5Yfdjdfw=;
        b=NyMs0PCMO333OKjMXs4mp2ld3LOdALWLG2vk0ETehDfGe8fgRzHgKoxl1QA18xEeaQ
         VDQUQ3+c/oe839GzdGvnhTGv4+r3CqFlErw/OIooOoZde4kUQM57fUXBMujz+1ASx9Gf
         yc5Exf6gl/KAm9no+9wlTwpdi39AHcnh+Pqa1zYVaDMYFRYsbREZ9fYVIPd2Ar5DN6Y+
         Vzv+yBywRB36jCRNT2beLz2VGSrLU+Mo5+WXwzbFeSQJpBZyrPyDAqAPlGGxuv8MZWW4
         SDKYjfrlOpHN7j57HmfPlZtT8zRmOyKt9upfFuUEbEtulzyk65NoRywPT4HkxwO4TFps
         ssnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLTGjf9wqlQF7C4kf5b7pTzt/Jvc7N4OKSy5Yfdjdfw=;
        b=b1/uBMCXDsKQE7Y+I5y4IqWnQF8TF3r7bKFFGapT+1+uXbfpa2PoE9omNJGpxxT3//
         sTfATPhT6yqn6o1yToYmzdP2550FXiWSovtWu+iJu3MzbLmKWoWchT8/Tw3dNIUJ+/IH
         KWj7+SPWMuRpMJHwtfl+tu0WCwENCst1mu6kZ/m3ouCPnuyvhwXABvZc0UvpqPyNrJLe
         ULAkL9q78wS3nyvJfQ0nanh8LhuUOqNYeleV9rL0Ub4I7pePNo9eCFgjcotJ0SlQSa4h
         PdLriZ6k1FAsJKwBoTDtmXeKOysJa/wyyBu2B9tbspVCB6ac/rlpgd+h4cpHto/OxGV8
         3yVg==
X-Gm-Message-State: AO0yUKVm373KIjCQYkTEAJip+ixMpmSFnpNW2J15jH1meMox6lHR1400
        UiGJv6JhRyEDq5U9krnrZx+TQhMBJpsABLRZDUJH2ixcdT7pDg9A
X-Google-Smtp-Source: AK7set/dLQgY8/4KGoCBzl949Enm3fl6DAvP6C8S5VOZNm/aZ3wrZL81FaH/PUr1Xwnm9AEcxPH8VzZ+CcEiC6PcfOY=
X-Received: by 2002:a50:c344:0:b0:4aa:a4df:23fc with SMTP id
 q4-20020a50c344000000b004aaa4df23fcmr1545528edb.1.1676669926646; Fri, 17 Feb
 2023 13:38:46 -0800 (PST)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <Y+/v15TyCbSYzlVg@tapette.crustytoothpaste.net>
In-Reply-To: <Y+/v15TyCbSYzlVg@tapette.crustytoothpaste.net>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Fri, 17 Feb 2023 13:38:34 -0800
Message-ID: <CAJoAoZmMQ-ROdCp0=4oaFa836-PqxwYntnRSBSzzJc5chp16eQ@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 1:21 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-02-17 at 21:12:23, Emily Shaffer wrote:
> > Hi folks,
>
> Hey,
>
> > I'm looking forward to the discussion!
>
> While I'm not personally interested in the VFS work, I think it's a
> great idea to turn more of the code into libraries (or at least make it
> more library-like), and so I'm fully in support of this approach.

Yeah, I expect this sentiment is true for most contributors. And I'm
really hoping there are other things which aren't on my radar, but
other contributors are enthusiastic about, that would also be served
by this kind of library approach.

For example, I seem to remember you saying during the SHA-256 series
that the next hashing algorithm would also be painful to implement;
would that still be true if the hashing algorithm is encapsulated well
by a library interface? Or is it for a different reason?

> When
> I send patches in the future, I'll try to make sure that they're
> friendly to this goal.

That's awesome to hear. Thanks, brian.

 - Emily
