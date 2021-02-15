Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAB4C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 03:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944E060232
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 03:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBODRV convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 14 Feb 2021 22:17:21 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:40409 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhBODRU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 22:17:20 -0500
Received: by mail-ej1-f51.google.com with SMTP id b14so2902188eju.7
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 19:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DjFRANgDT5k2TLJ6RSTuqDnH0VhXezrTnabOhF16HB0=;
        b=bSCuOCS0WFpiF56rOv0ZaPUq1u6FNN6RQge6t7N9EVKG5bfG0nnWaPMXXp9Sye/eKm
         30tNA5E+AQGYCW70J9DNHsfmP8a/nlI11JHvwVVsC+kt6KPUCmHBV5EM3pJle+aCsn7p
         oYzZlusCVxdEAsF19BbbiIgk6+cOgCA+OVoNqwf3u47h9eXUOCrsOVoBd94TOi4deJqT
         IoY79dh6A8qezxO27RD+u0ks7tN4fPYs4P8xBwRCnDZUcbQT7/+GTTz97b+UHleaSlTS
         Hxmxp7ZHCXvb/j1VSlEbxbTTTnKU87Aib1evn8bg28FUIzc78TD+sHZKfb809UlB3veV
         B/cg==
X-Gm-Message-State: AOAM531jAZ2uoz0+6BRw6L6/qT5c1kXsiv5R5UuD11MhThsP1o2/s13v
        1VvcVMR5BX6mAbogE30Eu9jUIIdq0jb5ndfhays=
X-Google-Smtp-Source: ABdhPJxT95jGkCy8usXvZijCxLf2i4C2+HzvIO5H7NxNHY6ElvBLVgaGRwBjTtFayfyECoUuzHHzhp8apMrFMD6Lkx8=
X-Received: by 2002:a17:907:98c3:: with SMTP id kd3mr13813823ejc.482.1613358999121;
 Sun, 14 Feb 2021 19:16:39 -0800 (PST)
MIME-Version: 1.0
References: <87tuqebj6m.fsf@evledraar.gmail.com> <20210215005236.11313-14-avarab@gmail.com>
In-Reply-To: <20210215005236.11313-14-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 14 Feb 2021 22:16:28 -0500
Message-ID: <CAPig+cRmfeW=Di5uS9LnE0EVFnm5A5j=-z46J-zYGMm1E-8K6w@mail.gmail.com>
Subject: Re: [PATCH 13/20] userdiff tests + docs: document & test "diff.<driver>.x?funcname"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 14, 2021 at 7:56 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Add the missing documentation for "diff.<driver>.funcname" and test
> for how it and "diff.<driver>.xfuncname" interact.
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
> @@ -153,10 +153,22 @@ diff.<driver>.command::
> +diff.<driver>.funcname::
>  diff.<driver>.xfuncname::
>         The regular expression that the diff driver should use to
>         recognize the hunk header.  A built-in pattern may also be used.
>         See linkgit:gitattributes[5] for details.
> ++
> +When provided as `diff.<driver>.funcname` the regular expression is
> +interpreted as a basic regular expression, with

This would be easier to understand: s/, with/. With/

> +`diff.<driver>.xfuncname` it's interpreted as an extended regular
> +expression.
> ++
> +
> +The `*.funcname` and `*.xfuncname` variables behave as if though they
> +were one configuration variable for the purposes of what value
> +eventually gets used. Setting `*.funcname` will override an earlier
> +`*.xfuncname` and vice-versa.

Extra blank line before this paragraph?
