Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEE8C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA8D20659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbgEMXYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 19:24:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42270 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732374AbgEMXYF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 19:24:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id s8so1528572wrt.9
        for <git@vger.kernel.org>; Wed, 13 May 2020 16:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkNrPMguP1X/y7GoLBEnSMtZHdl2kzxyneNnO9ToXIQ=;
        b=Zaw1mk/A6PpK4+7JGp9dNScmjKfes8WJO0q8BUNhhMheXd6JJ2+RbJacJtoOC7fDBy
         yas/HxepdZ14ZOhBHyOyXr35T3XVWsfjnnzOH1Qh4PFMwfcHl8pZJGdCArxk2L73MYL9
         Axew7coJ+xL9vZJfklT6YqncS5gfmwLxXMBl/bZjDlPpHLwS2YhqE4lEDkv2DVxrDiH0
         2CxxEre7ayJ8RLWBpgjkSoXN+Yk7swo0oqqIkRaxD6HoSY/J9g+1ZjF30f2v8YXlvlSj
         zrov580y474IsIA+y3Gwm9nEllw81Bmsq2osw3NrIaEE+DkQvP5vsesxm8aSqalhUpxL
         7GOg==
X-Gm-Message-State: AOAM532hKqnwGVOiu7KW4kY1As6C2gaW1opw2AQ4bQ6bYcaijyyr+l5z
        ELYI4DOXpixJ2hSyokFx8byWf2hYyxgZLdEeYZc=
X-Google-Smtp-Source: ABdhPJwVWYHT+U+N99SOzo37okqV7+bdf/WbYB+J2SO1QPEhibp42dABjU+GKAQjeDxZyJQAmTSCIVYKkCtTDlVfMoE=
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr1918038wrt.415.1589412243990;
 Wed, 13 May 2020 16:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589393036.git.liu.denton@gmail.com> <891a39c853ce3669b6167dc9ad8a2328e4321a9e.1589393036.git.liu.denton@gmail.com>
In-Reply-To: <891a39c853ce3669b6167dc9ad8a2328e4321a9e.1589393036.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 May 2020 19:23:52 -0400
Message-ID: <CAPig+cQpQsoCg4ujASek3RP7HhHVpgprXbekGQJKseX=tbYYfw@mail.gmail.com>
Subject: Re: [PATCH 4/6] pkt-line: extern packet_length()
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 2:07 PM Denton Liu <liu.denton@gmail.com> wrote:
> In a future commit, we will be manually processing packets and we will
> need to access the length header. In order to simplify this, extern
> packet_length() so that the logic can be reused.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/pkt-line.c b/pkt-line.c
> @@ -306,7 +306,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
> +/*
> + * Reads a packetized line and returns the length header of the packet.
> + */
> +int packet_length(const char *linelen);

The function comment seems rather gobbledy-gooky to me. Perhaps it
could be clearer by saying something along the lines of the input
being a hexadecimal 2-digit representation of a packet length and that
the function converts it to a numeric value (between 0 and 255).
