Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE550C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 13:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbjEJNzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 09:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbjEJNzl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 09:55:41 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F292130
        for <git@vger.kernel.org>; Wed, 10 May 2023 06:55:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ac7c59665bso81662141fa.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683726900; x=1686318900;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=deW3yGA/sQQ0wq9G18zv6l7R1cG4JhXK9QT6UyROJ+A=;
        b=o0+RBIDe+IABmv1t0qXaAMHJruXfCGex41ekLOk5PdgLb81tJogZlaLKf6jXu00kD6
         uG8851oWOUBjO0lxyD3CA4nKK5sGJlS0YocOk9W7L5u+Cyq4dokymTMnM7PsmDxRyfyt
         oWaj9cDfFanGSlGlAhjO9qWGTBWcD4nHAFK2PlBTC4cOy0XTRvrsbPeUc8SZ9dk9trwq
         lA7Sdk3aAZV3mpHz94JxPFFtIPri9IKOTAmejtPTtqKmQeMAoUNlFF3nNcgcDmQlskt0
         3a8leslG7m8pamid9s3t0t9eP11c2jDcwO+L+Vdmh/g2tY05icOzcc6CT7RF8LOqd9tV
         tOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683726900; x=1686318900;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deW3yGA/sQQ0wq9G18zv6l7R1cG4JhXK9QT6UyROJ+A=;
        b=IVc3BxHdBLcZweIJXtdJfqoQLMFbkZ5S4qoNCYGTMeS+R47kyVGFGJt9CKGmbQeIKZ
         qK8Gxo3fXVvTFKtUFXUWjuIqu6hmovg/dMSUYGKFvntijZ1FmYoZEbEzTZmKIdg7H83g
         5xSKaXx6auP7h8/FMZmMuCoQ9qse+pE/+LYc1gVYPXvxJF64RCZVxExHHoCNOojOFOnI
         DSUHVgXvKfNNp8zO1tbzzsNYJo5a91sO40t7Y7uVG3LbcCHqxkkkOS/bcYakvcLPXbzp
         bA66sKOQIkAG94WBaTY9mAHBDpkxk4rXvgArRh0CqWGqioWjPDbHN+LQpKwffFeJTedQ
         69kQ==
X-Gm-Message-State: AC+VfDwy0r01LUSdBzH+Rt8l+5gwVHJW581xoBfo6NDFTkKHyT8vlxuQ
        QRMc0S+WCppdYONIslW2bxE8lcAim7s=
X-Google-Smtp-Source: ACHHUZ7HH/McyTUEGZBvmAQMKRmHCb2Kcqb+OpDjunDpUInBkp+0QZOVxy0rubVMxxGv50gnEtELTQ==
X-Received: by 2002:a2e:80c6:0:b0:2a6:2444:9892 with SMTP id r6-20020a2e80c6000000b002a624449892mr1900940ljg.25.1683726900386;
        Wed, 10 May 2023 06:55:00 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q23-20020a2e84d7000000b002a77f45cc00sm2036699ljh.29.2023.05.10.06.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 06:54:59 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
        <xmqqmt2lqofb.fsf@gitster.g> <xmqqttwskse5.fsf@gitster.g>
        <87o7n03qgq.fsf@osv.gnss.ru> <6459a33b14bd6_7c682947d@chronos.notmuch>
Date:   Wed, 10 May 2023 16:54:59 +0300
In-Reply-To: <6459a33b14bd6_7c682947d@chronos.notmuch> (Felipe Contreras's
        message of "Mon, 08 May 2023 19:34:51 -0600")
Message-ID: <87v8h0guks.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>
>> > When a command does not behave the way one thinks it should, being
>> > curious is good.  Reporting it as a potential bug is also good.  But
>> > it would help the project more if it was triaged before reporting it
>> > as a potential bug, if the reporter is capable of doing so.  Those
>> > who encounter behaviour unexpected to them are more numerous than
>> > those who can report it as a potential bug (many people are not
>> > equipped to write a good bug report), and those who can triage and
>> > diagnose a bug report are fewer.  Those who can come up with a
>> > solution is even more scarse.
>>
>> I'm afraid the solution I'd come up with won't be welcomed.
>
> My solutions are often not welcomed, and yet I still implement them.
>
> It might be a waste of time, but often I've found out that very quickly
> after attempting to come up with a solution I realize there's a lot of
> detail I was missing initially, so even if the solution is not welcomed,
> it helps me to understand the problem space and be more helpful in the
> discussion of potential solutions.
>
> So if I were you, I would still attempt to do it, just to gather some
> understanding.

I sympathize, and I did recently. However, I figure I'd rather spend my
time elsewhere, say, in the Linux kernel, where my experience is
somewhat different, and allows me to enjoy my work.

[...]

>
> I for one welcome any and all attempts to fix git's awful user
> interface, regardless of the reception of the maintainer, and the "core
> club".

For UI, the problem is that there is no core model defined, nor any
guidelines are given, so every discussion ends-up being what "makes
sense" and what doesn't for a user, everyone involved having his own
preference, that often even changes over time.

In this situation attempting to fix the UI sounds like waste of efforts,
as nobody can actually point at the state of the UI to which we are
willing to converge, so there are no objective criteria for accepting of
fixup patches.

Thanks,
-- Sergey Organov
