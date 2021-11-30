Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F04C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 00:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhK3Aq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 19:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhK3Aq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 19:46:57 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542F6C061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 16:43:39 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id x6so23711452iol.13
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 16:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZlzvMRuQijPh7fdXnGSMtVpUhdDFqn992e4I+imDEVw=;
        b=28m+v0IvqC8O7Lhwjc/YxqV4hX7+Oi5cQYj2WmrX7Z5oKMZdtvB0vXdGlz8iIZuWSF
         qGtITvJ7bG1wuttkDR566qsFYiokFx/wRi9o+jgf8ccPjrCeQ7QotSO6ush9fuPQkf2O
         JCgkhRKe/WGJ3rEt0pu75KmS4nVsdkCHkoFSrwTjdsYeK0RkIboKMiPmol9jbxasnqCw
         Ui8TtpA+VpP5TiLFpMgjyoQ3/lAGUauYw6bUr6YmOLSUi6CYIXPyqXz2DlMvEF4AGxjQ
         eRdZ153t6MtWw0ZfeR0n+TQ1ncNWGjiVNjJv7SBJ+w2E1u3bLXin4U9Q9Y+yiL3iDAWb
         apeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZlzvMRuQijPh7fdXnGSMtVpUhdDFqn992e4I+imDEVw=;
        b=qDI//PG6BPEHcLHWhkqjzloyF+FMxEWI/dxUbVN1tjCBkzVMAGdz0typFdZw0h0Mre
         CbZRS9EI8KkUjnArTk+myT5zMpPfnvVRa+U3B+Lil9FAqg4f9MKAAPeaSzAgMVf0njd4
         AE/lGyIJNhM1UzcNTbUWVo88Z40aESCKwgGAAwztIr29ioxkCeslH2leKcOv28YQhkQM
         WHjGtsqLO40p5KjztNBx6lqWDWfEw3/82qhF3w+QhO/j8YYZk+3XD0L/284F784qspbr
         d1tO1HacjlwRUmBMVuFoXmYarQdHOTP+QwgvCwy4r2dabzbNJFInl/NX8jsLroXrrhub
         yB9A==
X-Gm-Message-State: AOAM530Fjm4jOXDP2sLDmkGFz8TDr77oZ4wBrfxIi82Kb67L3ad97z+0
        4MNpy9HbqGA6lMM9zdAkAH3+HsamvEbbJFfz
X-Google-Smtp-Source: ABdhPJzaUlEWyXMQWETaPwTLKqKlY6tp7ncBJ4lqSRzaZlNH17omrWj6/fcUgnT7iPN5i9ozSkRNFw==
X-Received: by 2002:a05:6638:190f:: with SMTP id p15mr70540911jal.82.1638233018808;
        Mon, 29 Nov 2021 16:43:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 11sm9202868ilt.63.2021.11.29.16.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:43:38 -0800 (PST)
Date:   Mon, 29 Nov 2021 19:43:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Nikita Bobko <nikitabobko@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG REPORT] `git rebase --exec` shouldn't run the exec command
 when there is nothing to rebase
Message-ID: <YaVzufpKcC0t+q+L@nand.local>
References: <CAMJzOtyw78-8gt3oGscN7KUzpzRRWtAQuGfcJ+R_Fjoom9Lexw@mail.gmail.com>
 <211129.868rx7gnd5.gmgdl@evledraar.gmail.com>
 <CABPp-BFRE2=Owf15WzkacNfdNKbkd2n4GZh7HqDokKzeviBWRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFRE2=Owf15WzkacNfdNKbkd2n4GZh7HqDokKzeviBWRw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 04:14:33PM -0800, Elijah Newren wrote:
> On Mon, Nov 29, 2021 at 2:25 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> >
> > On Fri, Nov 26 2021, Nikita Bobko wrote:
> >
> > > Steps:
> > > git rebase HEAD --exec "echo foo"
> > >
> > > EXPECTED: since 0 commits are going to be rebased then I expect "foo"
> > > NOT to be printed
> > > ACTUAL:   "foo" is printed
> >
> > I don't think this is a bug, but explicitly desired behavior.
>
> My reading of the docs are such that I'd expect the same as Nikita here:
>
>         Append "exec <cmd>" after each line creating a commit in the final
>         history.
>         ...
>         If --autosquash is used, "exec" lines will not be appended for the
>         intermediate commits, and will only appear at the end of each
>         squash/fixup series.
>
> There is no line creating a commit in the final history when you do a
> git rebase -i --exec "echo foo" HEAD (there is only a noop line), so
> there should be no exec line.

Thanks for quoting the docs here. When I ran this myself, I thought that
the docs must say something like "after every line" and not further
specify "... creating a commit".

But they do, so I agree with the original report from Nikita that

    git rebase -x 'echo foo' HEAD

should be silent in order to be consistent with the docs.

> > When you do:
> >
> >     git rebase -x 'make test' BASE
> >
> > You expect to run 'make test' for all of BASE..HEAD inclusive of
> > "base". E.g. for HEAD~1 we'll run 'make test' twice, and you know both
> > your HEAD~ and HEAD passed tests.
>
> This is not true.  Try `git rebase -i --exec HEAD~$N` for various
> values of N>0.  base is not included.
>
> > So why wouldn't doing the same for HEAD make sense?
>
> Indeed; HEAD is weirdly inconsistent and should be brought in line
> with the others.

Yep.

Thanks,
Taylor
