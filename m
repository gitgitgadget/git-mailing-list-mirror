Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00678202F2
	for <e@80x24.org>; Fri, 24 Nov 2017 01:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbdKXBal (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 20:30:41 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35833 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdKXBak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 20:30:40 -0500
Received: by mail-qt0-f170.google.com with SMTP id n32so29788101qtb.2
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 17:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t7nwecdLpoNFvOM/6YrE4JereYiqq5UHLg1U9RhIM+I=;
        b=ayN2oLN17NIA9Y5PnMaTbUnPbF/ldIoBuwx0rgfbInh+o+Ev1LzrjYncD0UHmwS1o7
         DqagUqwCAywmvG3mjMb/TGgqeCfDPMFHTZuk8TghYHYD/ldAnrm5DQiiOugwCM+63kZ0
         ENfFOCyOjM32pHfHo7T//4a5zap05cwPL4va7tkwbwNKygXEJPN4aMHMxU0TyC60YvJy
         F2F55p0h/DfgvYlEamO/LeIkCJzj57lViz0NTizGf75RH3pq85uYyQCt2Z+C351BAvtC
         jb9MvxJmcT3iZf5D5CQgNtiFEuBJeV+ylDSPIa5P0DheXeC80bW7EjBXDhpUu+xHamZo
         rT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=t7nwecdLpoNFvOM/6YrE4JereYiqq5UHLg1U9RhIM+I=;
        b=pIxbZdBN5yJojG8bH+IVmB4F79Y42VmvinAa5UBH1P9rEaAO+ab3mFUlydFzXGdPvZ
         WL4FnkAq1gAEdmMlIgaifilGaa470BQ9PA8y1KCeOsAFJRrPjq4WlDkSSsDRnMdbCsx0
         8iWtRRjfNXyUNGHNXxZHHPza7cfYRM565cM3SwfYUSRKcxpt1KLnjLEkgSKWU6RQaesD
         jsPFXeJVRbA1ZoCAtH6I3cjcKwMzZdBKlpHSFLm4L4Mo8I1oCgJbBy4oJynUsEnrRopK
         OPVQAhmnMkm6uWDgDTSBIluNknfmLR2tEZLYxYUT2/fyJjO8UQToyAXqoTf1ZJ68bbsq
         B9mw==
X-Gm-Message-State: AJaThX5isDY0HQdv3RSCNeOaPmkzyEnr70oSG1dpdjjztLclT6M/UY1N
        WN71iIfH52izr28pfL0dt+vMIcdydUh5x1UVObc=
X-Google-Smtp-Source: AGs4zMZiHMHxDrCx3ZDrKzrKKcB6/GSUVdPWrE0mX4mteNaUqyBitypVliuiuMXJL6ydmZR8e1FuVGaDAi2cRoR3B/g=
X-Received: by 10.237.35.37 with SMTP id h34mr42783884qtc.9.1511487039441;
 Thu, 23 Nov 2017 17:30:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Thu, 23 Nov 2017 17:30:39 -0800 (PST)
In-Reply-To: <20171123234511.574-1-max@max630.net>
References: <20160401235532.GA27941@sigill.intra.peff.net> <20171123234511.574-1-max@max630.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Nov 2017 20:30:39 -0500
X-Google-Sender-Auth: HFXuajD4_JDozG8uygEuGqlF1_Y
Message-ID: <CAPig+cQEaqaOTcC=5pZZmZNs_QQQ0vBRbzczyM3ZXXi+ZHW4XA@mail.gmail.com>
Subject: Re: [PATCH] http-backend: respect CONTENT_LENGTH as specified by rfc3875
To:     Max Kirillov <max@max630.net>
Cc:     Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 6:45 PM, Max Kirillov <max@max630.net> wrote:
> [PATCH] http-backend: respect CONTENT_LENGTH as specified by rfc3875

The "RFC" seems to be missing from the subject line of this unpolished patch.

> http-backend reads whole input until EOF. However, the RFC 3875 specifies
> that a script must read only as many bytes as specified by CONTENT_LENGTH
> environment variable. This causes hang under IIS/Windows, for example.

By "_this_ causes a hang", I presume you mean "not respecting
CONTENT_LENGTH causes a hang"? Perhaps that could be spelled out
explicitly.

> Make http-backend read only CONTENT_LENGTH bytes, if it's defined, rather than
> the whole input until EOF. If the varibale is not defined, keep older behavior

s/varibale/variable/

> of reading until EOF because it is used to support chunked transfer-encoding.
>
> Signed-off-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
> Authored-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
> Fixed-by: Max Kirillov <max@max630.net>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> diff --git a/http-backend.c b/http-backend.c
> @@ -317,6 +317,76 @@ static ssize_t read_request(int fd, unsigned char **out)
> +/*
> + * replacement for original read_request, now renamed to read_request_eof,
> + * honoring given content_length (req_len),
> + * provided by new wrapper function read_request
> + */

This comment has value only to someone who knew what the code was like
before this change, and it merely repeats what is already implied by
the commit message, rather than providing any valuable information
about this new function itself. Therefore, it should be dropped.

> +static ssize_t read_request_fix_len(int fd, size_t req_len, unsigned char **out)

Wrong data type: s/size_t req_len/ssize_t req_len/

Also: s/fix/fixed/

> +{
> +       unsigned char *buf = NULL;
> +       size_t len = 0;
> +
> +       /* check request size */

Comment merely repeats what code says, thus has no value. Please drop.

> +       if (max_request_buffer < req_len) {
> +               die("request was larger than our maximum size (%lu);"
> +                           " try setting GIT_HTTP_MAX_REQUEST_BUFFER",
> +                           max_request_buffer);

This error message neglects to say what the request size was. Such
information would be useful given that it suggests bumping
GIT_HTTP_MAX_REQUEST_BUFFER to a larger value.

> +       }
> +
> +       if (req_len <= 0) {
> +               *out = NULL;
> +               return 0;
> +       }
> +
> +       /* allocate buffer */

Drop valueless comment.

> +       buf = xmalloc(req_len);
> +
> +

Style: Too many blank lines.

> +       while (1) {
> +               ssize_t cnt;
> +
> +               cnt = read_in_full(fd, buf + len, req_len - len);
> +               if (cnt < 0) {
> +                       free(buf);
> +                       return -1;
> +               }
> +
> +               /* partial read from read_in_full means we hit EOF */
> +               len += cnt;
> +               if (len < req_len) {
> +                       /* TODO request incomplete?? */
> +                       /* maybe just remove this block and condition along with the loop, */
> +                       /* if read_in_full is prooven reliable */

s/prooven/proven/

> +                       *out = buf;
> +                       return len;
> +               } else {
> +                       /* request complete */
> +                       *out = buf;
> +                       return len;
> +
> +               }
> +       }

What is the purpose of the while(1) loop? Every code path inside the
loop returns, so it will never execute more than once. Likewise, why
is 'len' needed?

Rather than writing an entirely new "read" function, how about just
modifying the existing read_request() to optionally limit the read to
a specified number of bytes?

> +}
> +
> +/**
> + * wrapper function, whcih determines based on CONTENT_LENGTH value,

s/whcih/which/

Also, the placement of commas needs some attention.

> + * to
> + * - use old behaviour of read_request, to read until EOF
> + * => read_request_eof(...)
> + * - just read CONTENT_LENGTH-bytes, when provided
> + * => read_request_fix_len(...)
> + */

When talking about "old behavior", this comment is repeating
information more suitable to the commit message (and effectively
already covered there); information which only has value to someone
who knew what the old code/behavior was like. The rest of this comment
is merely repeating what the code itself already says, thus adds no
value, so should be dropped.

> +static ssize_t read_request(int fd, unsigned char **out)
> +{
> +       /* get request size */

Drop valueless comment.

> +       ssize_t req_len = git_env_ssize_t("CONTENT_LENGTH", -1);
> +       if (req_len < 0)
> +               return read_request_eof(fd, out);
> +       else
> +               return read_request_fix_len(fd, req_len, out);
> +}
