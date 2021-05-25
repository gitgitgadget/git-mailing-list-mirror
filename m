Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EB9C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBDB61420
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhEYKq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhEYKqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:46:25 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614ABC061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:44:55 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so7057393ool.1
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yhgv15bsap5urkdKBLLR0PZac1eQRlqVjC50Pih4Id0=;
        b=m0qqSrJ/p8vTH73o66eysogcHrNUQ27gN9SVfc+PBvlbrzD2Zloyg+1qTpKKC3rD+r
         oF7kU75Y6VqcvHchDFd/cAiUULhW7RB0gUnu/8f6TcDGIZRTrVW4+gXJD3YH3EbQcaDL
         7E+zrlGLudzDODlMLSl+cIUNZgG75FEcTS0qQzd2qLvK6u9Wzoq/w/6k4rhQ5kVaA+a4
         ABuqnGxcp/7lKMtsndtrxVpbXPyflOLotIuBcvUzO2b1mveWF98/qclDWeVB+8dStVDT
         Gfjljn0wJmPXTlHA96F8w8U+k/jQ7RVdch+cuY/Va/POv+EsDGpc7fqOsZSWvbuZZFA4
         9fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yhgv15bsap5urkdKBLLR0PZac1eQRlqVjC50Pih4Id0=;
        b=lt2rAX32B6FLnkozSHH7uTbaOT9ZoxniHx11Jh1SirNpum6DNoMgmf+DglNgo/LWzM
         XpUXUHBSN0vViAPjqhbq3JSo3AW/2WaCxu3V+Yd5Dj00nBxp6QEZ7wor0tl5GzSINOi5
         tFFV05ePVUuZV18n8owl5LjNxJfcot9nNXOxHeEJREgjyyqqSS0N+kiL4zW3LSFACw4d
         0y82p3La9P1/OS18E7rMVwPstKpf74AIbkEEuCLwMVID/MMFdh7kZsZQs4SrJZGd6XNN
         Qj1NWGuKOIHWyWQe8qmSBrsyPztjoIwZWU5XOHQhw5mvgbdw3kuw5ryolvI9UHJsOxp5
         LL8A==
X-Gm-Message-State: AOAM533vX/IGCmj1ajN1EVlG0PbPFq9o7kcAgwXKNR30fUeKDy9LYYs1
        CCjj93iA+vbMf09BedRrdZU=
X-Google-Smtp-Source: ABdhPJycpq2rGjh/ORP9rDsjEyxUQkU6U79BWQGeSwwRZIu0/MQclu5xrEHdYFOZ+dJ+bZK5RmUdGA==
X-Received: by 2002:a4a:4c49:: with SMTP id a70mr166089oob.74.1621939494652;
        Tue, 25 May 2021 03:44:54 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e21sm3196277oie.32.2021.05.25.03.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:44:54 -0700 (PDT)
Date:   Tue, 25 May 2021 05:44:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Message-ID: <60acd525e89f_2257a208b0@natae.notmuch>
In-Reply-To: <xmqqlf83fge2.fsf@gitster.g>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
 <xmqq1r9wj9im.fsf@gitster.g>
 <60abfd46a8ca3_1b20920823@natae.notmuch>
 <xmqqlf83fge2.fsf@gitster.g>
Subject: Re: [PATCH v2 00/12] doc: cleanup old cruft and asciidoctor revamp
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Apparently my scripts call `git format-patch` with -D, which doesn't
> > generate appliable patches when files are deleted.
> 
> Don't call format-patch with -D, then ;-).

I won't. I've fixed it now [1].

> > Do you want me to send it again without -D?
> 
> Sure, if a collection of patches want to be reviewed and applied, I
> would think it helps for them to be appliable to a common tree (like
> my 'master') with tools reviewers and the maintainer are know to use
> (like "git am").  As more roadblocks are added before the changes
> can become reviewable in the reviewers' trees, less chances they
> have to get reviewed.

I think this is reviewable:

diff --git a/Documentation/manpage-quote-apos.xsl b/Documentation/manpage-quote-apos.xsl
deleted file mode 100644

But yeah, could be more reviewable.

[1] https://github.com/felipec/git-send-series/commit/0f4bbf90fdd224e3d5253332755ad3d45c862ee4

-- 
Felipe Contreras
