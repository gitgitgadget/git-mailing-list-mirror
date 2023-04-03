Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19978C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 22:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjDCWyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjDCWyU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 18:54:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4803E170D
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 15:54:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d13so28701318pjh.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 15:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680562459;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbgbKl8ZdnZbwsqWeIBLqzk1AZln3eDRDMhc7VQ5MmY=;
        b=UFjhY5aIPq8DVGz6F0nMfBzjeV2NNSojEgp8iTDoFIMjtYMQB4m2/5pSLdUguuz4f7
         HXv6W1I/WP8TaDaq2e6LcJxEANJK/Y3mb47Mrg+ziNG54eGYgbs9hMjCyVLx4ljjTGsh
         BUB4HsCWqMh7i2XkkKzTRHydN+cktLPJhic5pU+4aMLb1PmvCR77PHc6uD235ZB70eeN
         T+udG/jAO8v91HTChHj1bw/FEmh1pK6RO02zum344PRlQsg1V8JbfYS8Iqf+LxGsQQWY
         2wJx95Mdx2ZW1sJ4+R4sDEDB+WDwy6HtYlGDXrwifzP4h8+HR7cOxeyQ0/avTHdLis5x
         tzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680562459;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IbgbKl8ZdnZbwsqWeIBLqzk1AZln3eDRDMhc7VQ5MmY=;
        b=uC8tVkt++epp6Nl2zvSfPwsiKO3GGbMjhHhYzy56iSTrefxOZptu8M6zjvdZTf/45O
         ZLKweC+SaIO1buqGrcgOJFKNmvEXcYau8uak7jl25ZGwktWyJVy/3EPx8/q4X4tjqi4J
         le9wCceiApNXDGhFnmnYDhvUAUvlBK8gVpxdbSxI8j7y+TU6xMSNuGLtHY+ycn4in0bd
         Wa/e9W9QpATwYDWNFEOufkS574epK8f0LeSZx9n7jVzjE513SK4C7gwszszg2Fpsdmm/
         L7J6BYqtuWiH3Z3+SDad/nq5LSevUxmYrhSGJVcnW2MAEQOcZz1E9hwsHS4K1A+uZtsU
         1i2g==
X-Gm-Message-State: AAQBX9f3eGIPn+IOweHC12dzAFG7G5srVU7X4XYkNrhoRgEJpcYL1XR7
        4WuMFPKJDxOmwFVHndSYyJY=
X-Google-Smtp-Source: AKy350ZttZIODpoxCv1Ejr/TWfF7+TPAf6d8dX0g6vjagSTxrxIp8DRIhertOqaN7Oq9njJR9WVxow==
X-Received: by 2002:a17:902:fa10:b0:1a2:17b1:70d with SMTP id la16-20020a170902fa1000b001a217b1070dmr562705plb.42.1680562458411;
        Mon, 03 Apr 2023 15:54:18 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id jo17-20020a170903055100b001964c8164aasm7078249plb.129.2023.04.03.15.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:54:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [RFC][PATCH v1] write-tree: integrate with sparse index
References: <20230402000117.313171-1-cheskaqiqi@gmail.com>
        <xmqqilec4ra0.fsf@gitster.g>
        <CAMO4yUGnkR5Jj5m52LXb9+LQUcJyjMW_RcFM2dzALAaKa064dQ@mail.gmail.com>
Date:   Mon, 03 Apr 2023 15:54:17 -0700
In-Reply-To: <CAMO4yUGnkR5Jj5m52LXb9+LQUcJyjMW_RcFM2dzALAaKa064dQ@mail.gmail.com>
        (Shuqi Liang's message of "Mon, 3 Apr 2023 18:16:52 -0400")
Message-ID: <xmqq1ql04lwm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

>> Has the test suite been exercised with this patch?  It seems to
>> break at least t0012
>>
>
> Hi Junio
>
> I commented out the 'test_perf_on_all git grep --cached bogus --
> "f2/f1/f1/*"' before
> running 'p2000-sparse-operations.sh'.

Sorry, but I do not see why you are bringing up p2000 performance
measurement script here.

