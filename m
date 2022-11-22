Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67280C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 00:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiKVAgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 19:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKVAgU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 19:36:20 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5FC6975
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:36:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so6478120pjc.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iH3D1zAp1sCWecdm1OXV/9p7M0mxHmaHU02zsegx0u0=;
        b=VgDfxCi9cwdkyGtI158RhZ7DGXyOq+gJKC3y8O/C3rI1Fzxgb/cc9X1mUxEVsf6HtJ
         uHGH+lcg+Ndan037hDabX3iBj0OCPsAIPEVlurziWND7Zhav1p24ahbHb8IHYQThs0Iu
         nGt5RBd/4HS99D2Bxs9qnjkmIRlZgs285GukLBmQ3M8XoP/8heaNL5q+p719SExZAwEC
         4/LpClqTKE0a7F96kUE2I2OK18Uvo51avFA82MjGLUCRumJ6DdOZhxJVzVwyBydmlwGa
         wQGJR20QVClqCrLaaVDa17ym+D371JGO4kJMquYxHOxBxnda6CecVESkENBZNJpm5rzZ
         kSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iH3D1zAp1sCWecdm1OXV/9p7M0mxHmaHU02zsegx0u0=;
        b=YA4LQNquA+ziB4O0SiQyvpgZzH/7C9qo9jc8MBzmIPypOQOtNzxNa0W/iz2+0OclID
         cgsz97AfIvYBkMynP4ccf7n+Mny3r1MfIKC4CAD1iCZpQahnj2YYzzVEhkwybhDCZr3I
         U7hgpSvHixmrYd2rZP1ZAKBnNmL/bHUrVChqBKBktFBpcLUXw7kXOfZNj4OA6t2zPrs6
         cVRoVCyb5gaOE95cu08cDfBPcMFj4aG+qjPUr5VjDtOjvLnGeRGJOQorlpxj+tgWKHvS
         +x+3aUGJrswyYipoy49giUy0XjLV3G9R2xRGD3pqlLMWxB5ljzt2WXnPazs+FeCzZS57
         xedA==
X-Gm-Message-State: ANoB5pk9SkT/a0RasR+RY5cbZTiRIeUAVYOE0VktjFOnfMNjHLbBiDuf
        Ti1YuLx3dtDxyy08EjtBt/A=
X-Google-Smtp-Source: AA0mqf6U750YhzsjQ83+mMjkaTAbXU5xch+FqJn36eRHJlsLiZKlPPbm7bx6t6iIFAenZKRk4VUaCA==
X-Received: by 2002:a17:902:6b85:b0:187:3c62:582c with SMTP id p5-20020a1709026b8500b001873c62582cmr1612876plk.114.1669077378262;
        Mon, 21 Nov 2022 16:36:18 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 125-20020a620683000000b005385e2e86eesm9572741pfg.18.2022.11.21.16.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 16:36:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH] docs: de-indent first paragraph of gitformat-* to flow
 the text
References: <221109.86bkpgriso.gmgdl@evledraar.gmail.com>
        <patch-1.1-1c1434bba31-20221121T141411Z-avarab@gmail.com>
Date:   Tue, 22 Nov 2022 09:36:17 +0900
In-Reply-To: <patch-1.1-1c1434bba31-20221121T141411Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 21 Nov
 2022 15:15:50 +0100")
Message-ID: <xmqqmt8ju8ou.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Fix formatting issues with the documentation added to the new
> gitformat-* namespace in c0f6dd49f19 (Merge branch
> 'ab/tech-docs-to-help', 2022-08-14).

I think I saw you do this before, but please refrain from blaming a
merge UNLESS there is a regression between the tip of the topic
getting merged c0f6dd49f19^2 and the result of the merge c0f6dd49f19
as it is confusing.

>  === CHUNK LOOKUP:
>  
> -  (C + 1) * 12 bytes listing the table of contents for the chunks:
> +(C + 1) * 12 bytes listing the table of contents for the chunks:
>        First 4 bytes describe the chunk id. Value 0 is a terminating label.
>        Other 8 bytes provide the byte-offset in current file for chunk to
>        start. (Chunks are ordered contiguously in the file, so you can infer
>        the length using the next chunk position if necessary.) Each chunk
>        ID appears at most once.
>  
> -  The CHUNK LOOKUP matches the table of contents from
> +The CHUNK LOOKUP matches the table of contents from
>    the chunk-based file format, see linkgit:gitformat-chunk[5]

This makes the result awkward to read for those of us who consume
the text in the source form.  I do not think a one-time cost of
reindenting the whole paragraph (and reviewing the patch to do so)
outweighs the cost of burdening the readers with the awkwardness.

