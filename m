Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D031F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 06:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754773AbcIHGcD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 02:32:03 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33312 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754231AbcIHGcC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 02:32:02 -0400
Received: by mail-yw0-f193.google.com with SMTP id g192so1558238ywh.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 23:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c0x5SEXmommE0pJjR13FpiV7JNpsBHThG6rTArwJaNg=;
        b=RuOnKqfhIAMbuboGJKSVqa3jUH62VyBla3mCyMg578nc32h7nBMJoXPSczAJQ9lmjg
         2moXtoX7P7RS7sLbZqAwcOnAtOqG+qD3K0BhJ1NA7NlDyT8KqThcuooQGWcLJdevyXIo
         2boFJw9u5m/G0VaMS7daqZCiTqnDWWBVgdAS6ag7foQ7FtrmzRG6x5HwsAZztPhfYaJh
         AMzPd/UajCqNCIFG4XpUNajYtvjvY7j0J/gFj3TBvfaNcGUuwku+kC327fY5udxqQrgo
         UzPPbA127IabvV2emQP6BxdzKLWRjiMu+sk/K+pWD600QEWgSNgx2Q49OyO3yOEcRnSw
         H6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c0x5SEXmommE0pJjR13FpiV7JNpsBHThG6rTArwJaNg=;
        b=WzGdB+geiz5JIHi1btmYv3oSwGpDGwdWJOT83U6tIvyP80a/VTSQ1+w6LavMTOydqq
         Kh/9AO1sLpPn146YFKgHOGZViCDzuwUDjHWaFrhrG2zAdtFSiwME7iSUDo+m2HaupRrO
         47vHkutvTPVZrL4f+epRc+nuKSn6/GEel+W4W7/wAiVV5J9hOV/CQgvpKJpB8wsYCFl6
         wJPbQNJ9+XZ6PoMpWLPuaIryTqQMcmCTmBM69ytiKBUqsFEHGzxvh0tyAb7dN8/k6gri
         mpes54LYKj3yka67xBH2X7pz+g/qfnfXhW0IhEo51WQfipoYzH79fOLYdZAhLfEq6Ma9
         +5PA==
X-Gm-Message-State: AE9vXwNxq3TFng7GcEfs7ZNmu4GYRUhG1+vPyY1z4v6WkdxbHwUZGo95/Fp7fgjNc5bzNekh/z2QrFZd4diagQ==
X-Received: by 10.13.197.195 with SMTP id h186mr40818976ywd.54.1473312852817;
 Wed, 07 Sep 2016 22:34:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Wed, 7 Sep 2016 22:33:52 -0700 (PDT)
In-Reply-To: <20160907233648.5162-2-sbeller@google.com>
References: <20160907233648.5162-1-sbeller@google.com> <20160907233648.5162-2-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 7 Sep 2016 22:33:52 -0700
Message-ID: <CA+P7+xrdtwAQkmHGkL37rZMJLWAn1ezAophn+QASz354eL8MqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] diff.c: use diff_options directly
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 7, 2016 at 4:36 PM, Stefan Beller <sbeller@google.com> wrote:
> The value of `ecbdata->opt` is accessible via the short variable `o`
> already, so let's use that instead.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>

Seems reasonable.

> ---
>  diff.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 534c12e..4a6501c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1217,7 +1217,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>         const char *line_prefix = diff_line_prefix(o);
>
>         if (ecbdata->header) {
> -               fprintf(ecbdata->opt->file, "%s", ecbdata->header->buf);
> +               fprintf(o->file, "%s", ecbdata->header->buf);
>                 strbuf_reset(ecbdata->header);
>                 ecbdata->header = NULL;
>         }
> @@ -1229,9 +1229,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>                 name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
>                 name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
>
> -               fprintf(ecbdata->opt->file, "%s%s--- %s%s%s\n",
> +               fprintf(o->file, "%s%s--- %s%s%s\n",
>                         line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
> -               fprintf(ecbdata->opt->file, "%s%s+++ %s%s%s\n",
> +               fprintf(o->file, "%s%s+++ %s%s%s\n",
>                         line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
>                 ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
>         }
> @@ -1249,15 +1249,15 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>                 find_lno(line, ecbdata);
>                 emit_hunk_header(ecbdata, line, len);
>                 if (line[len-1] != '\n')
> -                       putc('\n', ecbdata->opt->file);
> +                       putc('\n', o->file);
>                 return;
>         }
>
>         if (len < 1) {
> -               emit_line(ecbdata->opt, reset, reset, line, len);
> +               emit_line(o, reset, reset, line, len);
>                 if (ecbdata->diff_words
>                     && ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN)
> -                       fputs("~\n", ecbdata->opt->file);
> +                       fputs("~\n", o->file);
>                 return;
>         }
>
> @@ -1282,8 +1282,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>                 }
>                 diff_words_flush(ecbdata);
>                 if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
> -                       emit_line(ecbdata->opt, context, reset, line, len);
> -                       fputs("~\n", ecbdata->opt->file);
> +                       emit_line(o, context, reset, line, len);
> +                       fputs("~\n", o->file);
>                 } else {
>                         /*
>                          * Skip the prefix character, if any.  With
> @@ -1294,7 +1294,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>                               line++;
>                               len--;
>                         }
> -                       emit_line(ecbdata->opt, context, reset, line, len);
> +                       emit_line(o, context, reset, line, len);
>                 }
>                 return;
>         }
> @@ -1316,8 +1316,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>         default:
>                 /* incomplete line at the end */
>                 ecbdata->lno_in_preimage++;
> -               emit_line(ecbdata->opt,
> -                         diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
> +               emit_line(o, diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
>                           reset, line, len);
>                 break;
>         }
> --
> 2.10.0.2.g0676c79.dirty
>
