Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91D582093C
	for <e@80x24.org>; Fri,  9 Dec 2016 01:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932200AbcLIBuP (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 20:50:15 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36291 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753787AbcLIBuN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 20:50:13 -0500
Received: by mail-yw0-f193.google.com with SMTP id r204so365690ywb.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 17:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dVIGlx1XuFrSykfNz7J3bLs8LqqGUoTTdsx3mF0rxYo=;
        b=ez1f9u0jiDuEcAaD5xmhbPUiKgXd2G/USsqDn+NQvG/8GIodu8NE6yK+H8o88etu2y
         CzEnGx+5zPxnQodKziiIrisXDy173LhcbYqkH+i88qBY/ItpLqBQovODkSmxhr8aNyaG
         HOH9l38aMoZIQfAxQKBqTVac19iY4mZU2qOsPOmrl1yUk2SRjaOdkbewQ2eVGLuCdW1c
         M3eusw5K6fvq0RH/QZY19xqvHRHnMXDJod4bgAmzg0BzveEGE23Okwxwyl4kSuW1G+9o
         xNBypcWzfOC9XuTxSx8BZJPaTcac1MclXzQrF010PQWKoI9XwW8fei9s0VdHDT9RyqBB
         L47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dVIGlx1XuFrSykfNz7J3bLs8LqqGUoTTdsx3mF0rxYo=;
        b=IsvK74KF1hMj4S/YJYdMDgLUHH5FjxPr4DaTyOaN5W5H5oSXrtHesbhOeX9iNY70Hc
         1xrkn4q1KZ7NQ/LvhZEyA5OhO2TK91t/A0i3VSbudB4ghYR2fuC6yceiiUWfbVOni56I
         4WIGF/x+UlnZaylodcMy1FlyUarw+mls/aSOouHnKKoH6wM35AlvWgHCf3nLSLt36Tdq
         PG2FS4TQG0VwGsqpewqdD6oJ5LZ8f7+PR8fZa28BJYMObJZHKh+Vkt9OSg+NqRO7LP7a
         LFpv/rF+RdUPEFzzPK1MQGke6H/pfNN/WKWBsHbLSWSkfrqS6HvxenMSUqIcAQ3We8/w
         IkNQ==
X-Gm-Message-State: AKaTC007Jg5CstSKZVBRAcMV/SYcB0UgDMRlcshaIHCnA5wfDY9vO+9pUmCl62jdwP26HKhb08SgxPDCp7XIsg==
X-Received: by 10.13.250.3 with SMTP id k3mr69217571ywf.276.1481248201295;
 Thu, 08 Dec 2016 17:50:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Thu, 8 Dec 2016 17:49:40 -0800 (PST)
In-Reply-To: <1481241494-6861-2-git-send-email-bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1481241494-6861-1-git-send-email-bmwill@google.com> <1481241494-6861-2-git-send-email-bmwill@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 8 Dec 2016 17:49:40 -0800
Message-ID: <CA+P7+xpjpGhk0MzyZ5VjKD_bORL9WQJvcFm8hi_ptxJpL_+NJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] real_path: resolve symlinks by hand
To:     Brandon Williams <bmwill@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 3:58 PM, Brandon Williams <bmwill@google.com> wrote:
> The current implementation of real_path uses chdir() in order to resolve
> symlinks.  Unfortunately this isn't thread-safe as chdir() affects a
> process as a whole and not just an individual thread.  Instead perform
> the symlink resolution by hand so that the calls to chdir() can be
> removed, making real_path one step closer to being reentrant.
>

Better description for this part of the change. I like the
improvement, as it clearly indicates what this particular patch is
about, and why, but doesn't over-state what we gain here.

The rest of this seems reasonable, though I'm not super familiar with
the code, so I didn't have any comments.

Thanks,
Jake
