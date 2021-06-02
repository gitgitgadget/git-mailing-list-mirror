Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BC3C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 21:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8973613AE
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 21:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhFBVSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 17:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBVSk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 17:18:40 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05CFC06174A;
        Wed,  2 Jun 2021 14:16:56 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so902578ool.1;
        Wed, 02 Jun 2021 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=OR0vZLC69IiyT4ypo7Eh+2A/eWbHPbW4MgdKpUyG+Uw=;
        b=AWo4Qm+h17+bQmjN2afrOjbyMxcUf9Rt/frA3X3zSzVGH+vvZ3sVsQfgy0jmeUzi8T
         mh4+0uhpcGizcDzhnu6Zs2pPInN2vjNgk92TSH5MnpPAC8Xin2Lb6UUcnDyAo8W87b7g
         /I4IX4HuIRxxJUj2T2T5S2dx0kE3hzGgPhA0b9YZNzCwi3KjRfOoMVDUgWKpe+QWji3y
         DuforVJehGdkBqWJG7a0g7i4HLT2gUls5ChLOHkN9n8K1jGubVP8iqinlGKzP07CN8Q2
         wEb5Ly0idE2JUxZNH9JNRe4CkvC/ODl5iBWKDE2wgUFgjsIGOOQty+8RdHgQevz/bOCX
         VAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=OR0vZLC69IiyT4ypo7Eh+2A/eWbHPbW4MgdKpUyG+Uw=;
        b=eKJ45Goz6mgTxpzMtgU6lxWFpEo9YLyf07mCSjGa3eVqs3rC13OuYX2FiqXUvpOZR4
         N4ACJl1pGLYxLCskzkifcFGD1NbFM/z9TQCx30sMyOJvC+NgiMpsnGJ5FDR2JZ/gQh5O
         0QtykIfU/ap7z3e6QJRqeNSflQqXwSCJWKBarqXW2TNWeq/cYmDZhkN0SOmc5GCZk/4s
         Xi2TetsRvMXTYIDl1ZEXboAism8p8bCl+lXNqNC9QpPlC3ksgjqv8SFkOOWVYubMezFI
         EJAtof49yahZ1iWWWAoE0303Mjyi5GoIiWXg0viMrImpj+QYYZ/DVz6DA8quWoE2dbU0
         t4ng==
X-Gm-Message-State: AOAM533Slb5easrdPgbCpPkvfXMYyZ3ghaMiNQ/FRajVQRStHbykQ8s1
        Kzlwubr9MyRdc9Tgam66+GgRp7lV2aiWhw==
X-Google-Smtp-Source: ABdhPJxo1f2+kgOVPuhkc967KnJYlFthltXeJhCzAKvT38tQoM7Ms9tBYEbybdd8g4wCPQZ9hnuqkw==
X-Received: by 2002:a05:6820:386:: with SMTP id r6mr3191559ooj.25.1622668616258;
        Wed, 02 Jun 2021 14:16:56 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id o20sm236330otl.2.2021.06.02.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 14:16:55 -0700 (PDT)
Date:   Wed, 02 Jun 2021 16:16:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        git@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <60b7f54697fda_16925f2083d@natae.notmuch>
In-Reply-To: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com>
References: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com>
Subject: RE: git feature request: git blame --ignore-cleanup/--ignore-trivial
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathieu Desnoyers wrote:
> Perhaps a new git blame "--ignore-trivial" and/or "--ignore-cleanup" could solve
> this by filtering out "trivial" and "cleanup" patches from the history it considers.

While this feature would be a good addition, more often than not I need
to look behind the latest commit regardless of whether or not it's a
trivial one.

So what I often end up doing is a `git blame --incremental`:

  git blame --incremental -L100,+6 file.c | grep -o -e '^[0-9a-f]\{40\}'

This can be fed to `git log --stdin --oneline --no-walk` for more
user-friendliness.

Of course you could just do:

  git log -L100,+6:file.c --oneline --no-patch

But for some reason that's much slower on my system.

Cheers.

-- 
Felipe Contreras
