Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2599FEEAA7C
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 22:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjINWja (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 18:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjINWj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 18:39:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC11270B
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 15:39:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26b44247123so1197353a91.2
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694731164; x=1695335964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHZS3B9jTeV+IYVts2Ry7S6HacRLQ1ta68E4ydyCqdA=;
        b=eWWsQ7qS1E9zSkXWcU8RxKrfVNiYTi6JBnTBnaBjJ+lY9Phn2V15DdPZHhuFx3+Ir8
         WFBRRwob101kfzwuboAWxJrVPZNs8Mh3r1Zfy2a52SkZfMEmTFQ8WzT+oumpz5VbQTOI
         LYTr61dM6syIdjH7t9W1EZeXJI+x1wtHPb0wwXN4iJTX/xqT6l9axkFpYfpBi9Vo5pSY
         FhOZE88z2wJjpJaUWFulUAttKsGrfM3xSUbbJxOxNzbqIi4Fmm/ColbKIhyeol29i+Sd
         KJH5b0yUmb8vfdGLUEFv0KtFWJj74KOn9wW8/rSUJQaYMFqj71QiIMzZFutqc8po9tOn
         ZS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694731164; x=1695335964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHZS3B9jTeV+IYVts2Ry7S6HacRLQ1ta68E4ydyCqdA=;
        b=RGdndT4ky0/heRuRQD4ro9Mjs74s97Xemw9HyXc2B50wqC2gpHD8+/JU/PRk+3F80M
         0YWNzuktDaoPGo3VVQyRPvW188fNrTHs6MnQ2Fq8S6DX0iW2p4s9WOmFbiGnzBviI2RA
         KsQ5vSWpS+THhmqy/1eGovbQJcKvFWdSPLJxHHWqC42UlywOwb5a20PM+tvYUit4aRm4
         zDxg98kvYAkeCCIUJWCk6rRdBqWSoaqSWHyHdOtKTlkADiungat0vG3tkl7OAeVMKva6
         9s/SBvbz7RipuIZg6mxthk/ZfxtucpCBYEzoh3QSuSr5al3k54VYjPSN0fJksLtm/YzC
         Ledw==
X-Gm-Message-State: AOJu0YyQ8D3N1SbpguAzEwA0XhyyzrOtibafo0n+X/GSKUNMYqJl5C38
        i8W+8+4CYYD/HSM+gFF247EZdQwEqMVtXbMuTPvYGjgBEbaaUeXiM7hlFQ==
X-Google-Smtp-Source: AGHT+IE73EwYM+4+ePHkpBJSQjYzLYIq+dKuFV8/QDzivueGLhvBwkCQ0RyTfx91Um+OPg0jnpJGC2VpyzDR6g5jfqc=
X-Received: by 2002:a17:90a:8a89:b0:274:7be1:f1ce with SMTP id
 x9-20020a17090a8a8900b002747be1f1cemr2550923pjn.23.1694731164158; Thu, 14 Sep
 2023 15:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230906060241.944886-2-sokcevic@google.com> <20230911170901.49050-2-sokcevic@google.com>
 <xmqqsf7ks4nn.fsf@gitster.g> <CAJiyOijMvqK184wFgoXFyX5kmURkX3k2OmuiBpArikj26iHpMA@mail.gmail.com>
 <xmqqfs3jpbg2.fsf@gitster.g>
In-Reply-To: <xmqqfs3jpbg2.fsf@gitster.g>
From:   Josip Sokcevic <sokcevic@google.com>
Date:   Thu, 14 Sep 2023 15:39:13 -0700
Message-ID: <CAJiyOiidpD5eNvxVV8rZP7Xej4_8bBfgTOG75T8PVsmvwya3hg@mail.gmail.com>
Subject: Re: [PATCH v3] diff-lib: Fix check_removed when fsmonitor is on
To:     Junio C Hamano <gitster@pobox.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2023 at 10:07=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> It seems to be entirely doable, even though the stench from the
> abstraction layer violation may be horrible.
>
> ie_match_stat(), which is called by match_stat_with_submodule(),
> does pay attention to CE_FSMONITOR_VALID bit, so none of the members
> of struct stat matters when the bit is set.  But the bit is not set,
> all members that fill_stat_data() and ce_match_stat_basic() care
> about do matter.  Other code that follows callers of check_removed()
> do care about at least .st_mode member, and I suspect that in the
> current code .st_mode is the only member that gets looked at.
>
> So after all, I think your original "fix" was correct, but it took
> us some time to figure out why it was, which means we would want to
> explain it in the log message for developers who would want to touch
> the same area in the future.

I finished testing this - after my original fix and after running all
tests, I can confirm that `st_mode` of `struct stat` is indeed not
consumed if CE_FSMONITOR_VALID is set. But, it's fragile and likely to
cause problems in the future. Your approach of constructing `struct
stat` based on `struct cache_entry` is the way to go.

I see you created a new set of patches in a separate thread, so I'll
start those tests and report back there.

Thanks!

--=20
Josip Sokcevic
