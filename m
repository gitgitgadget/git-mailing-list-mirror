Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACB7C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A2E60249
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhJ1T6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJ1T6B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 15:58:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A804EC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 12:55:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g10so29096198edj.1
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xkOwm94Jz5UBca2c50zlKsmzHvc4WORzRnJ0jpa/BSo=;
        b=SJ+vdtEpq0hjZiOouQE5qa9L/0slYBd3kichmjjyfaKyG5z2vboKXGuZmE+oxtJfMQ
         xl1oCkBy1eRn+0Kz3vBVSKe/RwDhk31haC1x4YyJgHEKg+vDAoh/XOhn+jlQxCEnVloM
         tCHU9oAU5JR8tUoczKw12W7kjYB0kmI8c6IHdhN3+Gd60vo9HDfJFTlf6tM2L+09UJbD
         RpJkDYLkcwKZChUIW9kqpyWLSZTaHk5fW6tDo3gSHvzvc3hGmoWQviMuhu3bsWDwfCeE
         eUfJWYT9LKrrYuIo4X57ONLvEJDGcNmGS0XhP+NIXRFEgBJoeoSAQ8QPVMy5qdAdPrnN
         3qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xkOwm94Jz5UBca2c50zlKsmzHvc4WORzRnJ0jpa/BSo=;
        b=iYxzI7ogEZ3tW/mtqQ//fOzHxTkaIMz9AEdOfaNQGjIcDvpPb/eeBXY0vjSf8IqUBS
         Lp6WIZyW9YQ+E1/KQvG/1kUYqLvU3B+yIqau4BDCqemfyEbxiRGpWbYaagyezCHz3iS8
         Wd2piBAxE2wnavTcscNhN+DN7qPe0Ip8Dr1M1/meIxUHvt0JGDwbbvsICvz2Kc0H6j5b
         aD82WHPWWzYUb/7WsAqGxuCLX8LFA8Ix7OrwUSWY75k1HlFDh6dA+pJgYfaR8r7mgSde
         nCd0dY+gHRrqh+OaTSqg50vesx5KgQemmrfQUPDtbUzIq9/vsWIBc2G7kvuf7bwEdqBb
         hURA==
X-Gm-Message-State: AOAM530wFuhVIHzS4hJKOfoJIegmWzwWQdu3W+oWwocSxYk61bFfdXMo
        JBZJTJi6Oyh3nI0DXDHZQYY=
X-Google-Smtp-Source: ABdhPJxgIsBt5vOlG6y3ZmA7DAVBIsDoLG+ckvoS3hQv9jECdHtynu1kIdM+L5su90USSGc0XfwKOQ==
X-Received: by 2002:a17:906:c187:: with SMTP id g7mr5184412ejz.534.1635450932264;
        Thu, 28 Oct 2021 12:55:32 -0700 (PDT)
Received: from szeder.dev (94-21-23-225.pool.digikabel.hu. [94.21.23.225])
        by smtp.gmail.com with ESMTPSA id q2sm2186840edh.44.2021.10.28.12.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 12:55:32 -0700 (PDT)
Date:   Thu, 28 Oct 2021 21:55:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Is t7006-pager.sh racy?
Message-ID: <20211028195527.GA2574@szeder.dev>
References: <xmqq1r4b8ezp.fsf@gitster.g>
 <20211024170349.GA2101@szeder.dev>
 <YXbsPrU6nRSboQ7r@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXbsPrU6nRSboQ7r@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 01:41:18PM -0400, Jeff King wrote:
> On Sun, Oct 24, 2021 at 07:03:49PM +0200, SZEDER Gábor wrote:
> 
> > On Sat, Oct 23, 2021 at 05:04:42PM -0700, Junio C Hamano wrote:
> > > It seems under --stress it is fairly easy to break the said test,
> > > especially the one near the end
> > 
> > I couldn't reproduce a failure with --stress, but after a cursory look
> > into those tests I doubt that either that test or any of the
> > preceeding SIGPIPE tests added in c24b7f6736 (pager: test for exit
> > code with and without SIGPIPE, 2021-02-02) actually check what they
> > are supposed to.
> 
> Yeah, I am puzzled that they are using test_terminal in the first place
> (as opposed to just "git -p"). And you are right that a raw git-log is
> unlikely to be slow enough to get SIGPIPE in most cases.
> 
> My usual test for an intentional SIGPIPE is "yes". So something like:
> 
>   git -p \
>     -c core.pager='exit 0' \
>     -c alias.yes='!yes' \
>     yes
> 
> will reliably trigger SIGPIPE from yes, which git.c will then translate
> into an exit code of 141.

Oh, that's clever.  Alas it's not applicable to our tests, because
'yes' is not portable; 8648732e29 (t/test-lib.sh: provide a shell
implementation of the 'yes' utility, 2009-08-28).


> If you really want to see SIGPIPE from a builtin (which arguably is the
> more interesting case here, though I think it behaves the same with
> respect to the pager), it's a bit trickier. One way to do it is with a
> command that doesn't generate output until after it gets EOF on stdin.
> 
> So something like "git log --stdin" works, but you have to contort
> yourself a bit to make it race-free:
> 
> -- >8 --
> # The I/O setup here is:
> #
> #         fifo:log-in          stdout
> #   shell -----------> git-log ------> pager
> #     ^                                 /
> #      \-------------------------------/
> #                 fifo:pager-closed
> #
> # The pager closes its stdin, which will give git-log SIGPIPE. But the
> # tricky part is that after doing so, it signals via fifo to the shell,
> # which then writes to git-log's stdin, triggering it to actually
> # generate output (and get SIGPIPE).
> #
> # You can verify that it's race-free by inserting a "sleep 3" at the
> # front of the pager command (before the exec) and seeing that the
> # other processes wait (and we still get SIGPIPE).
> 
> mkfifo pager-closed
> mkfifo log-in
> git config core.pager 'exec 0<&-; echo ready >pager-closed; exit 0'
> (git -p log --stdin <log-in; echo $? >exit-code) &
> 
> # we have to open a descriptor rather than just "echo HEAD >log-in", because
> # that will give git-log an immediate EOF on its input when echo closes it, and
> # we must wait until the signal from pager-closed. Likewise we cannot wait
> # for that signal before the echo, because the subshell is blocking on opening
> # log-in until somebody is hooked up to the write end of the pipe.
> exec 9>log-in
> read ok <pager-closed
> echo HEAD >&9
> exec 9>&-
> 
> # now we can wait for the subshell to finish and retrieve any output
> # it produced
> wait
> cat exit-code
> -- >8 --

Ugh.  I think this would work reliably, but...  ugh :)

I wonder whether we could do this as a new pair of 'test-tool'
helpers, one to run the pager through the usual pager-invoking
machinery and to generate a lot of output, the other to be used as the
early-exiting pager, with a pipe between the two to ensure that the
SIGPIPE does happen.  Well, essentially the same that you outlined
above but in C instead of shell, which I somehow find less "ugh".

