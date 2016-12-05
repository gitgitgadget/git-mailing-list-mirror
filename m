Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711841FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 19:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbcLET5f (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 14:57:35 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35507 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbcLET5e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 14:57:34 -0500
Received: by mail-qk0-f175.google.com with SMTP id n204so357953643qke.2
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 11:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KqhbanOR2vSbhZLgvtdyZwgiC+DxlvYVyVSRz/WGy68=;
        b=ec7aHCvf7hpYp5DIt/2StAY3LU0HT9JA52LLrVIcI37OdO2D/m7vvLza3rTLxO/fG/
         tiU+GGQZX5XtUlU8t3vMGPgGJjE+Avy9ge4YOT6VGvzFuaFJzYeVF3sovljctoA1iTCC
         JKYRU6QwIhCRvIOQ/b7PKrphqOdGsgY3ZvcYcqH53JDB/SEs1sx0sst1vMzrmH8hZWdH
         0rm6Ax+kn3f0L5XMIMK/vxV6DFfeG+pm+JuOY4bgo7ozq6M28aDy3JY+qtI8D/0e1K5d
         KRNO+N2NtGoXp8hroQ26sjxpeWW8Y6ZY9s8cfokVMevitrr5kUYqT+Zdsin63Zlo5g1t
         jCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KqhbanOR2vSbhZLgvtdyZwgiC+DxlvYVyVSRz/WGy68=;
        b=OxAKV+aFvg2DfN1/Hg+97F9GKNLGZI41W4IXYGRLjdqPlPJetff0ZTY+OUmiQ4n5C1
         +ZUndCQN61LV1faLtf3wlOb6kBf8t9MPorXE+EAy1cXIn+bIFQbzbkrA0fTt2kUBdcdd
         eYe9QAtvFoIP6oksK864UWY6T9HPHtHMbnUMm14dBx8Yzg66B2TJwYxHosvlTbSMAyEL
         B8pGnk/RIRLO7foghWyAfUGpj130m5K6JyZuS4GGcIdmFyb/L4n1z9JvNQkor3a5Cj27
         pN5Ne61DY+UrqHHaPVlbypl3KsWbTRSEOF1JhMLOJ6ApvbuTV8tUsl4AxZoL+eSWDfRX
         vVFA==
X-Gm-Message-State: AKaTC01yXni/jTTuiWu6skIj7EFXf8BF+33bm8rXDGf5rDnBIDc4olG6uXPB0ZHBvNkqGAsZpi5eMro3EvhX3laZ
X-Received: by 10.55.112.134 with SMTP id l128mr31547468qkc.220.1480967853143;
 Mon, 05 Dec 2016 11:57:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 5 Dec 2016 11:57:32 -0800 (PST)
In-Reply-To: <1480964316-99305-2-git-send-email-bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com> <1480964316-99305-2-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Dec 2016 11:57:32 -0800
Message-ID: <CAGZ79kauPdE1uiFSvBALkNiwXbnV6d6xhwLdWNQwRir_8rTG6Q@mail.gmail.com>
Subject: Re: [PATCH] real_path: make real_path thread-safe
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 5, 2016 at 10:58 AM, Brandon Williams <bmwill@google.com> wrote:
> The current implementation of real_path uses chdir() in order to resolve
> symlinks.  Unfortunately this isn't thread-safe as chdir() affects a
> process as a whole and not just an individual thread.  Instead perform
> the symlink resolution by hand so that the calls to chdir() can be
> removed, making real_path reentrant.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

Thanks for working on this, some comments below:

>
> +/* removes the last path component from 'path' except if 'path' is root */
> +static void strip_last_component(struct strbuf *path)
> +{
> +       if (path->len > 1) {
> +               char *last_slash = find_last_dir_sep(path->buf);

What happens when there is no dir_sep?

> +/* gets the next component in 'remaining' and places it in 'next' */
> +static void get_next_component(struct strbuf *next, struct strbuf *remaining)
> +{

It's more than just getting it, it also chops it off of 'remaining' ?



> +       strbuf_reset(&resolved);
> +
> +       if (is_absolute_path(path)) {
> +               /* absolute path; start with only root as being resolved */
> +               strbuf_addch(&resolved, '/');
> +               strbuf_addstr(&remaining, path + 1);

This is where we would wait for input of Windows savy people.

> +       } else {
> +               /* relative path; can use CWD as the initial resolved path */
> +               if (strbuf_getcwd(&resolved)) {
> +                       if (die_on_error)
> +                               die_errno("Could not get current working directory");

I am looking at xgetcwd, which words it slightly differently.

    if (strbuf_getcwd(&sb))
        die_errno(_("unable to get current working directory"));

Not sure if aligning them would be a good idea?

Going by "git grep die_errno" as well as our Coding guidelines,
we don't want to see capitalized error messages.

> +
> +               if (next.len == 0) {
> +                       continue; /* empty component */

which means we resolve over path//with//double//slashes just fine,
as well as /./ parts. :)

>                 }
>
> -               if (sb.len) {
> -                       if (!cwd.len && strbuf_getcwd(&cwd)) {
> +               /* append the next component and resolve resultant path */

"resultant" indicates you have a math background. :)
But I had to look it up, I guess it is fine that way,
though "resulting" may cause less mental friction
for non native speakers.


> +                       if (!(errno == ENOENT && !remaining.len)) {
>                                 if (die_on_error)
> -                                       die_errno("Could not get current working directory");
> +                                       die_errno("Invalid path '%s'",
> +                                                 resolved.buf);
>                                 else
>                                         goto error_out;
>                         }
> +               } else if (S_ISLNK(st.st_mode)) {

As far as I can tell, we could keep the symlink strbuf
at a smaller scope here? (I was surprised how many strbufs
are declared at the beginning of the function)

> +       //strbuf_release(&resolved);

This is why the cover letter toned down expectations ?
(no // as comment, maybe remove that line?)

Thanks,
Stefan
