Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B8CC433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 00:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbiBTAiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 19:38:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiBTAiX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 19:38:23 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B70754F8C
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 16:38:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z22so22096975edd.1
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 16:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VH0nNv6Rwoj+ZmEvpYVo579NRSjQOPtF3+TQeWnxFLw=;
        b=qQ1JQJUSHgM0l9hLmBAAxR+2aDtHpeMu24hjwy2w/ZAXrJ9XSYlcm0DlxyRIbJEKQS
         DUG60S3UY68NlIlHi1JbMz1KlitpCezaVV9koEn8PYgixVDacfna6pSwUXgFiSLs+FCZ
         fNTDVsOtSOiZNNRprCrVmA6hAhXWTkGMKN7xeulfih1t6Tsn9ZgpuVXBWJz1ZuY8OWjX
         9/KXdfJ64o8CjawIS9FrLRddCHVVSw6FdEbcg9LQT9JrfvNx87itf6bdF/GeFQUrFBrk
         cqXnO13LRfiX5fwWr7NMemb7RQmvhKQwGZG29xx1OkludT5H8GBRI/SxWJNnELc2gNpI
         y7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VH0nNv6Rwoj+ZmEvpYVo579NRSjQOPtF3+TQeWnxFLw=;
        b=TspyWcPT/fh+cLxpyyyZMKt8jVcOJqcU7dk5jJS8g2CuTp2r+9iUHm3eWeqd8uUTkA
         3ajdyZGtixgeCHDIcR9T4SIvCSIAu6u4FvH0tWcNPUy19qZRkk7MgZDuuJfXfgYOTt9h
         /Sk0xGG/Xg0rvYjR1840xbJmC99v5cXLS5stxZaA0qO7uwKKs1CCYsDyFUhCItWag5SI
         JUkzoFCdfapI/ltERgXe3s6LsPCplQWxUEb+q/P7lKR1vWc1u/x+BP7JP49pKPra5xMo
         wPLOoDyRounFi1qk5tELTpeML6u8NkwHIy/2ZTZraJIIAE5VUek4KaZr4tDx8JAWdKj4
         tXEw==
X-Gm-Message-State: AOAM532m4eony8EQ13laSYfYRxwxeDxN/zkbg4TNsWE5iQhvuBqwMANY
        VA8jDBvC6q8ZWW4jJPCpg3Frl9KDa1mfarJLbss=
X-Google-Smtp-Source: ABdhPJzyTbxQNXaHAhvevQp/OOLKjkI8dVIzWTB1KAAkF/6tcfINwCRZUcaHlWQ8noCadxt50KR0VPbN4eD2t0kfb9s=
X-Received: by 2002:aa7:c04e:0:b0:400:4daf:bab1 with SMTP id
 k14-20020aa7c04e000000b004004dafbab1mr14814033edo.101.1645317482111; Sat, 19
 Feb 2022 16:38:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
 <73bc1e5c5dffbe9c132ea786dd414ef2159967e3.1645290601.git.gitgitgadget@gmail.com>
 <220219.86o832cwup.gmgdl@evledraar.gmail.com>
In-Reply-To: <220219.86o832cwup.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 19 Feb 2022 16:37:50 -0800
Message-ID: <CABPp-BEpSEmndTHOLrdTGmcf_+5uoR6_7fy58KXXktV4tcTXpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] merge-ort: fix small memory leak in unique_path()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 19, 2022 at 2:31 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Feb 19 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > The struct strmap paths member of merge_options_internal is perhaps the
> > most central data structure to all of merge-ort.  Because all the paths
> > involved in the merge need to be kept until the merge is complete, this
> > "paths" data structure traditionally took responsibility for owning all
> > the allocated paths.  When the merge is over, those paths were free()d
> > as part of free()ing this strmap.
> >
> > In commit 6697ee01b5d3 (merge-ort: switch our strmaps over to using
> > memory pools, 2021-07-30), we changed the allocations for pathnames to
> > come from a memory pool.  That meant the ownership changed slightly;
> > there were no individual free() calls to make, instead the memory pool
> > owned all those paths and they were free()d all at once.
> >
> > Unfortunately unique_path() was written presuming the pre-memory-pool
> > model, and allocated a path on the heap and left it in the strmap for
> > later free()ing.  Modify it to return a path allocated from the memory
> > pool instead.
>
> This seems like a rather obvious fix to the leak, as the other side
> wasn't ready to have the detached strbuf handed to it, and instead is
> assuming everything is mempools.
>
> The downside is a bit of heap churn here since you malloc() & use the
> strbuf just to ask for that size from the mempool, and then free() the
> strbuf (of course we had that before, we just weren't free-ing).
>
> So this is just an aside & I have no idea if it's worth it, but FWIW you
> can have your cake & eat it too here memory-allocation wise and avoid
> the strbuf allocation entirely, and just use your mem-pool.
>
> Like this:
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 40ae4dc4e92..1111916d5cb 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -731,6 +731,16 @@ static char *unique_path(struct merge_options *opt,
>         int suffix =3D 0;
>         size_t base_len;
>         struct strmap *existing_paths =3D &opt->priv->paths;
> +       /*
> +        * pre-size path + ~ + branch + _%d + "\0". Hopefully 6 digits
> +        * of suffix is enough for everyone?
> +        */
> +       const size_t max_suffix =3D 6;
> +       const size_t expected_len =3D strlen(path) + 1 + strlen(branch) +=
 1 +
> +               max_suffix + 1;
> +
> +       ret =3D mem_pool_alloc(&opt->priv->pool, expected_len);
> +       strbuf_attach(&newpath, ret, 0, expected_len);
>
>         strbuf_addf(&newpath, "%s~", path);
>         add_flattened_path(&newpath, branch);
> @@ -741,10 +751,10 @@ static char *unique_path(struct merge_options *opt,
>                 strbuf_addf(&newpath, "_%d", suffix++);
>         }
>
> -       /* Track the new path in our memory pool */
> -       ret =3D mem_pool_alloc(&opt->priv->pool, newpath.len + 1);
> -       memcpy(ret, newpath.buf, newpath.len + 1);
> -       strbuf_release(&newpath);
> +       if (newpath.alloc > expected_len)
> +               BUG("we assumed too much thinking '%s~%s' would fit in %l=
u, ended up %lu ('%s')",
> +                   path, branch, expected_len, newpath.alloc, newpath.bu=
f);
> +
>         return ret;
>  }
>
>
> A bit nasty for sure, but if you're willing to BUG() out if we ever go
> above 999999 suffix tries or whatever (which would be trivial to add to
> the loop there) it's rather straightforward.
>
> I.e. we know the size of the buffer ahead of time, except for that loop
> that'll add "_%d" to the end, and that can be made bounded.
>
> Obviously your solution's a lot simpler, so I think this is only
> something you should consider if you think it matters for the
> performance numbers linked to from 6697ee01b5d3. I'm not familiar enough
> with merge-ort.c to know if it is in this case, or if this would be
> pointless micro-optimization on a non-hot codepath.

That's an interesting idea, but it's a micro-optimization on a very
cold path.  You need to either have a D/F conflict that persists or a
mode-type conflict (e.g. an add/add conflict with symlink vs. file
types).  Those tend to be quite rare; in fact, the testcase with the
performance numbers in 6697ee01b5d3 didn't have any of these and never
even triggered this codepath (otherwise I would have caught the leak
in my earlier leak testing).  So I think simple and robust makes more
sense here.
