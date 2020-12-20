Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69BBC433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86FFB22AAA
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgLUFnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgLUFnC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 00:43:02 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC7DC0613D3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:42:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s26so20766139lfc.8
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AuTLQBvoCi9CsUNrtKJmlrICeC8b2Z7V0Jcv5bkoVc8=;
        b=hJjjzHzP8g6RjhwzI2xXO4kKt5rjM2QHCPqXOTWxmqIsx86Ed+NT98qJyhZboZ7yci
         appYvZNDlJTO+IOFUfEn4boNItlyJpoLOXJ/xWncknr7c8tpBygQW4uw0hg9qoTqBYeb
         ek+Zr3qjn0jdGn2j2pAmniLGh9LiKp9OJukkJQwZHcu+81w9k+hbYTsFwZVDB3TIO0Ap
         2fsUjU0D3ZaIIaqE0i9q9FzGLZ2C6LFbJRwV5n5S9sWk+s5GkhKRLleNJ72+QIKJMSEy
         vWfqp3nKMpfHbZ3RfMP5OmA+t+qOKxuAlBtaFNLx9CCds3qL+YvtygLfBERrsu57uymd
         VCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AuTLQBvoCi9CsUNrtKJmlrICeC8b2Z7V0Jcv5bkoVc8=;
        b=JK614w4m9nWBpZMLedwFuuQqq4g1TLwjGH2m+aJ9J00b+jMd6o/kRwNfQ5T84iiUIB
         tUoT6WM78gG8TkJskr+sZmLONCHdHwS3pLoUWTrsMDcje+bEHqmOjVVb681YIwFwnWvA
         0ytUHP8xWUr1Hc+pofw76OU4bVnaISczznLFtn2zMFrQP8hyIZwcG0DX56YDa88cvx9A
         r8GgDdK3y3gkQKGY82pS4ir5WHOHQVEgjsPz2DzyGcDBgVpZDiS0ULRsjIqmGcU8+D3N
         76BGhfb+g4Agck49bmnLkNzvrx2YQzf2zry86gWC25yVXGPrxQV84FrzekBL/eQIwuT3
         Wy9w==
X-Gm-Message-State: AOAM530PGZuzfI06vvjI7sOfK+WDXwi0rm7WacGyp8wpUeg0nJeTwidW
        HgSbiydJypOvW7AmzIqfDGlRmqBR8eQ=
X-Google-Smtp-Source: ABdhPJxoTWMEhTjLRwQHHDSvjHrx1CKZ4IKWm4RZ6VxPTj8aIpvqcLk4M5V8ym6L2eAn5t0xg0gZwg==
X-Received: by 2002:a50:fd18:: with SMTP id i24mr13938930eds.146.1608503678334;
        Sun, 20 Dec 2020 14:34:38 -0800 (PST)
Received: from gmail.com (194-166-85-110.adsl.highway.telekom.at. [194.166.85.110])
        by smtp.gmail.com with ESMTPSA id c16sm2388040ejk.91.2020.12.20.14.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 14:34:37 -0800 (PST)
Date:   Sun, 20 Dec 2020 23:34:35 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re* [PATCH] diff: suppress --name-only paths where all hunks are
 ignored
Message-ID: <20201220223435.tmo5ty5tzwu7et4d@gmail.com>
References: <xmqqeejsdv7x.fsf@gitster.c.googlers.com>
 <20201216231840.3163806-1-aclopte@gmail.com>
 <20201216231840.3163806-2-aclopte@gmail.com>
 <xmqq4kkl1atq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4kkl1atq.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 05:27:13PM -0800, Junio C Hamano wrote:
> Johannes Altmanninger <aclopte@gmail.com> writes:
> > The diff_from_contents bit means that we have to look at content
> > changes to know if a path has changed - modulo ignored hunks.  
>
> But your sentence without " - modulo ignored hunks" says that very
> clearly.  So perhaps these three words can just go away?

My bad, this should rather be

	The diff_from_contents bit means that we have to look at content
	changes (modulo ignored hunks) to know if a path has changed.

probably dropping the three words makes it even less confusing.

> It's not like we were buggy when diff_from_contents bit is in effect
> for all output formats, is it?

Right, it's useless to set the bit here.

> > +		opt->color_moved = 0;
> 
> Why is color_moved so special?  If we added some other new option,
> how would we make sure that the person who is adding that new option
> would remember to reset it here?  And how does that person decide if
> his or her new option needs resetting or not in the first place?

I copied color_moved=0 from the DIFF_FORMAT_NO_OUTPUT section of
diff_flush(). It happens to work correctly in both places because no diff
contents are printed, but yeah it's not robust to future changes.

> Also I am not sure if "caching" the file handle to /dev/null is
> good idea or not.  When will it be closed?  Would repeated
> invocation of the diff machinery work well with it (think: "git log
> -w --name-only")

I believe that repeated invocations work fine, because the file is never
closed (which may be a problem?). The file could be made nilable if we still
need something like that.

> This somehow feels wrong.  For one thing, RAW is about showing
> object names of preimage and postimage, which means it shows the
> preimage and postimage are either identical or different, and
> options like -w, -I, etc. that inspect and hide some textual
> differences should not affect its outcome at all.

Yeah, I realized late that -w --raw will have sort of unintuitive semantics.
This combination is probably rare but I guess users could set an alias for
diff -w.

>    I am tempted to declare that just like "raw", "name-only" and
>    "name-status" formats work with byte-for-byte equality


OK, I think it's better to keep the current (consistent) behavior.  I don't
think it's worth to special-case "--name-only".

It's easy to read the names from a "diff -I" output anyway.  This filter is
broken in various ways, but works well enough in practise:

	diff -I | perl -ne 'print "$1\n" if /\+{3} b\/(.*)/'

> and "-w" and friends are ignored just like in "diff --name-status --patch"
> the "--patch" option is ignored.

For interactive use, it would be more helpful to reject useless options
instead of ignoring them. Though ignoring is probably desirable to allow
liberal use of these options, I'm not sure.

> --- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
> 
> Subject: [PATCH] diff: correct interaction between --exit-code and -I<pattern>

Looks good.

> +test_expect_success '-w and --exit-code interact sensibly' '

Maybe 'exit with 0 when all changes are ignored by -w' though either version
is fine because I think the intention of the test is already obvious.
