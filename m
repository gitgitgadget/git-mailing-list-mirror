Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B87C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21991207FB
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="xPSvAbsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHCQkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCQkB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 12:40:01 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EB1C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 09:40:01 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id 6so28716640qtt.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sO74Hmz6kFifdZckJPJxz4JaZmRFbq8obvgFVB4PFzE=;
        b=xPSvAbswDz3pO6Kwam286uxuNxx8/ENua5FERPpijeyxPjnRBauHao0apGVLc79GrA
         ihsh5xJhDzoZhcOgggWilTrJcp1G829/d6NJYYhWtgahc2F3mBBEG7KoBQrFQCwNlTBn
         M9JjvMbE0w6euyb6xwTVzj6bFCvFI6zsrhRp9zyU8s9oZ83bNmQM6Y4TseEECdO5aGW6
         0PmUD68E2ihXKiL8FhzkK/HwL6HjSn0fAOAXeVY+pPh+4YfWA4eUTIkdv/FmiHfkazhb
         e7qAe4L10BeYGv+P/We8vjT6OvDVhYOZ73XmKOO1PGehMqm/hG0IuilQ/0YncFP3cHTs
         ExNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sO74Hmz6kFifdZckJPJxz4JaZmRFbq8obvgFVB4PFzE=;
        b=P4LTwW9zeoXbj9zUU5iAQk+NUhDcXqN/SlecVbfWH69jsMlHphSD/Un7vh3hO1H3iX
         7EJntqxckx1FD5OBulZjNZwMGLMqKA5VOmuRzCgL4Nf+XDfZO7qrOdE66wqD+CVNxYmp
         aA2sBLNTNNZ4g1ad51QTv89pVkepbKmb5XX5rGTawG8/7bqve+R7ZB1iM4AwpwZjKGr3
         0TRIr6aVl2752dSHNY9RtFVc/MlDuO+yntIHXG2YI9S/feGbp9tssFcCPQC0r73zO3Bz
         RUa+8TpiBZl9hZeHjntIMOHvgpenS8Db5Iq+JBCr7/OpSLTXZUa7bBqOjuaZcA6v1Zpc
         x1WQ==
X-Gm-Message-State: AOAM532P41pDYXATEicFPptcPmVdgoNfmtmBKXZUOJGIuFruHSdtA5au
        5S0YAmCrrJgIfePgKCEfnOr99A==
X-Google-Smtp-Source: ABdhPJxcKaMV4OuYbODMtEZSsDWHE+2+LfNbe4Za3DOmzJJH1UJ191CJRe5vhGzKDZ7bN5Bw0VV+7g==
X-Received: by 2002:aed:2542:: with SMTP id w2mr3322537qtc.272.1596472800290;
        Mon, 03 Aug 2020 09:40:00 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id d16sm19343547qkk.106.2020.08.03.09.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:39:59 -0700 (PDT)
Date:   Mon, 3 Aug 2020 12:39:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: Renaming the "master" branch without breaking existing clones
Message-ID: <20200803163958.GD50799@syl.lan>
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
 <20200803160051.GA50799@syl.lan>
 <xmqqh7tjwvkn.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7tjwvkn.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 09:19:52AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I am a little uncomfortable with the idea that a 'git pull' would modify
> > 'refs/{heads,tags}' in addition to 'refs/remotes'.
>
> Those who want to rename their own branches should be allowed to do
> so easily when it is convenient for them to do so, whether the
> reason for renaming their local branch is because their upstream
> renamed the branches they are interested in and have good reasons to
> use the same name, or because they made a typo when they created
> their local brnach, but I do not think renaming the local branch
> should be done automatically.

I agree that doing so automatically would not be welcome.

I like your idea in this thread about doing so with a small helper
script. I would even be OK with something in contrib that understands
'--dry-run' (to print what it would have done) and '--all' (to rename
all tracking refs at once).

Thanks,
Taylor
