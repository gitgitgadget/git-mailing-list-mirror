Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9565C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 20:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B6420758
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 20:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw7NCDN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgHQUgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgHQUgu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 16:36:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3038C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 13:36:49 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f26so18952446ljc.8
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AJAxmn09tWXnVSfmvJpHeRAi8sNjhHDTGJYHxQdt7Ck=;
        b=hw7NCDN5ffacxOeTmzoE0nSZQpoSiz7GwKNQsvwbGos4hNgI9jbahj3JQxzdvlhBau
         +HIpMY3H3tX/AHEQYhemcBwRIfp6p3q/AG0DbFEcdwJHSckhn5nEDL+YsNn7QhhvKmCb
         Qu63xfKcp+R40btLmEvjb7pb867Zt5eYPKHmIJ+m4WtHT7gSqFugo4x3qkrai4n8yGki
         8BhGNm070hdR9H+E4Um1TEO1G+OWg/QH5Jcgh0stpo3UUwj1GzDF/e6v7zm8RzP9zYvl
         jDiCzTKzj5qGl6kTQFbAREPcsmyZlPCajcNz+ANwZryZv9uMfaVB8xZuHI/87ZwYpffs
         xaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=AJAxmn09tWXnVSfmvJpHeRAi8sNjhHDTGJYHxQdt7Ck=;
        b=mTPfTTs0AXhu+NwWPfx2jCTcDSqcw7dFPFLOBSrsYYJm0gmBd9XzAWrItsoYtUmyV1
         ylTtIbBV70KM3q5dvPT7t16XWlwUIwsKUp0AeH8lj/ACllbaAYWcYHiFc1qNp56Gf2UJ
         /RmuyvfccPhVJftxHRZ3LI+bZ+81Mv88199Qn8PlNNSSlngOFg8KXtqbVbp/KZYFcQqY
         LjqBlQaxff2QWtwtCxaO7Qf7M49qMf+bVgXsUNchNEd6osnMpOUqvKTk91iBneC0wlUQ
         wT3hwo7A3+NUpEA8Wh9U6pdXxGjqEVrWno6Nn6AcqlskzICo4lM24SWZLmZXOKAdT+Nz
         +XGw==
X-Gm-Message-State: AOAM531Dqmn8SQ/ury2A8sOvvlvOgWwL8wCDK6aUR++i2UWCDS8QY1t8
        OtM6EqRAe7GwdU3j4n3PtGZIKwVplTA=
X-Google-Smtp-Source: ABdhPJyvyXMvwDCR03AoPNBX4VFA1WosS3TpHpaMeRf0jwNiZ1WT4TrDnVuDhL4vtlvTMRFHyAlwkA==
X-Received: by 2002:a2e:87d7:: with SMTP id v23mr8470243ljj.325.1597696607733;
        Mon, 17 Aug 2020 13:36:47 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 5sm5778836lfz.35.2020.08.17.13.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 13:36:46 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH  3/3] t/t4013: add test for --diff-merges=off
References: <20200805220832.3800-1-sorganov@gmail.com>
        <20200805220832.3800-4-sorganov@gmail.com>
        <xmqq3650n2rc.fsf@gitster.c.googlers.com> <87lfisk915.fsf@osv.gnss.ru>
        <xmqqy2msllz0.fsf@gitster.c.googlers.com>
        <xmqqtuxglksy.fsf@gitster.c.googlers.com> <87ft90uq8w.fsf@osv.gnss.ru>
        <xmqqmu37lmym.fsf@gitster.c.googlers.com> <874kp4uoic.fsf@osv.gnss.ru>
        <xmqqr1s52nv5.fsf@gitster.c.googlers.com>
Date:   Mon, 17 Aug 2020 23:36:45 +0300
In-Reply-To: <xmqqr1s52nv5.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 17 Aug 2020 10:17:34 -0700")
Message-ID: <87wo1xko0y.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> So, do these both effectively resolve to:
>>
>>       git log -m --no-diff-merges --first-parent --patch 
>>
>> where first -m is the one implied by --first-parent, ...
>
> Eh, why does --first-parent even affect the choice of -m/no-m when
> --no-diff-merges is explicitly given?

Well, let's try your question on 3 abstract options:

"Why does --X even affects the choice of --Y/no-Y when --Z is explicitly
given?"

And what is the assumed answer?

"--X should only affect the choice of --Y/no-Y when no --Z is explicitly
given"

right? Or, in other terms:

"--X implies --Y unless --Z is explicitly given (as opposed to implied?)"

Do you see the problem here? I do see this as a problem. Simple "--X
implies --Y" should be sufficient to achieve any of required behaviors.
No need for such complications.

I just try to figure if some more or less strict model is hidden behind
all this, and it seems there is none.

Thanks,
-- Sergey
