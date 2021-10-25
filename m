Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCAEC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CA760F22
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhJYVus (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhJYVur (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 17:50:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B47C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:48:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 187so12198457pfc.10
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ntl7JZbDPe2W3MmzEi9tr+uAn+gDDre2p+qwZ5TII7I=;
        b=rgb51udh4PG9jFKc5Fhc0MorSwmGYdGEto8YRvrOK/KR894x54eBIeiHJhLPBI+kqv
         Ng5t8ONwtwCCpiC8HZY2H5ENkinSblOyEiRqx3tpJtTNKWzXc+e9XPgGQagtSOqIu8f8
         3HWyOP4ow7gdEJJdSyDYtTnFcp7wus7AJsFj9Ds/Q+9d2eOm0Aha80r/36RqCYlFGp+7
         MNx2YFlX7bcctCKwSqLbyoi0THSEeyLQthYrleRw68ogwjBaRezIcUBKZWlNcNhSAWe7
         2YqiqxrfuLIoWez9XY4PD0UtfFUyeUinf4XxUq5vFHUIZZhw0JKtLLz9jFMsPOsRY3XV
         nzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ntl7JZbDPe2W3MmzEi9tr+uAn+gDDre2p+qwZ5TII7I=;
        b=h9w8m+YAmaLRyz2qADzJhr905YWldLETY/1stEVxuwnNPi14iEy/Fetdms7VRTpKve
         Ru/MPmLKOOasgOc88knx2ks3hloPoSuZtPNc60+VtaiYjhJpyXL/yq36NrrIB4y/z8Ws
         512tXCtUPxttVH70xbQ0snDOKTeArJD5YX6JBvbEENmdZ/hcW+SCgXIhfMeepTjyqo4P
         3Ut/mDV4+nKnHvP1ZI+vfy1mbf6/yZujvgSoZdCAHb5yWTsq+8Dp0ePC9j0dFsJIi1I7
         YqMX5hRgScqT6KrslPX1JQkWgExtac28vZUCyXPG8SRpk0HlGQjAiOir2Pcz0ylRTe3H
         TFQg==
X-Gm-Message-State: AOAM530d/SjzAC+/HbnXuvPBifw8RYtZFGSfjSf/TSItaXqvchfH5kHq
        7px4OeqpGIFtx3nejzimmy6Fvfuf0gLV1XjFdXiEhBHWmx8M6A==
X-Google-Smtp-Source: ABdhPJzoLvWHwNv4h8vkWeJ4+yRThz/OjUTMCcHSQBhlWzf36nr3i6DuSkXoUS8fCSsAAkfMuapn4w20vVGLVwF/6vo=
X-Received: by 2002:a63:70a:: with SMTP id 10mr1827650pgh.299.1635198504354;
 Mon, 25 Oct 2021 14:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-HFGgkXsA-MXBOdiogDid+=F8jmqw0zxwQoUzha-jc1Hw@mail.gmail.com>
 <YXcC8jQbFsaqYN2M@coredump.intra.peff.net>
In-Reply-To: <YXcC8jQbFsaqYN2M@coredump.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 25 Oct 2021 14:48:13 -0700
Message-ID: <CAGyf7-Gge72Cr39pEci8CNBiVWDO2O5MesrFRqafE-_ibHfR0g@mail.gmail.com>
Subject: Re: Unexpected cat-file --batch-check output
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 12:18 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Oct 25, 2021 at 12:02:38PM -0700, Bryan Turner wrote:
>
> > I'm working with some users trying to reconcile an odd mismatch
> > observed in some Git output.
> >
> > Running an ls-tree for a branch and path, limited to a single pattern
> > within, shows this:
> > /usr/bin/git ls-tree -z refs/heads/develop:path/to/parent =E2=80=93 fil=
e
> > 100644 blob 4c8d566ed80a1554a059b97f7cd533a55bbd2ea8    file
> >
> > If we then run cat-file --batch-check, though, we see this:
> > echo 'refs/heads/develop
> > refs/heads/develop:path/to/parent/file' | /usr/bin/git cat-file --batch=
-check
> > 28a05ce2e3079afcb32e4f1777b42971d7933a91 commit 259
> > cc10f4b278086325aab2f95df97c807c7c6cd75e commit 330
>
> That's definitely odd. Some things I'd try:
>
>   - do other versions of cat-file behave differently (i.e., is it a
>     regression)?
>
>   - what does "git rev-parse refs/heads/develop:path/to/parent/file"
>     say? If it comes up with 4c8d566ed80, then the problem is cat-file
>     specific. If not, then it's a problem in the name resolution
>     routines.
>
>   - likewise, what does "git cat-file -t cc10f4b27808" say? I'd expect
>     it to really be a commit (a bug in batch-check's formatting routines
>     could show the wrong object, but I'd expect the oid to at least
>     match what ls-tree showed).

I don't have that specific data, but one thing I do know is that
cat-file -p prints commit contents:

/usr/bin/git cat-file -p refs/heads/develop:path/to/parent/file
tree c378146c918c05794e5fb1d1f6986c81ca866326
parent 6cb6016c78c4c963311ca82fc53764141b0d3bdd
author ...
committer ...

<Commit message starts here>

One other observation. I threw
cc10f4b278086325aab2f95df97c807c7c6cd75e into Github's search, on a
lark, since so much open source is there, and it actually finds that
commit in multiple repositories[1][2][3]

[1] https://github.com/bitcoin-sv/bitcoin-sv/commit/cc10f4b278086325aab2f95=
df97c807c7c6cd75e
[2] https://github.com/fakecoinbase/bitcoin-svslashbitcoin-sv/commit/cc10f4=
b278086325aab2f95df97c807c7c6cd75e
[3] https://github.com/TuringBitchain/TuringBitchain/commit/cc10f4b27808632=
5aab2f95df97c807c7c6cd75e

None of those repositories has a branch named "develop", and the
"file" I've obscured here is not present in any of them, so while
there is clearly some ancestry in this repository with open source
roots, it's evolved since then. Experimenting with some of the
"nearby" files that are present in those public repositories, I have
not been able to reproduce the issue in any of them.

>
>   - Is there anything odd about the tree? E.g., duplicate entries, out
>     of order entries, etc? Examining "ls-tree" output might help, but
>     "git fsck" should also note any irregularities.

I've sent some further commands, based on your suggestions, to the users.

>
> After that, I'd probably start running "cat-file --batch-check" through
> a debugger. I know you said you don't have access to the repository, but
> perhaps whoever does might be willing to run it through "fast-export
> --anonymize" and see if the bug persists?

fast-export --anonymize might be a way forward. Thanks for suggesting
it (I always forget about it); I've mentioned it to the users.

Thanks Jeff; I appreciate your time/insights!

Best regards,
Bryan Turner
