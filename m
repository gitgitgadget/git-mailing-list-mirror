Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF681F404
	for <e@80x24.org>; Sun, 28 Jan 2018 19:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeA1TuU (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 14:50:20 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:44362 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeA1TuT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 14:50:19 -0500
Received: by mail-qt0-f173.google.com with SMTP id l20so10226658qtj.11
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 11:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nrB80DRc+4ybeIPNHSWI88hQAtNKnYrC01N14g6uUCo=;
        b=Rogz/AZ0j2quck/llRcYJN3o+MVRhaVwBlQXDANsRxH6V6a68j33Tig9XKJZRg0I58
         +mBjqe0pSXtba1jWCG5QwNsE5MVSyuET4pto0Se962+Edyx/79dJrwjOTJPlMcfees57
         H99+IrJPUnhm9e6suL1wKJ7Z1SpO3WQxjrzpmK3z9BbuJE0TpYazcD05db52ubcoE9lO
         wgi+qtDN4dMoxZHHi6D9rVXLQuUnVF4nd0JtVZ6WvIvUyTAiwRc1/cFZBK2YK7Cas68T
         9zQn2h8xMFl2lPS3f333UFvOtqAaRkKoLwh5Wlw8/KmvuZHQEqYhxkDrGH3Wgfz/Knpu
         AD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nrB80DRc+4ybeIPNHSWI88hQAtNKnYrC01N14g6uUCo=;
        b=DdOBQJ9tc5+rUsPv49PmgQxp+pBE4Ca6lv1LLcwA4yGtUQCCBKgGLyLgQOAXzzLgEZ
         j+s3Iatq1X4qAGV94lHn6MfZfPXmn3OQrQDfTIsgNgqo1TAohhFX4sdst3onp8gW/Mm/
         amNhQ+oaz6sN3TuO/MguGXEbn6oW1STuhMKHssT0kyMMa+MfOaf5xkxTFlyn/Om1XeWz
         STITOO634hAkFFnvTeCYPtAjIm2+V0AMxOmXD++tEufjWkygZ7YuFGzyXn04zzqzlHzN
         vfUjOXo1Xf32V1HHmTd8iqQse84YVuxZwiM1XExu8YkQRrYHhRL/lcymFr0W7RZPL/N/
         QP6w==
X-Gm-Message-State: AKwxytfE38GO0riik6MtgmxK3/pg4S8HVk/2cUhauL0KVNRep7XbFWMB
        esQ3VkTQlNwGJm9wtzpvG/ojxYm856/TqAPvStw=
X-Google-Smtp-Source: AH8x227ezpuNmLwwRYuqvwt5qBxEcdAXb36o01SDXXBYTlrVBOvvPAlMgWbZUZb6fT+I2u9XfDgRV/vXzeHSP3Ngy7M=
X-Received: by 10.200.47.130 with SMTP id l2mr35168059qta.277.1517169019142;
 Sun, 28 Jan 2018 11:50:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sun, 28 Jan 2018 11:50:18 -0800 (PST)
In-Reply-To: <20180128155722.880805-10-sandals@crustytoothpaste.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net> <20180128155722.880805-10-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 28 Jan 2018 14:50:18 -0500
X-Google-Sender-Auth: b1gD0IicnjbAcp-oIp1Q8inEuEI
Message-ID: <CAPig+cQ6UZJh5sZJURTiZ+T8eV8pyBSMTM8Re-BN7ZVwGc60+A@mail.gmail.com>
Subject: Re: [PATCH 09/12] read-cache: abstract away uses of SHA-1
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 28, 2018 at 10:57 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Convert various uses of direct calls to SHA-1 and 20- and 40-based
> constants to use the_hash_algo instead.  Don't yet convert the on-disk
> data structures, which will be handled in a future commit.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/read-cache.c b/read-cache.c
> @@ -2000,26 +2000,26 @@ static int write_index_ext_header(git_SHA_CTX *context, int fd,
>         /* Flush first if not enough space for SHA1 signature */

Did you want to update the comment to remove the SHA1 reference also?
(Or was the omission intentional per the commit message?)

> -       if (left + 20 > WRITE_BUFFER_SIZE) {
> +       if (left + the_hash_algo->rawsz > WRITE_BUFFER_SIZE) {
>                 if (write_in_full(fd, write_buffer, left) < 0)
>                         return -1;
>                 left = 0;
>         }
>
>         /* Append the SHA1 signature at the end */

Ditto.

> -       git_SHA1_Final(write_buffer + left, context);
> -       hashcpy(sha1, write_buffer + left);
> -       left += 20;
> +       the_hash_algo->final_fn(write_buffer + left, context);
> +       hashcpy(hash, write_buffer + left);
> +       left += the_hash_algo->rawsz;
