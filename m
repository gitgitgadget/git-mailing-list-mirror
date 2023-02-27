Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA409C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 23:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjB0XPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 18:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjB0XPT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 18:15:19 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87940DBE7
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 15:15:14 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id ky4so8558456plb.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 15:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+hwKJYMyJGx3nksgiXB4uB9hWHSU+xZGq5u+zV5ySE=;
        b=OhVydg/spCh7pURUhmV859e6K4ECkITqPxscphJgoaCDrBLfWriZkVJZrVfqfudi3l
         X+uCtmJYC0OSpqcfvIeJ0syCdMPDySehmoGnaP8lYvpQKBlHe7kBjbrMYqsF2jhZPgcd
         BZLODEJ7CMO7ceoIor/Gkia0iqp6buhwgyYVjfetVoODzqL8nHj5QxxLgJO/Oet+S7wZ
         ATJBBMhwSPLVDaxJ31+Lej8xJCAIoENWZ8IoihJXwI27CUPzj4VYaBsV4T5o/uGECZqu
         iqn5GZxRRV1WM4ihbB6gD/H7Uc357ZBzQWCEQYDT4ZLOoskElYrp/Z8OxUebOywgAdfK
         ixJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W+hwKJYMyJGx3nksgiXB4uB9hWHSU+xZGq5u+zV5ySE=;
        b=5J/V/vwrEm7ISAhrxP5oE/I3u0H/UwEDwo0w+aNE9Kspvduxg6JTnLJxXpyv7ZZ5m7
         5KHWaQrun+Y1QAG+PvY0n3J9M4EJ2+ZS+F/kEHnZxtBm+ukJnqOSqgwrewegD9NjOzk6
         GHx7+sZ3qGBRfSdRHw9jIjKC4n0jvOe/jI4B1cjheFUsR5CzWQBoSX5qu109uOx757bu
         SScwZk00ktzj1rsEQJv8D6m8GGhjx/kUvJM3tBofNkZU5y0yd99QjBYFH4DkTvrTaDzr
         keiM7vUywXhAiy2Eca9/8tZeUeAxrMZo8xTmlvqLsaItVF3IuhGYQutLSZlTYDni6MUJ
         j6HQ==
X-Gm-Message-State: AO0yUKU5Tb7tZ3/48Vu6zPQlKsuJOSduZyjVEfD9ww3/omsURPi87ug0
        WeYuKAdLMZ/ESsMmIcA7P1HPX06WnUc=
X-Google-Smtp-Source: AK7set9Zkqrh7yB0BGt0lxFsaWZRyziyJy0QbqA4bStq8mRkULbEDxKucOk5RdHfD1yrw5HHEsmnJQ==
X-Received: by 2002:a17:902:da8c:b0:19c:d3e0:1eea with SMTP id j12-20020a170902da8c00b0019cd3e01eeamr817167plx.6.1677539713825;
        Mon, 27 Feb 2023 15:15:13 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902fe1800b001943d58268csm5104059plj.55.2023.02.27.15.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 15:15:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Git List'" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Problems with CSPRNG in wrapper.c
References: <003d01d94b00$16abc7a0$440356e0$@nexbridge.com>
Date:   Mon, 27 Feb 2023 15:15:12 -0800
In-Reply-To: <003d01d94b00$16abc7a0$440356e0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Mon, 27 Feb 2023 18:06:07
        -0500")
Message-ID: <xmqqv8jmr98f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> First, I was not aware that csprng was a git dependency ...

You can choose from implementations that depend on common external
libraries and system functions, but we have a fallback internal
implementation that only requires /dev/urandom.

See description for CSPRNG_METHOD in Makefile and 05cd988d (wrapper:
add a helper to generate numbers from a CSPRNG, 2022-01-17) for
additional background.
