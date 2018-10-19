Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B3D1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeJTAnq (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 20:43:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43367 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeJTAnq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 20:43:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id q41-v6so38957166qtq.10
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 09:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FL4PTf0GaKVSRGEng4Afq67ksts9bMDZEEH0PxO4Tlk=;
        b=bbhHtcTIIzNr04+32EEe6d88x3rwNf1wO1GdaKljaFmljwubog1/d5IqN+EY+mv+lm
         r6xzt5/PFJ/0llY0plgWLgMoQh38fc9Jt6GxAFrlvXvKQ9wksGHpNOPTDUEx53qgIJpZ
         bZxbn7w4e9RV81gFISapMvY3RfdS2Yh71JnWn9oc+eDRYLLPJiSP8bov0wIlo4zvnvGx
         /UGyp12CCHQtv/+7nLnbf6ZI76DSzthXNZaH9pHSn4nA9rd/XSLgvpuKYyauQ0t7WKgV
         q3QxiCA8Eabq9r7wArtjZKKlRtxVhnW4NqWP/EGeO36oKMBkM46XjlV6+451/7t/CcS8
         k4gA==
X-Gm-Message-State: ABuFfojZk4rYh2cLhoHa4f6ScF0Rf0mJiJPuhSpw3+JoU5slVkfMqhTN
        GmN/wOP+ct/UkemvXbNPS8MNKI7AaY0YOW1ZqKUIGpzE
X-Google-Smtp-Source: ACcGV63lmQPAZH9VPLvcZtqOFLdD5hY4QcRNaz28DGUGHS5nqVGYohTYdLF6i1uSZiA0W4Df2umC2c9vlZNcZZW19KY=
X-Received: by 2002:a0c:967b:: with SMTP id 56mr35059960qvy.62.1539967015282;
 Fri, 19 Oct 2018 09:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181017164021.15204-1-peartben@gmail.com> <20181019161228.17196-1-peartben@gmail.com>
 <20181019161228.17196-3-peartben@gmail.com>
In-Reply-To: <20181019161228.17196-3-peartben@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Oct 2018 12:36:44 -0400
Message-ID: <CAPig+cSL9=mmvdq9J9VXF67=010E1eZBjrYYaYQDN1z1OEf0CA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] reset: add new reset.quiet config setting
To:     Ben Peart <peartben@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 12:12 PM Ben Peart <peartben@gmail.com> wrote:
> Add a reset.quiet config setting that sets the default value of the --quiet
> flag when running the reset command.  This enables users to change the
> default behavior to take advantage of the performance advantages of
> avoiding the scan for unstaged changes after reset.  Defaults to false.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -2728,6 +2728,9 @@ rerere.enabled::
> +reset.quiet::
> +       When set to true, 'git reset' will default to the '--quiet' option.

How does the user reverse this for a particular git-reset invocation?
There is no --no-quiet or --verbose option.

Perhaps you want to use OPT__VERBOSITY() instead of OPT__QUIET() in
builtin/reset.c and document that --verbose overrides --quiet and
reset.quiet (or something like that).
