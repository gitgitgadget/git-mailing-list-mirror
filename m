Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34095C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 16:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjDGQaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 12:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDGQaV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 12:30:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F7B211F
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 09:30:20 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso1806041pjm.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680885019; x=1683477019;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKl60YgQF1613AxQMH0ER7dLQ1CVqo5c4MvN6cBV2Ow=;
        b=iggr+pXBIOndAXaQ91AVFvB6ci+zlmKhETx1DmfQ8VeyQK3nhr60qLeorK3+WMk57i
         kOxfgo6RKmsX+ldhklBmqDtsVxuYYcYI45nw1cItk+AesCFoukOdsvAI+sqMu4VHhGtO
         QRNNo00OI2Iqze2o1HzMSwWD3xnKiEo2OmMBK/5vLnZXlrE83S9SV/zPwSkwlo/y77iM
         wlOwyfLkCPdyFnt2WaASmCi9bvCVMSg3tsdgEcF5Nrl6fB+yk8iZfnYHTgVu2tTw1Oua
         pxwh9MnWaLorGr39vpDnN7z5BU+luSW284cS2MR19eS+7Lfo8FofGvf8TOcCVjyqzaGi
         UGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680885019; x=1683477019;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VKl60YgQF1613AxQMH0ER7dLQ1CVqo5c4MvN6cBV2Ow=;
        b=jDJhQ8TW74CVxEVWoITL6JndYnJPPIe8YQoiKAaL0MptpQ/KjVceK/2U4M5/tNQcXJ
         NQnvycdLU3atejrlig5ojgTwECzEDoXm9yi37CpMpP8ZPftEwjtlXYwQc8peNY7AsDLf
         XkUcqOJRJ8HVQ7gUwQZQ48/OaFE0N9j8Y/2WTf1wmfkAZRdT6e2GkuWLlMnC7Vrd99zt
         mQ4HZssy3uir6Wxut2/FQnYwFUCHS2vwpnkwWBTv21SNICi2yCsiowFF0+I87HqlYolf
         DkcGWKF6+NzaIJGstsBRa2vQe20XZxxttUsW8gUlsJ2qSG4r7Mj27MYvYbZGLwj7/UKZ
         UxgQ==
X-Gm-Message-State: AAQBX9fYEkqg9qlpoofHqJXM+OpJUST54momI8cezRXwn2B3RTePZqYD
        1Y9U5ffiaw5ze/+6CSlOIQXA+UDuTZs=
X-Google-Smtp-Source: AKy350ac6MVlqz0zsmFhjRDp6Av3OEN0VhsH0vHSPjCJb5A41l3jaXyBMmQjPlZD0CO25HCK3pLltA==
X-Received: by 2002:a17:903:24e:b0:19e:e39b:6d90 with SMTP id j14-20020a170903024e00b0019ee39b6d90mr3588428plh.25.1680885019359;
        Fri, 07 Apr 2023 09:30:19 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b0019f1222b9f6sm3146080plb.154.2023.04.07.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:30:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, johncai86@gmail.com
Subject: Re: [Question] Can git cat-file have a type filtering option?
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
Date:   Fri, 07 Apr 2023 09:30:18 -0700
In-Reply-To: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
        (ZheNing Hu's message of "Fri, 7 Apr 2023 22:24:22 +0800")
Message-ID: <xmqqy1n3k63p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> all blobs, and then use `git cat-file --batch` to retrieve them. This
> is not very elegant, or in other words, it might be better to have an
> internal implementation of filtering within `git cat-file
> --batch-all-objects`.

It does sound prominently elegant to have each tool does one task
and does it well, and being able to flexibly combine them to achieve
a larger task.

Once that approach is working well, it may still make sense to give
a special case codepath that bundles a specific combination of these
primitive features, if use cases for the specific combination appear
often.  But I do not know if the particular one, "we do not want to
feed specific list of objects to check to 'cat-file --batch'",
qualifies as one.

> For example, `--type-filter`?

Is the object type the only thing that people often would want to
base their filtering decision on?  Will we then see somebody else
request a "--size-filter", and then somebody else realizes that the
filtering criteria based on size need to be different between blobs
(most likely counted in bytes) and trees (it may be more convenient
to count the tree entries, not byes)?  It sounds rather messy and
we may be better off having such an extensible logic in one place.

Like rev-list's object list filtering, that is.

Is the logic that implements rev-list's object list filtering
something that is easily called from the side, as if it were a
library routine?  Refactoring that and teaching cat-file an option
to activate that logic might be more palatable.

Thanks.
