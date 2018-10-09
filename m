Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD3DD1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 03:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbeJIKyb (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 06:54:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34944 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJIKya (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 06:54:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id e187-v6so327988wmf.0
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 20:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wEn0ItoEN0sfhsj74p1trU54/Z/TpDvRHv6BxJWBKvI=;
        b=Rm5T2zuxll/Wn34o0vmVKwSPCNaX70jphLeYEBtpcfw3NtaTojm7bKD6/HsrZuS8ur
         dlWnuRotY/LXROe3/u8EQzXoArAtec7D03LI8PLLxSqfU2ZFd6zN6StnWWStcQNTWR6f
         PAAlsGFlJ1VJ888gr6NhX3fW5cMPIjMYe9tBMwdYH7OBV+u4uMvaYgLFs1ylsEbT8EmU
         xZU1/WhiUnDRb3uR7OnPLD7zf/v5zbi2yLeYKf45J/Kfx4N+2eNTH69P8GGHsUM30B4P
         nCxzLC5NOILt7p3y3BLgUHD5Tih3AQAOkVVXwKLwqWCQPJSUn0DKBwvEfzAOZ1+a4wQz
         OCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wEn0ItoEN0sfhsj74p1trU54/Z/TpDvRHv6BxJWBKvI=;
        b=AAVMqQHvNdQ0MOJDYXFsgXQCzGyMXRhwwb7jgU/+LbApbTtYUZY4XCHONoumDgosFC
         spyPVTmQeKZR5CaJyBuS7VKo+GLUc47jFcspoGDCmF8229u9jcUb1aydKEoJ+g7ysaUW
         5UA6qJ74vRO/3HhCNU6nh52jpenw2D9QeymQTBfSkUfd2VTYRe0Gj6KrsP0y1VFPXBLE
         kh2W9pK44e9W7EgLnqmPFtwxpfAuOdoDMYnq6ekGS35PO6CAgUSyJvJ3XdN7SICFRbFB
         /Wpc4PbwuMcacrNxi7ClW0Le7jcPWAlGDzvqUvawwaOrKy/tLoPujOqr2dquutOI/06o
         ob/g==
X-Gm-Message-State: ABuFfoiVBgwtrLfAiELZ/QNM26DmdBGoQO0IaAbGdyrKG9ziCvLTjR9G
        e+7coenjEKIpYf98Ih9ffU4=
X-Google-Smtp-Source: ACcGV60uI8hZcpPuaCFWe4VYKkUzU4rq+v73HOZcEj6n+bsaor0in6NoCNR0dRw63ySWDkgob6vgCw==
X-Received: by 2002:a1c:1dcc:: with SMTP id d195-v6mr420511wmd.119.1539056380139;
        Mon, 08 Oct 2018 20:39:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v76-v6sm19257585wmd.32.2018.10.08.20.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 20:39:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 09/10] submodule: support reading .gitmodules when it's not in the working tree
References: <20181005130601.15879-1-ao2@ao2.it>
        <20181005130601.15879-10-ao2@ao2.it>
Date:   Tue, 09 Oct 2018 12:39:38 +0900
In-Reply-To: <20181005130601.15879-10-ao2@ao2.it> (Antonio Ospite's message of
        "Fri, 5 Oct 2018 15:06:00 +0200")
Message-ID: <xmqqd0sjss91.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

> Finally, add t7416-submodule-sparse-gitmodules.sh to verify that reading
> from .gitmodules succeeds and that writing to it fails when the file is
> not checked out.
> ...
>  t/t7416-submodule-sparse-gitmodules.sh | 78 ++++++++++++++++++++++++++

This now triggers test-lint errors as the most recent maintenance
release took t/t7416 for something else.  I'll do s/t7416-/t7418-/g
on the mailbox before running "git am -s" on this series.

