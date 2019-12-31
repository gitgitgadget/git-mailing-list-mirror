Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854B4C2D0C2
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 10:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C57E206DA
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 10:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8V5bYMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLaKee (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:34:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33303 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfLaKee (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 05:34:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so34898737wrq.0
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 02:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TZPZfITVKNXPzwWO7OFZ+CidZASrqT0JfDzmNbRQ7RQ=;
        b=n8V5bYMQs0YLHenvIZ4u5DOlDxFR5Yx7r4hTQOU+VkLy2ZdknwNk7nSYBVdrEAJZEC
         J7JZm9+VB9kw6HWSBfOhz2G65VQ98RWqNUTA8aTAOK1WjsyMo8qlWxGMAIUmTvXDrotU
         /PWsNYG3d8gxIkyhpECVL1ADB3B9RrIFjFFedYk54ogFWZbeLX/+OcqazNaiM9gu2XjA
         d5kVukUlverN4u2tJS0SmKWJsBUAyRCHtcGHA69jmmX8UQai/F1RXzpuC6haFZg/U7U9
         /U2Ji0qQJI3QJwPhpdi0iZFGS2u19n5XNtSFVeZGZsjSd6zxmeFYcOeNFZgFMFPJsv1+
         cRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TZPZfITVKNXPzwWO7OFZ+CidZASrqT0JfDzmNbRQ7RQ=;
        b=C2IwR3fcZUf6ZLejhapsSih7LM+IvDFDctt/s0NkaZKwWUcottHWJhOYNSzaLK/VyZ
         F3l+P9L4Onk9mbltU6cRu0Pbdj0IT0xrzGl7JTj+iiJAN9zvTMUvJunnbyuMy7FdZj6v
         lrhuWmjRaieF89f6AxueJW0Q13DHlYe2Aa4eCbM8M3uz/e6vPx2ABTaL3trxC7EyMuHK
         qVTIwowTbpj46cOtjtNAkRlbCuZOdzBQ89rN75pdIQoTcANurq24GVnNdW49obIxF4xH
         G2v4fmxj2ygLSkSlMEvpjPokyS7NU2wt5pvBPFThsfGyXouumM9/HHBrNY8hEWqHy0DS
         G3mQ==
X-Gm-Message-State: APjAAAUoiOc2qT78oiXnX8xZ/DfdywRcoXy3gN5KaAbMbph+aST/x3sI
        Z43xNqqNXTYLyOwi+qqoYXQ=
X-Google-Smtp-Source: APXvYqwfIKjBAKJpNEh76sPqz2f+5C4sN32U9eCHwEnZCx7bjrEG2JAgTNyCsrv/bD/tiE7vM18+mA==
X-Received: by 2002:a5d:67c7:: with SMTP id n7mr39900376wrw.319.1577788472074;
        Tue, 31 Dec 2019 02:34:32 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id p18sm2183492wmb.8.2019.12.31.02.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2019 02:34:31 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 00/17] merge: learn --autostash
To:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <cover.1577185374.git.liu.denton@gmail.com>
 <xmqqo8vpfpri.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4032e4bd-fa3d-54eb-fe95-38549dff3aaa@gmail.com>
Date:   Tue, 31 Dec 2019 10:34:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8vpfpri.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/12/2019 21:49, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
>> Alban reported[1] that he expected merge to have an --autostash option,
>> just like rebase. Since there's not really any reason why merge can't
>> have it, let's implement it in this patchset.
> 
> Sigh.
> 
> I would actually have preferred to remove the autostash from rebase
> if the goal is to have a consistent behaviour between the two,
> though ;-)

I find the --autostash option to rebase useful if I want to edit a 
commit and I've got uncommitted changes. I wish it was called --stash 
though as it's not automatic as one has to set a config setting or pass 
it on the commandline. I'm also not convinced the config setting is a 
good idea as it allows rebase to run when I think I've committed 
everything but I haven't.

For `merge --autostash` I think we need to consider the interaction of 
`--no-commit` with `--autostash` as `stash pop` will refuse to run if 
the merge modified any of the stashed paths.

Best Wishes

Phillip


> But it is OK as long as it does not degrade the codepath with
> changes that wouldn't have been necessary if this weren't added.
> 
> Let's see how it goes.  Queued.
> 
