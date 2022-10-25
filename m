Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B927FA3743
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 04:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiJYEQB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 25 Oct 2022 00:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJYEP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 00:15:58 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A94E0EB
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 21:15:56 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id y80so9422985iof.3
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 21:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Rp34NfcsxqpDh4Vocl330oagrzZAXfpFm+Iw4r3SMM=;
        b=PRc8Tbel+EZGHFPRs/7GWuSALQJ5Kh9fTCoGgDoeN/H86EEAUZmoPFt4ObjzbE+PlA
         vMBl/W6y5BhuVUCKUQasb0VKndVWepIoyteSXshybgFXGwrGl1gLTY7uxGgnfdXkQY5P
         /WdYIyNivPUjp/I54/qGcLXrsSjDy4zIhrJQQ5B0reNHUfzyjLsZ914MzAbIKxVQiKG1
         2py9mYHN5X+dCc+yENFNTOLmw13VlPIuCemEFBOcG3gIkjaT8UUUJjWB4+EuWIbrJvlk
         kXtIkaETulBsiUgYZ7i4qWqK581VDf+WoQ4nzflnRGK/0SNL4ZNOgV3jCNBPwI4lmmxM
         i/cg==
X-Gm-Message-State: ACrzQf30dWPzvroTuVxANAEtVJbmV02xx4lo3SfLYa11dgKKC0w+uxRq
        Jg2sMou/DEsEoX5VJEGk16PfiJ4miHetnb4osBE=
X-Google-Smtp-Source: AMsMyM7KhxkJvpfifc7S5rZh5P34UtZ/3d4ztt1wTdRiEfpTIpZ2JdFDfhHCGbMq2nGxCl2f6c6HBGe6APWSN9ZTlqw=
X-Received: by 2002:a05:6638:134f:b0:372:8558:1e34 with SMTP id
 u15-20020a056638134f00b0037285581e34mr6001505jad.285.1666671356056; Mon, 24
 Oct 2022 21:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
 <pull.1324.v2.git.git.1663041707260.gitgitgadget@gmail.com>
 <221024.865yg9ecsx.gmgdl@evledraar.gmail.com> <CAPig+cT=cWYT6kicNWT+6RxfiKKMyVz72H3_9kwkF-f4Vuoe1w@mail.gmail.com>
In-Reply-To: <CAPig+cT=cWYT6kicNWT+6RxfiKKMyVz72H3_9kwkF-f4Vuoe1w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 25 Oct 2022 00:15:45 -0400
Message-ID: <CAPig+cQhsGpOa1XqfOj-zV1esc_uEkOPGg3hVUkSWrkVma+GNQ@mail.gmail.com>
Subject: Re: chainlint.pl's new "deparse" output (was: [PATCH v2] [...])
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2022 at 12:05 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Oct 24, 2022 at 6:28 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > Another thing: When a test *ends* in a "&&" (common when you copy/paste
> > e.g. "test_cmp expect actual &&\n" from another test) it doesn't spot
> > it, but instead we get all the way to the eval/117, i.e. "broken
> > &&-chain or run-away HERE-DOC".
>
> Yes, I recall considering that case and others, but decided that
> that's probably outside the scope of the linter. [...]
>
> It is unfortunate, though, that the shell's "syntax error" output gets
> swallowed by the eval/117 checker in test-lib.sh and turned into a
> somewhat less useful message. I'm not quite sure how we can fix the
> eval/117 checker to not swallow genuine syntax errors like that,
> unless we perhaps specially recognize exit code 2 and, um, do
> something...

Another "fix" would be to drop the eval/117 checker altogether. I
retained it as a final safeguard in case something slipped past
chainlint.pl, however, I'm not sure how much value the eval/117
checker really has since it misses so many real-world cases, such as
any &&-chain break in the body of a compound context (if/fi,
case/esac, for/done, while/done, (...), {...}, $(...), etc.).
Moreover, we see now that it's also obscuring useful error messages
(such as "syntax error") from the shell itself. So, dropping it may be
an option(?).
