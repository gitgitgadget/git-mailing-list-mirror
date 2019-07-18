Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3D11F461
	for <e@80x24.org>; Thu, 18 Jul 2019 16:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfGRQ3z convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 18 Jul 2019 12:29:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46895 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRQ3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 12:29:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so29355680wru.13
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 09:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0I+YwizkE1CQTeWUx2PMvlJPmyLUaBh9q2QA5Mk+LZw=;
        b=NyI6UCgJq5LfFqPf3aAvgnm3YbbfsXTw8g5BL6LvATTEg01EfW3lfLGLThOb6iscLC
         TFlYLUhHzuWdp1K4wZMfAI/IgZ/jC7oIGY7wK2gZs5Hak+KXeu56p+P7k1XuZ68/2WaL
         OVoaltw9s+0qaVC28gQoz54wESANOtzTPd8P7ls3vPcuhV8DsE5/PGJ6LwQskZOJzgwM
         VYb+maWIV13Z7UlPYeABcwH9CTe5UWYtSDsEHvHbyBxnDa28FM3ibFEa3soX5hsk0iPY
         9/gnSiT6I3QR/CF1kE0KfPZWHfvab/zSTFk/WKkC4e1Es/Y8sn2sD6BB7KzlX6YnNtfo
         u+qw==
X-Gm-Message-State: APjAAAW5gycf/l3xeyxVQDlvwPsEH3o5vf+mTXhHce+Eh9op3EypPs1a
        uv9wmO4VZoOeFlt1j0hVuDg0GA/Srs+Yf7E+QGM=
X-Google-Smtp-Source: APXvYqzOb7vh5MQqD5/P4cAwYwToJ+vOS29WHF+LHi3eJpS050rxCsSEcNZWv8Ah7poSZklf8yn44FaKTfWU4UrvYMk=
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr35697023wrj.10.1563467393374;
 Thu, 18 Jul 2019 09:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <20190709211043.48597-1-emilyshaffer@google.com> <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
 <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com> <20190718152234.GI20404@szeder.dev>
In-Reply-To: <20190718152234.GI20404@szeder.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Jul 2019 12:29:42 -0400
Message-ID: <CAPig+cT5nbXcsj+CH38FwfE0m+S6VffG_Zz8iz0zpw49zDwd+Q@mail.gmail.com>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in push_refs_with_push
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 18, 2019 at 11:22 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> C99 'for' loop initial declaration, i.e. 'for (int i = 0; i < n; i++)',
> is not allowed in Git's codebase yet, to maintain compatibility with
> some older compilers.
> [...]
> [1] The Azure Pipelines builds have been using Ubuntu 16.04 images
>     from the start, so I belive they never caught 'for' loop initial
>     declarations.

s/belive/believe/

> [2] On Travis CI 'make test' alone would take about 9 minutes in this
>     new job (without running httpd, Subversion, and P4 tests).  For
>     comparison, starting the job and building Git with GCC 4.8 takes
>     only about 2 minutes.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
