Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E7E1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfJBPyP (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 11:54:15 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41767 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBPyP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 11:54:15 -0400
Received: by mail-vs1-f65.google.com with SMTP id l2so12237501vsr.8
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ah+2hq9ly3dLBQXoc74UnpjVEYrBZ5N4uQ0MlmIz1HA=;
        b=OvVeE9X45Ho+GfNPp4pJcPDJe9Q819qY4dkrDQFtHpn7BtET4N+25F9DPn+LhQfAet
         ygqbzhPG2f/sRhyz9B/U6DzuWyV0abb6wG2DLSyj9qCwmcDDvpD6KzOa8xPo5tV5qUF+
         9M0wGbbiRgjCvwo9zVm/iCjX5WUickbfvPfkZ7qo7xWUzqbjxYEBmTfkCpTSfx6zzic8
         yLrcYkUArvbZ9Lc/5cjAm2hV5gcOrxEUlX55pmq/TVd/kH9qhTlVLmvdpWPOSv87pJyY
         OuOYrFovvQzlR5U4pI2ni0Jh2nZoY7IjVjgPJImmqz7lGXU4a4aF3BhosgYWm9X2c75e
         PnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ah+2hq9ly3dLBQXoc74UnpjVEYrBZ5N4uQ0MlmIz1HA=;
        b=txLuguVGc9+Wd4yYX5w0fa+xGGupAGI5n59TEd/gw1hpdFdFuTKP8Bd2C0yfdn3XeL
         EgDV/0Cf8vzJ83LKazjINnnG82ifDE5QYOoWwYRMee5v2eLUF2bSa7DKy0Q3Psb1ID3S
         D3LrVtb0rMTmZNoJqWI5e5x5zLbDYpiGYaiboK7T3Q2JcmAFbIxYYvi4CqSn0kTR1N+q
         DQQ/dGS/T1PtxK5ctigCi1WjjnGT6iRtC6DL5ZlRujjLSfpwK6Lgl6C8fHbcYISRBmsw
         9ZQSaYkK/PdHheDD+g8HSwb7ZKkBCvJMdqAdf4FR5YWSEPV4yeySKOpN7hWMZzU98wk2
         9ZZA==
X-Gm-Message-State: APjAAAVLhUL+GEHZuoAnymBr0/1sCupGuPVPfDbs4mpQuCaEiXrXBKHH
        6mLdMzBADUxIarN6R1iIZaHZ6yiMVCX3+1p6iO/EaXtBL/o=
X-Google-Smtp-Source: APXvYqxg07/JUNN3gmCPZrQdEGeevL32ZjBCX5pgevy1JQrP584Vm6nwXuOqVsUROdY95weCLcIer/tXq3FsCrvzM8o=
X-Received: by 2002:a67:e8ca:: with SMTP id y10mr2197373vsn.136.1570031654122;
 Wed, 02 Oct 2019 08:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190925014005.17056-1-newren@gmail.com> <20190930211018.23633-1-newren@gmail.com>
In-Reply-To: <20190930211018.23633-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Oct 2019 08:54:02 -0700
Message-ID: <CABPp-BFckDZL4iAqhHmrXDpFi3eQgvOkbgjJdGRZE4ePUwNDuw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] fast export/import: handle nested tags, improve
 incremental exports
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Sep 30, 2019 at 2:10 PM Elijah Newren <newren@gmail.com> wrote:
>
> This series improves the incremental export story for fast-export and
> fast-import (--export-marks and --import-marks fell a bit short),
> fixes a couple small export/import bugs, and enables handling nested
> tags.  In particular, the nested tags handling makes it so that
> fast-export and fast-import can finally handle the git.git repo.

I see you picked up this corrected series in pu; thanks.  However,
your merge commit, 2a99d6b6ff7c ("Merge branch
'en/fast-imexport-nested-tags' into pu", 2019-10-02), claims "Seems to
break t9300 when merged to 'pu'.".  I know v1 did that and I could
reproduce, but I can't reproduce any failures here.  Was this message
just left over or is there some problem you are seeing?

Thanks,
Elijah

>
> Changes since v1 (full range-diff below):
>   - Fixed an issue integrating with next/pu (in particular, with
>     jk/fast-import-history-bugfix)
>
> Elijah Newren (8):
>   fast-export: fix exporting a tag and nothing else
>   fast-import: fix handling of deleted tags
>   fast-import: allow tags to be identified by mark labels
>   fast-import: add support for new 'alias' command
>   fast-export: add support for --import-marks-if-exists
>   fast-export: allow user to request tags be marked with --mark-tags
>   t9350: add tests for tags of things other than a commit
>   fast-export: handle nested tags
>
>  Documentation/git-fast-export.txt | 17 ++++--
>  Documentation/git-fast-import.txt | 23 ++++++++
>  builtin/fast-export.c             | 67 ++++++++++++++++------
>  fast-import.c                     | 94 +++++++++++++++++++++++++++----
>  t/t9300-fast-import.sh            | 37 ++++++++++++
>  t/t9350-fast-export.sh            | 68 ++++++++++++++++++++--
>  6 files changed, 268 insertions(+), 38 deletions(-)
>
> Range-diff:
> 1:  b751d6c2d6 ! 1:  1d19498bc6 fast-import: fix handling of deleted tags
>     @@ fast-import.c: static void parse_reset_branch(const char *arg)
>                 b = new_branch(arg);
>         read_next_command();
>         parse_from(b);
>     -+  if (b->delete && !strncmp(arg, "refs/tags/", 10)) {
>     ++  if (b->delete && !strncmp(b->name, "refs/tags/", 10)) {
>      +          /*
>      +           * Elsewhere, we call dump_branches() before dump_tags(),
>      +           * and dump_branches() will handle ref deletions first, so
>     @@ fast-import.c: static void parse_reset_branch(const char *arg)
>      +          for (t = first_tag; t; t = t->next_tag) {
>      +                  strbuf_reset(&tag_name);
>      +                  strbuf_addf(&tag_name, "refs/tags/%s", t->name);
>     -+                  if (!strcmp(arg, tag_name.buf))
>     ++                  if (!strcmp(b->name, tag_name.buf))
>      +                          break;
>      +                  prev = t;
>      +          }
> 2:  26b77dde15 = 2:  e1fd888e4a fast-import: allow tags to be identified by mark labels
> 3:  e0d1a1d7aa = 3:  93175f28d9 fast-import: add support for new 'alias' command
> 4:  edea892661 = 4:  8c8743395c fast-export: add support for --import-marks-if-exists
> 5:  6af7e1fdd0 = 5:  eebc40df33 fast-export: allow user to request tags be marked with --mark-tags
> 6:  631ae9a63e = 6:  de39f703c6 t9350: add tests for tags of things other than a commit
> 7:  c0e932e4da = 7:  ac739dbb79 fast-export: handle nested tags
> --
> 2.23.0.264.gac739dbb79
>
