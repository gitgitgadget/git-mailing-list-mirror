Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF76C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 03:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjAIDxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 22:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbjAIDwx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 22:52:53 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA4011803
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 19:51:50 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so11499774pjq.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 19:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wHWQ3y38CAPZDT1c65qHqrv/RBY6AsyzYbk26aQ+Xg=;
        b=Y9K6RIYF2AX8ila4nWqzJvVTTXuiza4seEcR+pimYSLsz6BwRJqzJxJwMFOLfaZt0d
         z9TiYnwkEZXleGg5+S53J6/C7+PCLhtmg9CFMzb1vwbzi1dbLMEgRzvY5N3lcAjOjJve
         JEjnkOr56C/reNieM1qGYWqoNZ4niEEPPrPPqMtjaK30S2YSnBmf+ld7KIN3CyHt90LN
         53jZchW8RJjwONS3BCe07Tow3Z/GAx6Hxn6tznzXRrMPNGftiuRrVOot8y+FNVE8PsGZ
         ym1AlRfUr73C12bJlyURNWfKn/13XCHT5WYTq1c5Sf1KLyL01ijI/FCKWHSasnOtYwvj
         gUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3wHWQ3y38CAPZDT1c65qHqrv/RBY6AsyzYbk26aQ+Xg=;
        b=xgxNQYhoSIBBtqkZ3lmLe7ebJ+HvFMbIgZyiLmKKO5CXBGYOyCfnfIsCK8Pj1/rlXI
         jyXqjZZEqJw46AXDPQYbLjj1P+hvkOUKa/f2THCLciAIMkGkCfeLhCl4lY8pzk4Dg24L
         u+hU61yVwd44Bwvk2llahk+AMnloQx8OQ/c7Ai3l1h/yPTNFuRlsgY9y5iDr5IrhuGtq
         7k5hACvWKOhJNLn/x6jHcIKLdZTWliAHvjVanUy1irfp0IltpDp3UY+uMRj2o88kAcTy
         3z5PxNoZTQ48nO1L93wxKqqUp6hbsIbaEgut4g6zpCTLuK3mspXDFB/aWf79ajbAdCaC
         xSeg==
X-Gm-Message-State: AFqh2kq5VHAJY6EqS5/+7quPdTsi1oODPeoyMjsH9YYnT0BkYn24ELto
        RrnCsIC/PO7bXQz6HcmUWPY=
X-Google-Smtp-Source: AMrXdXu2c9mW/0tAQpgU4D9sOXBGn58hO0eiEZRf7jdq9fA333OGn3AndaDk0Fwc4kp8vnmf0etFag==
X-Received: by 2002:a05:6a20:2d1f:b0:ac:9d6b:c1f0 with SMTP id g31-20020a056a202d1f00b000ac9d6bc1f0mr83492560pzl.40.1673236296855;
        Sun, 08 Jan 2023 19:51:36 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b00189fd83eb95sm4935697plg.69.2023.01.08.19.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 19:51:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: should git rev-parse -q --verify on a range produce output?
References: <CANgJU+Vo3B=YuqgWVgiRMMiBwTFEh98O0LSJJ+ES6EM=MP4Cew@mail.gmail.com>
        <xmqqmt6tzrcx.fsf@gitster.g>
        <CANgJU+UeZJP=tBx7ALd8_X=b25RkAdQ1NkQpueSL-p+kpCO17Q@mail.gmail.com>
Date:   Mon, 09 Jan 2023 12:51:36 +0900
In-Reply-To: <CANgJU+UeZJP=tBx7ALd8_X=b25RkAdQ1NkQpueSL-p+kpCO17Q@mail.gmail.com>
        (demerphq@gmail.com's message of "Sun, 8 Jan 2023 11:45:13 +0100")
Message-ID: <xmqqpmbowek7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

demerphq <demerphq@gmail.com> writes:

> Is this something you think should be fixed? I would give it a go if
> there was some direction on what it should do in this case. Just error
> early and produce no output?

I do not mind if the error case gets changed to behave differently,
as long as the updated behaviour is something everybody thinks an
improvement over the current behaviour.  I do not offhand know what
the "fixed" behaviour should be.

I do not mind if nothing changed and documentation gets updated to
reduce end-user confusion, either.

Thanks.

