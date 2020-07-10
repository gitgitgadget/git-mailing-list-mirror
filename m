Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3D9C433E7
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 12:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242E420772
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 12:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGPNrXDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGJM6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJM6I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 08:58:08 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E31C08C5CE;
        Fri, 10 Jul 2020 05:58:07 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b185so5070955qkg.1;
        Fri, 10 Jul 2020 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nQoGOpWPaVx67CKb9WI+bSalMdq4/lypurXp16g1b1g=;
        b=GGPNrXDkUSwSxrctjlEUZJb6+6w7lNzvTb/uWHnoDjhPskiDjnuCnc0U4C4nG0ZY8b
         j4h8/tt9Y9StkbgYYIg/5aapRmnQJ3CEPPV+iNIAAncVZFVI+DZ4eSXlV0JkYqGvgq7Y
         Ulxxs43iS22wVMLDZGZz+qN80XK5aMsKnRDwJtQDN7Sq4Y8j2niGZD4O63WRGEuDkESH
         IrlhlhRDcP+PLwenRiaOkDv1PHu2WVW3fuwIfAY8CBVhPA5QWOPxEeY4JgqpFLOOQo/u
         Pb5FTfYShXurQYfXpKqGm9S9mr/vEH8TVkGFhci3l2zEGd9waIt4lyabTEsl3ZnGU2sY
         felQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nQoGOpWPaVx67CKb9WI+bSalMdq4/lypurXp16g1b1g=;
        b=slgYabKnWLUVTkjQy1M60h1xTngNkWWS6HFVLOoQsSS5yiK3TjVS0AeRbdyqtEyAQD
         kihkncPx2O8zVW9jqJK5rwsVA5bpCDnm/OoPns266J6LgP0xyQY2KHOpcNn75OB/wh2c
         ZOA+2s8NI9Utv/Q3D0FJkIixJog4ml3UPrCZ0pd4Pw6p4voao4ny+65mn3+mOiOyZ4vj
         s0jVpQ/CbYdgHSh8bq9oF7mf6cdbsLGSgOh9NXX5eHmP2o0O5df0owHLB3yRnUWRSEdg
         mGEo5H7VrRmq1S3OsHgtZgw6FZNrCd3202o41/5+gTxK20pwVhQJT5Zmz6Aj2Uy9wzhk
         Ep1Q==
X-Gm-Message-State: AOAM531YdHSmAUIBT3HygmpMt30rY2HykzRXw3GUmBUfgMWbGtbqfEvk
        El7JZesjWdlA2lm0hA4fXLs=
X-Google-Smtp-Source: ABdhPJwL6jPy/HTo1uBxryS0KuEkHbLOcxhgt/wsizpNMPuSjmeJil7PB3CQ4ZoCQ7c63hImqx8yAQ==
X-Received: by 2002:a37:bcb:: with SMTP id 194mr70069602qkl.103.1594385887060;
        Fri, 10 Jul 2020 05:58:07 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i35sm7150803qtd.96.2020.07.10.05.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 05:58:06 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.28.0-rc0
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
References: <xmqqh7ugwen6.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <01e87be3-3911-afc1-e738-69446275c8c0@gmail.com>
Date:   Fri, 10 Jul 2020 08:58:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7ugwen6.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2020 5:40 PM, Junio C Hamano wrote:
> An early preview release Git v2.28.0-rc0 is now available for
> testing at the usual places.  

This might be part of your new process, or it might be an
oversight. It seems that GIT-VERSION-GEN did not update with
this RC, so the built version will still have a 2.27 start [1].

This differs from previous rc's [2].

Thanks,
-Stolee

[1] https://github.com/git/git/blob/v2.28.0-rc0/GIT-VERSION-GEN#L4
[2] https://github.com/git/git/blob/v2.27.0-rc0/GIT-VERSION-GEN#L4
