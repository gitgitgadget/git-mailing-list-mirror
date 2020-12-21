Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C458C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 20:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F12224D4
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 20:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgLUUUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 15:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLUUUk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 15:20:40 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC58C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 12:20:00 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id b24so9978200otj.0
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=0RRxN3SPVC5dOg1Kk1jWbcSCWdoAKsUqodD1JYzBQV0=;
        b=c1ooz0KICzTaVVbIsmBqGp+HOOoHtakQakgvbK8PMkCnhkJo2j75xdSqd91iTnLxiN
         0kM7ECxMIs1Wb1KM4kJoWFof0+2Gs4xzEDu9eH2HvDBr1Tf6Gh1BgL65HfSM7ffBcmgi
         iHVgLuqJhs0nOiRGtm7Nd4ZuFbXlL/FvPAJnFmauy2DkG2PZRuARzU8Aa9xYQh8Hy+a3
         /B+0rkkXQwvcKkflGiP+q2XuGtmwUim1OlWs+4E6TqcUbYfzNVw9cuPdf1FNgonBAUF/
         1UG8hKynblqSIJx9t93uBFOJbO35Qayrfv+jagjauLe92pqiEGLXV4z+b66l7PHADWp5
         uBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=0RRxN3SPVC5dOg1Kk1jWbcSCWdoAKsUqodD1JYzBQV0=;
        b=TCdQnYYMOEi3rHVKN/3V9zNzMyQ1i8KsTJ/ZoBXfmj9FnMVNhN8bQmMb4yp6Q0T7AZ
         3BcYtSOmIVExsqZpb7L1t4RBJ8A2J4HC4XVhfBWKmI7u4jFP2Qb9ain4CV7kocC5pQqr
         fLpc/oi5ClY7pZWj7WHnFWmiumljybQzCEB6VmIy30Dxqv6OJlyJ0v9CT8Tn7j275uCj
         DsDSq1rrPUzIPy4gVoyOaV1vhX9vttZnQGRbkvuh7uQNa28/woHfMSZ23HI9YAR546E8
         4Ljrzakok/dWRAGhLvi9E0Z2WsZmOGhvYWSNi5y1ZLuX3Yhh0sixRoA0dGrH/oHgd1KI
         T7AA==
X-Gm-Message-State: AOAM532FNwhZP4z4T0SzdV3HmIARgv6mboRM94jQDpe+DfOi2qqGvCRw
        HAbqRCiTXup2juKtWPJ0+Ls=
X-Google-Smtp-Source: ABdhPJzbDAYMhe3DNmCegz9hFCDIynzH4LIlzZVrIyazrKtBHA9e5n1XQT1btBNL6v+4EBdILpb94A==
X-Received: by 2002:a9d:c68:: with SMTP id 95mr13139657otr.328.1608582000034;
        Mon, 21 Dec 2020 12:20:00 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t2sm986953otj.47.2020.12.21.12.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 12:19:59 -0800 (PST)
Date:   Mon, 21 Dec 2020 14:19:57 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Message-ID: <5fe1036d63729_f938208b3@natae.notmuch>
In-Reply-To: <xmqqsg7zkk75.fsf_-_@gitster.c.googlers.com>
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
 <CAFQ2z_MtpPNSpL9=OoyPfDRfkFxnCO19qBDnY9bnZiEEGtuMsQ@mail.gmail.com>
 <xmqqim8vm41g.fsf@gitster.c.googlers.com>
 <xmqqsg7zkk75.fsf_-_@gitster.c.googlers.com>
Subject: RE: [PATCH] SQUASH??? allow t0031 to run with any default branch name
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> It seems that we should stop assuming what the name of the default
> branch is in a new repository.  One good way to do so would be to
> change "git init" to "git init -b primary" so that the tests won't
> get affected whether the default name is master or main or any other
> value, and then use 'primary' throughout the name, instead of
> assuming 'master' will stay to be the name used when unspecified
> forever.

A better name would be "initial".

Even in tests branch names should mean something, and in the context of
git, the master branch means the original branch from which all the
other branches were copied from (usually). In tests the primary branch
is not necessarily the master branch, so "primary" doesn't cut it.

Another option is "original".

If the meaning of the word is not defined yet, a placeholder can be "nonce".

Or if we don't want to assign any meaning at all, just "blank", "nil",
and of course "foobar".

Cheers.

-- 
Felipe Contreras
