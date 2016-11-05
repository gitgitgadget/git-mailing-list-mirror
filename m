Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB98C2022A
	for <e@80x24.org>; Sat,  5 Nov 2016 05:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbcKEFJE (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 01:09:04 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34984 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbcKEFJD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 01:09:03 -0400
Received: by mail-wm0-f43.google.com with SMTP id a197so86919474wmd.0
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 22:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rKenNL1l4ydRUp/UzxhPJl0+MrRmWNhbm3aVyubNwnM=;
        b=i9Z75iK76rM8PwclruRO8Enl2r5cIlQ5YQ3P7YMV38spx55BU34CSszCWjxyvvCgCh
         j71n7j8nzMGTmmybCi71xlJ0etECOnG+iTqFKRRavkXK2EhMYc4+oQoeOEEpj7Kx6lb+
         ahZ4uCTlbcadt//S9UBYA4KoLEt9EOqMVFgZiUjbL1n7rnwr4GI8Yzk10KAkG30E26B1
         xqUd5K4pkO0rV1RqPOyJFcxJl1Qa/o4mRq1SwMpgrHW8gdzaU4ESlV7PTOdPvTqWLoGj
         vnWLbaYRUmyftt6gs/E/bH9zvpAaB65lFm7OU/3D3lnsW95KQYcd5i6qRoRMKvf1c1pc
         rvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rKenNL1l4ydRUp/UzxhPJl0+MrRmWNhbm3aVyubNwnM=;
        b=FkuHxk349X0SIvUMpY0ncIOZFSDgp08J6861ZPoTb4D22OdqyCyGae7hnyUBuDj+vO
         9cW9SuV8JDyFpL6rGYQKilatVQmsBMDAP/ZYOnp40uaiq6kud5WOiyVNdLJF3mDGZX4Q
         KF7n1DDKT8t/3nsVT6kbGc/g3M8r2cKCo3gLeOjzFw7lWPjGY0DifjoO5f3tGnfrgQGF
         wAhgz85BU2sbEAoeRDqeJ2MocldrSwfAHBAoSy5lffl+6yyT60vMOm06laneO/IsjoAP
         fAK55S2F0xgEtPLn4O48AKPxQDe1gsH5ScVAUx5IKF0IUDN/qdBIe6g1P+1H1ixlF/Tr
         rpqw==
X-Gm-Message-State: ABUngvcs18jr9uJI7/ZMm0Y9zg0jaDB1w0tqAfSpfHHZJPtdlzhNHCftHH2pRON2IJgeE/wP512Xp6XyQsvCg6Fp
X-Received: by 10.28.32.150 with SMTP id g144mr201424wmg.46.1478322541144;
 Fri, 04 Nov 2016 22:09:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.140.5 with HTTP; Fri, 4 Nov 2016 22:09:00 -0700 (PDT)
In-Reply-To: <20161027223834.35312-5-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com> <20161027223834.35312-5-bmwill@google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Fri, 4 Nov 2016 22:09:00 -0700
Message-ID: <CAGf8dgKMEm0JUqMV=yfhAfDxyPnp2Xoq9-RKDVTMomcMnPr2_w@mail.gmail.com>
Subject: Re: [PATCH 4/5] grep: optionally recurse into submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 3:38 PM, Brandon Williams <bmwill@google.com> wrote:
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 8887b6add..f34f16df9 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -18,12 +18,20 @@
>  #include "quote.h"
>  #include "dir.h"
>  #include "pathspec.h"
> +#include "submodule.h"
>
>  static char const * const grep_usage[] = {
>         N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
>         NULL
>  };
>
> +static const char *super_prefix;

I think that the super_prefix changes could be in its own patch.

> +static int recurse_submodules;
> +static struct argv_array submodule_options = ARGV_ARRAY_INIT;

I guess this has to be static because it is shared by multiple threads.

> +
> +static int grep_submodule_launch(struct grep_opt *opt,
> +                                const struct grep_source *gs);
> +
>  #define GREP_NUM_THREADS_DEFAULT 8
>  static int num_threads;
>
> @@ -174,7 +182,10 @@ static void *run(void *arg)
>                         break;
>
>                 opt->output_priv = w;
> -               hit |= grep_source(opt, &w->source);
> +               if (w->source.type == GREP_SOURCE_SUBMODULE)
> +                       hit |= grep_submodule_launch(opt, &w->source);
> +               else
> +                       hit |= grep_source(opt, &w->source);

It seems to me that GREP_SOURCE_SUBMODULE is of a different nature
than the other GREP_SOURCE_.* - in struct work_item, could we instead
have another variable that distinguishes between submodules and
"native" sources? This might also assuage Junio's concerns in
<xmqq37jbqf83.fsf@gitster.mtv.corp.google.com> about the nature of the
sources.

That variable could also be the discriminant for a tagged union, such
that we have "struct grep_source" for the "native" sources and a new
struct (holding only submodule-relevant information) for the
submodule.

> +/*
> + * Prep grep structures for a submodule grep
> + * sha1: the sha1 of the submodule or NULL if using the working tree
> + * filename: name of the submodule including tree name of parent
> + * path: location of the submodule
> + */
> +static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
> +                         const char *filename, const char *path)
> +{
> +       if (!(is_submodule_initialized(path) &&
> +             is_submodule_checked_out(path))) {
> +               warning("skiping submodule '%s%s' since it is not initialized and checked out",
> +                       super_prefix ? super_prefix: "",
> +                       path);
> +               return 0;
> +       }
> +
> +#ifndef NO_PTHREADS
> +       if (num_threads) {
> +               add_work(opt, GREP_SOURCE_SUBMODULE, filename, path, sha1);
> +               return 0;
> +       } else
> +#endif
> +       {
> +               struct work_item w;
> +               int hit;
> +
> +               grep_source_init(&w.source, GREP_SOURCE_SUBMODULE,
> +                                filename, path, sha1);
> +               strbuf_init(&w.out, 0);
> +               opt->output_priv = &w;
> +               hit = grep_submodule_launch(opt, &w.source);
> +
> +               write_or_die(1, w.out.buf, w.out.len);
> +
> +               grep_source_clear(&w.source);
> +               strbuf_release(&w.out);
> +               return hit;
> +       }

This is at least the third invocation of this "if pthreads, add work,
otherwise do it now" pattern - could this be extracted into its own
function (in another patch)? Ideally, there would also be exactly one
function in which the grep_source.* functions are invoked, and both
"run" and the non-pthread code path can use it.

> +}
> +
> +static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
> +                     int cached)

This line isn't modified other than the line break, as far as I can
tell, so I wouldn't break it.

> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> new file mode 100755
> index 000000000..b670c70cb
> --- /dev/null
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -0,0 +1,99 @@
> +#!/bin/sh
> +
> +test_description='Test grep recurse-submodules feature
> +
> +This test verifies the recurse-submodules feature correctly greps across
> +submodules.
> +'
> +
> +. ./test-lib.sh
> +

Would it be possible to also test it while num_threads is zero? (Or,
if num_threads is already zero, to test it while it is not zero?)
