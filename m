Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FE0C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216DF2137B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 21:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="DU/X9+tl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgD2VtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726950AbgD2VtJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 17:49:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16156C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 14:49:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d184so1744983pfd.4
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R1JAgM1YxN4T3x6necT97cV1uPjmEEcBM8zFEILO+6s=;
        b=DU/X9+tlu2b/iyB6XtSQLSKk+FG8jt04wmdo+/cASPLeBimAmJ27wHgXNrs9mF8OWG
         ak0eRnuWa8wnTJ1xSHiYXwLxFMuW3AYNovFZZJMaWnjdHpYtnmzrVTRc3FfNnqpCowm6
         GaCPTDuUo7XmQs8HdV7kCR2J61j6LbPTdvRapqad8OxIVJREUBoMmmczqmqvb0DGc8k5
         LiIx/1Y5Dge5a7nzO9yaFb90JEvnZwvUlorVFC7ioBjorWCS38NTRxwOmVwQht+L9p6h
         GXkRUYmtxFNLtYlrJ1+UjyhNyC2dYwEOEevGH1kUYxOuMiHDuZZiFWbK63Ng7RfXFxHd
         46Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R1JAgM1YxN4T3x6necT97cV1uPjmEEcBM8zFEILO+6s=;
        b=jagHeWrPVfs2GsFUlOVsbahKcSxiHulwacIiHWrnRo+BXu4fvcFqV3GvnH0hqhRhu0
         qfA6T2RYmEkFN8hLv3hQxpyTR2Qxht2sxJ3GFGDvtrHcIPC2k9SEpkUmRa6wxC2XoAOE
         /szPXbnUJjgqHDT7MsaB9VdwagbPvsVrmsNxXvnl0J5ddLcsWmjXVE3Su0aiBngdRyQ/
         xBwiSk85XxyjteZVGuiDKrG6l1kfmZW7BKw8+U8nSc2OM6C+Sq5LmpqwfHwHFahc1osl
         ix6lMucKERdEdJG+Y9sbO/l2ly0P347nC3Nmbz86k7Vi8KIJpWHPFEkXORuXQ3/WtHCp
         rGXg==
X-Gm-Message-State: AGi0Pubm2bGSj0vHugoi+eTBIjFTMUuqIf457gBI5pW4dJ/6+UPlx8ls
        ALLGq0wQrpuifhGpEh92GBnIHw==
X-Google-Smtp-Source: APiQypIu6K4sh4P+uihaQKU+QdA5Ma41oqKYZKOvCo47q7fI77eW/JZjfemuoyRA/Va/pPPWaK4yqQ==
X-Received: by 2002:a63:cd47:: with SMTP id a7mr262973pgj.322.1588196948367;
        Wed, 29 Apr 2020 14:49:08 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x195sm1855225pfc.0.2020.04.29.14.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:49:07 -0700 (PDT)
Date:   Wed, 29 Apr 2020 15:49:06 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Taylor Blau <me@ttaylorr.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* [PATCH 0/4] t: replace incorrect test_must_fail usage (part
 5)
Message-ID: <20200429214906.GA12075@syl.local>
References: <cover.1588162842.git.liu.denton@gmail.com>
 <20200429195035.GB3920@syl.local>
 <90edb162-e035-bdb7-a2d2-ffc6bd075977@kdbg.org>
 <xmqqblnaufyt.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblnaufyt.fsf_-_@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 02:42:02PM -0700, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > Am 29.04.20 um 21:50 schrieb Taylor Blau:
> >> This comment has nothing to do with your series, but I am curious if you
> >> are planning on touching 'test_might_fail' at all. These can be useful
> >> for non-Git commands, too, such as 'test_might_fail umask 022' on
> >> systems that may or may not do something sensible with umask.
> >
> > When it's not a git command that might fail, the idiom is
> >
> > 	... &&
> > 	{ umask 022 || :; } &&
> > 	...
> >
> > -- Hannes
>
> I hoped to find this documented in t/README, but ended up writing
> this.  Overkill?  I dunno.
>
> -- >8 --
> Subject: [PATCH] t/README: document when not to use test_might_fail
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/README | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/README b/t/README
> index 13747f1344..870950c7d1 100644
> --- a/t/README
> +++ b/t/README
> @@ -875,7 +875,9 @@ library for your script to use.
>   - test_might_fail [<options>] <git-command>
>
>     Similar to test_must_fail, but tolerate success, too.  Use this
> -   instead of "<git-command> || :" to catch failures due to segv.
> +   instead of "<git-command> || :" to catch failures due to segv,
> +   but do use "{ <non-git-command> || :; }" to ignore a failure from
> +   a command that is not git.

Hmm. I say this as somebody who just re-rolled a series to add two
'test_might_fail umask 022' lines, so am a little disappointed to learn
that this is not considered to be idiomatic.

To me this seems a little overkill, but it may not be on environments
where an extra subshell incurred by 'test_might_fail' might be overly
expensive.

Junio: do you want another reroll of that series? :/

>     Accepts the same options as test_must_fail.

Thanks,
Taylor
