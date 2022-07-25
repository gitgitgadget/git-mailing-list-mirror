Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFA0C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 23:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiGYXud (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiGYXuc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 19:50:32 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24E11BEA0
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:50:29 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id l14so9439719qtv.4
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e+r8zvVbJqfDEyC0a6jjkhDrhfS7iJ3UqNko2vAkovM=;
        b=dDofJlU4gEgFqDePiFi2lZpUvCh6NjFGpykK9Al4hs0JmUZH6ZeFFhAL2zo8vec/NG
         FZ+xnoOKxEz2ZrvyzIAxIHSrJkPOLDXdOPXjqAJrLaEM+53fH1JEiyT+IdyUE9eRO6NG
         Q/ChN+jn1tzXnvW/uvZvzUqLF1gKVWHwt6CKcM4r+DalZ/or95ijhWCH9BogUu7SnZUX
         QdrRG/+H/HGG0FE/inRUGGwja+HIp30ltX8EhI4NCSbupp7yLq17NEZFq1Ln/N58L8N9
         qod07kVp33Tbcpw4FbM/SJtssqKIbEn/FIJYflHEsybHOdSKbaT2mzuR6UdaLjbad37J
         O84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e+r8zvVbJqfDEyC0a6jjkhDrhfS7iJ3UqNko2vAkovM=;
        b=LD7kXaek8BrdoTrA5w7NZmBrFbx+mb83AHWlMQrrdqBuGVQ2R2xggl/DeN4BhQqbi3
         KsldFpj7jisR6w/cQgVP4BGwcMBZsM8a8aplfbgbyJrjKrTFbHho9xdSlzrPYvzOf2Mg
         dnIbJFYAuIT5Vw5Jk6oKvHsXiYTSVFr4ppsJlKZwpJq1B5L8sunN1klo5Kbp2AxCl7tN
         PVq0q7U8aO0WHKCK+fA7CCkbklxB8iqrzbR6z3zYtDm2La17h0EifZ/CP254Bepv/u+2
         4ke1VKNGD+LL+uX43ScJXe0zOaF3mtT6R48at8r4oVC95txyRAg6S57QzAfjZq5rHmpB
         x0jA==
X-Gm-Message-State: AJIora9Lfu4AUD4P/C+zHmL7QyOvxHfXQ1sLcedM0PpJMxf7ZPijbGqC
        d4Yy/6jI6/peCNsTj+c9K2lm6VJLNdbkew==
X-Google-Smtp-Source: AGRyM1s+5FyN1D8UkZ+8rCDHYQGE8wWe7hdiOn2EQvI/g92ieGIWGqtBv1mJxWY6rg/dWaEiQatNjg==
X-Received: by 2002:ac8:5815:0:b0:31f:a54:c7ce with SMTP id g21-20020ac85815000000b0031f0a54c7cemr12311788qtg.21.1658793028918;
        Mon, 25 Jul 2022 16:50:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 2-20020ac856e2000000b0031ee663b5b8sm8488951qtu.83.2022.07.25.16.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:50:28 -0700 (PDT)
Date:   Mon, 25 Jul 2022 19:50:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/cat-file.c: support NUL-delimited input with
 `-z`
Message-ID: <Yt8sQ6kPoUUQFjle@nand.local>
References: <cover.1658532524.git.me@ttaylorr.com>
 <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
 <xmqq4jz8bdcg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jz8bdcg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 10:35:43PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > @@ -14,7 +14,7 @@ SYNOPSIS
> >  'git cat-file' (-t | -s) [--allow-unknown-type] <object>
> >  'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-objects]
> >  	     [--buffer] [--follow-symlinks] [--unordered]
> > -	     [--textconv | --filters]
> > +	     [--textconv | --filters] [-z]
>
> Is "-z" useful with any other option, or is it useful only in
> combination with one of the three --batch-*?  The above suggests the
> former.

It only makes sense with `--batch`-related options. But doesn't the
above suggest the latter, not the former? That synopsis line begins
with:

    'git cat-file' (--batch | --batch-check | --batch-command) ...

which made me think that this was the invocation for batch-related
options, and only listed options that made sense with a `--batch` mode
of one kind or another.

> > +test_expect_success '--batch, -z with multiple sha1s gives correct format' '
> > +	echo_without_newline_nul "$batch_input" >in &&
>
> I I recall [1/2] correctly, the input lacked the LF at the end.  In
> the original "LF terminated" use converted to use these variables,
> because $batch_*_input is "echo"ed to create the file "in", the lack
> of LF at the end is a GOOD thing.
>
> But here, echo_without_newline_nul is just a glorified "printf %s"
> piped into tr to turn LF into NUL.  What is fed by printf into the
> pipe lacks LF at the end, so the output from tr will not have NUL at
> the end, either.
>
> That might happen to work (because the EOF may be enough to signal
> the end of the entire input, thus the last input item), but it does
> not make the test case for "-z" exactly parallel to the line oriented
> input.

I see what you're saying. And, yeah, I think it happens to work since we
treat EOF as marking the end of the last input element, regardless of
whether or not we saw a NUL byte or a LF (depending on whether or not we
passed `-z`).

I think the helper should probably be something more like:

    echo_with_nul () {
        echo "$@" | tr '\n' '\0'
    }

or similar. But as you note below, this is probably not even worth
extracting to a helper function.

'
> > +test_expect_success "--batch-check, -z with multiple sha1s gives correct format" '
> > +    echo_without_newline_nul "$batch_check_input" >in &&
> > +    test "$batch_check_output" = "$(git cat-file --batch-check -z <in)"
> > +'
> > +
> > +test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
> > +	touch -- "newline${LF}embedded" &&
> > +	git add -- "newline${LF}embedded" &&
> > +	git commit -m "file with newline embedded" &&
> > +	test_tick &&
> > +
> > +	printf "HEAD:newline${LF}embedded" >in &&
> > +	git cat-file --batch-check -z <in >actual &&
>
> As I already said, I suspect that new users who know how our path
> quoting works would expect c-quoted path would work just fine
> without using "-z".  It is not a reason to refuse "-z" to exist,
> though.

Yeah. I think we can do both, if there is a need. I suspect that just
`-z` support would be sufficient for now, but I agree that one doesn't
need to tie up the other.

> > @@ -436,6 +465,11 @@ test_expect_success '--batch-command with multiple info calls gives correct form
> >  	echo "$batch_command_multiple_info" >in &&
> >  	git cat-file --batch-command --buffer <in >actual &&
> >
> > +	test_cmp expect actual &&
> > +
> > +	echo "$batch_command_multiple_info" | tr "\n" "\0" >in &&
>
> This is what I would expect.  The _info variable lacks final LF,
> which is supplied by "echo", so output from tr ends with NUL, which
> mirrors the line-oriented input we used above.

Yep.

> > +	git cat-file --batch-command --buffer -z <in >actual &&
> > +
> >  	test_cmp expect actual
> >  '
> >
> > @@ -459,6 +493,12 @@ test_expect_success '--batch-command with multiple command calls gives correct f
> >  	echo "$batch_command_multiple_contents" >in &&
> >  	git cat-file --batch-command --buffer <in >actual_raw &&
> >
> > +	remove_timestamp <actual_raw >actual &&
> > +	test_cmp expect actual &&
> > +
> > +	echo "$batch_command_multiple_contents" | tr "\n" "\0" >in &&
> > +	git cat-file --batch-command --buffer -z <in >actual_raw &&
> > +
>
> Likewise.

Ditto, thanks.

Thanks,
Taylor
