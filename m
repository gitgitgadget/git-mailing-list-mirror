Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C61C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 04:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLPEY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 23:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLPEX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 23:23:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E571F18B2E
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 20:23:58 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t17so1285004pjo.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 20:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kk60m1JJhwArOhpcRDIV4JkOL60AeUODf/b6CCNh5L8=;
        b=GYik2B6xlDceY1B3i5oLxNnZt6eiQtoTjY1301JbbZQinC9C8xfVVuGi/SLw9WQ/sa
         OJMHTtuDYfmVT7H7/32OJbk6QzNYYw+WpyJK0iR6CnqrNZH+Ikt1AOQw/ILIgN3A20wi
         orys2gNIzvo9T43R81XrPeL8VY4tzDVt29iotNmSWlX4idcnoA8hfvYPzKX+UvSeV+gu
         rVEBqKMn2HbzuRhooaRY1r/XshAWY43NPbUNbpLMGhyYV2E1w5wzDuOgSfrTmkqwqjif
         IpR3KdmIPPkMZ4ATEwj7Hk66DTKnm0tr/u0GGoZW9TbWlMY0L0jmeI7Aczn1Bd6STM1s
         V1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kk60m1JJhwArOhpcRDIV4JkOL60AeUODf/b6CCNh5L8=;
        b=z3Btk2c+rV9IKDo3wlxMWDIZT8mDWiNfl3N35kHgOm6wbaiwMX/5ut6CUy0j+YP9rC
         metlPg5bXQvBQ2fNz/SpwkoFSfufxuuDeeWjGGKqYA7pF6vHn/ryAMCMJYRFf2ka8Sr2
         bwSKX5ngblP9N7mvPGcxQduU/LyyTkSWbwRjzxyC1k5VPDjzIn74mBTPwZTKBQj80e/Z
         X4k9389653nqO5XpSsOtUPKrqY8la7T5ZOO8ReWkfR5W+uTwyyovcBgor+YHOwtEpf4V
         h2Ul4n135tcwlFpuO7FGcGbaNZ4nlK1IBDkZESKzUMpvyI2RhiuWEK6Qi9QYdUDrpOJF
         Dc5Q==
X-Gm-Message-State: ANoB5pl7WhrkmWe5wBPfcFdqTu4tmye3J7FRwsNV1HC/kclLK59I430j
        lY9Y9fZxhfRj8TfSYL4UVnhj1JMdnyOZ7Q==
X-Google-Smtp-Source: AA0mqf5OBctvYGs8JHVK8obdufm4Wzg9xzuZXspi/d0+AxL5koyasj2ny4YspVFbdCo2bK7NwLTisA==
X-Received: by 2002:a17:90a:510d:b0:219:e1ae:8e06 with SMTP id t13-20020a17090a510d00b00219e1ae8e06mr32248233pjh.15.1671164638278;
        Thu, 15 Dec 2022 20:23:58 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id nk20-20020a17090b195400b00212e5fe09d7sm434145pjb.10.2022.12.15.20.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 20:23:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com, plavarre@purestorage.com
Subject: Re: [PATCH] date.c: allow ISO 8601 reduced precision times
References: <20221216033638.2582956-1-phil.hord@gmail.com>
Date:   Fri, 16 Dec 2022 13:23:57 +0900
In-Reply-To: <20221216033638.2582956-1-phil.hord@gmail.com> (Phil Hord's
        message of "Thu, 15 Dec 2022 19:36:39 -0800")
Message-ID: <xmqq359gnfhe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> From: Phil Hord <phil.hord@gmail.com>
>
> ISO 8601 permits "reduced precision" time representations to omit the
> seconds value or both the minutes and the seconds values.  The
> abbreviate times could look like 17:45 or 1745 to omit the seconds,
> or simply as 17 to omit both the minutes and the seconds.
>
> parse_date_basic accepts the 17:45 format but it rejects the other two.
> Fix it to accept 4-digit and 2-digit time values when they follow a
> recognized date but no time has yet been parsed.

I worry a bit that this may conflict with other approxidate
heuristics.

> $ test-tool date approxidate 2022-12-13T23:00 2022-12-13T2300 2022-12-13T23
> 2022-12-13T23:00 -> 2022-12-14 07:00:00 +0000
> 2022-12-13T2300 -> 2022-12-14 07:00:00 +0000
> 2022-12-13T23 -> 2022-12-14 07:00:00 +0000

All of these may be obvious improvements, but the thing is that
there is nothing in the approxidate parsing code that insists on the
presence of "T" to loosen the rule only for ISO-8601 case.

For example, with only 6 digits, do we still recognise our internal
timestamp format (i.e. seconds since epoch) without the
disambiguating '@' prefix?
