Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3793CC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 16:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbiBYQeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243009AbiBYQeH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 11:34:07 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A09F11B5DF
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:33:35 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z15so5118816pfe.7
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1OpyTbTObG2pTmUXHKL+6aOv1Z/jJJrzQQT6SMvPg0s=;
        b=oWYm7OiktNEp7vu3g3LReLjv9V4Jq8jwbygUiO+RnSLnj/l8SlQkQ/5TUnIgoo/oWv
         zndjlNsP5iGr6rVxeGLAQNWq3I9BRIy/7K2bfMqTJBLM9L+yXVSqIuRcvsr+5/+jf9zc
         TdlQLZgVkWXI1FGBOHRSqi72voRGQ4YO9yhC76jRqqn72yXjWihJdiwtlzYZANFamvVF
         X15gj0gK2BJfuaQt/PLFeLl1DFpfx65DOQ8Re1ozAdTiRifP42YzMK6xup7SAocpCwy5
         NefTDbaAXEkegKgaPXTF8bfnAligcj862wNdv1FXShJl6zf5Gd9Zjiuqy7Q0QWvCIoS/
         4X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1OpyTbTObG2pTmUXHKL+6aOv1Z/jJJrzQQT6SMvPg0s=;
        b=ZGmCRf52N0e1pQUvl65ml/X/Tac2sfHsXH8sHaBH3ycSa/3zeKXx8dr+zl6wf7C8LO
         I9hdmaPUwL+iZ5hVfJQSt+9VNi2zUqqHdzWKyKtl3mRK8Sc+Ls+GnCGib9ZESj2yhYdq
         +EPd49xkAnGrbBvFjk/rttMcllj7CZrkWRitfuBZOdUCHSYHAlle4lJx9uK9YqejVFls
         tK66OU2I5mWMxTBz7Go/lNqIK1v7TL66syUVCHPdkkovlaVrYr/KcRtxTp6PKqUpKkhq
         Ea+kcBxeEqzCpjSEG2gwBP3HdVHxJfOLTtNqgqL9wMtsbr0DCklQPeEsw7WMe9CTq1m0
         np1Q==
X-Gm-Message-State: AOAM5330DYYDegdFmg7rDJDVn6Rnp/B9a+vjJrk8dVQPk3UGvNBa2WcP
        5pWVpGHiKyFVKzEBcE+0W0o=
X-Google-Smtp-Source: ABdhPJwLums5oSNoGipWMKltaUJ3UQ9/Ez1+7sxItUCoKTSL2NuqFPLhj3bc3kYhLRBVdkCIMMIWYw==
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id bk3-20020a056a02028300b00342703e1434mr6883172pgb.74.1645806814460;
        Fri, 25 Feb 2022 08:33:34 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:4559:4408:3487:ab8e])
        by smtp.gmail.com with ESMTPSA id q14-20020a056a00150e00b004f1252a21casm3720692pfu.161.2022.02.25.08.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:33:33 -0800 (PST)
Date:   Fri, 25 Feb 2022 08:33:30 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        jabolopes@google.com, Jeff Hostetler <jeffhostetler@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] repo_read_index: add config to expect files outside
 sparse patterns
Message-ID: <YhkE2vxI4nM3ut0K@google.com>
References: <YhWbWOd6PeF1RZw1@google.com>
 <20220224052259.30498-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224052259.30498-1-newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren wrote:

> Signed-off-by: Elijah Newren <newren@gmail.com>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, and sorry for the slow review.  My one remaining area for nits
is the documentation, but that can be improved iteratively via patches
on top.

[...]
> --- /dev/null
> +++ b/Documentation/config/sparse.txt
> @@ -0,0 +1,28 @@
> +sparse.expectFilesOutsideOfPatterns::
> +	Typically with sparse checkouts, files not matching any
> +	sparsity patterns are marked as such in the index file and
> +	missing from the working tree.  Accordingly, Git will
> +	ordinarily check whether files that the index indicates are
> +	outside of the sparse area are present in the working tree and

Junio mentioned the "sparse area" could suggest that the area is
itself sparse and devoid of files, so it might not have been the best
choice of words on my part.  Perhaps "whether files that the index
indicates are not checked out are present in the working tree" would
work here?

> +	mark them as present in the index if so.  This option can be
> +	used to tell Git that such present-but-unmatching files are
> +	expected and to stop checking for them.
> ++
> +The default is `false`.  Paths which are marked as SKIP_WORKTREE
> +despite being present (which can occur for a few different reasons)
> +typically present a range of problems which are difficult for users to
> +discover and recover from.  The default setting avoids such issues.

The git-sparse-checkout(1) page never describes what SKIP_WORKTREE
means, so it might not be obvious to them what this means.  Also, the
"can occur for a few different reasons" may leave the user wondering
whether they are subject to those reasons.  What the reader wants to
know is "I should keep using the default because it makes Git work
better", so how about something like

 The default is `false`, which allows Git to automatically recover
 from the list of files in the index and working tree falling out of
 sync.
 +

?

> ++
> +A Git-based virtual file system (VFS) can turn the usual expectation
> +on its head: files are present in the working copy but do not take
> +up much disk space because their contents are not downloaded until
> +they are accessed.  With such a virtual file system layer, most files
> +do not match the sparsity patterns at first, and the VFS layer
> +updates the sparsity patterns to add more files whenever files are
> +written.  Setting this to `true` supports such a setup where files are
> +expected to be present outside the sparse area and a separate, robust
> +mechanism is responsible for keeping the sparsity patterns up to date.

Here I spent most of the words explaining what a Git-based VFS layer
is, which is also not too relevant to most users (who are just
interested in "is `true` the right value for me?").  How about
reducing it to the following?

 Set this to `true` if you are in a setup where extra files are expected
 to be present and a separate, robust mechanism is responsible for
 keeping the sparsity patterns up to date, such as a Git-aware virtual
 file system.

?

> ++
> +Note that the checking and clearing of the SKIP_WORKTREE bit only
> +happens when core.sparseCheckout is true, so this config option has no
> +effect unless core.sparseCheckout is true.

Good note.  Same nit about the user not necessarily knowing what
SKIP_WORKTREE means applies.  Also, we can remove the extra words
"Note that" since the dutiful reader should be noting everything we
say. :)  I think that would make

 +
 Regardless of this setting, Git does not check for
 present-but-unmatching files unless sparse checkout is enabled, so
 this config option has no effect unless `core.sparseCheckout` is
 `true`.

Thanks,
Jonathan
