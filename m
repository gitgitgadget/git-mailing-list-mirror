Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EFBC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 02:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFEFB60F58
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 02:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhG0CPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 22:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhG0CPg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 22:15:36 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5697EC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 19:56:03 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso12101449otq.6
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 19:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=zzKexRWwaBEXrdtnnp1VXHYt+WhSgEn/ag2AtY1ceao=;
        b=JRedAah+0XKUMAksNj2hzJOUsl+sReU8IKxGLlSo7nLYbILsYzrQiNRlpRXDCyKUr2
         4DHmiypy8KBW+/kbIyHWDLDqaIv9Ksl2Su0IB+er0FcO/0IXFsPU+SxBBPiDjThTcgZR
         s82VSPmIXZfn4q017u/5KsNkFTVk2HqsRBT/VNlnhwvhfZQdxlEZ7bSIXErQ5hhiupoW
         lg+4myx2wEMyHkivt0if0p4565wD0cNT2rJfn/KXinV/Dm9TUPjylGesmJIBbaUT8KtU
         R2egeQT+m34uzT3muq68En63SrGO45h9k4laGGrkGusT/HL8J5XF1QhMNC55Tl4Xt68h
         nXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=zzKexRWwaBEXrdtnnp1VXHYt+WhSgEn/ag2AtY1ceao=;
        b=SD6hgmSkFElWOZVrDBpHtMUg03alQSFd8Jd1rHxyqj04HFCohTiG3CJPTLddI4pC6W
         cbwcxll79fOWO0W8dxaoXx0BJEMNby/NTFr/jaPUEHaCeIx9dUItl0nGRVz1H38VcWdT
         TVsJZI8Rt/8HB7gpd1mIscAaAM//1T22dg4URPuunvQCWjTf4vMddONfMnr5qc/663kw
         eKocTLsfdF8J2kTzB60kCwiMgRle9O8mc715zH9aCiWWOCeyH2IhRg4P+gu6eJX1syz0
         widRDlEDl+ImVUwMXF+GZJxGYn9BLU82CHl/S6UAFK5K8L4BtNXBS+o7ZNwyTZzVxZRo
         3DTA==
X-Gm-Message-State: AOAM530q0rcx00xiyjPbU6xfKmTpJhcPp31+rn8wfpsq2iT26rOkAi6f
        usL5j85wSG8y41HasUJwdGE=
X-Google-Smtp-Source: ABdhPJxRsszKTTrRDuY82J6aV+d7cQ4dBOQ+I6XaUQ5iixWu6jNM5ZNilxpP+sk4/AhPDEX0UxAsnA==
X-Received: by 2002:a05:6830:1e8f:: with SMTP id n15mr14117606otr.339.1627354562730;
        Mon, 26 Jul 2021 19:56:02 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u18sm371561oif.9.2021.07.26.19.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 19:56:02 -0700 (PDT)
Date:   Mon, 26 Jul 2021 21:56:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git List Mailing <git@vger.kernel.org>
Message-ID: <60ff75c0e29b6_2d1d20889@natae.notmuch>
In-Reply-To: <CAMMLpeTL92cDmMHsE3iuhHQrVjwLFWHxE0CwD+uDBoPGAQCrkg@mail.gmail.com>
References: <20210721134650.1866387-1-felipe.contreras@gmail.com>
 <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
 <xmqqeebregns.fsf@gitster.g>
 <CAMMLpeTL92cDmMHsE3iuhHQrVjwLFWHxE0CwD+uDBoPGAQCrkg@mail.gmail.com>
Subject: Re: [PATCH v2] pull: introduce --merge option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Wed, Jul 21, 2021 at 11:11 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > The "--no-rebase" option, which is documented as a synonym for
> > "--rebase=false", has been there, but the implementation is buggy in
> > some corner cases, which has been worked on recently in a separate
> > thread.  I do not think it is too bad to add "--merge" as yet
> > another synonym for "--rebase=false".
> 
> It's convenient to have the one-letter option `git pull -r` to
> override the configuration and do a rebase. I'd really like to have a
> similar one-letter option `git pull -m` to override the configuration
> and do a merge. That would also alleviate a lot of the desire for a
> separate `git update` (i.e. "fetch and rebase") command.

My proposed `git update` is not "fetch and rebase", but fetch and
fast-forward.

Morevoer, `git pull -m` would still merge with the wrong order of the
parents. On the other hand `git update --merge` would merge them with
the correct order.

I'm not sure what -m would alleviate.

-- 
Felipe Contreras
