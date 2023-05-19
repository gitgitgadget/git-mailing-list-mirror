Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454F4C77B7A
	for <git@archiver.kernel.org>; Fri, 19 May 2023 16:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjESQ41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 12:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjESQ4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 12:56:25 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4C12C
        for <git@vger.kernel.org>; Fri, 19 May 2023 09:56:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5346d150972so2067053a12.3
        for <git@vger.kernel.org>; Fri, 19 May 2023 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684515374; x=1687107374;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZWuZPxieRW1DSiCkHkvQSvu4KZb/KegxWVNHRWGgkI=;
        b=kuHuHzIBBb6X5aGVHSxhrn1vJVkgUV02VimWQzO26kgS2yDvkPZnMLG1cmnnRzqwOG
         BnVfeImU7Ha3j99/8A8BegwsRWmr4Cl50UwUvKXUQHtk/KL3ry0Pc0gq6h0u7xmVhQ8A
         1Q5mt3gr2n1rbLLQf7j/OWImRXTDX0ZyGHLld2Xb5xCJPuAbgka6Dyy9a1d3cmADEbLQ
         n9e+b4VNBl/pEncIi03u0bOI+UeCOEixP7W3tpEPew8c8zcZnqEwgOB0tuSx6JyaXH7F
         OTJGVTwzCGoy8bxJ3wwWL7pJi993sCeZrDCF0q2oWkdjZKEV7QMEYGW2qspyzYGIatwF
         5X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515374; x=1687107374;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mZWuZPxieRW1DSiCkHkvQSvu4KZb/KegxWVNHRWGgkI=;
        b=k9mvHMsCaWom30l7v/rhJ5qzNCPEryndEU/v3HDN3UuiFOKg0eTTf3YhMK81ExRyai
         UrDUxGyllnuvugjqpg0Fq9gtBcQK0roRQSLVQZnoVTGjEw6+qOd4sUdg54eedbLFAPUd
         qYj9szXies/GthLFGHpdbovTCPlKvQhEhJ2nseQVtI0ahoCPAnBd2Js21hCzBfacWzWl
         oC6utIoJN9fT7sWyXcVB7TvKJJCwA6GOc8mFa2u2870plt2sqI4+PiEcKIkI/hNIYhs3
         80xxryQ/m7V7aYQF4XuBRA27HGIwP6JTdJrf+Iq/V/p4x0vZ7jqzezK2TEHKU8gNqIH6
         t2fQ==
X-Gm-Message-State: AC+VfDwo0IiiAOlZBg2HueqsvwfFZ2G3lB+JPbzIEjRZPVIbZnQhIjBY
        a4rvBLi+DcB5BTJ6aBjfcj1IZNaOjqU=
X-Google-Smtp-Source: ACHHUZ7T6bHbvlcpqrnzmzTG96nFS98fuvwSsxA0vbcdlRKcG5gnckL8SQCGPYvVz0Yxh4w4hWDjJQ==
X-Received: by 2002:a17:902:7009:b0:1ac:5717:fd5 with SMTP id y9-20020a170902700900b001ac57170fd5mr2879549plk.60.1684515374528;
        Fri, 19 May 2023 09:56:14 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b001aaecc0b6ffsm3677909plf.160.2023.05.19.09.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 09:56:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: free elements of rev.ref_message_ids
 list
References: <20230519000239.GA1975039@coredump.intra.peff.net>
        <20230519000543.GB1975194@coredump.intra.peff.net>
        <20230519145431.mnn2rpptvplorsf2@carbon>
Date:   Fri, 19 May 2023 09:56:13 -0700
In-Reply-To: <20230519145431.mnn2rpptvplorsf2@carbon> (Konstantin Khomoutov's
        message of "Fri, 19 May 2023 17:54:31 +0300")
Message-ID: <xmqqpm6wqmz6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Khomoutov <kostix@bswap.ru> writes:

> On Thu, May 18, 2023 at 08:05:43PM -0400, Jeff King wrote:
>
> [...]
>
>> There's no new test here, as the leak can already be see in t4014.44 (as
>> well as others in that script). We can't mark all of t4014 as leak-free,
>> though, as there are other unrelated leaks that it triggers.
>
> Probably s/be see/be seen/.

Indeed.  Will locally amend.
Thanks.
