Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA8DC54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 18:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiIHSDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 14:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiIHSDH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 14:03:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95B1F10FB
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 11:03:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id iw17so12033727plb.0
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=A0vTVc4LrQn7YjllqP8G9F2VSv6CJ6bbUDVAMGKkDpU=;
        b=jDIAXkkz59vlQnIntQWAvaN4ADR4EUGLQ3hPfSn34GWcKutyV7MJUxVtR/H9Jt6hzr
         5GYrhRuA9/S3uGF26fo/YbvWeKio4MsUxrYpNz+BwMO3ttWUTpDkCXxrCb1k/T0o97Zl
         ZnAa2mGIBtDTNH+9sdHX10vvX3HqlfAMSzDrLZ3XxZjEf23tEAIeWQokis/xnQaRMgW3
         Lbht/N8ZJH7akdV4LM6zg+Hb1shyehZmGiqThiiMS10zsw9fOzwByyTpeq62Kla2R8zp
         r/pFzZoGNAQHn5V3Z3siUHd93Dx3hvAfEewMcBO47l1Mx+880Gcf3hrdoAfoRynkpw++
         DAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=A0vTVc4LrQn7YjllqP8G9F2VSv6CJ6bbUDVAMGKkDpU=;
        b=qifLTMcf4YYMDuaKalo/tELuVwkTXm+hlBy0o2P/JrxxKrmaDbTSiYQ5LoIaya9nMY
         Z7BPoA02YSAPang4ISSKXznBFsk9ZG8EpaZfr647E942sqopp1JT/I6trTeILf3jjrG+
         d0nbgl/pyDb0rKXRD9Cfrcb6SE7oJJ8leb+5vYkKbgRjXIu+2nOUdipN9WwrNN/nU4kZ
         rMNEyk8uUE/XcypF6bARVT5isvl7VwYlipC/DPSrHQrPX9rSPjxCBn1dZw47+Az9dQnn
         NQHztJ8+CsXEhwte1cqPE0jGwnj+x5GXpI5Ik7s/TXMAC17rdCqXz+UfPkMD/Zto2a48
         l6sQ==
X-Gm-Message-State: ACgBeo2n3gPEu5IdGQZwjFXgQ27za2OVkLlce3IpDOwyhg5L9eFnI9M5
        aitEz/8AurZaU+cueCJBRf0=
X-Google-Smtp-Source: AA6agR5Pw/g0MRWDOCEneLORjhcIsxgzDCIbEu8FHD8EUTaptrFO0LommqwMLbvdti5QEDVw3PfRvQ==
X-Received: by 2002:a17:902:cf4a:b0:175:4fbb:7766 with SMTP id e10-20020a170902cf4a00b001754fbb7766mr9890992plg.94.1662660186353;
        Thu, 08 Sep 2022 11:03:06 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t23-20020aa79477000000b0053e8cfb2e39sm3607356pfq.207.2022.09.08.11.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:03:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: LSan curiosity in t1300
References: <Yxl91jfycCo7O7Pp@coredump.intra.peff.net>
Date:   Thu, 08 Sep 2022 11:03:05 -0700
In-Reply-To: <Yxl91jfycCo7O7Pp@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 8 Sep 2022 01:29:58 -0400")
Message-ID: <xmqq8rmtrbfq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And it is complaining that we've leaked "key". But as you can see, we
> always free it. The problem is that for this particular invocation we
> die("missing environment variable name"), so of course we don't make it
> to the free(). Normally this is OK, though. The "key" variable is still
> on the stack, so the leak-checker should realize that it's still
> reachable.
>
> But if you run this in a debugger, you'll find that under -O2 the "key"
> variable has been optimized out! So LSan is producing the wrong result
> due to the optimization. It doesn't know that "key" is conceptually
> still reachable.

Yikes.  

Is that related to the cause of the other patch from you, i.e.
wanting to get "registers" but unable to?  If they manage to get the
value of the register that holds 'key', would this disappear, I
wonder?

> Maybe this is a known problem, but it was certainly surprising to me.
> I'm not sure if we should do anything about it or not. It doesn't seem
> to trigger in CI, even though I don't see us taking any steps there to
> use -O0 or similar. So we can perhaps ignore it for now, and this
> message can serve as a warning. But if we think LSan isn't reliable
> under higher optimizations, we could perhaps teach the Makefile to
> prefer -O0 when it sees SANITIZE=leak.

Nice note to leave here, I agree.

