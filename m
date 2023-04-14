Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDDAC77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 18:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDNSkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 14:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNSko (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 14:40:44 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E2E55B4
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 11:40:43 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id cd9-20020a056820210900b0054195d9431dso3514989oob.11
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681497642; x=1684089642;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRetIA2oNqUEnotynIRzG6UCI48YCWDqhNlQExbGt28=;
        b=oYYjIljarbttI9y2aQaZqvitTQ7AUFxckuNwSOVxgyvCCS1HAnZ+JI5SP6EV3h7U0i
         oT1igR2o0fzYu+63cksbpnMYk3Z9I54PwRGag2TsrSVajrgThi/3ALKtCLJGb7/xfBNK
         rM2ok3OcO4YacsCQ0X/vpWJUhBjEfKrXYD7Djr+0ijrsgI/xCgWFcOYIQqeaHn87ENSe
         cancPTRG2r10RN4HEccqUubuP8bh8A8iFZaxooyAeWzFI8JBIVzCZK1Kidxj/8owlxcr
         0RdLX4+6yNo2aE18XiFBbuGPGZmE5ORMVPjk35+28wU8qUvuwOZVI+p0QFIEA9/2jk8P
         kQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681497642; x=1684089642;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BRetIA2oNqUEnotynIRzG6UCI48YCWDqhNlQExbGt28=;
        b=kzB9AQOILFjS7qbpBoHuTNrOxztwDrl7IeB9Vg67NCHgbMnZh93pu1wrSTWj1AbOpJ
         A+OQoe56PsLOVC6v2QqYP7dHzcu/Z3DfNwtNCBfmV0VlEZJDObbO3DSesb5iQFEEde/b
         j0pOOBnu3rOIXNIjFgrQ1NRsE2rZ3xpxZRgu+5xQCRS0R1Px8VqOm72BlN3BMhN18fcb
         ss9nEGziFAEN+5Lxl6n0jbaVN028eOOJOpjttrxYHVRMPI35gr1xSHTaMiBgWUCL74sW
         BJl3u10kTqu09+yeIGXVS3vUikjoHuKAtPo3Zpo8bDSg8l1TDYyzJlT70C7MYvizqiGO
         3Jjg==
X-Gm-Message-State: AAQBX9cUaYwdBSjee443yK/IbY3Go0wt1DPnEJkmf16UVmao+xHzLq0u
        8CJTWj1jiJOQHV21lxaRIe3FGh9Xta0=
X-Google-Smtp-Source: AKy350bA9fSbGi+ZRMI4mcsVESlZU6F9KEWn3SGV4EpGGcBeXWRYXLZRu9kHD/5DAspNRLUwelmO5A==
X-Received: by 2002:a4a:52cf:0:b0:542:26f2:e003 with SMTP id d198-20020a4a52cf000000b0054226f2e003mr3150279oob.6.1681497642467;
        Fri, 14 Apr 2023 11:40:42 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u9-20020a4aae89000000b0051134f333d3sm1934224oon.16.2023.04.14.11.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:40:41 -0700 (PDT)
Date:   Fri, 14 Apr 2023 12:40:40 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Message-ID: <64399e28eed60_5f7732949f@chronos.notmuch>
In-Reply-To: <xmqqa5zas7xf.fsf@gitster.g>
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
 <20230414070449.GA540206@coredump.intra.peff.net>
 <643949a57396c_5b7e62948d@chronos.notmuch>
 <xmqqildys97o.fsf@gitster.g>
 <xmqqa5zas7xf.fsf@gitster.g>
Subject: Re: [PATCH] doc: set actual revdate for manpages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Formatted output from a repository working tree changes from
> > "04/14/2023" to "2023-04-13".  The value change may be intended,...
> 
> Forgot to mention another thing.  While it may be a good idea to tie
> the datestamp etched in the formatted result to that of the source
> material, rather than the date the formatter happened to have been
> run, the committer date is more appropriate than the author date for
> that purpose, as the former is the date that the change made on the
> latter date (which is earlier) has become a part of the whole, from
> which the formatted result was produced.
> 
> It may not make a big practical difference:

Or _any_ practical difference.

>  * For an individual who is trying out the changes just made, the
>    committer time and the author time are likely identical.
> 
>  * For a release process, what is at the tip of the released branch
>    is likely be the release notes and version bump, recorded by the
>    releaser, and again the committer time and the author time are
>    likely identical.
> 
>  * For results of a pull request, the times are likely identical for
>    the merge commit.

Agreed that committer == author in these cases.

> but from the philosophical standpoint, it does matter.

I prefer to focus on the real rather than hypothetical (or
philosophical).

I do create my own releases (e.g. 2.40.0+fc1) and a real issue with the
version script (rather than philosphical) is that it only considers
annotated tags, so I have to carry a patch that adds `--tags` to the
`git describe` command.

Shouldn't dealing with real issues of real people have a higher priority
than philosophical issues?

For the record, I do agree the committer date feels more proper, but it
doesn't make any real difference, I just wonder about the priorities.

Cheers.

-- 
Felipe Contreras
