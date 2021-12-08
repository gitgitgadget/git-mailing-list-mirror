Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A92C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 00:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhLHArx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 19:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhLHArx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 19:47:53 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199D7C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 16:44:22 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id l7so1252107lja.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 16:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbI1xdSaW4brJxbMu7DY9GV1VZrP+TIClPB26Zv3LJA=;
        b=Gds2O7EckYgaCO6BzDu3RVKyXZ6itr42nYEF0J4XNWne37wcAwE9uAVYgdT9WZYX0y
         Mw70kvRB0m2Bxm4cZYytiKEuy4xkbyUYzz3kSjO0ENlxjtnjFKweTee+jYntfJRk0jnI
         80hc/nJeIgLgVzOLMktXJqoSfsfWD1bLd4sYtVXS2OPUSzZ42mIjRyEbv/R5i4qcxWQh
         XXI7/6QbGgQwoAeLdH0ENJRErS07ZJC0XI3ooO0SKD3FDwlJwAbh5xTFrLoJXYCmn8ot
         ryZkfpCw4/XiCATBnZmeSmfAY4ruEzLK+EjBhT2dADnNgqMXSlZiCi7hD6/GZh5lo+NP
         c9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbI1xdSaW4brJxbMu7DY9GV1VZrP+TIClPB26Zv3LJA=;
        b=5T5lg2uMBH4BnLU4OcRc625Ld0PSSkK0eZtBTy4/qvxsUekT4Kq6i9ih8q+Qesv77+
         nEbg931lrKbqwf3zSJ4oiL8F+w3ys185bzWPRgYrTjpXerzeYRJdkRyKHpFKnY/fhKZI
         4JC6hWVFS0knkFgGTcL9960o+hfjpa2BlyED5B6bWPcnsJ8SjvlG3faZq+LZ4KnAa5QT
         O9IeTHTo2uFz53v7HwWOo0r6cOwN1uFy+CnUEQyjCfhIOahlgtmgoA8KqgUJUiqxSBjd
         jvTbf7TZkDhgITA+JBMUrmH5LsCmwF9K30Wg5kZHovo6ZOnZyBQ82rKxZBXrC3BW6KZF
         5+pg==
X-Gm-Message-State: AOAM532r2+0ERTepMYWD4i1EXuDFeE1t4av8VVfK9FREYqfFw53V3kuo
        6j+bdq5cqxYqvku5C6KyLmnIP94c+kAZfKppZGw=
X-Google-Smtp-Source: ABdhPJzf61AY5BB9owSrhQYC0lO9yHEjvEOz/+mtWAUlVdkhYRX+OMMSNv2YSksnu2OGohq3DukmceSdRNLL8j/axKk=
X-Received: by 2002:a2e:89c4:: with SMTP id c4mr44907367ljk.230.1638924260380;
 Tue, 07 Dec 2021 16:44:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com> <Ya9L5GJqlBF1YEk2@ncase>
In-Reply-To: <Ya9L5GJqlBF1YEk2@ncase>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 7 Dec 2021 16:44:09 -0800
Message-ID: <CANQDOdeL5LUV-2pffSyqZ9kGAhS4V4wg5--6ERvMALEkfsUCTg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] A design for future-proofing fsync() configuration
To:     Patrick Steinhardt <ps@pks.im>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 3:57 AM Patrick Steinhardt <ps@pks.im> wrote:

> While I bail from the question of whether we want to grant as much
> configurability to the user as this patch series does, I quite like the
> implementation. It feels rather straight-forward and it's easy to see
> how to extend it to support syncing of other subsystems like the loose
> refs.
>
> Thanks!
>
> Patrick

Thanks for the positive comment.  I'm assuming that a major Git
services like GitHub or GitLab would be able to take advantage of the
granular options and knowledge of their hosting environment to choose
the right values for any server-side git deployments.  I'd probably
turn off syncing for derived stuff like the commit-graph file and pack
metadata.

My underlying interest in all of these changes is to make Windows stop
looking so bad (we're defaulting to core.fsyncobjectfiles=true).
Batch mode should give similar safety and much more optimizable
performance in our environment.

Thanks,
Neeraj
