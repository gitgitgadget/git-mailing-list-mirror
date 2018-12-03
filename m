Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01391211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 23:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeLCX7c (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 18:59:32 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:43892 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCX7c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 18:59:32 -0500
Received: by mail-ed1-f51.google.com with SMTP id f9so5889805eds.10
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 15:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdJGnVDjZjOyqb9NzUVGlNZQSXu53zkxJ6dEwlAfL8M=;
        b=Bhcgd4VDb8n5waoAhS1nYQozNOfiY4E6Y5MeMagq35hlAKyCglDfRW8asBFUjOqQxG
         vF2GRucBC2JxdxH+xuE6YtpDRPzTEqnNeCUf8ubiVtCHOSssHLxFMkk0SSG6dA3oGpNQ
         P6GU3XOd5wXPvtyjlYU8b1jmgAmGJXS4JDx0y39VERL4fYmYDEGi4zckrlPN9kcXPakm
         cIBwuxl0eHPQj5vW4PH/UpGGn6Jjuv993FxmRMQMAK6ttEUKcAFYEd9U26McF9u9hdxe
         Ws/31N23GAhtOLysENaGokCk8d8dpi16UoZse7CDsO5M2Ka71Mlx+YGPukc+UaLQOmGo
         792Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdJGnVDjZjOyqb9NzUVGlNZQSXu53zkxJ6dEwlAfL8M=;
        b=kM1S0yPNPTEFZZfCJfjEz0l1HV310Vwea9eIBr4bpfJFQrsDyVBs8e8IGJZXUDK3vo
         OCGA1i1SrCER2pdQvzFPil16i+SDVxbbwk/QM4wgeoxN3zsZj0qQAseW44UgC2J7l05L
         2u5fELl9UqunW+NYtwz4sxk663eDMiNZ6PadnGeysKZi2NBbO3KcQFK0pOmAUb9QnEbx
         fUPCW+29OqAWlZzU7c5151Qif6K11pGvAzHRHEJv2O7SXd/hLwBMVDib915UO5gqQRUy
         cUO16Nex8FxgFhRRenrSx9r+Wjj5YT0XPpzWfl+TbkvVKsW50k4Vvi5bkHLeWYIc5tON
         +9ZA==
X-Gm-Message-State: AA+aEWaY+OhdCTTHrlA9zrPTzgHGfzAn6sL3TK7UYyA4V6U7kb3pjnTb
        TeyO9ricfk2eHlwdfHyk9BSfUGpGCa1hsAARqBmgcc+0ppg=
X-Google-Smtp-Source: AFSGD/WzEmyWH196xa6yBB3VArvgDWEHl+HlU2U++Xz3fqqrBpsKFINS8yke8KuKc0oYuCOdrgkeojOZr0yMs8qCPWU=
X-Received: by 2002:a17:906:e287:: with SMTP id gg7-v6mr14380121ejb.128.1543881570595;
 Mon, 03 Dec 2018 15:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20181127045301.103807-1-masayasuzuki@google.com>
In-Reply-To: <20181127045301.103807-1-masayasuzuki@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Dec 2018 15:59:19 -0800
Message-ID: <CAGZ79karTiSh94qwgrL76qOQ_W_bEK=2y3UvSsdz+cHpUXXqeQ@mail.gmail.com>
Subject: Re: [PATCH] pack-protocol.txt: accept error packets in any context
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/pkt-line.c b/pkt-line.c
> index 04d10bbd0..ce9e42d10 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -346,6 +346,10 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
>                 return PACKET_READ_EOF;
>         }
>
> +       if (starts_with(buffer, "ERR ")) {
> +               die(_("remote error: %s"), buffer + 4);
> +       }
> +

Handling any ERR line in the pkt reader is okay, as
* we do not pkt-ize pack files and
* we do not have any other parts of the protocol where user data is in
  the first four bytes, which could randomly match this pattern and
* the rest of the pkt-ized part of the protocol never sends
  ERR lines.

Makes sense.
