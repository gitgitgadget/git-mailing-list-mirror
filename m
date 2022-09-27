Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8F7C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 19:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiI0Tfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiI0Tf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 15:35:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4DABCB6
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 12:35:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x92so1397155ede.9
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=3H+ne5f+CVeoehge6UgQOpGl/5sPuOTFPca4WKzShYE=;
        b=OIwWVT+2zue3GP42PRBT9a+wQr1anJEgHDJoo0acmyIoH4+5O8WkJID9+SqNW7KuC4
         Tc6N0PGWGmw6EQgLrwWCwvg+YjRijqal974flBmtTH+MQ+cp4sLZ1L6y9pXRe0YOXmMM
         yqrwJakERz+tu9iVkK8Q6hENnEIUJ/pcfQwy2bO0bY2aBqp7f9Tu3vU/8p3DjelYAnmM
         83DW3hw99TOLl1RBPxV6UQw0FhhpBxgZ0lpJnguqhFDiPeuL2LwBJtx0ZCB/xY0cotsY
         5Ia7QixAXwrjoYkOMLBVuXuZ7So5AehKsDQePj0NOLH5xEwJa/uxy81ffAcL7qh/LJmT
         bl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3H+ne5f+CVeoehge6UgQOpGl/5sPuOTFPca4WKzShYE=;
        b=OyAWBA+P07YOGENYYBenkdlLhjVvPLKrzk42WfA7YyvmTWDrGEeQxay4mKE0i2MZp+
         v0X3s4LAgfi0qsOKpV7JYVA0iaK1e69e+gJL51koItmhvTex3F0VZJv8Me5Rl08wsrDu
         9tEfes6gwXzJH2I3D25k91gx7l2g+qRhIHLaTD86NwW4KmSko0Wyy3Bn1OaHlVJkcOG1
         05J8rURT9eLjjPz6DN6QlUoSPEk7EYOkfJrskZT4W3HHTlSq+Qg6JyH5vPO/ScmEsZLe
         9VC+Z5JQ3v4+PVr2jXa4Y62mgGaGVHgQbdIhBOK+q/4wJhgunCBGDKKbFHQuZyuTAXip
         nr4w==
X-Gm-Message-State: ACrzQf3nsi/z1sW3ZPaocuhrHOTV1YiqQo3pnNIvi9kB3FRY7zXFlk1e
        i5+Kmbk7/Cs6LclYZgz0Y8o=
X-Google-Smtp-Source: AMsMyM67oM46bidwzBkU4vSxR17GUiQrnQIa/ad/2K4ik4nbipHPzcqWy1+F66uZx0IgJZE7/uSMgQ==
X-Received: by 2002:a05:6402:2554:b0:450:28d2:2152 with SMTP id l20-20020a056402255400b0045028d22152mr29842506edb.303.1664307323765;
        Tue, 27 Sep 2022 12:35:23 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906211100b00741383c1c5bsm1224162ejt.196.2022.09.27.12.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:35:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odGMU-000XCC-0a;
        Tue, 27 Sep 2022 21:35:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        emilyshaffer@google.com
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
Date:   Tue, 27 Sep 2022 21:34:22 +0200
References: <20220922232947.631309-1-calvinwan@google.com>
 <20220922232947.631309-2-calvinwan@google.com>
 <xmqqy1u9uddc.fsf@gitster.g>
 <CAFySSZA=tThoHdTY7+bMStvC=xeeyMiv4aVDYt-eNW2mQE10qg@mail.gmail.com>
 <220927.86ill9yymv.gmgdl@evledraar.gmail.com>
 <CAFySSZBSAW=zea8UoMiaQkf8rdJUBGHDYZQFkPLW7mRSciS-FA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAFySSZBSAW=zea8UoMiaQkf8rdJUBGHDYZQFkPLW7mRSciS-FA@mail.gmail.com>
Message-ID: <220927.86fsgcy5j9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 27 2022, Calvin Wan wrote:

>> I don't know if you started this work or not, but I had a WIP rebase of
>> those on-list patches lying around in my tree, which I'm rebasing on
>> "master" currently.
>>
>> Some of it's a bit tricky with the in-tree activity since then, I'll
>> send them in when they're ready, maybe you already did your own rebasing
>> of them, or maybe it helps & you'd like to base a re-submission on top
>> of them.
>
> I have not started on this part yet. Do you have an estimate as to when
> you're planning on submitting your rebase?

I hacked this up today, it passes CI at least:

	https://github.com/git/git/compare/master...avar:avar/hook-run-process-parallel-tty-regression-2-argument-passing

> I'm also considering not using
> my pipe_output option and going a different route since there is the
> issue of dealing with potentially unbounded output.

Okey, if it's not blocking a re-submission of yours then I'll definitely
wait until after the RC to submit the above, at least, but if you'd like
it earlier...

