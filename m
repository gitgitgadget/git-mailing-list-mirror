Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C11C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 05:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B69961360
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 05:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhFBFoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 01:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhFBFoA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 01:44:00 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F323BC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 22:42:17 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so1457157oth.8
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 22:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=AGMmXo4Ac9J9/duzlPfzGCbC0tDCqibgdPFO69SX5V4=;
        b=eGcD+Z8PHsRI+XTI0Z81NXBRD0oLx5lZaT00m6SgbhoJaKjpqO0ngEyxoJjt3CfHaK
         5x5PD5CSPtrWk6Uz1b0SfjHW5F8WepM3p37A3YyEvztUBEBhnjYHcxzOpqxhXvS3Xnwq
         aPGCN3bSaI46wiROjGSiGldChEP8Ikq3+uv+O878BSLCSx3qS2IEQClf1LjXPJhepAXs
         q5VXqMIrcuqTPv8SsurxMdzyewYnTPHJgZbbv+P98Ll+5qYmeeBJ5Fb9Qpuzr/4l0M3j
         bqnkXhejX7CVJ5guRXaXq9lsrjxpiOhXfCRpRiqEgni3qrfxEsC23ui+P5XZnubkaHbR
         6o3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=AGMmXo4Ac9J9/duzlPfzGCbC0tDCqibgdPFO69SX5V4=;
        b=SkJw2fJCIfM3ei8xuQUwi+wuZGDVoRJad6p4xadWChNexbezTKCe7gXcVaO+NbxfOM
         L87rlEIzBUulQ4LE82kafSKbZIyI0jXYQR8oRfJPIPL22eTEO6o/Gg1+wcsHbHBZvMq3
         l8P7iIB68TGMHtoBlyDj0+AgkdAQwrOgobWtj06zdHOMwJSk/K5U7oSJxX+YBHtchYY8
         M4wWZzs4P3na3k2Wr2DU/nwd3JNmEJdK9QL/55+P41Cw6x1queBn7J76uWZm8iM+h3Ar
         dxfFJoTQ1DRlFliKAdCFzxr2RDLS8DIwsZVl8l/juGVE6Qoy26UBJ9CEVRi8/O0eA5Hh
         zwig==
X-Gm-Message-State: AOAM533nFyAS7XO8M3N9OAWHYCJ63Rc4vuVul8uPI9zMoE7jBPS9v6pD
        aiM4P5FktxRDIvU1Xyf8arE=
X-Google-Smtp-Source: ABdhPJztwESkDfNUlFzEh6Gd69pTEn4SSeOcRGReVpq+XUo2xGBYNN/uX+aosJ4NeZStCKBp6sXvyQ==
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr12743493oto.331.1622612537381;
        Tue, 01 Jun 2021 22:42:17 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y7sm3802718oix.36.2021.06.01.22.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 22:42:17 -0700 (PDT)
Date:   Wed, 02 Jun 2021 00:42:15 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Message-ID: <60b71a37cb4aa_67d0208bf@natae.notmuch>
In-Reply-To: <179668e9-008a-0b70-a193-b0a479ba0146@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <YLZ5H2Muh39Q4M5T@google.com>
 <179668e9-008a-0b70-a193-b0a479ba0146@gmail.com>
Subject: Re: [PATCH 00/31] minimal restart of "config-based-hooks"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 6/1/2021 2:14 PM, Emily Shaffer wrote:
> > On Fri, May 28, 2021 at 02:11:02PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
> >>
> >> After suggesting[1] an another round that the config-based-hook
> >> topic[2] should take a more incremental approach to reach its end go=
al
> >> I thought I'd try hacking that up.
> =

> I think sending this complete reorganization of a long-lived topic
> is not helpful, especially because the end-to-end diff is significant.

The end-to-end diff is significant because it's not the full patch
series.

Give me pointers to the two branches and I'll get you a patch series on
top of =C3=86var's that gets you *exactly* zero end-to-end diff to Emily'=
s
series.

There's many paths to end up with exactly the same code.

I do it all the time.

> I've also seen messages as early as January where =C3=86var mentioned
> wanting to review the series, but not finding the time to do so.
> It is reasonable to expect that contributors attempt such major
> reorganizations according to reviewers feedback, as long as the
> reviewers are timely about delivering that feedback.

The Git project doesn't have deadlines.

Code should be merged when it's ready to be merged, not when it's
convenient for $company.

I have patches that have been stuck for 7 years. Why should $company get
a fast-path, an exception, or preferential treatment?

Cheers.

-- =

Felipe Contreras=
