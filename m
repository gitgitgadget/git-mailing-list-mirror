Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E51C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 19:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhL1ThS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 14:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhL1ThP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 14:37:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B166DC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:37:14 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o6so77576948edc.4
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sp3/xq3s3ncTuq1vRJo+M3jxJ5lqX3/hG/yl/PdKPZc=;
        b=cBDyMD45upWFF671t8sD2ro1FCUw7/aMrqOWlvxHWMZh299g4I3bUffI5WPqk/vvKf
         HlZTkutSlAacJj5QfJdeU5kNww5jkSvIb0RI5985Iw/yEuEvDmddnoGaejvkFtkt+xeP
         VeArOmsKJ+u7iFlrg3Nftl24E+cLbgGBLtOe4mk+mkkgaZYuDsr/TTZru06DxNG0Udlg
         J8QvaNuaJpQb6crMtRohctI2C3LUAEghyudspKqK7T0raPjks3R7dMzs7mHPe9feUX2E
         pskZds3faGKVcDzf+E4rR780JTV7e1AWZhr8q3dkDpaDAO05TA0BdesiBphHDi4KA6LA
         uLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sp3/xq3s3ncTuq1vRJo+M3jxJ5lqX3/hG/yl/PdKPZc=;
        b=zSZQQrfVRCXnvEpjMXCeYZ4dFJchYF7oofx/3MThSQs1/SfgAa8ZFEChWo9R4VknPo
         GUdfL3d1ijkl71AGWlYozEhjbQZvwl5+y4l26WiPHnM+DvsvfwvhH4/nvJ03Q/I9IqoW
         d5g0FnkI4GIMbvgZwCiGhAlFTp57MxTBbrmvWWBq4eD6953lcylIwWqxXpZz/epqUpNZ
         Npdx80W0U8kvCh0Ls6Z21+4ppbgNZNnHzp3hhm8akfLqnqey9gUsEOqjb8HCFWaWGQRd
         PkQ2WmiFSK+G83/S2zqv0rqaICjX6GYYb2juS8NtDQAou8646WgGBocdK8FsNKVXKuL0
         H6sw==
X-Gm-Message-State: AOAM530hgcgqcXq4gNfo3uFQgN+uA02XSyI4fAHHnU1FfmRLLGC44GKw
        z8/yfQcSMaksQSnnoWN7Hs8A+p+WEfDW/haUAoHpn4+hTs+eSw==
X-Google-Smtp-Source: ABdhPJxTdfv79IBqERR16KpIImRrZkEr+nTM3rmtb8KEqOFwmYm+OBrmNxCddrr3Z3YuuVJlACuyFuC9oXCoeqItp1k=
X-Received: by 2002:a17:907:60c8:: with SMTP id hv8mr18285000ejc.192.1640720233205;
 Tue, 28 Dec 2021 11:37:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com> <d5566f5d13605f30be6fd221fc624479cbbd0392.1640419159.git.gitgitgadget@gmail.com>
 <20211228105614.qzmm3hglabtlcsx4@gmail.com>
In-Reply-To: <20211228105614.qzmm3hglabtlcsx4@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Dec 2021 11:37:01 -0800
Message-ID: <CABPp-BFONtGb5TYUAe2jazuRgKWMsvSJTxSnxrEPM9OYq68Wow@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] ll-merge: make callers responsible for showing warnings
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 2:56 AM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> On Sat, Dec 25, 2021 at 07:59:14AM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Since some callers may want to send warning messages to somewhere other
> > than stdout/stderr, stop printing "warning: Cannot merge binary files"
> > from ll-merge and instead modify the return status of ll_merge() to
> > indicate when a merge of binary files has occurred.
> >
> > This commit continues printing the message as-is; future changes will
> > start handling the new commit differently in the merge-ort codepath.
>
> "the new commit" looks like a typo, do you mean "binary conflicts"?

Good catch, yeah should be "the binary conflicts message"

> >
> > Note that my methodology included first modifying ll_merge() to return
> > a struct, so that the compiler would catch all the callers for me and
> > ensure I had modified all of them.  After modifying all of them, I then
> > changed the struct to an enum.
>
> Heh, this is a clever way to work around C's weak typing.
>
> The language server I'm using (clangd) supports the Call Hierarchy feature,
> which is intended to list callers or callees of the function at the editor's
> cursor. If I ask the server for callers of ll_merge I get this response
> (on 510f9eba9 plus this series)
>
>         ll-merge.h:98:1: ll_merge - list of callers
>           builtin/checkout.c:242:12: checkout_merged
>             builtin/checkout.c:279:17:  merge_status = ll_merge(&result_buf, path, &ancestor, "base",
>           rerere.c:943:12: handle_cache
>             rerere.c:984:2:     ll_merge(&result, path, &mmfile[0], NULL,
>           notes-merge.c:342:12: ll_merge_in_worktree
>             notes-merge.c:353:11:       status = ll_merge(&result_buf, oid_to_hex(&p->obj), &base, NULL,
>           merge-recursive.c:1035:12: merge_3way
>             merge-recursive.c:1090:17:  merge_status = ll_merge(result_buf, a->path, &orig, base,
>           merge-ort.c:1763:12: merge_3way
>             merge-ort.c:1816:17:        merge_status = ll_merge(result_buf, path, &orig, base,
>           merge-blobs.c:32:14: three_way_filemerge
>             merge-blobs.c:48:17:        merge_status = ll_merge(&res, path, base, NULL,
>           apply.c:3491:12: three_way_merge
>             apply.c:3511:11:    status = ll_merge(&result, path,
>           rerere.c:608:12: try_merge
>             rerere.c:623:9:             ret = ll_merge(result, path, &base, NULL, cur, "", &other, "",
>
> So there are 8 callers in total; but only 7 print the warning (including the
> one in merge-ort which will change in the next commit). I think you missed
> the call at rerere.c:984 because we ignore its return value.

Doh, I missed one!  Though, as pointed out by Junio, rerere won't
operate on binary files and thus can't hit that codepath.  Still, I
should either have it in both rerere codepaths or neither.

> > @@ -133,10 +133,12 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
> >       xmp.ancestor = orig_name;
> >       xmp.file1 = name1;
> >       xmp.file2 = name2;
> > -     return xdl_merge(orig, src1, src2, &xmp, result);
> > +     status = xdl_merge(orig, src1, src2, &xmp, result);
> > +     ret = (status > 1 ) ? LL_MERGE_CONFLICT : status;
>
> " (status > 1 )" has an extra space
>
> I'm not sure it's wise to handle status=1 and status=2 in two different code paths.
> Both mean the same (the only difference is the number of conflicts).
> status=1 coincides with LL_MERGE_CONFLICT but that's purely coincidental
>
>         ret = (status > 0) ? LL_MERGE_CONFLICT : status;

Um, whoops.  Yeah, this should be > 0, not > 1.  (As per
xdl_do_merge() comment, status >= 0 means status returns the number of
conflicts)  No clue how I messed that up so badly; kind of
embarrassing, honestly.

Thanks for the careful reading.

> > @@ -236,7 +239,8 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
> >               unlink_or_warn(temp[i]);
> >       strbuf_release(&cmd);
> >       strbuf_release(&path_sq);
> > -     return status;
> > +     ret = (status > 1) ? LL_MERGE_CONFLICT : status;
>
> same here, I'd test for "status > 0" because that's the convention for
> external programs

Yep.

...
> > diff --git a/rerere.c b/rerere.c
> > index d83d58df4fb..b1f8961ed9e 100644
> > --- a/rerere.c
> > +++ b/rerere.c
> > @@ -609,19 +609,23 @@ static int try_merge(struct index_state *istate,
> >                    const struct rerere_id *id, const char *path,
> >                    mmfile_t *cur, mmbuffer_t *result)
> >  {
> > -     int ret;
> > +     enum ll_merge_result ret;
> >       mmfile_t base = {NULL, 0}, other = {NULL, 0};
> >
> >       if (read_mmfile(&base, rerere_path(id, "preimage")) ||
> > -         read_mmfile(&other, rerere_path(id, "postimage")))
> > -             ret = 1;
> > -     else
> > +         read_mmfile(&other, rerere_path(id, "postimage"))) {
> > +             ret = LL_MERGE_CONFLICT;
> > +     } else {
> >               /*
> >                * A three-way merge. Note that this honors user-customizable
> >                * low-level merge driver settings.
> >                */
> >               ret = ll_merge(result, path, &base, NULL, cur, "", &other, "",
> >                              istate, NULL);
> > +             if (ret == LL_MERGE_BINARY_CONFLICT)
> > +                     warning("Cannot merge binary files: %s (%s vs. %s)",
> > +                             path, "", "");
>
> With the next patch, 7/8 callers of ll_merge (almost) immediately print
> that warning.  Looks fine as is, but does it make sense to introduce a helper
> function for the common case, or add a flag to ll_merge_options?

I started by adding a flag, and Peff suggested not doing so (because
the printing doesn't belong in a "low-level" merge, as ll_merge stands
for[1]), but instead making the callers responsible.  We could add a
helper function, outside of ll-merge.[ch], but I'm not sure where to
put it or what to call it and I'm leaning towards just leaving things
as-is (well, other than fixing up the important issues you brought up
before this).

[1] https://lore.kernel.org/git/YVOZRhWttzF18Xql@coredump.intra.peff.net/
