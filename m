Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110C51F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 17:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeGLRzg convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 12 Jul 2018 13:55:36 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40550 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbeGLRzg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 13:55:36 -0400
Received: by mail-yw0-f194.google.com with SMTP id p129-v6so10750435ywg.7
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 10:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7WlYNX5bqU6LN5iKh8FjzI0UJt0bu7rOGxPL1zKB0l0=;
        b=Ci9jbD8iwtRiocLZtD9gjUfbct3rvtenQ1A6EiBqFy6u2SZBfZG3e2yFXEy7IxqIZ9
         fscF9iXxjV9nPYua6gH6erm+AsvKczmwkwcWeIrojCcCvMdEnjref8T4Ht5ttfK1H4Ou
         uSxcm8ZydKrxjyUEQoamK8SZJES7vUTVyfdlx2Aw4I5cCgUSRh4vDfDA/CcI3G0ALEK0
         9pYwRyG2MOJ/ytu2UulbtbbxPJhiMph3ewdcKoGbhlaf9vuBt94a0Oi1Zylzxqw1a5f7
         30bMYudwgrVVaPg70jaoeI7v1q2uZZN6pkAVOYQ5FKs4ChmuzREx8UA2W6u0wCIe0KQN
         W/zA==
X-Gm-Message-State: AOUpUlFCPRQEw8hMPf83UDrq/6OIBegJmOoqYbjpuQvJCbb0TnGdeMyn
        +7HGa02fu+DNkF9nW0dnpUUAM3ULf6TPcCYgoSc=
X-Google-Smtp-Source: AAOMgpfRONdIxrxVrwQ40AFYrPpuUpw158CXL5q1N4t9GyrRkWCVB9OXbmvrudWcImJgrAB9hFuuSDAOU9YPj4UST68=
X-Received: by 2002:a0d:c105:: with SMTP id c5-v6mr1613788ywd.131.1531417500900;
 Thu, 12 Jul 2018 10:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180702002405.3042-1-sunshine@sunshineco.com>
 <20180702002405.3042-22-sunshine@sunshineco.com> <20180712123729.17861-1-szeder.dev@gmail.com>
In-Reply-To: <20180712123729.17861-1-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Jul 2018 13:44:49 -0400
Message-ID: <CAPig+cRYNo_KL02LN1LOa79Zm2oYZqbnBHJ=KDA3oaF4pVfjcA@mail.gmail.com>
Subject: Re: [PATCH 21/25] t5000-t5999: fix broken &&-chains
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 8:37 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> The change below should be squashed into this patch to fix a
> previously unnoticed broken &&-chain.  I think you missed it, because
> this test script is rather expensive and you didn't run it with
> GIT_TEST_CLONE_2GB=YesPlease.
>
> diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
> @@ -23,7 +23,7 @@ test_expect_success CLONE_2GB 'setup' '
> -               echo "M 100644 :$i $i" >> commit
> +               echo "M 100644 :$i $i" >> commit &&

Thanks for finding this. I tried to get as much coverage as possible
by installing packages I don't normally have installed (Apache, cvs,
cvsps, Subversion, Perforce, etc.) and even temporarily modified a
script or two to force it run when I simply couldn't meet some
prerequisite, thus reducing the "skipped" messages to a minimum, but I
wasn't even aware of this prerequisite since I never saw a "skipped"
message for it.

Looking at it more closely, I think the reason it didn't come to my
attention is that this script doesn't use the standard skip_all="..."
mechanism for skipping the tests but instead "rolls its own", and
apparently 'prove' simply swallowed (or was unable to produce) an
overall "skipped" message for this script.
