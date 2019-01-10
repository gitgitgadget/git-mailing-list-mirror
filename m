Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6E21F803
	for <e@80x24.org>; Thu, 10 Jan 2019 18:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfAJS1S (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 13:27:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40252 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbfAJS1S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 13:27:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so7424wmf.5
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 10:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dU80BD9z4P1jEX7FhrMMICJwz2LvaUTXlRs5FwQzRqU=;
        b=vHSnUeFj5QFrGfsi7x+PdVw9ySFLStPcYnB15Dm+sD6Xpni8aBWDOR2ORuwSFcpXb+
         auPkEAnM0uV3fHJBA7qHHsPOw7oORmVvccPLfW4TfeoUOv4W3bBLaxpzkLDmVU2GFZgk
         kgLco1neRezHFNn8eE8NdI2g9eV6MxT46mErey2ido58ETf01hCbgfiP3CM4bZJlfQKk
         DlGuutBqeTpeEM4HW1w9qGglzIf80J2jSVPTlS2KXkUFuYBZtcF894vOlpLMgPU6fxNE
         e0cmygO7cZiOixHCZYgaXFFUsLyrsWX0v6SpXg/L9J9nAmBHnLUPNvXLIHGBf4rBKKlS
         QzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dU80BD9z4P1jEX7FhrMMICJwz2LvaUTXlRs5FwQzRqU=;
        b=hXw6fWxPpnmOAC+pcSZhoqeKoVR4y358RlgHbpXb2F4FbODCn2t4VOU1cY9Qx4WwNn
         MKpirFKca6QD69cKeaIEO3MmnIgtoi+97Cjvw4ZqaM8t7j3fmfHG3hDBH6cXU5BGafWN
         q5eUhpQW85G+QrKuZxgFf+2PzmMgh6JQYWxWfuMhwnIEyCSfnAKfiId0KxaOrKjKa3Sw
         lGzsxVkMlAjsU2ND6L1Y7MrwQu4qbBO8W+yLY7JNXWfSQ3vP2ayN2EGSabglizj+QTp+
         d2MPZyF+kw8/ENbjO94jAPWijwSkh1pz2Qm96pTDmnBs1BNn/2NMnthiih58RqeqG+VQ
         86yw==
X-Gm-Message-State: AJcUukeMUlq66DHyDi/v3AL7X1K71ZH7r92wdiE0tCoA6phgtwEhXj1Y
        zZtdByFm9LrRgr8vW6RuRQTzFxP4
X-Google-Smtp-Source: ALg8bN7MOu0wUI9Egu6/4NJtSK0n6Ik/aOflJTa8JclRJAKMgZZVnK9UFNRCDONUHggnd0oamd+GRA==
X-Received: by 2002:a1c:cbc7:: with SMTP id b190mr4855wmg.13.1547144836324;
        Thu, 10 Jan 2019 10:27:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q9sm46295018wrv.26.2019.01.10.10.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:27:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Kim Gybels <kgybels@infogroep.be>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Karsten Blees <blees@dcon.de>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] diff: ensure correct lifetime of external_diff_cmd
References: <20190109221007.21624-1-kgybels@infogroep.be>
        <CAPig+cQKnEWb+co_NJ0UyZbXZrvx2KsbS_ZugdyjjYZcz8tjvw@mail.gmail.com>
Date:   Thu, 10 Jan 2019 10:27:15 -0800
In-Reply-To: <CAPig+cQKnEWb+co_NJ0UyZbXZrvx2KsbS_ZugdyjjYZcz8tjvw@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 9 Jan 2019 18:10:58 -0500")
Message-ID: <xmqqh8eg2wsc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> However, you might also consider using xstrdup_or_null(), like this:
>
>     external_diff_cmd = xstrdup_or_null(getenv(...));
>     if (!external_diff_cmd)
>         ...as before...
>
>>         done_preparing = 1;
>>         return external_diff_cmd;
>>  }

Looks good.
