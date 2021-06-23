Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887CAC4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A9B60FF4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFWTSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 15:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWTSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 15:18:09 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704D0C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:15:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso3026033otu.10
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=HZhcvNIz8R3JIip9aDBs7ixi7smObyVuNXK/YGCQEAc=;
        b=MnGsQ9I4xESYE6bIR74NlLwJwCAQiWSfAZg2NKEUl7Bj7oBvzESnp/8yhWuD/Ispbw
         DiVDGFWqUjksarl16hAXE9+QfhRxHQGcgi3jv2WJZAFk8agSocQawDb9LLwTHscajstP
         JXOYXsP2pWB229l6cK7U7vjoliOOdGL5d98AOwxmavnfh4g52WgYY4W/qfbxya5lioss
         ETE+MXcoiJ5EAO4v0bfqGY3GUHpwN9ecEw9/wOUmBNk6OIE02ytKf7KqVXF83Nb+UKrm
         NmukfJWtp33hua+pcf9DsSfL18a8hbYLzxPRVKlBGHlg+xJBX+OS+8XqgfVKyw7n2QGW
         uQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=HZhcvNIz8R3JIip9aDBs7ixi7smObyVuNXK/YGCQEAc=;
        b=Ij8SiuQA3VRpiTY4NgZEo2ap6xa8IhdOKp/lLRZm33KSQ4mooxLsJB+4U1oIhTjMfs
         Fq5bbR4prUS0ebsm5TKpjWeYiQoKFICOygOA6/3wNzc6QoXNFcdUPGdMG7VyYyhUu8nJ
         C/wnZ4nmBnL33wa169MIOnEhHiGOaOV8FTDTpRBiiikL3Ld4Q9iBnPSqHYvqDCZXQ9ry
         LwYRNG4S8GdTdK/yUfSFZn+8ntxqz0TLMvw42FeMJHJAiaK5w3UZacVuZtDmgR7SUdjn
         3qbh7RVu4ZKRH9cojTGy+uIFwp+oiKxwYfmonlIRJyzRp6N5bgnuyUTKOVWYMJ56IUh0
         73nQ==
X-Gm-Message-State: AOAM531MS/Gz61T4zZD22kyE7imrZrtAOeTWrMaUU4YjHfkRRu0i+VuW
        NrKkfJrkxz1mRymj/9wcQH0=
X-Google-Smtp-Source: ABdhPJyb3JWdCwJOW+hJDAO5SFYQez8Mw/OKivx/s2RS9yCfw275ThNAThS9Tvi2lyxARHJGS0uuyw==
X-Received: by 2002:a05:6830:919:: with SMTP id v25mr1290485ott.77.1624475749880;
        Wed, 23 Jun 2021 12:15:49 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id k3sm148384oom.14.2021.06.23.12.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:15:49 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:15:48 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60d3886442d62_4290208a@natae.notmuch>
In-Reply-To: <8735t93h0u.fsf@evledraar.gmail.com>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <YNIBRboFiCRAq3aA@nand.local>
 <8735t93h0u.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I don't think the way Felipe used it in his patch is an unambiguous
> improvement, it would need to be some combination of reverted/adjusted
> if we went for the "anything you make must always have a 100% working
> copy" general approach in:
> https://lore.kernel.org/git/cover-0.6-00000000000-20210329T161723Z-avar=
ab@gmail.com/

My view is that it's the tool itself (gcc, asciidoctor, asciidoc) that
shouldn't write the output if interrupted, and generally that's the
case.

If we do want out scripts to not generate output if interrupted, that
should be fixed in the script itself.

-- =

Felipe Contreras=
