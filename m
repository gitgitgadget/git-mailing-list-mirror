Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FEEC4321A
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BB122E00
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392090AbhASRzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbhASRns (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 12:43:48 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E512C061574
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 09:43:08 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id h4so22680820qkk.4
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 09:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmEtnM6LL3v8oe+GjznXIcjlNfbK8VrtV5UJVApAZhs=;
        b=MYqYWdO5PEolfl2Xtgwc+a0Z80XVPs87tyMATXQNGputxM16dQvuHEzN/EWcmPX28c
         XiCMQIapkegpyH3BsfpqiWAzQ1jBsWbz4gv0RB9ZKFdhOffsrZd8ie1pm/JMowx9vBoe
         p9SL6WKRxyO/MW4GzsJ6Os28Jh7bUcYbVlY7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmEtnM6LL3v8oe+GjznXIcjlNfbK8VrtV5UJVApAZhs=;
        b=QwFkc8/rRjXP5in1MR4prPDeUWXMgCNLRSdWEGJP16mwynHF4yxseTNf/o3l58LFiH
         /lGfuLhboaF3YEFbESSJ5SmvScXxqhnDvLyIPQtMtl7hfq6YZ+WLtbTCA6NMcXLaRUg/
         Bk47EJf0eBdDzTUhVoKfJOoJlnOHJSXvsZ6kPb3KkF1BR2qLgqlBNCi8r5kTGwwNc5ie
         zToV9n1EdFdODe8HdTbtlyAz9qf7Ivq9r54uLyc9YXQXLKzfSLOxH8HB0BVeN+Ps3eA4
         EyXMMW15uylFHOnfck/1RhKgODbuJ/+gTwG5QYgRKDL9e70hR1O1lxJtUboo0JuFNo3G
         bEBw==
X-Gm-Message-State: AOAM531X2bGNlfbqap6ZwB9nFBNLTk5WJLZ59V4JCATrZB+sgbFhz2cf
        CH9LtQ5++Jjte3k51p8vNrG662aqRcHeT4Fx+GeVSD17qHLcw93I
X-Google-Smtp-Source: ABdhPJy5jYTPSzkzfUEZc34DWLx2tmgsaYalytJr5xkAmOEzisHGtcNmv1rY6pJBnLabpMs6RG3joSKpoKkE2RGXteA=
X-Received: by 2002:a37:c0d:: with SMTP id 13mr5344334qkm.275.1611078187584;
 Tue, 19 Jan 2021 09:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20210119144251.27924-1-jacob@gitlab.com> <20210119144251.27924-2-jacob@gitlab.com>
 <YAcE/dTuOB9PbGQU@nand.local>
In-Reply-To: <YAcE/dTuOB9PbGQU@nand.local>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Tue, 19 Jan 2021 18:42:56 +0100
Message-ID: <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
Subject: Re: [PATCH 1/1] ls-refs.c: minimize number of refs visited
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

Thanks for your reply. That sounds like a great idea!

On Tue, Jan 19, 2021 at 5:12 PM Taylor Blau <me@ttaylorr.com> wrote:
> But, I think that we could get pretty far by treating the prefixes as
> refs so that we can call ref-filter.c:find_longest_prefixes(). For its
> purposes, it doesn't really care about whether or not the arguments
> actually are references. It simply returns the longest common prefix
> among all of its arguments (delimited by '/' characters).

What does "delimited by /" mean?

Without really understanding the longest common prefix code in
ref-filter.c, my intuitive concern is that the specifics of glob
matching and special treatment of '/' may bite us. I suppose we'll be
fine because ls-refs has its own matching logic. So long as
for_each_fullref_in_prefixes yield enough prefixes, the end result
would remain the same.

The question is then, does for_each_fullref_in_prefixes yield
everything we need?

I think my approach would be to expose the new
for_each_fullref_in_prefixes iterator you propose through test-tool,
and unit test it so we can be sure it handles both contexts
(for-each-refs with globs and special '/', and ls-refs without any
special character behavior) correctly.

I may be overly cautious here, take this with a grain of salt because
I am not an experienced Git contributor. On that topic, apologies if
I'm botching my inline replies in this email.

Regarding your patch: it works correctly and as fast as expected for
my development "many refs" test case. Yay! It also segfaults and fails
some tests but see my comments below.

All in all: thanks, great idea, yes we should reuse, I only lack
confidence on correctness because I don't fully grasp your
longest-common-prefix algorithm yet.

Cheers, Jacob


> --- >8 ---
>
> Subject: [PATCH] ls-refs: iterate longest common refs prefix
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ls-refs.c    |  4 +++-
>  ref-filter.c | 46 ++++++++++++++++++++++++++++++++--------------
>  ref-filter.h | 10 ++++++++++
>  3 files changed, 45 insertions(+), 15 deletions(-)
>
> diff --git a/ls-refs.c b/ls-refs.c
> index a1e0b473e4..6a3e11d45c 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -6,6 +6,7 @@
>  #include "ls-refs.h"
>  #include "pkt-line.h"
>  #include "config.h"
> +#include "ref-filter.h"
>
>  /*
>   * Check if one of the prefixes is a prefix of the ref.
> @@ -109,7 +110,8 @@ int ls_refs(struct repository *r, struct strvec *keys,
>                 die(_("expected flush after ls-refs arguments"));
>
>         head_ref_namespaced(send_ref, &data);
> -       for_each_namespaced_ref(send_ref, &data);
> +       for_each_fullref_in_prefixes(get_git_namespace(), data.prefixes.v,
> +                                    send_ref, &data, 0);

Remember to add that strvec_init(&data.prefixes) I talked about in my
commit message, or you get a segfault.

You also need:  if (!data.prefixes.nr) strvec_push(&data.prefixes, "refs/");

Without it, the "ls-refs without ref-prefix" scenario fails.

>         packet_flush(1);
>         strvec_clear(&data.prefixes);
>         return 0;
> diff --git a/ref-filter.c b/ref-filter.c
> index aa260bfd09..c34bf34d06 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1987,6 +1987,36 @@ static void find_longest_prefixes(struct string_list *out,
>         strbuf_release(&prefix);
>  }
>
> +int for_each_fullref_in_prefixes(const char *namespace,
> +                                const char **patterns,
> +                                each_ref_fn cb,
> +                                void *cb_data,
> +                                int broken)
> +{
> +       struct string_list prefixes = STRING_LIST_INIT_DUP;
> +       struct string_list_item *prefix;
> +       struct strbuf buf = STRBUF_INIT;
> +       int ret = 0, namespace_len;
> +
> +       find_longest_prefixes(&prefixes, patterns);
> +
> +       if (namespace)
> +               strbuf_addstr(&buf, namespace);
> +       namespace_len = buf.len;
> +
> +       for_each_string_list_item(prefix, &prefixes) {
> +               strbuf_addf(&buf, prefix->string);

Missing format string "%s".


> +               ret = for_each_fullref_in(buf.buf, cb, cb_data, broken);
> +               if (ret)
> +                       break;
> +               strbuf_setlen(&buf, namespace_len);
> +       }
> +
> +       string_list_clear(&prefixes, 0);
> +       strbuf_release(&buf);
> +       return ret;
> +}
> +
>  /*
>   * This is the same as for_each_fullref_in(), but it tries to iterate
>   * only over the patterns we'll care about. Note that it _doesn't_ do a full
> @@ -1997,10 +2027,6 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
>                                        void *cb_data,
>                                        int broken)
>  {
> -       struct string_list prefixes = STRING_LIST_INIT_DUP;
> -       struct string_list_item *prefix;
> -       int ret;
> -
>         if (!filter->match_as_path) {
>                 /*
>                  * in this case, the patterns are applied after
> @@ -2024,16 +2050,8 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
>                 return for_each_fullref_in("", cb, cb_data, broken);
>         }
>
> -       find_longest_prefixes(&prefixes, filter->name_patterns);
> -
> -       for_each_string_list_item(prefix, &prefixes) {
> -               ret = for_each_fullref_in(prefix->string, cb, cb_data, broken);
> -               if (ret)
> -                       break;
> -       }
> -
> -       string_list_clear(&prefixes, 0);
> -       return ret;
> +       return for_each_fullref_in_prefixes(NULL, filter->name_patterns,
> +                                           cb, cb_data, broken);
>  }
>
>  /*
> diff --git a/ref-filter.h b/ref-filter.h
> index feaef4a8fd..f666a0fb49 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -146,4 +146,14 @@ struct ref_array_item *ref_array_push(struct ref_array *array,
>                                       const char *refname,
>                                       const struct object_id *oid);
>
> +/**
> + * iterate all refs which descend from the longest common prefix among
> + * "patterns".
> + */
> +int for_each_fullref_in_prefixes(const char *namespace,
> +                                const char **patterns,
> +                                each_ref_fn cb,
> +                                void *cb_data,
> +                                int broken);
> +
>  #endif /*  REF_FILTER_H  */
> --
> 2.30.0.138.g6d7191ea01
>
