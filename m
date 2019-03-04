Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB59020248
	for <e@80x24.org>; Mon,  4 Mar 2019 13:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCDNnI (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 08:43:08 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37256 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCDNnI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 08:43:08 -0500
Received: by mail-io1-f66.google.com with SMTP id v10so3963993iop.4
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjSvXagSnJc77dRFYRlFpBNy0zfGp3d9kUMieHKlwNk=;
        b=nKmZnNN9tgXPMyf2bfAXoEk0PHKf+GUYFMl6+bkfPJLlSvgmFzNio2reXjzsVCQ1CR
         P704akQbpxh2i9U6RpRU/YXZGE250mbNkhaXfNegEbeqsk/GIgyEsjPn2yFvgVG7XKYx
         aZn2SDyg/Vs6ny+bieaTfr4LmPIrJlWkBlZM2tCovnM+2pXYGEo5havetCtlU6u6MEpn
         0qTolO5o7vn5UnbVvYD0unciJLmLm3FzNxZ3LGjly3vLXotk0e3f21MVdwr+OibiZBVj
         ikG0E1rR+XbZbbsaT5SWoSf8SZMu7rEfj4K6+J4M+x7vdMOLG2bSQkhrZQtxbAdusrWX
         Qe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjSvXagSnJc77dRFYRlFpBNy0zfGp3d9kUMieHKlwNk=;
        b=r1A36hJdD1e+D9s0LbGZCRg6vqhSmBORP1p4DD9LHRBzJZI9WIB5lyQRHZfgEhofVm
         rxHnuPTr+z7ifXZhH05LIuHhpSxhkDgGlNbGWdwR+BujWQFbgyk5G1gK10l09TJYdDUB
         A7koXcS0i1vGRWXxz8d8qmqyeJKun796HUgkbAFH8r2SI4I644uyRLy4C3KSV0bxQaeI
         8LHkVHxQujQh5xhI9c+MBka1ISSE6kE0kD1pNiekwbnGIxsXAg7ZWr4mt3BOXpiXGNOe
         95eavIOYHuB0FLTNAb2plwaIVNzLXZtWuyO1qnOv4PrXhW6+4K1z2ZMZXcekDsFLWj/N
         qdYQ==
X-Gm-Message-State: APjAAAW0hBkEIvzGjW6P7PlPQ6hsRh8yCfViXTu04CTj+4CwPiJDspc0
        4m2WlpugAh2kvvAxRm1R4UDbryDw8TC0YL4aWDU=
X-Google-Smtp-Source: APXvYqx1XB3hv8sUgg6J45NwYePBGNK9xoBTLzNnoOUta4suqWpLL3qCbL3aoNu1Of7JfMRrhY57xhikqL31ccVesoY=
X-Received: by 2002:a5e:8416:: with SMTP id h22mr9942646ioj.118.1551706987060;
 Mon, 04 Mar 2019 05:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20190303165447.GA31116@sigill.intra.peff.net> <20190303165537.GA23755@sigill.intra.peff.net>
In-Reply-To: <20190303165537.GA23755@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 4 Mar 2019 20:42:40 +0700
Message-ID: <CACsJy8BWp9+SDwcXv_a6aFN=YSoQN3E7sOGDRm5a6Pi7QhzexQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fetch: avoid calling write_or_die()
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 3, 2019 at 11:55 PM Jeff King <peff@peff.net> wrote:
>
> The write_or_die() function has one quirk that a caller might not
> expect: when it sees EPIPE from the write() call, it translates that
> into a death by SIGPIPE. This doesn't change the overall behavior (the
> program exits either way), but it does potentially confuse test scripts
> looking for a non-signal exit code.
>
> Let's switch away from using write_or_die() in a few code paths, which
> will give us more consistent exit codes. It also gives us the
> opportunity to write more descriptive error messages, since we have
> context that write_or_die() does not.
>
> Note that this won't do much by itself, since we'd typically be killed
> by SIGPIPE before write_or_die() even gets a chance to do its thing.
> That will be addressed in the next patch.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  fetch-pack.c | 9 ++++++---
>  pkt-line.c   | 6 ++++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 812be15d7e..dca249e9d7 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -191,8 +191,10 @@ static void send_request(struct fetch_pack_args *args,
>         if (args->stateless_rpc) {
>                 send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
>                 packet_flush(fd);
> -       } else
> -               write_or_die(fd, buf->buf, buf->len);
> +       } else {
> +               if (write_in_full(fd, buf->buf, buf->len) < 0)
> +                       die_errno("unable to write to remote");

maybe _() these strings.

> +       }
>  }
>
>  static void insert_one_alternate_object(struct fetch_negotiator *negotiator,
> @@ -1163,7 +1165,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>
>         /* Send request */
>         packet_buf_flush(&req_buf);
> -       write_or_die(fd_out, req_buf.buf, req_buf.len);
> +       if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> +               die_errno("unable to write request to remote");
>
>         strbuf_release(&req_buf);
>         return ret;
> diff --git a/pkt-line.c b/pkt-line.c
> index d4b71d3e82..093b2f3976 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -88,13 +88,15 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>  void packet_flush(int fd)
>  {
>         packet_trace("0000", 4, 1);
> -       write_or_die(fd, "0000", 4);
> +       if (write_in_full(fd, "0000", 4) < 0)
> +               die_errno("unable to write flush packet");
>  }
>
>  void packet_delim(int fd)
>  {
>         packet_trace("0001", 4, 1);
> -       write_or_die(fd, "0001", 4);
> +       if (write_in_full(fd, "0001", 4) < 0)
> +               die_errno("unable to write delim packet");
>  }
>
>  int packet_flush_gently(int fd)
> --
> 2.21.0.675.g01c085a870
>


-- 
Duy
