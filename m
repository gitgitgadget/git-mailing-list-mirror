Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2C7C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872F820757
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgD2WAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:00:38 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:51649 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgD2WAh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 18:00:37 -0400
Received: by mail-wm1-f48.google.com with SMTP id x4so3737040wmj.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BuKwRhBtmGXof+hg/g/FrYAwJQpKD5rEWjrjAeRxKus=;
        b=mlzOv0uj6ZRIUv/AEn3EF+vEqlaX00zs36LweETFvo3Tk1DpGWI6zC66rtPF/04LM4
         5vrunw+v+Sg7vv8fmT6COD1P7BNtUx8LQ2T4xdRdj3BzEdHx/tXGYET1Dkf9HhvgRdKV
         gs6D1Fks3yQQjaWHdPHWLRN4yPeiFz6aXJL+5bClSsRuD8FE99+Dfozb4PGeH9uEjUOq
         WNvzdQIXIL+mcQA8xLGAqmm5B7PJfuQXcP7GlHSC55cpovIPD4QgE5p01zfZYJS0GKC5
         8gkidyf4B1enao3erCetOnDsp3SMCguD2kOqK3gWNIpN8Hl4HuM3+Hr63bpib9knvnXA
         UCFg==
X-Gm-Message-State: AGi0PuaJkcvoTrspCZh0aY680g00eoYRd/TlJmNzMmZe/pnZBhHEeWJg
        aPjgyVCynCBYRTFPg3gbK5dwo9QQTOisvFFsVoo=
X-Google-Smtp-Source: APiQypIhrQSFRrXki+bRZ80XF/UCkAycUfkgE2sZyrrHOCk2lMoGYjhxb7SJ+wb25g8DV11qLoQTtNPdPHMsbYd/o/U=
X-Received: by 2002:a7b:c213:: with SMTP id x19mr5358948wmi.53.1588197634585;
 Wed, 29 Apr 2020 15:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588162842.git.liu.denton@gmail.com> <20200429195035.GB3920@syl.local>
 <90edb162-e035-bdb7-a2d2-ffc6bd075977@kdbg.org> <xmqqblnaufyt.fsf_-_@gitster.c.googlers.com>
In-Reply-To: <xmqqblnaufyt.fsf_-_@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Apr 2020 18:00:23 -0400
Message-ID: <CAPig+cT5DH2KW4nnQxUMaZzLR0JSLovGbpGC=3vYOWY2QWyKsw@mail.gmail.com>
Subject: Re: Re* [PATCH 0/4] t: replace incorrect test_must_fail usage (part 5)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Taylor Blau <me@ttaylorr.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 5:42 PM Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] t/README: document when not to use test_might_fail
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/t/README b/t/README
> @@ -875,7 +875,9 @@ library for your script to use.
>   - test_might_fail [<options>] <git-command>
>
>     Similar to test_must_fail, but tolerate success, too.  Use this
> -   instead of "<git-command> || :" to catch failures due to segv.
> +   instead of "<git-command> || :" to catch failures due to segv,
> +   but do use "{ <non-git-command> || :; }" to ignore a failure from
> +   a command that is not git.

This seems like a good addition and perhaps may help reduce reviewer
burden (not that this comes up very often, but I've recommended it
here and there when reviewing patches). Here's a possible alternate
wording:

    Similar to test_must_fail, but tolerate success, too. Use this
    instead of "<git-command> || :" to catch failures due to segv.
    To ignore failure of non-git commands, however, use
    "{ <non-git-command> || :; }".
