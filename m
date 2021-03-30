Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B61C433E0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDCFE6199A
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 07:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhC3HE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhC3HEm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 03:04:42 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F30AC061762
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 00:04:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v8so5665875plz.10
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qEU469QxJk+OZN4NKsIFY/EpIFZobKbuiDb0oqkWQTA=;
        b=tKjVky5GaLqtJAU5eu2qTLF/V32kcl23vDBMPKmo3jJAv/cDUCMLBHG1zyzs0Y4dJB
         Iyn5ALvFDH7axE3ELmNpWVu4fRPnZU280fh569/wH75xq1RanfxlpOTiQebeV1blCYxD
         gsZuRc7z7xmRNw9h82YegEFDuncX1VmwDu3EpOeGg8eCena3hUT388urYQFNyroWLK0a
         i+P8KxhiIDOC23YUEYObQP4fuy7FcXiWvUkJQd0aUXvTSXRuAVDCrfVhLwRMhRVwJR9v
         prd+QufCGMugCqKWj18KOO+rVlYPnvK0I5Esaqklp/DleruytRuKOKVXEG9XUQ5gR5M0
         Lhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qEU469QxJk+OZN4NKsIFY/EpIFZobKbuiDb0oqkWQTA=;
        b=tyLe8m5+o9fbKEhcI8iGpnRWtIXfeo2aX8ReyGJxpSfRaZYXRIpZuOB8LD6iDPmKe/
         2SabfS/NVxIPQRE0TK0DV9BOJxWzcbTVX3XgASYQodHnEuryzEp6ouY5sxVdibguurvq
         lipfeU2S9F7Wpgd3/Wh0SNfynQwhlZC7iYweYQE6XK9kXFICgtxCmn+BeCJuh7KYDRW0
         Dcne9tpQFCh/CxwcdsGioQ0gXx+ZD385ncoe2PAqelkfqifpmZHWDZieug+2T3b4aJaD
         3K8CvokBrXr7QoSR0WPcEjqK02IAd+k+NnZs/+qSyW/LUpyrg1x1mjeuDsz0aCjq1QTo
         gMuQ==
X-Gm-Message-State: AOAM532pPjvHa4wiKUUOt2T4KiSEPhZq9hjPJ6WP6ID0HkCwVMbzJkB5
        FfF4Rn5u9zs6+FCKnabQ5thd9vd43TdCQ7IQ
X-Google-Smtp-Source: ABdhPJxHLuu6/LXTNn+7Go1g15kRPvtScujSr3iV739M22q7Opt9nMdkNd8iMSUztY0Di+aECGnLnA==
X-Received: by 2002:a17:903:1cc:b029:e6:f37a:2185 with SMTP id e12-20020a17090301ccb02900e6f37a2185mr32490115plh.67.1617087881984;
        Tue, 30 Mar 2021 00:04:41 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id j92sm1728657pja.29.2021.03.30.00.04.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 00:04:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <09678471-b2a2-8504-2293-e2b34a3a96e8@gmail.com>
Date:   Tue, 30 Mar 2021 12:34:38 +0530
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8256AFA-898E-4388-8FCC-7D3D340C001E@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <3def82fd-71a7-3ad9-0fa2-48598bfd3313@kdbg.org>
 <5BA00FC6-9810-49AB-8DE2-D4F4010E2F82@gmail.com>
 <09678471-b2a2-8504-2293-e2b34a3a96e8@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 29-Mar-2021, at 15:48, Phillip Wood <phillip.wood123@gmail.com> =
wrote:
>=20
> Hi Atharva
>=20
> On 28/03/2021 13:23, Atharva Raykar wrote:
>> On 28-Mar-2021, at 05:16, Johannes Sixt <j6t@kdbg.org> wrote:
> > [...]
>>>> diff --git a/t/t4018/scheme-local-define =
b/t/t4018/scheme-local-define
>>>> new file mode 100644
>>>> index 0000000000..90e75dcce8
>>>> --- /dev/null
>>>> +++ b/t/t4018/scheme-local-define
>>>> @@ -0,0 +1,4 @@
>>>> +(define (higher-order)
>>>> +  (define local-function RIGHT
>>>=20
>>> ... this one, which is also indented and *is* marked as RIGHT.
>> In this test case, I was explicitly testing for an indented '(define'
>> whereas in the former, I was testing for the top-level =
'(define-syntax',
>> which happened to have an internal define (which will inevitably show =
up
>> in a lot of scheme code).
>=20
> It would be nice to include indented define forms but including them =
means that any change to the body of a function is attributed to the =
last internal definition rather than the actual function. For example
>=20
> (define (f arg)
>  (define (g x)
>    (+ 1 x))
>=20
>  (some-func ...)
>  ;;any change here will have '(define (g x)' in the hunk header, not =
'(define (f arg)'

The reason I went for this over the top level forms, is because
I felt it was useful to see the nearest definition for internal
functions that often have a lot of the actual business logic of
the program (at least a lot of SICP seems to follow this pattern).
The disadvantage is as you said, it might also catch trivial inner
functions and the developer might lose context.

Another problem is it may match more trivial bindings, like:

(define (some-func things)
  ...
  (define items '(eggs
                  ham
                  peanut-butter))
  ...)

What I have noticed *anecdotally* is that this is not common enough
to be too much of a problem, and local define bindings seem to be more
favoured in Racket than other Schemes, that use 'let' more often.

> I don't think this can be avoided as we rely on regexs rather than =
parsing the source so it is probably best to only match toplevel =
defines.

The other issue with only matching top level defines is that a
lot of scheme programs are library definitions, something like

(library
    (foo bar)
  (export ...)
  (define ...)
  (define ...)
  ;; and a bunch of other definitions...
)

Only matching top level defines will completely ignore matching all
the definitions in these files.=
