Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0458BC433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 01:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbhKUBuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 20:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbhKUBuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 20:50:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF03C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 17:47:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z5so60112889edd.3
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 17:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GewRFc5iFEG5JUFkGRQPoj2JsSBTse3xJ1gZEbZH//E=;
        b=WoXM52qgyGrOwRl0cn4mXzaHLf993Hb+x3SS8D2lilYCGWSypCc3YYrPI+z0Di0Qyy
         HDL/h3OPOS/6oVDhrllvY/eoexh2U2Hd5vQCtDWLXm3PqGDjIbQhj0qvSTztIf4aYbkD
         iCI/Jklo0diopOE5eOzJAGTADrhY6wsRTiwtnzZ3JNRNAAXOe6eOOsxCb+hsSxGe7g2/
         IZPT0eIB3iplKZTdGmdwLH0mIZCyL2yKSjdp2R5hyNnpccvoKVEHAe3BEsJmId76VhgH
         Omzd0ziAk4FTxvdO4IeZ6b0NpMsnkJSgW4EHF+odvGgRrv0mYP3K9SEBu8tGqAt2imAC
         hK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GewRFc5iFEG5JUFkGRQPoj2JsSBTse3xJ1gZEbZH//E=;
        b=NEAak5bh/zDH5D9bjiGkAFXYH5juJIICkmZYN3Xqpqf9FhcwiIWCIF8RWjfPxcZKkV
         Sg+ZUOhr5qvyQMOI3eMEdKRdUdYswtjZQnUCVXISmjclOYyF2BGCScW4K87UjOLw/oTB
         3DRHxHA5qNcSYRMymfQ3HCXQIoC7daGOHk02p7u/fZpUp/ou/q5AtVjj9NAxgjESnu4e
         aP6A+uzzPAuy7c5yzt6dlAHbY3rSjleClA00Swcp9QgCkp8pSlb5bC8mpXOpCUt9PKSi
         CpKuixdKHImdbGDWhDDc+KcCtxFXBfh5fPf56VKUtR2ivwZQq5NK7L0NlSzdKR78hCN3
         nY7w==
X-Gm-Message-State: AOAM532gw7OHmAug28cF8HrS69q9vYVIZrFYqnc29cuNNQrQ6S4Xf/vi
        ufhh6hFrdhb4WqTLsoOTs4940+rgvnlxV3WJdqo=
X-Google-Smtp-Source: ABdhPJwZIhwXUa7+92YGMHYnlR/97KCzbjj1KMygyBH0t9y6aVA96h3mHLr+jmqiyhkvgdMkRNm2xY2sMGtNl74ZGZ0=
X-Received: by 2002:a17:906:3a4a:: with SMTP id a10mr14710667ejf.253.1637459223814;
 Sat, 20 Nov 2021 17:47:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
 <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com> <cfdd33129ec6860cbec0cb20302598429db1115e.1635802069.git.gitgitgadget@gmail.com>
 <xmqqh7ct89us.fsf@gitster.g>
In-Reply-To: <xmqqh7ct89us.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Nov 2021 17:46:52 -0800
Message-ID: <CABPp-BH2O+fezCui0utYbpShp6NaMwWapyr8i+mDDjjhzec4LQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] blame: enable and test the sparse index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 3, 2021 at 9:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > We do not include paths outside the sparse checkout cone because blame
> > currently does not support blaming files outside of the sparse definition.
> > Attempting to do so fails with the following error:
> >
> >   fatal: no such path '<path outside sparse definition>' in HEAD
>
> Does this indicate that we need to update how the command line
> safety in verify_working_tree_path() works in a sparsely checked out
> working tree?

I wondered the same thing, but no I don't think we need any extra
command line safety here.  The behavior Lessley is reporting here is
equivalent to the following in a regular (non-sparse) checkout:

$ rm t/test-lib.sh
$ git blame t/test-lib.sh
fatal: Cannot lstat 't/test-lib.sh': No such file or directory
$ git blame -- t/test-lib.sh
fatal: Cannot lstat 't/test-lib.sh': No such file or directory

blame without a revision has always failed for files not in the
working tree, regardless of whether those files are found in the index
or HEAD.

>  If foo/bar is outside the sparse definition,
>
>     git blame HEAD foo/bar

Actually, that works; there's no error and the code with Lessley's
patch will show the blame info for foo/bar (assuming foo/bar was a
path in HEAD, of course).

> may get such a message, but shouldn't
>
>     git blame HEAD -- foo/bar
>
> make it work?

This also works.  But both of these things are kind of testing
something different; when given a revision, the checkout is irrelevant
to git blame: git blame with a revision will work regardless of
whether the checkout is full, sparse, completely empty, or
non-existent (i.e. a bare clone).

> > -# TODO: blame currently does not support blaming files outside of the
> > -# sparse definition. It complains that the file doesn't exist locally.
> > -test_expect_failure 'blame with pathspec outside sparse definition' '
> > +# Blame does not support blaming files outside of the sparse
> > +# definition, so we verify this scenario.
>
> IOW, why is it a good idea to drop the "TODO" and "currently" and pretend
> as if the current behaviour is the desirable one?

I think dropping the TODO is correct, but the wording is confusing --
it has nothing to do with sparse checkouts.  I'd rather say, "Without
a specified revision, blame will only handle files present in the
current working directory and error on any other paths"

> > +test_expect_success 'blame with pathspec outside sparse definition' '
> >       init_repos &&
> > +     test_sparse_match git sparse-checkout set &&
> >
> > -     test_all_match git blame folder1/a &&
> > -     test_all_match git blame folder2/a &&
> > -     test_all_match git blame deep/deeper2/a &&
> > -     test_all_match git blame deep/deeper2/deepest/a
> > +     for file in a \
> > +                     deep/a \
> > +                     deep/deeper1/a \
> > +                     deep/deeper1/deepest/a
> > +     do
> > +             test_sparse_match test_must_fail git blame $file &&
> > +             cat >expect <<-EOF &&
> > +             fatal: Cannot lstat '"'"'$file'"'"': No such file or directory
> > +             EOF
> > +             # We compare sparse-checkout-err and sparse-index-err in
> > +             # `test_sparse_match`. Given we know they are the same, we
> > +             # only check the content of sparse-index-err here.
> > +             test_cmp expect sparse-index-err
> > +     done
> >  '
> >
> >  test_expect_success 'checkout and reset (mixed)' '
> > @@ -878,6 +892,18 @@ test_expect_success 'sparse index is not expanded: diff' '
> >       ensure_not_expanded diff --staged
> >  '
> >
> > +test_expect_success 'sparse index is not expanded: blame' '
> > +     init_repos &&
> > +
> > +     for file in a \
> > +                     deep/a \
> > +                     deep/deeper1/a \
> > +                     deep/deeper1/deepest/a
> > +     do
> > +             ensure_not_expanded blame $file
> > +     done
> > +'
> > +
> >  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
> >  # in this scenario, but it shouldn't.
> >  test_expect_success 'reset mixed and checkout orphan' '
