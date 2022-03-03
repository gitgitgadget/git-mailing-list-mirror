Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CBAC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 06:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiCCGRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 01:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCCGRp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 01:17:45 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD66F166E12
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 22:17:00 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bg10so8438918ejb.4
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 22:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CEwURGRL0yVD/1XlthuMnunbWqNBP5eYj/feW6ZNn+A=;
        b=D5lo1lhj+Co8jtIDO2YUVF1REqnnV/QPUwTV8UHELwF8Ep/mX2I/LjpeFj37XjDIHD
         W14xhfiWgFqby9yxj+SQbASvzyjwjMpfxfvMHWmZjHCTw9XEYrRzZiD+VDp+k0qxWwvZ
         noxyGSKDhHiXqU/WcXMND7MA8JDDa9q67hYOxCcpvhQ1N01ecZAvQzXakLI81iS5h4QA
         9JZmlnurDMQC4xiWQ15ZcNJ/GwaCMykXYa49rB7JlbRT86fkeccYSsBah2D/wcWhTCeG
         3qnLtdO5hfPe1XOdopIPMAcFYs3O9lgolCnRXAj4A/k7LaN6eIn0YiJqcED7gZ1EU3oQ
         4tdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CEwURGRL0yVD/1XlthuMnunbWqNBP5eYj/feW6ZNn+A=;
        b=2MOJwNgDGTvCWxNSGAL4zcGJXekMt5ThqKnUd/s96PpPulORqNLpaY7LuKdKhDrBbL
         reUg2vFfGmSou0dwHvOYjbrZ7or8d4Nrjec294NheAT8OoGYbpHFrqn3VBNjr+Bsf9fJ
         +V5dLfLYkWMNJt8o/V2hVtmcvWkx8VvOtNvLj+dsk0Oi6faPJOLPjZZB/MbAlAMJAVEf
         8dKA7M5xpjWBH+WmVsoo230x4irOOEy+HV1N7NaLOm2mQG+Z5Z/9qH6pecmJT/1btSLn
         IhznEh9YTZS643Z0vDpiHcYnifKIaJis+8st4EgEYf18ddQlVocSowFf4E8rFhqgmEq7
         en/Q==
X-Gm-Message-State: AOAM5338wBEHPRXNlRDg3/F3usAhIp/3shQzcQCBks7wDSNTyZHW3xb0
        H/zoWd9vKnNKY6KI5jMYyhIsuOPKor9Upw/8Ne4etYxVvwxDKIWf
X-Google-Smtp-Source: ABdhPJyCMMExsIhPdn3OJ8bHEtUnjxLHBMulxp3ONca4MrjLxbwrSq4Z9Wn8ZvCTiTHvUk9SfCY6LYnAueUQSfPd8zA=
X-Received: by 2002:a17:906:4fc8:b0:6d8:5059:f998 with SMTP id
 i8-20020a1709064fc800b006d85059f998mr6141216ejw.487.1646288219134; Wed, 02
 Mar 2022 22:16:59 -0800 (PST)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 3 Mar 2022 07:16:47 +0100
Message-ID: <CAPMMpoiTJAuadBEOPWOVa-kguSXMDvAhvD22B63QwYpu=H7xEw@mail.gmail.com>
Subject: What does it mean to have multiple upstream tracking branches?
To:     git <git@vger.kernel.org>
Cc:     Josh Steadmon <steadmon@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 Hi,

In my recent attempt to create a "simple" branch.autosetupmerge
option, I have repeatedly been confused by the enforced rules around
what is and isn't valid for the branch.<name>.merge and
branch.<name>.remote configs.

Until Josh Steadman's recent work on --track=inherit, the "automatic"
addition of branch.<name>.merge could only ever result in a single
entry.

Now we support multiple entries being added as a perpetuation of an
existing branch's setup - but what does it *mean*? I could understand
if the idea was to have transparent tracking across multiple remotes
that are supposed to have the same content (eg a single server set up
over multiple protocols), but that does not appear to be possible -
branch.<name>.remote can only have one value.

Is there any documentation (or could someone provide pointers) as to
when multiple branch.<name>.merge values can make sense and what that
means / what it does?

Thanks,
Tao
