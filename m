Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F48C2D0C3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 22:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA69206CB
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 22:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldo+4yEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfLXWFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 17:05:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43598 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfLXWFs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 17:05:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so16349469qtj.10
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 14:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W2Qv0EDq1HyQtmGCCg2vvoNhbMxTKtE4v8sDsCehGR0=;
        b=ldo+4yEtNuTXLdwgGZRzH0Et9uXTk5lfPmye+A6iGGj4uwa0vIq7ALUKKq13oUNfSa
         x8uWUuqKZI3gMnzWJaN8I0MuJeC5r38OL2Cv+emuhjw8MNUq6ehUo06IMLojvvbW5JcK
         SQP3vmvm7FBUAgq1ea4pMiSIe5zJ0Le3DKxx3c9BIMkmolJZvbb69JBKB7mV9wErHo1n
         LeIBQmvVkvzMkAkB4vdGwWlWJb0K5klkVFTH3ROrY91IL9BmjF7NG+Y5DspNd4VBU2p0
         OE+5lnudfRgYptX7C0HmZavvaVa3+0oZpSEVFVtln6Tb6nUkqHwEe4TJ8urI+pptQxHc
         wggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W2Qv0EDq1HyQtmGCCg2vvoNhbMxTKtE4v8sDsCehGR0=;
        b=lXAgDZjvwhqI88X6ZFxwmxaI7uItieo43FXgi495/BQRYzKo5bWsepE7iMFhAiMfFZ
         SNSgXGon670cjfpwnuS9VmjBoBVhagIniP9fToq9C1Qe2YasxYc1wOQiIm3+6Apnue0U
         a4oS+N2p6vH7tL1VimJpCR0fimwJJIjNYHmu5mHvYtOguwtjc9i5szmnoduaV2pBPyqy
         aFq07YFBg5VBAEkYB+wyzi8fUxGQuGe+Tfi67WM8TWogy5xp4CvFrX/YV4O7qV5DVRSb
         d0iQr/6CJIpYx6RSW1UnKG35c21o064WX4dm3qcC6hD4GNG7eUft7h5RVMwJHH13yd7N
         YM3A==
X-Gm-Message-State: APjAAAUW42/oSwgOaBQHMvoIK8U1N5TAHOipY68nRws0LUhok4FD968L
        Pnq7oqnWFmQwVzRmCk3EzsM=
X-Google-Smtp-Source: APXvYqy/RlueIfagLai44OAT8DO32H5Rvcz69bM9de7G7ebzlkWmeb7jnlBLKkKNUmS5wqXXbU9c+A==
X-Received: by 2002:ac8:6f09:: with SMTP id g9mr29204968qtv.275.1577225147490;
        Tue, 24 Dec 2019 14:05:47 -0800 (PST)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id w1sm8013307qtk.31.2019.12.24.14.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 14:05:46 -0800 (PST)
Date:   Tue, 24 Dec 2019 17:05:44 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] format-patch: make format.outputDirectory relative to
 worktree
Message-ID: <20191224220544.GA1917@generichostname>
References: <9422e4225143b2b908bd1fed9a510b9333bf34a2.1577191015.git.liu.denton@gmail.com>
 <xmqq36d95xwh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36d95xwh.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Dec 24, 2019 at 11:25:18AM -0800, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> > Rewrite the output directory logic for format-patch so that it will be
> > relative to the worktree of the directory. An escape hatch is provided
> > for if the previous behaviour is desired by prepending "./" to the
> > variable.
> 
> Anything that forces existing users to change their existing
> settings is not an escape hatch.  It merely is a regression with a
> possible workaround.
> 
> So I dunno.  I probably would have accepted a patch that *adds*
> outputDirectory configuration that behaves the way you are proposing
> in this patch if we did not have the variable yet in the system
> (i.e. three or four years ago), but I am not sure if it is a good
> idea to change it after these years.

Perhaps instead of switching the default behaviour so that it's always
relative to the top of the worktree, we can add some sort of prefix to
indicate that we want this behaviour. Maybe `worktree:path/from/top` or
`^path/from/top` or something like this?

Thanks,

Denton
