Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F1A1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 21:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeBEVwm (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 16:52:42 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43214 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeBEVwl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 16:52:41 -0500
Received: by mail-yw0-f194.google.com with SMTP id x190so19490290ywd.10
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 13:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KP7aNSD/fWE9UB1k/MZdNdsP7brayKJo3rNgo2fLkC8=;
        b=gysEFbJZNOPx+85euohg5VJf13rFrEtLdR+67HGm6rQw2a+bvu2rWJa+taRv6v/KQN
         YblDFGPU5D2hxQkmznnuZr4QH7y5SNBcoFYEKz0H4r6qx45K3rIFYXm5DCFrgUGkyXdB
         kT5352u6pXvU5qjuG+Urn2o/VpA08xnuCMF5mQgMPiz0SyWlex1qJ3SaNe6E6g8EYly1
         3uetQ0zQPdjFdoyCAduyW3PtWuvbI+/qStEX3DW6gQYzsucuohYN4O7dlBD6Gf8s0p+V
         u7aUvXrOt8cSr1lqLYoUwm7OzG3OMsZiTt8/E3Dovn5ugTycb/UfalhApf74f7pArE5c
         doHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KP7aNSD/fWE9UB1k/MZdNdsP7brayKJo3rNgo2fLkC8=;
        b=V4z9y3mNq3ql3Dsoie+CerNl9cF9BdgGqIf1Zt989HDyUuzSFjVLkcTeHq2tnG0FTk
         lm4LmsqNtIDiE0/9Wy5z2aXvIUDhmIPjXiX72nXxAk466F70vqzVegN4DeZNauS9POiU
         3LvOhvkyAajVX8GdsyWk+od0w77MilC2zm38wZ0AhjUUtouZUY/XV9aBRrOByImtQzpj
         /H5FN3FJVkAGCJGRwTe6D44dSd+mT2zaM8Rq+VnPzJu/+haLRBcGSjsE60xdL0wcQRoD
         gUfwnuBDxmYyi2oalCKzbXkzwCORAVA0JbGV7wE678Fq8QqcoPnQhsYKZnDQRbb90WMa
         o7PA==
X-Gm-Message-State: APf1xPC9g+WKv1qePN9vWsbbVXzJY5y0Qf6rChWAROcGuBAXD3jfuHTn
        xHuAhYZT/lQPTeVMRfQGifXmI6yawlJ+x1ZuoHKv1exwVg0=
X-Google-Smtp-Source: AH8x227ji/0be1G4u7el7qDLGTsyfEOOD33eB9fPs111SHpc4K0Sti6hTKc6xGWXdSdOBSy9gEA8XEPan2lgn/67q6c=
X-Received: by 10.37.12.130 with SMTP id 124mr165299ybm.39.1517867560273; Mon,
 05 Feb 2018 13:52:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Mon, 5 Feb 2018 13:52:39 -0800 (PST)
In-Reply-To: <20180130232533.25846-29-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-29-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Feb 2018 13:52:39 -0800
Message-ID: <CAGZ79kYwDnL1AJ79Z02qxse1ZjKd1zqORqKTxpZGHmCqPhTHJw@mail.gmail.com>
Subject: Re: [PATCH v7 28/31] merge-recursive: fix remaining directory rename
 + dirty overwrite cases
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c                   | 26 +++++++++++++++++++++++---
>  t/t6043-merge-rename-directories.sh |  8 ++++----
>  2 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index fba1a0d207..62e4266d21 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1320,11 +1320,23 @@ static int handle_file(struct merge_options *o,
>
>         add = filespec_from_entry(&other, dst_entry, stage ^ 1);
>         if (add) {
> +               int ren_src_was_dirty = was_dirty(o, rename->path);
>                 char *add_name = unique_path(o, rename->path, other_branch);
>                 if (update_file(o, 0, &add->oid, add->mode, add_name))
>                         return -1;
>
> -               remove_file(o, 0, rename->path, 0);
> +               if (ren_src_was_dirty) {
> +                       output(o, 1, _("Refusing to lose dirty file at %s"),
> +                              rename->path);
> +               }
> +               /*
> +                * Stupid double negatives in remove_file; it somehow manages
> +                * to repeatedly mess me up.  So, just for myself:
> +                *    1) update_wd iff !ren_src_was_dirty.
> +                *    2) no_wd iff !update_wd
> +                *    3) so, no_wd == !!ren_src_was_dirty == ren_src_was_dirty
> +                */

Not sure iff this comment is at the right place and is a good addition to
the code base.

However it hints at the underlying issue of a bad API that is provided
by remove_file ?
