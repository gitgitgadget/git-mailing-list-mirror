Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4DBC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 09:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiLBJEm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Dec 2022 04:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiLBJEU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 04:04:20 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD65BA62E
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 01:04:06 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so4565546pjd.5
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 01:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gDu+5HC2gGVJTXnR1z0MVLt874diHEhv/OT9W+IOag=;
        b=4wEh63AjdC/xNBte2fvuZQzOhL5VmS4kUgW8M2H75qs5gzsqf7iAe6AHP0WMz49e12
         Fa+DgEuWuacp1lMNo10ScZ6hMUn82dE4rwbC9NkDUtNpNQZC8/T58K4Vb8yc2dAj8agh
         poSTfjpN461MKw40KOLg5K5eAgGfWoJUJKXW4b2NB/xRRPeqJryrTNviFfh/IMYGxXBR
         KAC9OnjCrvF7HrshlESq1xb5wAlwviv2Jo7iThvXgpoLYb6vxzFYEA3++WsXM/65Ic9b
         rBZu+DyliCxr0Gv8GC22egQWaPRtVHJwgh/VVLpTDxUnB2mJoNFIvNC1mJkg/WJpEt6Q
         LDqg==
X-Gm-Message-State: ANoB5plXjRUI3a64xDBUN7jPchOq5dgNrztO8Vq8b4s4OIK67h4519YC
        kfYuhFcWJ2fk6EWP/N6iJRRDW+LKKYAttIhXnqs=
X-Google-Smtp-Source: AA0mqf74tvwP3Cho8423w2dwCcqXl/mCCKfZwVKwKuU+Jr7GkrTxvRWtH4asXz+8EL2XGd0hXVx/IMrAcsjLg7sIils=
X-Received: by 2002:a17:90a:5d81:b0:212:cf2e:2b0b with SMTP id
 t1-20020a17090a5d8100b00212cf2e2b0bmr80678871pji.169.1669971845464; Fri, 02
 Dec 2022 01:04:05 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-1.8-7c9f8d2830f-20221202T000227Z-avarab@gmail.com>
 <CAPig+cQK8BRU0u0g+jAkyJaqSamYBynJ6s00_6H2beb6gXaRDA@mail.gmail.com>
 <xmqqwn7apodp.fsf@gitster.g> <221202.865yeugp7e.gmgdl@evledraar.gmail.com>
In-Reply-To: <221202.865yeugp7e.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Dec 2022 04:03:54 -0500
Message-ID: <CAPig+cQvqPgo1UKbAAtyz8UVJZiwrG7j+kAokMEimv1E62pR0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] log tests: don't use "exit 1" outside a sub-shell
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2022 at 3:55 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Fri, Dec 02 2022, Junio C Hamano wrote:
> > "return 1" is obvious and safe correction.  I have to wonder if
> > test_expect_success can be taught to be smarter to intercept "exit"
> > so we do not have to bo so careful, but that would be a much more
> > involved change to the lower-level of test framework.
>
> I can't think of a way to do so that wouldn't involve running the test
> in a sub-shell, which I think would bring us to the state management
> problems noted in [1] for Phillip's "test_todo" series, except in this
> case we'd have those issues trying to pass state back from the
> "test_expect_success".
>
> It's possible, but we'd need to change a lot of code that's expecting to
> talk to itself via variables in the same shell to use IPC between
> shells, wouldn't we?

It might make more sense to turn this on its head and make it a
linting issue and simply throw a "?!FOO?!" as is done for other
suspect shell code. In fact, I already have local chainlint.pl patches
which detect whether a subshell is active so that the linter can
complain if it sees `cd` outside of a subshell. I would think that
warning about misuse of `exit 1` outside a subshell (and perhaps
`return 1` inside a subshell) should be possible, though I haven't
thought through all the possibilities.
