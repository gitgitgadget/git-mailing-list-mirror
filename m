Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E5AC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2C061205
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhFMHoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 03:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhFMHoR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 03:44:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3284C061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 00:42:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e1so4968898plh.8
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=elVdF1HcgsLJG4FBJs9BJER00XgPI9dPgUMTuzFQofI=;
        b=EnL2T9AZ5VZzwaG1DWHpLVw1Jubv+ZQLWMJ4kVD+WXXyGxbgmuxn2oNE/czdTepmRj
         NQIWn2PyElkdBp90cFqU6umOMQFtKTdAvT/Qh6S+kd0LxRKIVDsm3cKWfUVUSBOhx6Fb
         bATe4VeOG6eMvjioCpJMtMMTOe8IcXU42A9jqBEp1BanRsjkxinnGsgG4+Qz5B998NX9
         ldO7yDrEXEoHCVOS8AItvzyG17mfl+Zrm0ENu5tWK8kZ+IEOhCONW946DgxciSTxcqQq
         1N8rK/0e8uaBq/okm6XXs/WERxKJIj51JK8zGNlzytnxy7pUZL34f5IXWoZ9DymcKMZ0
         aRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=elVdF1HcgsLJG4FBJs9BJER00XgPI9dPgUMTuzFQofI=;
        b=pucIuJfPHFzSeBkQYg5VT6rX1bCz/XDpo8DVmchYjkmdneG0BS8qvb/WPxstHROQam
         85Y8WNUKakQPwsFKc4dk2Wl9GdUXMPkqhoDBG9ml0FxXwe4hMB+4dTlA0sbpnvWNeZbE
         WQZHumYfR3AYyA1x6O4ZfxButyF3SWxojnHg2rf0QA9rqjtiqmjsueKdQfNWPOWOBizh
         oJ+6qlF5HxSahJI/FHpdtamNxRvxLg+FEXtGZDVB8yuDY+4+s9o+/eSGje/f3sxVWUsl
         ldjwkCfhheK4zENrcXSFGnvFyHl22zkfoxc8pGkWeBGZkrmREYnSl5AMOLxb4UWGhAU8
         G50Q==
X-Gm-Message-State: AOAM532UOgjumtfSCSNW7S+MXycvjDm5ro/0czVq5Hl2q8HLy5qd0byr
        HFd5CtkX7b+xjR+itVZhdV8=
X-Google-Smtp-Source: ABdhPJzZqs0xgLJgd1bqtxqY8NfHXB44S+/i6mzt3HTVGYDoMrdwLrjZkQZ9qGFPMR9TQoEmv1p7zA==
X-Received: by 2002:a17:903:31d3:b029:ee:bccd:e686 with SMTP id v19-20020a17090331d3b02900eebccde686mr11754571ple.1.1623570136310;
        Sun, 13 Jun 2021 00:42:16 -0700 (PDT)
Received: from localhost ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id w71sm3113804pfc.164.2021.06.13.00.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 00:42:16 -0700 (PDT)
Date:   Sun, 13 Jun 2021 14:42:14 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] t6400: use test_line_count_cmd to count # of lines
 in stdout
Message-ID: <YMW21lasp0orYfjZ@danh.dev>
References: <20210612042755.28342-1-congdanhqx@gmail.com>
 <20210612042755.28342-4-congdanhqx@gmail.com>
 <CAPig+cRNqX3F3GmYP3X4Z-cY2aRGFac9NZ3=KymW43etNaDjEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRNqX3F3GmYP3X4Z-cY2aRGFac9NZ3=KymW43etNaDjEw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-12 23:39:51-0400, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Jun 12, 2021 at 12:28 AM Đoàn Trần Công Danh
> <congdanhqx@gmail.com> wrote:
> >
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> > diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
> > @@ -82,13 +82,13 @@ test_expect_success 'modify/delete + directory/file conflict' '
> > -       test 5 -eq $(git ls-files -s | wc -l) &&
> > -       test 4 -eq $(git ls-files -u | wc -l) &&
> > +       test_line_count_cmd --out = 5 git ls-files -s &&
> > +       test_line_count_cmd --out = 4 git ls-files -u  &&
> 
> Nit: too many spaces before the `&&` on the second line: s/\s+/ /

Thanks, I'll update them, later.
In my defence, this patch was generated mechanically with:

	:%s/test \([0-9]\+\) -eq "*[$][(]\(.*\)|.*[)]"*/test_line_count_cmd --out = \1 \2/gc

I forgot to include the space after final ")"

> > @@ -103,13 +103,13 @@ test_expect_success 'modify/delete + directory/file conflict; other way' '
> > -       test 5 -eq $(git ls-files -s | wc -l) &&
> > -       test 4 -eq $(git ls-files -u | wc -l) &&
> > +       test_line_count_cmd --out = 5 git ls-files -s  &&
> > +       test_line_count_cmd --out = 4 git ls-files -u  &&
> 
> Nit: too many spaces before the `&&` on both lines.

-- 
Danh
