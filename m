Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F175C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E6C61919
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFOQ4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhFOQ4U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:56:20 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA44C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:54:15 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id z14-20020a4a984e0000b029024a8c622149so3167434ooi.10
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/kwPpacVYavgMrAAyaoDDpNk+WsglSJdb/SX3ZnmsPc=;
        b=fsvJnBK7OZhnO68XyUezU/1jEd3sapqi+ojOIp7Rw41OUGtNoSw7Z+T7yNjxQVmFjn
         mRUAG5fnWl2A33l0GPQPjPRXhNMo+aRorlZiHvbC4nHAGnCCSMOrpmur+ereA6Gp6F9z
         ObRfyjexzjBJiIHoYJiJ7/J8LYkPRRQCIrF07zAvhFqFVQ6knJVCkFQayJGOaPtm9cKX
         GFoVVX6567UiHy4oaFAF2zvEGALClxB39wc0nhBXLl2+poppG/++7gxNBN49dTCWFTjr
         +FynP3vKKBiykdQq0N4R2ymv+K6zmHHKfFh1kPXzqnfwzS+1J+ufzH+w7wfgKKKpCLy0
         foNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/kwPpacVYavgMrAAyaoDDpNk+WsglSJdb/SX3ZnmsPc=;
        b=Jv1wPAMFBc70S8+9l3ytxOVHexllSqdrj1BCigU7SWo88dpdV8z64H3CHon+rByx1R
         Fd2SFiQgUrl3V/wmHer5Zm33gaphVVicb47ieBSzzsPDxO0zimWLpbnNf7Gco1gfpjZB
         CuMjphjIa5PxSRh2DhtSxqhtOBBCSroupt19ANZicHNH4hNgYpDar1uo0dvCbk/vjtsH
         pnRZuCL1lPvz6PkksN9yO7YHk75PEOmTrBlJGzCzuVWtNhOx08DzQ3oJHKuQsJFtHWM2
         w+r1f640lCO3+ZkNw/2lcrHIefijD94ECLMz3NMcDOlnKdOygRd5/csqI0v5hbLiBHRV
         2GvA==
X-Gm-Message-State: AOAM533x/jXUcAb2lp8cy87df8vZlp8znmXINq0QX0eR37CTwp1NxmxX
        G3gNMsDsPYGqVkgNW4HREPA=
X-Google-Smtp-Source: ABdhPJwlYZXomZY56Oj9ITQqWBdBJ4s+YRYoWBJmMwjWmyuATGNGOZ2cd/EQLHjLnS+WQ48HMtQu5Q==
X-Received: by 2002:a4a:e9fb:: with SMTP id w27mr117839ooc.41.1623776055130;
        Tue, 15 Jun 2021 09:54:15 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id b26sm4177918otf.69.2021.06.15.09.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:54:14 -0700 (PDT)
Date:   Tue, 15 Jun 2021 11:54:13 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60c8db3558fb8_1296f208ac@natae.notmuch>
In-Reply-To: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
Subject: RE: [PATCH 0/6] doc: replace "alice" and "bob" examples
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I suggested in [1] that the "alice" and "bob" examples in our
> documentation would be better written without a reference to such
> fictional characters, for reasons that have nothing to do with trying
> to bend over backwards to avoid any reference to people's gender. It
> just makes for better documentation.

I'm fond of Alice and Bob, and I'm saddened they are the latest casualty
of the culture war, but if we are avoiding gender of examples, it makes
sense to let them go.

However, I want to defend this usage a little.

  1. Alice and Bob are familiar, so it requires less cogntive load from
     the user.
  2. Alice and Bob promote the usage of git as a distributed VCS, where
     unlike centralized VCS, you directly use the repositories of your
     colleagues.
  3. They provide some relief to an otherwise sterile landscape.

I don't think these changes make for a necessarily better documentation,
just a more sterile one.

Cheers.

-- =

Felipe Contreras=
