Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC80C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386321AbiFHA3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453005AbiFGXOt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:14:49 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FC918A850
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 14:04:31 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x16so10301602qtw.12
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PWk0e1OUiT4a4rjqsgRohtX7g3XizE5h+ab0nAzx0Sc=;
        b=O6eSwXQCejwJKVaOEnPCShZZj2/yeswBQ6BpGajtTSggNO+RqIzfaZ645ql3OR7/Ww
         RL9GITtt9+LjpCuSNuC7SckCFUKKhSjw5CRP4plUWJE5CSIRPDcPSygR98FEKDmaJke4
         14kzE02tyhOJ0ldA88VM2A+pNTwWoNumWggg1rQ/Mw/4sO2trQ4r5kSycEKNs46As/bF
         5ezlIslQxiiBhEwyyDZfm4sKVabM36/gQVqLlMd9mJabIc1pBTrzxzRW3cpocO5Bzh3K
         nxs9v3TueN6/gkuVvM7wOdhk6CCOcGQr+uADpGjgKqpNXjnqyek05nsyUL9QmwImgAhe
         rP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PWk0e1OUiT4a4rjqsgRohtX7g3XizE5h+ab0nAzx0Sc=;
        b=GAFa5vY/NL/yuGeVL4EgyltyaZFj8b5GQnHy3u0HD99kRMCNOSvEiZkfJibshAv77h
         92goqThnhFyHw+knDqO55N+w4ZgqpxnL4nh0tcJH1jHXYkZtUVn08IhWxHX2+2HwEa5Y
         DlKtm/6XpKqc9RAjLWdi2E5TJ7x6HeghPB7b37CYfaFW50XBF5twYZIuD4J6LgUv+xrc
         RVJzWx3rkhzUcYjBmJXTjinuDbix39rDm4hDkTy1jjlcwt3wFmUXre8F9M7YTXhpEJDt
         tELS05ok4jrfzH0uC1kAriSxo9Xb7zMhFfhKbkCz8HTQkWY0sRQD1GOonHpSddN/MPMR
         ioZg==
X-Gm-Message-State: AOAM533FJoQsl1ClpHfU1G7zBppN/hq+XdsspfOiyhEPBN3soWq06mZz
        4RIAj5H0/ER2BGxzCVjpupiP5A==
X-Google-Smtp-Source: ABdhPJym57a//wkbOlA3yaZ9GbBTlC9xPNIMJwE4Gency8OdCl5noqWztzVolGh+vxe2118gZclLlg==
X-Received: by 2002:ac8:7f47:0:b0:2f9:345d:9536 with SMTP id g7-20020ac87f47000000b002f9345d9536mr24383220qtk.496.1654635867647;
        Tue, 07 Jun 2022 14:04:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o22-20020a374116000000b006a370031c3esm14352944qka.106.2022.06.07.14.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:04:27 -0700 (PDT)
Date:   Tue, 7 Jun 2022 17:04:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH 0/2] builtin/show-ref.c: support `--count` for limiting
 output
Message-ID: <Yp+9Wk6VH1BR9T9c@nand.local>
References: <cover.1654552560.git.me@ttaylorr.com>
 <xmqqo7z54d7g.fsf@gitster.g>
 <Yp6GRccc5UElNrZb@nand.local>
 <220607.86mteovpg2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220607.86mteovpg2.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 07, 2022 at 10:18:56AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Jun 06 2022, Taylor Blau wrote:
>
> > On Mon, Jun 06, 2022 at 03:52:19PM -0700, Junio C Hamano wrote:
> >> Taylor Blau <me@ttaylorr.com> writes:
> >>
> >> > This short patch series adds support for a new `--count` argument for limiting
> >> > the output of `show-ref` (à-la the `for-each-ref` option by the same name).
> >>
> >> It makes me wonder why we limit this to show-ref.
> >>
> >>     $ git --pipe-to-head-N=3 any-command args...
> >>
> >> IOW, having to add an option like this feels absurd.
> >
> > I don't disagree. But `--pipe-to-head-N=3` feels like too broad a
> > stroke. This series at least imitates `for-each-ref`'s `--count`
> > option, which makes it feel acceptable to me (if not a little silly).
>
> Yeah, although I do think it's worthwhile to think about where certain
> UX decisions are leading us, i.e. the logical conclusion here is to have
> every command that emits >1 lines support --count, which as your patch
> here shows needs special support, and even in your case you haven't
> implemented it in a way that's compatible with all existing options.

To be clear, I don't think adding `--count` to every command is a good
idea. But it exists in `for-each-ref`, and not in `show-ref`, and this
series rectifies that gap in functionality. Perhaps `for-each-ref`
shouldn't have `--count`, but it does, and has since that command's
inception.

> B.t.w. why would a --count for --verify not just by supported have these
> be equivalent:
>
>     # same
>     git tag --count=3 --verify <name>
>     git tag --verify <name> | head -n 3

(I'm not sure if you meant "git tag" here versus "git show-ref", but
either way), `show-ref` in `--verify` mode outputs one line of output
per line of input, so a caller can easily limit the output by limiting
the input.

> >> > This is useful in contexts where a caller wants to avoid enumerating more
> >> > references than necessary (e.g., they only care whether a tag exists, but not
> >> > how many or what they are called) but doesn't have control of the output stream
> >> > (e.g., they are in Ruby and can't pipe the output to `head -n 1`).
> >>
> >> Are you saying that Ruby is incapable of run a command line like
> >>
> >>    av[0] = "sh"
> >>    av[1] = "-c"
> >>    av[2] = "git show-ref blah | head -n 1"
> >>    av[3] = NULL
> >
> > No, Ruby is perfectly capable of doing that. But it involves an extra
> > process (two, if `head` isn't a shell builtin) [...]
>
> Maybe this really is a limitation of ruby, or maybe I'm missing
> something, but doesn't it support just opening a process without "sh -c"
> and piping the output to your current process, as this perl command
> which makes use of execve() will do:
>
>     $ perl -Mautodie=:all -wE '
>         my $i = 0; my $lim = shift;
>         open my $fh, "-|", qw(git show-ref master);
>         while (<$fh>) {
>             last if $i++ >= $lim;
>             print "$.: $_";
>         };' 10
>
> Some quick searching for docs online suggests that Ruby's Open3 and/or
> Process.spawn might be the equivalent.

To be clear, Ruby _does_ support something similar to what you
demonstrated in Perl above, it just isn't easily accessible to our
current infrastructure for spawning Git commands.

> Isn't that something that would make this workaround unnecessary? Well,
> maybe not because...
>
> > [...]and the additional
> > overhead of creating a pipe and passing data through it instead of
> > writing directly to stdout.
>
> It wouldn't take care of this part, but I'm struggling to think of cases
> where you'd be running this in the context of github.com and not already
> need to capture the output of the command. I.e. surely you're already
> piping stdout/stderr into your program, no?

Right, there's already a pipe in place to capture the output, but here
I'm talking about an _additional_ pipe to feed `show-ref` first through
to `head` and _then_ back out to the buffer in the calling Ruby program.

Thanks,
Taylor
