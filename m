Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35984C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 01:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiLBBw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 20:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiLBBw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 20:52:27 -0500
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF685CE424
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 17:52:26 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3876f88d320so35348697b3.6
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 17:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z60bZmttCiz+Ht7BDEFGff+hqfXM2516Q4uwJJ1h7xQ=;
        b=ot9/IJcgk1wz0S/zwmqoJiUJc52F0iULzjVJ/N4+4aeYjNRz/2IrsEDW65FypNlApf
         ZHXZblkk42s35vO8ZgoqmrPKGMkMkhP4K4xfUlLRoiczy0h5xm1KNLokRzOCEoMWgRhb
         XVgGZyIU3yW4gTKmvqIICw+M3/zp5NqnZGqjy/ozXPHRe0XLfwgne3Qh95G/RvqcRzuH
         0AO/gqGEFxBb7hQNg1/+c/wuYRpY8RTgCe3vZhACaejusmuAETYXiDa6PbgID6Hfc7oh
         p35JPS7Vb71JelSou18lflkZEN8XWnrVxUePR95jHG+Qfg72Pfd1U178ZCqJbD3ZU7YA
         ya7g==
X-Gm-Message-State: ANoB5pm4dPdbP2arwVVm18WnTobnf2jIViuduHo9AREiovdVqASqiGyF
        wauoWd7E9A8YDzPsYTEesqCX8ZW7bT0rykyYgkk=
X-Google-Smtp-Source: AA0mqf6pcjWnoMsm+T/k7s7QTqgW91JLqk2fj8/udTZN1CwWidlNyWkGn59J5RZbhkDpCf/ukdUZI152qk9RfYqHRGQ=
X-Received: by 2002:a81:4a09:0:b0:38e:b5bc:e996 with SMTP id
 x9-20020a814a09000000b0038eb5bce996mr66962845ywa.493.1669945946072; Thu, 01
 Dec 2022 17:52:26 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-4.8-c36060934a6-20221202T000227Z-avarab@gmail.com>
 <CAPig+cTfx4QYBdtSomPRM+BpW+3ELqaQxD7okKhXzykVkyH9NA@mail.gmail.com> <CAPig+cSgnhzFCUVTQCcTKJK+2qVOpdB2R-Vq1DjqspDJudom4w@mail.gmail.com>
In-Reply-To: <CAPig+cSgnhzFCUVTQCcTKJK+2qVOpdB2R-Vq1DjqspDJudom4w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Dec 2022 20:52:14 -0500
Message-ID: <CAPig+cROyCWrweskbUoxjA9ziHPqUR++KgJ9ViTKwkPhz-J3QQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] test-lib-functions: add and use test_cmp_cmd
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2022 at 8:45 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> But, even that doesn't
> seem to buy much. The vast majority of cases where you've converted:
>
>     test "$dir" = "$(test-tool path-utils real_path $dir2)" &&
>
> to:
>
>     test_cmp_cmd "$dir" test-tool path-utils real_path $dir2 &&
>
> could just have easily become:
>
>     echo "$dir" >expect &&
>     test_cmp test-tool path-utils real_path $dir2 &&
>
> which isn't bad at all, even if it is one line longer, and it is
> idiomatic in this test suite.

I can't count. Of course, I meant:

     echo "$dir" >expect &&
     test-tool path-utils real_path $dir2 >actual &&
     test_cmp expect actual &&

which is two extra lines.
