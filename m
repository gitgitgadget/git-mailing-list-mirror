Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,MONEY_NOHTML,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4500BC47096
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 02:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B79613E7
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 02:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFDCS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 22:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhFDCS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 22:18:59 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF08C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 19:17:04 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id o9so7469525ilh.6
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 19:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vuq/deus2VvznM1iN+iK7mmk5qzJY38Ms4n5Lnsz0Wk=;
        b=dEN0g6AUdRXcj2pdXQQh8lR2q8tXxf+ItkHruSYaFqyi3xx42GrIbhdSg2tcwwusKW
         zy5+GdQ1pYBw/bbgRt9N8yyh+AuAT6whMKc1+wFsJiXp8QYS8JBtEx15Mmq4mPpLCiNX
         PvlUVyZ5VcqQHN3MZM5mKSwOPTpVBLenSD+0k8IfqySnx39a4T2HIYjCraeqaa0+GVJd
         GGx7+Cd2uQsFLqCAVp6sC6Mb56gvQyZdUyW3m/SG9TCT/svYpjrHDvo9zOXFKqNoZ86b
         +nxNxlhqJBQFtZSK3o/y1GPdaEdGJsQEPYrCItvT6u/Fxd4bekDVcT1ZDNaVk01/38LW
         yjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vuq/deus2VvznM1iN+iK7mmk5qzJY38Ms4n5Lnsz0Wk=;
        b=AoFx3SdprA9JvY/OmuBKqem6rH1SbgwVLHMqvwGzV2fcfR0Vbl0ijPFWxcIRf0oogK
         h9Zvj8s2nQ1Z9CETYG8VwYJZbg8Wasp2y88QHw4Fk2GmNwMAyqsB3pTK9dYKmlKyzQqe
         5Le0RCdf67LHCT8kByuU8nkmoLFFVbC9mjuf2QNoPklRSyLyNPEw/CDHqN6IAzVspP96
         p3jlqzyQ3+pmmdBQCfP7HpOft4eHSlwTK7VAjXOVNiGCPxMyBQtn0SQnQDZDGiLGCmhJ
         r6oLpw0I5p1s9Qmz6LfPFnCPx5qoHgBXyz7GU0GGWkrG2n1BFTfse3VhnLDgWdFQAc/M
         /MZQ==
X-Gm-Message-State: AOAM531wKxk0cpPmjJc72USvXDqrWXLOkTLIgqzaprY2lJP3wDriKlnb
        d5oEaFuvLpZDjSb1F0tTlt2YwInXMQa6ij3/
X-Google-Smtp-Source: ABdhPJzXHisMpEazX7+3+o/zo6qZqpE0NcXW+uDDP0a9QulNfoTHjwbXZPk2rD598xl+H0QhY2fq3g==
X-Received: by 2002:a92:260b:: with SMTP id n11mr2029412ile.134.1622773024153;
        Thu, 03 Jun 2021 19:17:04 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:ef50:a591:771b:2047])
        by smtp.gmail.com with ESMTPSA id z14sm2754016ilb.48.2021.06.03.19.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 19:17:03 -0700 (PDT)
Date:   Thu, 3 Jun 2021 22:17:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
Message-ID: <YLmNHpf+dXdK7OeH@nand.local>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
 <YLfc2+Te7Y3UY+Sm@nand.local>
 <YLfgy94sbmStC0mR@coredump.intra.peff.net>
 <YLfl4jkuwSCiNrrS@nand.local>
 <YLfm8cqY6EjQuhcO@coredump.intra.peff.net>
 <xmqqk0na2yyc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0na2yyc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 04, 2021 at 10:36:11AM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > This looks as I'd expect. But after seeing Eric's response, we perhaps
> > want to do away with the knob entirely.
>
> Thanks.  I was hoping somebody in the thread would tie the loose
> ends, but upon inspection of the output from
>
>     $ git grep -e fsync\( maint seen -- \*.[ch]
>
> it turns out that fsync_or_die() is the only place that calls
> fsync(), so perhaps doing it in a way that is quite different from
> what has been discussed may be even a better alternative.
>
> If any new callers care about the return value of fsync(), I'd
> expect that they would be calling this wrapper, and the "best
> effort" callers that do not check the returned value by definition
> do not care if fsync() does not complete due to an interrupt, so I
> am hoping that the current "we only call it from this wrapper" is
> not just "the code currently happens to be this way", but it is
> sensible that the code will stay that way in the future.

That makes total sense to me; I can't imagine a scenario where you
would want to call fsync() over fsync_or_die(). But if you did, then you
probably don't care about whether or not fsync() was interrupted, or can
check the return value yourself.

If it became more common, then I wouldn't mind #undef-ing fsync() and
replacing it with our own hacked up version.

> Obviously I appreciate reviews and possibly tests, but sanity
> checking my observation that fsync() is called only from here is a
> good thing to have.

Your patch looks good to me (and Randall already tested my version with
the additional knob on NonStop and reported it working as expected[1]),
so this has my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor

[1]: https://lore.kernel.org/git/009901d758b4$12016d80$36044880$@nexbridge.com/
