Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D63C07E96
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 01:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98DC6142C
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 01:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhGCBH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 21:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhGCBH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 21:07:57 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE7EC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 18:05:23 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so11962535otl.0
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 18:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xOT91NRoauLlH5WEXFP0oK/CWAzNZt7u+P6drJkiW0A=;
        b=plSfoqlK/LrfuTBmgs10rcnaoLD+NGTfcJ0J+VRakOM2wXVKa0NdS+wizIvwkzCbJT
         1ZJCOGWb2PoVGtzDDohbQB2EDin0GaQrShU0cgb28oj7JweMsWsndAwmS76xmqYsYIjM
         TcSeuj3UBh3XgJE/egjTJHMZNxtYqAoiEtBdQ0Stq45aq804FETmhdDlS/RlFrGCPuz8
         3PE0WgsUQYDnKNPZqWyM9XHxhstSco5GYihQSbG2hXFDBP34pogv3HfrKxw4+rzQjsP0
         eQxzOnb0PWwgXhKNHpkBjn7pibvv+5/T59lNKOyYqks6EpsjGZUD9cxRlFRfub4GQTS8
         a9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xOT91NRoauLlH5WEXFP0oK/CWAzNZt7u+P6drJkiW0A=;
        b=jHwvo/H1Z/WDblwIK9/mbJA0dzldmOYM68cwtiFIj4kTP8DfBIweVfRTZnhXL5AuqP
         QdFyaLOFfe9yXA+shlscjow0/mbhMtkmmp9vA+xCIrN9TsTudN0LI4nVytfT3TSPC2jS
         3sqFKxsgwF+bdgDsV8mjNXIepd7T/gp8SiGg7ym0bFSeDWZxbt6X4ZYqlhM29w1p4KIY
         LcYJeDORhmdr6RU7gdC6w2ihOuFPDF0ZBkxsy4UOsY5wkgJVpwnYDcqjmhYxPUBVVtV0
         ax1OSAn0gpPtEig84OrO9Q3FmHVST7oTd3Efda0gcdG2i6n1czLDPpF8waBHRjIAUavW
         CqYQ==
X-Gm-Message-State: AOAM530bYbICzULfHahZAFxaT/eNRSGIkIWFVcQ8qA07uFNNjmXxQZcJ
        30FDUI6VdCXvVpcU43MNXwg=
X-Google-Smtp-Source: ABdhPJxHZGI8e6Sf/QnThA3ACa2Q1G6uJmS72R6/zmVJIsQJXTMnz/FRdkX+j90O3JXpT9G3TAfW1w==
X-Received: by 2002:a9d:60b:: with SMTP id 11mr1579693otn.244.1625274323005;
        Fri, 02 Jul 2021 18:05:23 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id q13sm941466oov.6.2021.07.02.18.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 18:05:22 -0700 (PDT)
Date:   Fri, 02 Jul 2021 20:05:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w5h5c3RlaW4gV2FsbGU=?= <oystwa@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60dfb7d11cac3_3dd220811@natae.notmuch>
In-Reply-To: <patch-1.1-911881ce19f-20210702T115617Z-avarab@gmail.com>
References: <874kdn1j6i.fsf@evledraar.gmail.com>
 <patch-1.1-911881ce19f-20210702T115617Z-avarab@gmail.com>
Subject: RE: [PATCH] Documentation/Makefile: don't re-build on 'git version'
 changes
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Since 9a71722b4df (Doc: auto-detect changed build flags, 2019-03-17)
> we've been eagerly re-building the documentation whenever the output
> of "git version" (via the GIT-VERSION file) changed. This was never
> the intention, and was a regression on what we intended in
> 7b8a74f39cb (Documentation: Replace @@GIT_VERSION@@ in documentation,
> 2007-03-25).
> =

> So let's add an ASCIIDOC_MANVERSION variable that we exclude from
> ASCIIDOC_COMMON. The change in 9a71722b4df was only intending to catch
> cases where we e.g. switched between asciidoc and asciidoctor, not to
> undo the logic in 7b8a74f39cb and force a re-build every time our HEAD
> changed in the repository.

Once again, why do we care that the version is 2.32.0.98.gcfb60a24d6 and
not 2.32.0.97.g949e814b27?

Not just in the documentation, but everywhere.

Maybe we can add a GIT_RELEASE variable that unlike GIT_VERSION it
doesn't contain the precise commit. For example GIT_RELEASE =3D 2.33-dev.=


-- =

Felipe Contreras=
