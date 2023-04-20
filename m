Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BF0C7618E
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 19:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjDTTxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 15:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjDTTw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 15:52:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D322F4C18
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:52:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b87d23729so1271918b3a.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682020376; x=1684612376;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQjGtKl96/2ZE8KyBW4I6sebOn6HdqpGUee0OiSIfck=;
        b=Wdab3OQXPmJ/FwQpiMgWLxmm0zuln2oSAx743hG81XgfeyQoOWPKepEQNrTi4QPxi2
         9EmBuN+4OlnzqeA203y3qdPE7mhN7awSx2d/r5rcGRe7MU0xhZFpXEM2sp207HPjPqcg
         SFEk6PwTBiIBFL/le91vr6Olz2vXC/hZO0DUq4soAQwyWIwwNADHX01E+esu09KMeeFh
         bfSXclvZAjXEO9mclD4p9iCsP15lJbQRroPaKJEvXFx5nIvawHyd/TCrvRlMhxaYf2yn
         28AbGEY6JGrhvfi/F6Nbq1IvMhSI6SJSGbMP8cSGFSIRWdGcnmlI52rJCUxlPlv2p4jt
         c64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682020376; x=1684612376;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZQjGtKl96/2ZE8KyBW4I6sebOn6HdqpGUee0OiSIfck=;
        b=UDct/K5NC63kk0CDEECnYkwle4gzjRmCgo1VHHgyuOBPGdSd1VuhguYXrbbv0VAXJJ
         1QYaVx32l8xj793YmPtfT4WlKmzCl0OJqTCXe79gJzfA5/ypEe1QPnF3cXel18AnaXlT
         Md1xwYtccuBb4BpP2iMFtL0N5iMGqxObOsT630d2WYihypl/q9dzipAoPq6n2dp3xNCE
         BlBvcCNIwItKuWFK7ZSAddcfYtwrE08+HLzqhaXpzf5r9Hw9qw8dL07wWXGBDl3KHZaU
         A9anG+C7q3A9O+aG75vbVj1ly48tI+qoWanx0WargSfNA2nXP8CC+oNx4dphU9bQoznW
         DsAA==
X-Gm-Message-State: AAQBX9caTQVxCVkQg77qFB8dg9XpzEgtMcjilfkIKV3PALFRUpB88yWp
        0G8hncB6eFbuQbSKzhHTOio=
X-Google-Smtp-Source: AKy350Z/B+t1/tMuo3URewLYS6xrytajy+LV/B609Ub/WbfRHgNq0sg3m0ywoekhlnJJRYV4Of8wuQ==
X-Received: by 2002:a05:6a20:3947:b0:ef:f7a4:a67e with SMTP id r7-20020a056a20394700b000eff7a4a67emr3982831pzg.0.1682020375752;
        Thu, 20 Apr 2023 12:52:55 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id p11-20020a654bcb000000b0050376cedb3asm1448662pgr.24.2023.04.20.12.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:52:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] builtin/pack-objects.c: introduce `pack.extraCruftTips`
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
        <xmqqzg72zalp.fsf@gitster.g> <ZEGSvfEkE5PhokKv@nand.local>
Date:   Thu, 20 Apr 2023 12:52:55 -0700
In-Reply-To: <ZEGSvfEkE5PhokKv@nand.local> (Taylor Blau's message of "Thu, 20
        Apr 2023 15:30:05 -0400")
Message-ID: <xmqq1qkez5yg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> But it makes me wonder if it would make the life of end-users simpler
>> if we reserve a special ref hierarchy, say "refs/crufts/*", than
>> having to write a program for doing something like this.
>
> Ideally, yes. But I think there are certain instances where there are
> far too many (disconnected) objects that creating a reference for each
> part of the unreachable object graph that we want to keep is infeasible.
>
> Another way to think about pack.extraCruftTips is that the program
> invocation is acting like the refs/crufts hierarchy would if it existed,
> but without actually having to write all of those references down.

I do not need another way, actually.

If it is infeasible to keep track of what we want to keep from
expiration because they are too numerous and disconnected, I have to
wonder how a programatic way to enumerate them is feasible,
especially the enumeration is for doing something useful.  

You can write a program that enumerates all the loose objects and
existing object names that appear in .idx files and such a program
will cover "everything is too disconnected" case, but that does not
count as a useful use case---disabling cruft expiration would
achieve the same thing.  Is there a less hand-wavy use case you have
in mind?

THanks.

