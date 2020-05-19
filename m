Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E5DC433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 16:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82A420756
	for <git@archiver.kernel.org>; Tue, 19 May 2020 16:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgESQXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 12:23:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35556 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgESQXz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 12:23:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id n5so4346156wmd.0
        for <git@vger.kernel.org>; Tue, 19 May 2020 09:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybthD4DLMGuDCpSv4ZDU+luA7NWljd56TO5LX2rbgGg=;
        b=BXGQ/p7iLOTTEdxXqqZdJKOMZWALWzIkbyxY7F3Zf5FqG06i9bGvhTwPlGX2g3PfWD
         3x+pfMWx110geyVXrCRy5GULmgeUun0JrO7aO8I3QJHRzjcpPRFVGLWngQ5H1SLMs+pK
         mmwarNW2dtHETagvr/0m/bexUyPWyglDYEQjGIKb6a1Jpmq42H+bvMGqAyFGmjYPbctY
         Gmg7pdznNynnhb8/wlekDztrAOYvRSb2BYelPntsTh1Zf7EW3zh2Bvp2qR6c1X4bdhP1
         RsAl5zOhwQTBmIoIQCNHGUkLwXVVTcE1cQyoCGLVY4+CRx35cNWuBKXOhcOfmV8jjbjA
         mQ+g==
X-Gm-Message-State: AOAM532dRHJXK5tRTCxKYCWJOvPCXfI6xG8GmqHsThMynhDgQk1KfPxS
        fi3rMhIUd7JVqgcZUwwkwRs+6drWO1L8yOa657A=
X-Google-Smtp-Source: ABdhPJyDnptxMhdY5slphud0IhFXt0R5lrEcLpVhX/hcpUULMmec0mDl0+6D5xsyyZulcjdf7ZSYIE9MlqyOkh/BveE=
X-Received: by 2002:a1c:2702:: with SMTP id n2mr169878wmn.107.1589905433301;
 Tue, 19 May 2020 09:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589816718.git.liu.denton@gmail.com> <cover.1589885479.git.liu.denton@gmail.com>
 <36885943b239807eda49e231d8a45e1991f7288e.1589885479.git.liu.denton@gmail.com>
In-Reply-To: <36885943b239807eda49e231d8a45e1991f7288e.1589885479.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 May 2020 12:23:42 -0400
Message-ID: <CAPig+cT1KfkszVW_Wvwz+r7Q0TsP+iTx-Cc3UvasS5ESBGdAAw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] pkt-line: extern packet_length()
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 19, 2020 at 6:54 AM Denton Liu <liu.denton@gmail.com> wrote:
> [...]
> Change the function parameter from `const char *linelen` to
> `const char lenbuf_hex[4]`. Even though these two types behave
> identically as function parameters, use the array notation to
> semantically indicate exactly what this function is expecting as an
> argument. Also, rename it from linelen to lenbuf_hex as the former
> sounds like it should be an integral type which is misleading.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/pkt-line.h b/pkt-line.h
> @@ -74,6 +74,15 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
> +/*
> + * Convert a four hex digit packet line length header into its numeric
> + * representation.
> + *
> + * If linelen contains non-hex characters, return -1. Otherwise, return the

s/linelen/lenbuf_hex/
...or...
s/lenbuf_hex/input argument/

> + * numeric value of the length header.
> + */
> +int packet_length(const char lenbuf_hex[4]);
