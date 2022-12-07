Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903A8C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 05:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiLGF34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 00:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGF3w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 00:29:52 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA8A2AC51
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 21:29:52 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v3so15316196pgh.4
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 21:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkqZYAilAN8v4xUxjStkUzm6PqpbNgqDMZfjbjHlRmc=;
        b=msUhfwSKGHFv6NMh76NswCxGeKiSHIgoNCPcr7Tb5kJHZq0OO633vXT8M6CY9keeGn
         zWW6EWvYD/xn67iwl3ppCUUoLT9sORXjLUIoWU5QhPskVwI78iFaJA9yFQObEvDO2F9L
         rrZFK/ei2ci6vvtIj0Grnq87m4AbF78FHsepUMD0F2ig2/ZkA5Wlaz9O7GlyQxLgwR7B
         2QYbN4Opf6Ckpg9zULizgFAK9feXzY61DZYKZ636i9tWfZCsYa+f3SW/9AUUyO6Kt/b+
         B/sODyPbxr5MMJBc/yp2GDSsOdPTbXzgQiPa4QHd9Q9J1w01mAo9u/8aiVi2RD5il2Or
         FAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkqZYAilAN8v4xUxjStkUzm6PqpbNgqDMZfjbjHlRmc=;
        b=rKgNjq50gdhMgUMqejHVwVEsnKCOpr8gxh0iNblz5hjtKh6EdMYnPWLh1FVFCxuTxI
         JGBALWCg2rAEUb6Lcg0BIfzetsMoh7ZYh6QDzwRQnICfisKXqbZMaw2OqGYnrH3rthO3
         e1MglziBouBwfve88Kj6bo6xyajggk3VARQpb8yQk2bFR6HOvzKy8VUF96tCUogoZ2GG
         5xWwovfUPYd/Yewfk7naC/o+n44xyEpG0AktG1LuN+2xaD4MQFSgMbLz6bsOdosLOm+/
         xcnW7i+Zyg6TByueteihGLvtGCqe2Zjh/tUpGnOdBF4nGr9lJEfaSlL6oFr9cTGFlweC
         WO8A==
X-Gm-Message-State: ANoB5ploh3mTo+8pK51mhYhuMCaWIxq7WsOiAPETDqgirYrOSa9hA8Oe
        Mmf20vO89hrT+qFiE6ANV60=
X-Google-Smtp-Source: AA0mqf5OnJJhPtOnvtAShpVKm35xXSk3dR4VXwO+6mhFjVJ5ePdR7dGDNHif9y1qHLpfqWtJPIv6WQ==
X-Received: by 2002:a62:1855:0:b0:576:9ced:ebf7 with SMTP id 82-20020a621855000000b005769cedebf7mr18989673pfy.80.1670390991538;
        Tue, 06 Dec 2022 21:29:51 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k30-20020aa79d1e000000b005764c8f8f15sm9186230pfp.73.2022.12.06.21.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 21:29:51 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Lars Kellogg-Stedman <lars@oddbit.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] line-range: Fix infinite loop bug with degenerate regex
References: <20221205193625.2424202-1-lars@oddbit.com>
        <221207.86tu27aju3.gmgdl@evledraar.gmail.com>
Date:   Wed, 07 Dec 2022 14:29:50 +0900
In-Reply-To: <221207.86tu27aju3.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 07 Dec 2022 05:52:04 +0100")
Message-ID: <xmqq359r7pdd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> It's perfectly OK to provide a zero-width regex in general, e.g. try:
> Or for a non-git tool:
> ...

The same story goes for "^" or even ".*", I suspect.

> I think the real bug here is that we are pointing our regexec() at the
> haystack of multiple lines as an optimization.
>
> Then in "determine extent of line matched" and "is it a funcname line"
> assuming that a positive match must be non-zero-width. But that's just
> because the optimization is leaky.

Good thinking.

