Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4FF41F597
	for <e@80x24.org>; Mon, 23 Jul 2018 19:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbeGWUVE (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 16:21:04 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:43033 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbeGWUVE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 16:21:04 -0400
Received: by mail-yw0-f193.google.com with SMTP id l189-v6so634655ywb.10
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 12:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Wcr6FU71Ld36WQCBy2QvFyJJsn1mYQh1fCAFTut+CY=;
        b=pXzyVDgV2QjHHBCGLzDykfU/lwKUpo5nQ4mauE7Z0uggH2hJRVN1Me6zLJKTtS7irI
         tdGVnUpwL67CG78HSqGzNTBMXtQYOm7MCcp/Qx1/TXbFDw1GjJHc0wNcDf8RBeB60nph
         He/MtptHJBrDf1Qa5t+9jicceHpUNB2EgI66Tc9KazlELJgxRCnlvFztBCbvDYSOCutw
         LiFnk6FDa0Mc/npw7E6pe8VgJPYOW1Mh7FcJkrUDdgJ18UJsyV5sx39qLoGBba6nz+GF
         ndH+cnxnWF6eDSDSc9+YOWjHQgtWnZcaSiPuTImTGmQYnZZoCjRE52IpeN4p5IC8fDDJ
         U/Qw==
X-Gm-Message-State: AOUpUlHVj3zeXHJzOOfPbmvMVodlPKcvCHwFC6iaiwI8171rfPHaSRe3
        djdbrtajFv8moBVsgJ8x95mOG94Sd38G9NJIjBj3KQ==
X-Google-Smtp-Source: AAOMgpddNi/Lbrwg6rv1O/kSpz0y7g5vcBCsNmL+LwThA3UXa0cGoxDPR8QYonAvmCn4RWusruutcn4UvNkWxV+wO7s=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr7159650ywr.16.1532373505638;
 Mon, 23 Jul 2018 12:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com>
 <20180722095717.17912-3-sunshine@sunshineco.com> <CACsJy8C8RK6HkfoEYJGZg=sgtJS0WksHD3=7Souw3jYebRo=Sg@mail.gmail.com>
In-Reply-To: <CACsJy8C8RK6HkfoEYJGZg=sgtJS0WksHD3=7Souw3jYebRo=Sg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Jul 2018 15:18:14 -0400
Message-ID: <CAPig+cRsPV+PGtkEM_c1b4P-NF7Dk7A8DvPVuvdbx4ESr3pmqg@mail.gmail.com>
Subject: Re: [PATCH 02/14] format-patch: add --interdiff option to embed diff
 in cover letter
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 12:03 PM Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jul 22, 2018 at 11:57 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > @@ -0,0 +1,17 @@
> > +void show_interdiff(struct rev_info *rev)
> > +{
> > +       struct diff_options opts;
> > +
> > +       memcpy(&opts, &rev->diffopt, sizeof(opts));
> > +       opts.output_format = DIFF_FORMAT_PATCH;
> > +       diff_setup_done(&opts);
> > +
> > +       diff_tree_oid(rev->idiff_oid1, rev->idiff_oid2, "", &opts);
> > +       diffcore_std(&opts);
> > +       diff_flush(&opts);
> > +}
>
> Is it worth adding a new file just for a single function? I haven't
> read the rest of the series, but the cover letter's diffstat suggests
> this is it. Is interdiff intended to become a lot more complicated in
> the future? If not maybe just add this function in diff-lib.c

Good question. The functionality originally lived in builtin/log.c but
moved to log-tree.c when I added the ability to embed an interdiff in
a single patch. However, it didn't "feel" right in log-tree.c, so I
moved it to its own file to mirror how the range-diff engine resides
in its own file.

And, the function actually did several more things as originally
implemented. For instance, it took care of not clobbering global
diff-queue state, and consulting 'reroll_count' and printing the
"Interdiff:" header, but those bits eventually moved to live at more
"correct" locations, leaving this relatively minimal function behind.
It does get a bit more complex in a later patch, but not significantly
so.

I wasn't aware of diff-lib.c, but it does seem like show_interdiff()
could be at home there.
