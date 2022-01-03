Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C88C433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 19:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiACTrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 14:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiACTrG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 14:47:06 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74FC061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 11:47:06 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u25so18449422edf.1
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 11:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5FExhCYTTPTdxpf+htqrhjwDXOncp8coz1Xhc9kLVQ=;
        b=geEp0tSXAHUPePGP20UKXiQw8RTrGvAa8OZ1s7lf65HexIX2wITDLyitOtQMc2DOt1
         VsFGgA0DVoepVwsy7Le2bDS6zmatHo3u1MhT3PtFI9gyd/CMaYYsiIJgMcpJDJUWFAZH
         1vVA3bcXIMhpkA94TShvKmHajp5dQg+LfDPfyIkF5sssZ9IqZAM3e7bKsNDiC73D1Pyb
         IgGb34uC09lB9Bdn6GxP+my6vKOk0CESpOuHsHPtU333SMyUbLBRiDjTAfGvL1+EpW0V
         V0gjGybV5rTaj4JwXL4RgOJ33mWz1UwJRqtsQz1Vo/B6NX98MFIyry/QtUpHauXGzUD+
         OEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5FExhCYTTPTdxpf+htqrhjwDXOncp8coz1Xhc9kLVQ=;
        b=tozn+NsbR6g9nC0b4Zgf46xuMTEapFIYRGBQtXp68L5c75N4PQYaLoe/HzX5eR5r37
         BspcTRJ0Hku+/one3Bu7vR2RzGRh5tQXAKh3UFe8nhnj+p/osm3LEnfn3OyAuJ7pN1nT
         z/cAD2QcRfUuFaaW0SnyKSSgbAr8DLWjB0eWo0OTiAQRuXeKGJi3DS1BBEOqS3QPr3S8
         K04HFCO5hZunu/AUK1uHICAe8OY+MZxPfWQrNGyUZq6gEkYNPDRt0gcB27lN2rWf1Wct
         /ERWEbRZgJr9rXewlhtQZh35XQo69t7H0hBdCO/Rca2E8vgJZRfVP+AJaNd5+zkMBKsb
         vl5Q==
X-Gm-Message-State: AOAM532WcPKZJjGrEqGQnXoNS9qxYBnPQDatRVSEXnVmWaLA17XF3HoE
        IwkM7v6HIhdQkL7/EzvAnUqEuV7BdS8Qk+4TmFBsUgseEmt75Q==
X-Google-Smtp-Source: ABdhPJzxeSjcTC7bsQ324OO4EqUP+RcTRG22Wezg4N28HQNBlaBKFcGgEuVQGt+jo2Doy99vPHp49WmR844Cgu65yRE=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr36313281ejc.269.1641239224937;
 Mon, 03 Jan 2022 11:47:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <777de92d9f166793cddbb383f497518a5dedb9f4.1640927044.git.gitgitgadget@gmail.com>
 <20220103123114.uuvpk4nley22gfkg@fs> <CABPp-BH4okfDXVC418HwfHVR2_NtbKFBOfyYGZ9mWnABMzSruw@mail.gmail.com>
 <20220103172255.54psh2e5iqzd37sy@fs>
In-Reply-To: <20220103172255.54psh2e5iqzd37sy@fs>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Jan 2022 11:46:53 -0800
Message-ID: <CABPp-BEneaLnaTVo-Yb7fooLK8sQsDq_MdeBu-R2EporqCSqoQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] merge-tree: support saving merge messages to a
 separate file
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 3, 2022 at 9:23 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>
> On 03.01.2022 08:51, Elijah Newren wrote:
> >On Mon, Jan 3, 2022 at 4:31 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> >>
> >> On 31.12.2021 05:04, Elijah Newren via GitGitGadget wrote:
> >> >From: Elijah Newren <newren@gmail.com>
> [...]
> >> >
> >> > static int real_merge(struct merge_tree_options *o,
> >> >@@ -442,8 +443,15 @@ static int real_merge(struct merge_tree_options *o,
> >> >        */
> >> >
> >> >       merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> >> >+
> >> >+      if (o->messages_file) {
> >> >+              FILE *fp = xfopen(o->messages_file, "w");
> >> >+              merge_display_update_messages(&opt, &result, fp);
> >> >+              fclose(fp);
> >>
> >> I don't know enough about how merge-ort works internally, but it looks to me
> >> like at this point the merge already happened and we just didn't clean up
> >> (finalize) yet. It feels wrong to die() at this point just because we can't
> >> open messages_file.
> >
> >Yes, the merge already happened; there now exists a new toplevel tree
> >(that nothing references).  I'm not sure I understand what's wrong
> >with die'ing here, though.  I can't tell if you want to defer the
> >die-ing until later, or just avoid the die-ing and return some kind of
> >success despite failing to complete what the user requested.
> >
>
> I think i would prefer the merge operation to abort before actually merging
> when not being able to write its logfile. Otherwise we possibly do a whole
> lot of work that`s inaccessible afterwards isn't it? (since we don`t print
> the hash)

I see where you're coming from, but I don't see this as worth worrying
about.  For two reasons:

(1) I'm not sure I buy the "whole lot of work" concern.

merge-ort is pretty snappy.  For a simple example of rebasing a single
patch in linux.git across a branch with 28000 renames, I get 176
milliseconds for merge_incore_nonrecursive().  Granted, linux.git is
pretty small in terms of number of files, but Stolee did some
measurements a while back on the Microsoft repos with millions of
files at HEAD.  For those, for a trivial merge he saw
merge_incore_recursive() complete in 2 milliseconds, and for a trivial
rebase he saw merge_incore_nonrecursive() complete in 4 milliseconds
(See https://lore.kernel.org/git/CABPp-BHO7bZ3H7A=E9TudhvBoNfwPvRiDMm8S9kq3mYeSXrpXw@mail.gmail.com/).
So huge numbers of files pose much less of a problem than lots of
interesting work like renames, and merge-ort is pretty fast in either
case.  Sure, if we were talking about traditional merge-recursive
which would have taken 150000 milliseconds on the same single patch in
linux.git testcase (due to the 28000 renames), then we might worry
more about not letting work get tossed, but at only 176 milliseconds
even with a crazy number of renames, it's just not worth worrying
about.

(2) Even if there is a lot of computation, I don't see why this error
path merits extra coding work to salvage the computation somehow

By way of comparison, a regular `git merge` will abort after
completing the same amount of merge work (i.e. after creating a new
tree) when the user has a dirty working tree involving a path that
would need to be updated by the merge operation.  And that is not a
bug; it's a requirement -- we cannot first check if the user has
dirtied such a path before performing the merge because it's
impossible to do so accurately in the face of renames.
merge-recursive tried to do that and had early aborts that fell in the
false-positive category and some that fell in the false-negative
category.  It was impossible to fix the false-positives and
false-negatives without either (a) disallowing ever doing a merge with
a dirty working tree under any conditions (a backwards compatibility
break), or (b) waiting to do the notification of
dirty-files-in-the-way until after the merge tree has been computed.
I wasn't about to break that feature, so merge-ort had to delay error
notifications instead.

Now, the dirty-file-in-the-way condition is for a very common case
(either for users who intentionally like keeping dirty changes around
and doing merges but the branch they are merging happens to touch a
file they didn't know about, or users who just forgot that they had
local modifications).  In contrast, this case here is for when we
cannot open a file for writing -- with the filename explicitly just
specified by the user.


So, I'd rather keep the code nice and simple as it currently stands.

> Thanks for your work on this feature. I think this could open a lot of new
> possibilities.

I hope people do interesting things with it, and with the server-side
commit replaying I'm working on as well.
