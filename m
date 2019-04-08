Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05ACC20248
	for <e@80x24.org>; Mon,  8 Apr 2019 02:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfDHCgM (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 22:36:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51265 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHCgL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 22:36:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so12460836wmf.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 19:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1uTwg1oJgyrsBuH0cEnu+Gcp9AMi+WCxLbvKH4HHaDw=;
        b=OEuusnuxAkgaV1jsVndY7jHFm2IbZr/+xRDU+3R6Ge9wUjDkrx40uQobnitd9vlTdK
         ROwzKJcMGF8GdZTXx3pUKL5PnWPLzsmUJgN2VBebEmdqDf/Jqkkj9EBR/LmiecXn1xf+
         811XKs5yvbnKi/o106WOgFFcBLiTgjUpFTZxyMnj2TIomNtHMTD0/kaWIn7PwWn7A2ga
         zEuM/e6UKYTyQGvkQIQ7brf0UMdVdylV7BdMIGfxpOvXOZqRfXt2SIFuBrppJk+UHiW1
         mwECG8DZ+U7I85amrDvGMuO7qe7JomfuPYWw/5RPjofNOUtEx0J8f+sETliPwM0zOcKY
         wzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1uTwg1oJgyrsBuH0cEnu+Gcp9AMi+WCxLbvKH4HHaDw=;
        b=ohCJaV8seYvEyrOwW+ErdxHiEHG8l7fAtxICJvlGv4bbgY2BU8gI7iCft6itjGOpvF
         0+3YKkQl5Ao2+VR+tnGFD9LhsLOT6zP6YWH3apotqrzErVAzyUPAlcQAwHTDO0t0ZQ7K
         AltHtSlwAE0PpN/rye7IqoG1aDKBMEtcuEEH6b6VbtPF/q8FRXzFJlsWQ7hN6bAIe2SA
         iYrIEnCgmD80Ncb/EmblGcRBoeDBkzzD2JBDPyK5RMgHz45uYCwPJVhlrAraBDUTQ0zs
         5AzsGkUgUD/0fb0tm9dLYMnIvVvvlkuDVumQ9UVc5AifoQe06FIVP/WkMM2N+zBog5l2
         rm8Q==
X-Gm-Message-State: APjAAAUD22LR5hqvmcIGLmxNkszSAC1oOMATjF/DkJfww0w2LqBlRPFs
        D7jvyM4HY5YUoZ6rpH7M6Cs=
X-Google-Smtp-Source: APXvYqyZ/hUDZYVhLFCVoehQjt9cZAaJOAPJXs+AdhM6kjRsDAl4RNlglo+W9ADQmETaFAP79IeMhA==
X-Received: by 2002:a1c:544f:: with SMTP id p15mr15253145wmi.65.1554690969498;
        Sun, 07 Apr 2019 19:36:09 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w10sm18747154wrv.8.2019.04.07.19.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 19:36:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] diff: batch fetching of missing blobs
References: <20190326220906.111879-1-jonathantanmy@google.com>
        <cover.1553895166.git.jonathantanmy@google.com>
        <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
        <20190404024710.GO32732@szeder.dev>
        <nycvar.QRO.7.76.6.1904051528130.41@tvgsbejvaqbjf.bet>
        <CAP8UFD1qK61MtJ-XeMuwY4W2V0CdHeZQC9rQap1M+nEeaLmBJQ@mail.gmail.com>
Date:   Mon, 08 Apr 2019 11:36:08 +0900
In-Reply-To: <CAP8UFD1qK61MtJ-XeMuwY4W2V0CdHeZQC9rQap1M+nEeaLmBJQ@mail.gmail.com>
        (Christian Couder's message of "Sun, 7 Apr 2019 08:00:08 +0200")
Message-ID: <xmqqy34lb4vb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Thanks for investigating! Yeah, that's part of the problem.
>
> The fix I would suggest is:
>
> diff --git a/diff.c b/diff.c
> index f685ab10b5..a2b1241f83 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -26,6 +26,7 @@
>  #include "parse-options.h"
>  #include "help.h"
>  #include "fetch-object.h"
> +#include "promisor-remote.h"

Thanks.

>
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -6489,7 +6490,7 @@ static void add_if_missing(struct oid_array *to_fetch,
>
>  void diffcore_std(struct diff_options *options)
>  {
> -    if (repository_format_partial_clone) {
> +    if (has_promisor_remote()) {

Hmph, I see quite a few references to the variable disappears
between next and pu.  Is it that in the new world order, nobody
outside the low-level object-access layer should look at the
variable directly, but instead ask the has_promisor_remote()
function?  If so, can we at least document that?  Making it static
(or at least renaming it) would have helped the compiler to notice
this semantic merge conflict better.

> @@ -6506,8 +6507,7 @@ void diffcore_std(struct diff_options *options)
>              /*
>               * NEEDSWORK: Consider deduplicating the OIDs sent.
>               */
> -            fetch_objects(repository_format_partial_clone,
> -                      to_fetch.oid, to_fetch.nr);
> +            promisor_remote_get_direct(to_fetch.oid, to_fetch.nr);

Likewise between fetch_objects() and promisor_remote_get_direct().
Shouldn't the underlying fetch_objects be hidden from general
callers?

>          oid_array_clear(&to_fetch);
>      }
>
> I will send a new version with the above soon based on top of
> jt/batch-fetch-blobs-in-diff in pu.
