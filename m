Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A0A120248
	for <e@80x24.org>; Thu,  4 Apr 2019 09:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbfDDJba (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 05:31:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33331 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732611AbfDDJba (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 05:31:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so6854969wmi.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lErX7uQTVTo+Kst7VMDN9fOP+TZzOSekLWfHsogpmPA=;
        b=nNJF7dD0PHrWaPuFEmlpL5Gwy7+hx9wuPSPrMSC6xX0zeT5vzE0i8/ATZu3Awj/OZI
         5sHfZj4eyJZlMf1kUfZOdp2tAx3fB58ViKYQgIpbrJ8LuEwaWyKQZN+kOkfr4+mrf23J
         1s2eXE/aItNGpNUY1qpz/FtYQR3x6Yh214bxSyiBlYp8E4XEaipi2wf/JbI0RupuuGFU
         6Y1I85nQpLT8/SBEs0LpVntkwFH+aIlnWjeaiK83oa/RrQTrU7Ek2EfFdSYhxgP5d071
         RjN8oVV0LmvCoH/miiZbOY88Xy1r25ncnh3SULh1vba8q9rpaKt51ToRFJfQ4R4yg23H
         t3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lErX7uQTVTo+Kst7VMDN9fOP+TZzOSekLWfHsogpmPA=;
        b=hIBNHmyuZlCxG4kDwKIGSmJ0g9vAJFcT/D6jFIxxmAV/45vkKrfS8bzUoC2d/7XLZy
         5fZOG9fWN8PHu2NhP+zw/SfA7gpmIHH14EfqbHGebDA+6Xq0pCETkTZAjzlicEMwllpD
         l0XbMnsTJ+c3U0xbrtvR8ShFqbRT4bsxba/zgKKyDqrGO1q+zYjKeagVJ7BAbQrAdcyF
         1bm5dLRhVaF51LV3ldJ0BbenR8lc5qi7tf8tYoqnVPPSCV7jGE2GRW/TT7+tOXZu5Mcw
         9+L+uUVCuCy3HnD2ju91C/dXdG/BDD3vsHgr5HdG5EsH/6IzAwKPG5wWrUrCp//Chqnj
         jbCw==
X-Gm-Message-State: APjAAAVfKUVOS6kN218ROVJKCiFLhIhs99MODssKy6vURg209kqD6syB
        WVKHIRREAOzOB1QyuMWVQZg=
X-Google-Smtp-Source: APXvYqz4aDMibzRvlHlik+M3j0T9xFMk55pir2JvqYKJ7jKmPccvaQeG9UHYnxCFVrhJ+TREj9Rs7w==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr3531858wmi.57.1554370287814;
        Thu, 04 Apr 2019 02:31:27 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o17sm19218249wrw.73.2019.04.04.02.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 02:31:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
        <20190402230345.GA5004@dev-l>
        <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
        <20190403213318.GA14137@dev-l>
        <20190404020226.GG4409@sigill.intra.peff.net>
Date:   Thu, 04 Apr 2019 18:31:25 +0900
In-Reply-To: <20190404020226.GG4409@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 3 Apr 2019 22:02:26 -0400")
Message-ID: <xmqqftqyf76a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do still think it is likely to be a mistake. I think Junio's point,
> though is: who cares if the mistake was made? For the most part you can
> continue to use the tag as if the mistake had never been made, because
> Git peels through multiple layers as necessary.

Nicely said.

If we forget to peel, that is a bigger problem, but I do not think
it makes any sense to single out tag-of-tag as "curious" and forbid
it, when we silently allow tag-of-blob or tag-of-tree happily.

An opt-in (i.e. default to false) tag.allowTaggingOnlyCommits I do
not have any problem with, and I could be persuaded into taking an
opt-out (i.e. default to true) tag.forbidTaggingAnythingButCommits
configuration, perhaps, though.
