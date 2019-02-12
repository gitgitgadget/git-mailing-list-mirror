Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640FC1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfBLBiB (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:38:01 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35095 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfBLBiA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 20:38:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so7773931qka.2
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 17:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FgGALLfq8KtDQemjAq1RA4nrTVcNSztEJWU8Ooptx8=;
        b=kearNPWicKJpYWbiGTcGJggh8f5CEURRuexus645j8MXK/X52NGwjKWcgUJK5wPCAD
         RWGJJVbSPmXSdZ+xsDiPVof/SqKUwRsnQIY0fbRX/3PVJn5dyx5ccR+kYyn5oIzthE+P
         G+PWfwEyOD98mWJWbSWnhFz+zQr5EarhtVJ3mevl6sT1QXIpdvTugSRXIWft7O6FptTj
         P3bcwNuMYNms3Ut064LsziV4jNr+rQHrQQ/vIyqazHXs4JrPGhTuRE9ZIiV+msjo+M21
         c/cB4sJSPnOTyDGh6gr8mdf5ZJqNLvQeEcyDs4vDnBggUKpl0GLnzCh+5fzr7d43HZLH
         yyFg==
X-Gm-Message-State: AHQUAuYJJBKIsc5VzqAOK0iQYZuefOawsLoTWKqExR9URibIr8bzuF3h
        wrIVoTg19qTfeIdjwERLDMuk3o5B/mXqJ0u2604=
X-Google-Smtp-Source: AHgI3Ia90YUTOXbrg4wS1HJprz+3kEgCmpjvXw5udXF8ruJk1wPeFdvA/XAxv9CgOuaOqhdC/vYOL1Om52mKIybhENA=
X-Received: by 2002:a37:9584:: with SMTP id x126mr876766qkd.36.1549935479922;
 Mon, 11 Feb 2019 17:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net> <20190212012256.1005924-9-sandals@crustytoothpaste.net>
In-Reply-To: <20190212012256.1005924-9-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Feb 2019 20:37:49 -0500
Message-ID: <CAPig+cRQrkeD6rL8M9pL4kjPTwbPdjUYyH4Kes3jk9Wn0O-NtA@mail.gmail.com>
Subject: Re: [PATCH 08/31] notes: make hash size independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 8:23 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Switch out various uses of the GIT_SHA1_* constants with GIT_MAX_*
> constants for allocations and the_hash_algo for general parsing.  Update
> a comment to no longer be SHA-1 specific.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/notes.c b/notes.c
> @@ -527,15 +529,15 @@ static unsigned char determine_fanout(struct int_node *tree, unsigned char n,
> -/* hex SHA1 + 19 * '/' + NUL */
> -#define FANOUT_PATH_MAX GIT_SHA1_HEXSZ + FANOUT_PATH_SEPARATORS + 1
> +/* hex oid + one slash between each pair + NUL */
> +#define FANOUT_PATH_MAX GIT_MAX_HEXSZ + FANOUT_PATH_SEPARATORS_MAX + 1

I had trouble understanding to what pair you are referring. I _think_
you mean "pair of hex digits". If so, perhaps:

    /* hex oid + '/' between each pair of hex digits + NUL */

(but not worth a re-roll).
