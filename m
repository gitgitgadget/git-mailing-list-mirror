Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0E8C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 12:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F79061969
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 12:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhC1Ml2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 08:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhC1MlB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 08:41:01 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAF3C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 05:41:00 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h25so7692463pgm.3
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 05:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fNKEDEfyxgmPzbFYo0uVorogWu8Tllr4jDzz0e6XclU=;
        b=iEeK+fBTuPDlNVRysXaiGdZwcIjIR4No2YETEIe20AvOiCq8FmXVd4zkzYngzC4xRg
         ZyTmozSO+rkhwJs6WJVdlFM/a3hDLGyv0suUrokPAMBXneMjyCzwXk8RZ4ivjHYoVFdE
         hW4HGXxlagJMExSN03vCfP+EAoM0EpgersgRtvI+vYjsYbOSip609XoYOIUYUAiKtyUq
         UbqReg0dXs+Pbh2NYX85PBsOWdVGdMOGn5vDDvKZPR+IrOcJsbjX+A7pf7K28qc40/WO
         SoCo5JD08eF0RKRTkCbisahbd0MDQ5dJ69ZMcTnKlDPq+ExxNgzo/BdWGlNa83P5sqeU
         DPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fNKEDEfyxgmPzbFYo0uVorogWu8Tllr4jDzz0e6XclU=;
        b=LzBpu2v/QuvEzK1u2Ctl1cvfMxzSXHHIruQEbW+ul0x3JLMYJo8F/1Fzg9tdno0TED
         w0YPyxCiHwSBF858XO9lasvgyQGd0YCS8HYr6Wty0wiWLyDjZov8svRf+Lh/aLjp5K0g
         Fzs3gmVYWYXXedtvPtLb2lkAcAgVwOgnxEyNq9QYoR25GZpTYzJpqamLOWiA40OY25gf
         Q6Q0w3zMX0QkkzhNwaNwj4egkJN5OUdCK6xYKNQjc1FSM7g22T/j0hWZACa+VvPfNCuJ
         QV7dvNuHrzFI52H7w9PKb9FBLR5ItRAYxtxSRhSonxIQDAUW9cNZRxxjynpcbdigl+6g
         IODQ==
X-Gm-Message-State: AOAM530On4i6nlkMV0c4Qm9YhxvLQJOUe1jMlYWaSXAdcVgjDL53GagI
        qQnrMUMjfHSaMMRnxpZcAOw=
X-Google-Smtp-Source: ABdhPJwFaCskFP09BCiZu9/ZukAzFd3+ytHR2GLrNgE90ghDnR5Vvamfugu64DqRSAdhyZDQ1nQ/TA==
X-Received: by 2002:a62:80cf:0:b029:1f3:1959:2e42 with SMTP id j198-20020a6280cf0000b02901f319592e42mr20949788pfd.39.1616935260026;
        Sun, 28 Mar 2021 05:41:00 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id cv3sm13306484pjb.9.2021.03.28.05.40.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Mar 2021 05:40:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <87blb4nf2n.fsf@evledraar.gmail.com>
Date:   Sun, 28 Mar 2021 18:10:56 +0530
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <578FC14B-CB72-41CA-A8FD-1480EBCCB968@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <xmqq5z1cqki7.fsf@gitster.g> <xmqq1rc0qjn1.fsf@gitster.g>
 <87blb4nf2n.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28-Mar-2021, at 08:46, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
> The "define-?.*" can be simplified to just "define.*", but looking at
> the tests is that the intent? =46rom the tests it looks like "define[- =
]"
> is what the author wants, unless this is meant to also match
> "(definements".

Yes, you captured my intent correctly. Will fix it.

> Has this been tested on some real-world scheme code? E.g. I have guile
> installed locally, and it has really large top-level eval-when
> blocks. These rules would jump over those to whatever the function =
above
> them is.

I do not have a large scheme codebase on my own, I usually use Racket,
which is a much larger language with many more forms. Other Schemes like
Guile also extend the language a lot, like in your example, eval-when is
an extension provided by Guile (and Chicken and Chez), but not a part of
the R6RS document when I searched its index.

So the 'define' forms are the only one that I know would reliably be =
present
across all schemes. But one can also make a case where some of these =
non-standard
forms may be common enough that they are worth adding in. In that case =
which
forms to include? Should we consider everything in the SRFI's[1]? Should =
the
various module definitions of Racket be included? It's a little tricky =
to know
where to stop.

That being said, I will try to run this through more Scheme codebases =
that I can
find and see if there are any forms that seem to show up commonly enough =
that they
are worth including.

[1] https://en.wikipedia.org/wiki/Scheme_Requests_for_Implementation=
