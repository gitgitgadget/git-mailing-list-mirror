Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D769C3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 12:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjAFMtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 07:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjAFMtF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 07:49:05 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B4F745A5
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 04:48:58 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p24so1544257plw.11
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 04:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yh0iHzTtm0ioaUY3wXf3bSL3ZSE1FV1eeL7PLhJIkxE=;
        b=PGQSOERjyjnITzGzzNpVEZupUVmucsr8iw4P6iGO7JqfLMyVASZ4WMOQL1bPjzzSon
         lYw5HyrWyfoEGWOA6T27Ye0KJDDZOhPljQ+D0ODpEF0DV4DxHSd4v/mnQnNET+G9bAyh
         zhvwdkOKjYHuC3G4chQloRPxyHnLyDh4vVquV+Zx4urkIvuIAjJxTTxLfJ88kFJRSHOF
         q6XmPWdPftfz6Yxza6X0XZX2CA5UIWET5xuIZAz0SH7iXLBw5MKOfJGAAa6djYg2pgCR
         maVATt/A7hf7U0rXgWLIRhrqteHHpSyukdB5dy5yobseegzB/3XpNJh/nUXnaLvL1Y7A
         YBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yh0iHzTtm0ioaUY3wXf3bSL3ZSE1FV1eeL7PLhJIkxE=;
        b=ehK0tQzX3Bjtqs4FSd8PuhBhLg+2Bf0ViGYGC/iJ+rYIFFWjt70Smpp4dp5LH+32Vo
         EqMRVcNBCMSUbnKFEGwZoYwnS1uuzPJxQoEpfY2BXW+RW9PQn4y9GZcOskxkh3B5RjSM
         AefH2cgRfCeZ7iL9WONKCHtr+qRCbZmveqgcmT/PlXjb2GxDrFcISI7NA2DY7j2uMXGq
         Y1/r8igkT94gYyUBDXqHialf1wzGo+B8hWpFwEJ0u1nRPeMiBjWnmZtjOwuTwJNpgKj+
         EUpZ8lm63qoG6We7ULLZlJiAc9qOkNyMYppVHx9kDqAvJ4iswN5iliyft1FrOTnIf25s
         p3JA==
X-Gm-Message-State: AFqh2kohtJ7Z8I2YwklyJbHLVJdWrQRQEQgr7qbJKGjoj7Gr+VspE8Ct
        nb82D3jR33ONPEVLdSTO3pA=
X-Google-Smtp-Source: AMrXdXsMtBuV3iBP6K0XJBhsvR1IEpW6m0lviZZLIx6g81CdC3I7croZImKoLMqvYYMB6CxvEqP9Ww==
X-Received: by 2002:a17:902:c702:b0:191:2a9b:ec9b with SMTP id p2-20020a170902c70200b001912a9bec9bmr54317871plp.67.1673009337668;
        Fri, 06 Jan 2023 04:48:57 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902690600b00192aecb231asm902134plk.121.2023.01.06.04.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 04:48:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carl Baldwin <carl@ecbaldwin.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] diff: use filespec path to set up tempfiles for
 ext-diff
References: <Y7f/YiVu1TgbucDI@coredump.intra.peff.net>
        <Y7gAHenwmIo4gXTb@coredump.intra.peff.net>
Date:   Fri, 06 Jan 2023 21:48:57 +0900
In-Reply-To: <Y7gAHenwmIo4gXTb@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 6 Jan 2023 06:03:57 -0500")
Message-ID: <xmqqbknbsu9y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We can fix this by passing the pathname from the diff_filespec, which
> should always be a full repository path (and that's what we want even if
> reusing a worktree file, since we're always operating from the top-level
> of the working tree).

Very sensible.

> The breakage seems to go all the way back to cd676a5136 (diff
> --relative: output paths as relative to the current subdirectory,
> 2008-02-12).

Not surprising.  When I wrote all the rest of "diff", I didn't
plan to do "--relative" ;-)

> So the only bug is just the interaction with external diff drivers and
> --relative.
>
> Reported-by: Carl Baldwin <carl@ecbaldwin.net>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  diff.c                   |  2 +-
>  t/t4045-diff-relative.sh | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)

Thanks for a clear description.  The fix looks trivially obvious and
correct.

> diff --git a/diff.c b/diff.c
> index 9b14543e6e..59039773a1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4281,7 +4281,7 @@ static void add_external_diff_name(struct repository *r,
>  				   const char *name,
>  				   struct diff_filespec *df)
>  {
> -	struct diff_tempfile *temp = prepare_temp_file(r, name, df);
> +	struct diff_tempfile *temp = prepare_temp_file(r, df->path, df);
