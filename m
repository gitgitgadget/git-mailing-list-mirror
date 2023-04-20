Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F5FC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 16:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjDTQpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjDTQpj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 12:45:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A76F2D63
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 09:45:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a667067275so11688755ad.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682009137; x=1684601137;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5uWQxgRRmieJjutpxzyfOvVwUUBx+UQbtkmv2n3wfys=;
        b=seXoq/Xq2xNwDm+el0rDpiG4C0k8crRyspsQ3j6Jw4zPIuUKF+LhYQhtFZrAOulW7s
         ew2qVFp5aP4FoZA/T7YbgPSLhZPyCAwDO1wrVsNMYFQE8Exyw+/TtcQtqalgg1dYGaHt
         sddxba6X8e6t9DarNZfWbQ+X2FQAZ4Gc0o8iQvevzjkSiP4JPzpWiqh/uLLtDxujsXku
         kyRgLJf3Eh4UBvdrcKF7VffKGQVRxL+aNy/SlRDPqAcKyU3U2lswmSRCtu5cCC71Gdm6
         jNkQcLCGdqC4kg0390EVgew8biVQ6d3hQpDntBVEJqDKi1G9hA2TdKv565QsEy2ZrTSi
         PLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682009137; x=1684601137;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5uWQxgRRmieJjutpxzyfOvVwUUBx+UQbtkmv2n3wfys=;
        b=IdAN4xmcTqwOZ8WbCPanwcXHWCVAXenzt0SAGDCGV10VNHZgLHc++Afx91Sbb+OFFS
         jm2/nyXuXmxjdBRQdBZCwyjBVfbAwBnpUwtfEr0oqhHApVsAKDP+3217di0YhA8g/O0Q
         iPMtCyZakFDbWrECDc9AH2GeQDoOBG0H1vPHX5UBuZQzzuD4RAje78diyvJKEhenkwd0
         pDGqmSxXALpaKYxDdiVxw2oDYIL7jOWsxuOrI4G7aAe/BOg3u1TpeXj4w0uw0POLdX3m
         bP/Vi+a6jAVJYYlPgiya3wi8viH6RrVEgI4adXr6fIrZG8QyiQUt9ozIkPoPiFcv7sQ6
         ksgQ==
X-Gm-Message-State: AAQBX9eJxNFk7YxTStD4sJkAFxcr3iyjbBptRHPq3JgvLWW8pxMwmN8t
        lnPEshwkAdnBFX7P4PjXv4A=
X-Google-Smtp-Source: AKy350aBGaN4MJoDru9ooie+8hm1yOgC81jkzaDic+8YWOCh1VNb7Ms61Ym+Grn3vExly6aINHmYdA==
X-Received: by 2002:a17:902:d4ca:b0:1a6:523c:8583 with SMTP id o10-20020a170902d4ca00b001a6523c8583mr2425781plg.68.1682009137365;
        Thu, 20 Apr 2023 09:45:37 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id jg20-20020a17090326d400b001a1a82fc6d3sm1355223plb.268.2023.04.20.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:45:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Koichi Murase <myoga.murase@gmail.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Edwin Kofler <edwin@kofler.dev>
Subject: Re: [PATCH 2/2] completion: suppress unwanted unescaping of `read`
References: <20230420074616.1642742-1-myoga.murase@gmail.com>
        <20230420074616.1642742-2-myoga.murase@gmail.com>
Date:   Thu, 20 Apr 2023 09:45:36 -0700
In-Reply-To: <20230420074616.1642742-2-myoga.murase@gmail.com> (Koichi
        Murase's message of "Thu, 20 Apr 2023 16:46:16 +0900")
Message-ID: <xmqqmt321ozz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Koichi Murase <myoga.murase@gmail.com> writes:

> From: Edwin Kofler <edwin@kofler.dev>
>
> The function `__git_eread`, that reads the first line from the file,
> calls the `read` builtin without passing the flag option `-r`.  When
> the `read` builtin is called without the flag `-r`, it processes the
> backslash escaping in the text that it reads.  We usually do not want
> to process backslashes of the input but want to read the raw contents.
>
> To make it read the first line as is, pass the flag `-r` to the `read`
> builtin in the function `__git_eread`.

We USUALLY do not want?

If there were even a single caller that does rely on the usual
backslash processing happening in the current code, this patch is a
breaking change for them, so that phrase is not acceptable as a
justification for this change.  Perhaps

    After looking at ALL the existing callers of __git_eread, it
    turns out that they all want to read the first line of the file
    literally.  Worse yet, some files they read may record file
    paths, which may contain a backslash, so what they will read are
    corrupted unless we use `read -r`.

or something along that line would be more appropriate.

I did look at all the callers and I think they want to read things
literally, so I support the use of "read -r".  But I didn't validate
the other claim "may contain backslash"---the "... file paths, which
may contain ..." in the above example is a totally made up claim, as
I do not have access to a platform whose pathname separator is
backslash.  Please replace that part to describe the real world
problem you encountered that led to this fix, if there is one.

Other than that, a very well written description and good change.

Thanks.

> Signed-off-by: Edwin Kofler <edwin@kofler.dev>
> Signed-off-by: Koichi Murase <myoga.murase@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 9c10690a22..49dd69bb84 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -298,7 +298,7 @@ __git_ps1_colorize_gitstring ()
>  # variable, in that order.
>  __git_eread ()
>  {
> -	test -r "$1" && IFS=$'\r\n' read "$2" <"$1"
> +	test -r "$1" && IFS=$'\r\n' read -r "$2" <"$1"
>  }
>  
>  # see if a cherry-pick or revert is in progress, if the user has committed a
