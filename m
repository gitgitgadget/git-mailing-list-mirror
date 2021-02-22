Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D582C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 01:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1CF64EE6
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 01:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBVBU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 20:20:56 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:33552 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBVBUy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 20:20:54 -0500
Received: by mail-ej1-f52.google.com with SMTP id jt13so26658582ejb.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 17:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6IeAuwY5GoiKHqD88WAquRxqDxBHkTzMIhM3gKJhYSA=;
        b=cSetYECVOhDrLYt/W/wPy2BMWTMZKKPK8CHiUsS+FdhjlS2vQkBlH9mHmTR5yGDU7L
         lASvec9zGpdO5tb3v0uNVKSyWU9bUwDggB+4g77d+Ods6OF4N8ZZLjEiUa5eDlJvGlOy
         syER3Aq981zq75XgmsXgNRfMxPdCcGteI7OhnxtpVKe2mcxnByiz00Q+UChkPB3nHJ/A
         lYQ5KKoWukaw5bOPQpv1xT8ivGhqj5lC0nuBmUCgi/AGooW+e69w5UbcgWxVZ9XP0Hlw
         Fjue64r58HpzOVLqL/BqQwRZjvflouRsxn+3hmBSywjOpGEKP5ReMrIgUzzwQbJ0luDD
         LB3g==
X-Gm-Message-State: AOAM533ahJZDxRYN8XDFH5e2Ugcv2bug+KsimvY0+tkCH9HGN+ePPps+
        cwtTqskLIoGjosMEgce5+bkm1PVYt7FD5Hl6EL0uvQTeMUs=
X-Google-Smtp-Source: ABdhPJzMU0MnyTUPUJXKIKhduTuV5hJFy85pYJB1YGBhRSGZRmaElNpKsezGb87Fl2cjvDRzeeKy92hU1e6GlejvOdw=
X-Received: by 2002:a17:906:ae14:: with SMTP id le20mr12714689ejb.231.1613956813140;
 Sun, 21 Feb 2021 17:20:13 -0800 (PST)
MIME-Version: 1.0
References: <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
 <20210222004112.99268-1-stefanbeller@gmail.com>
In-Reply-To: <20210222004112.99268-1-stefanbeller@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 21 Feb 2021 20:20:02 -0500
Message-ID: <CAPig+cT9ZUqkOZWZS3+gEd3soh-xyfxu2yvQ_gY-LMgVV-rAiw@mail.gmail.com>
Subject: Re: [PATCH] refs: introduce API function to write invalid null ref
To:     Stefan Beller <stefanbeller@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>, hanwenn@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 21, 2021 at 7:43 PM Stefan Beller <stefanbeller@gmail.com> wrote:
> Different ref backends will have different ways to write out the invalid 00..00
> ref when starting a new worktree. Encapsulate this into a function and expose
> the function in the refs API.
>
> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> ---
> it's been a while since I looked at git source code, but today is the day!
> I was actually looking how the refs table work progresses and this patch
> caught my attention.  I think the changes in builtin/worktree.c (that
> if/else depending on the actual refs backend used)
> demonstrate that the refs API layer is leaking implementation details.

Welcome back. I have a few comments in response to this proposal. See below...

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -330,9 +330,9 @@ static int add_worktree(const char *path, const char *refname,
>         strbuf_reset(&sb);
> -       strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
> -       write_file(sb.buf, "%s", oid_to_hex(&null_oid));
> -       strbuf_reset(&sb);
> +
> +       write_invalid_head(get_main_ref_store(the_repository), sb_repo.buf);
> +
>         strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>         write_file(sb.buf, "../..");

Nit: This change ends up making the strbuf_reset() unnecessarily
distant from the location where it has most meaning (just before we
start using it again, which is the pattern in this function):

    strbuf_release(&sb);

    write_invalid_head(..., sb_repo.buf);

    strbuf_add(&sb, ...);

It would be clearer for the end result to be:

    write_invalid_head(..., sb_repo.buf);

    strbuf_release(&sb);
    strbuf_add(&sb, ...);

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> @@ -3169,6 +3169,18 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
> +static int files_write_invalid_head_ref(struct ref_store *ref_store,
> +                                       const char *dir)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       strbuf_addf(&sb, "%s/HEAD", dir);
> +       write_file(sb.buf, "%s", oid_to_hex(&null_oid));
> +       strbuf_release(&sb);
> +
> +       return 0;
> +}

I'm not super enthused about the name write_invalid_head_ref(). Even
if given a different name, I'm not necessarily enthused about it
unconditionally writing a zero-OID. Do you foresee other cases in
which callers will need to perform this precise operation?

The reason I ask is that the bit of code in
builtin/worktree.c:add_worktree() which this patch targets is itself a
hack to work around the shortcoming in which is_git_directory() won't
consider the newly-created worktree as being legitimate if it doesn't
have a well-formed HEAD ref. It's not visible in the context of this
patch, but there is a comment just above the changes to
builtin/worktree.c made by this patch:

    /*
     * This is to keep resolve_ref() happy. We need a valid HEAD
     * or is_git_directory() will reject the directory. Any value which
     * looks like an object ID will do since it will be immediately
     * replaced by the symbolic-ref or update-ref invocation in the new
     * worktree.
     */

As mentioned in the comment, it doesn't matter what the value of HEAD
is; it just needs to be something that looks like a well-formed OID.

So, my lack of enthusiasm for write_invalid_head_ref() is twofold.
First, this function is being introduced to paper over a hack, which
leaves the new function smelling funny. Second, the "invalid head" in
the name and the unconditional zero-OID feel too special-purpose and
focus too much on the particular current implementation in
builtin/worktree.c which happens to assign a zero-OID to HEAD. (At an
earlier time, builtin/worktree.h assigned the value of HEAD from the
current worktree to HEAD in the newly-created worktree instead. But,
as noted, the value is arbitrary -- it doesn't matter what it is -- it
just needs to exist long enough to pacify is_git_directory() and is
then immediately overwritten.)

On the other hand, I could see this as acceptable if "invalid" is
removed from the function name and if it accepts an OID to write
rather than unconditionally writing a zero-ID. In that case, it would
become a generally useful function without the bad smells associated
with the too-special-purpose write_invalid_head_ref(). (But I haven't
been paying attention to the ref backends work, so perhaps such a
function already exists? I don't know.)
