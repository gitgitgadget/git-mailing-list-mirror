Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEB2C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 17:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbjEKRl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 13:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKRl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 13:41:56 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B4E93
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:41:54 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ab087111faso2061579a34.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683826914; x=1686418914;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVd8dVkmoDo7Z2z36F2p4nvPSWRmcWwTvhxZuiVlUAg=;
        b=nT/WLsZF3vJ3bUd1QQcUgEa0FGynMTFNZQuVoT9uqG5gVigH/3/r9KGhL77VZBwTjs
         h4LCCzsK1LLd7kOizWcBmy4qEJOgV+uhg8o6m0Ex6wSRvR+gE1PLazFEmEA/xxM6RoxY
         TAIglnTKwozFWsb/FMbykVZ50jzQ/65ef/gbceJeHbTFGXsqlR1RSaehSv7GaQvNuXpW
         LXM0uNLfWO1eezTD+/ix1TI7YuK+lf/4prlUfEEqsW7olg67iiGd1vW78/2VDzib2C7Q
         11Lphcw0TwyQsHBbCmmlB4rSpYJKGdpIO5xQnh1dPlN+eHe1zDbsr+9uVKZAVVaNNpQn
         FbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683826914; x=1686418914;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZVd8dVkmoDo7Z2z36F2p4nvPSWRmcWwTvhxZuiVlUAg=;
        b=hbr3NSTN5Kz0rMCVg4mgsadUshz85lXFcJfbN8s+21NqkuzXAXdk7dS+y140nKIUn4
         whbwkgwC5eGZA3TwQAUCJCrgerWCfVeotPSP2+HT1Bub7vjeksRni6ZMp7PqaTsvaRhX
         Td1uARFpIfpSpgWE1HeokQ8tCBx9hMBPWLznrvLV8IoKTYF3JysL0++8YI8VWomnNIDo
         SnITrDFCw1T/klzNBBw3QnReduLInLP6FDoPOYj11jaS8wrCs03qcPR/3mLD2vyMiZHq
         dz7qNZAIAKYUazPfO+dE8GQoSq8vypX7S/WCxdeDJhmhG/PZR2JnP+8nTvL01UGSxOMy
         JBrA==
X-Gm-Message-State: AC+VfDxncQxWg9372y2I/IFe5mqdUBoBY6Pfw9/RsLkKnJlnxqN3BOj+
        EJW0uO0TTwAX/v0wfz0MhrCbBAILOJs=
X-Google-Smtp-Source: ACHHUZ5R+43x9m7WSRb9RDgwCYV4UUEo8fHA724kDSGfLJ6ltLHhQD7ezgZH6EoI3iYO+K0NkfaXPw==
X-Received: by 2002:a9d:68c2:0:b0:6ab:39e6:ec86 with SMTP id i2-20020a9d68c2000000b006ab39e6ec86mr2973978oto.13.1683826914225;
        Thu, 11 May 2023 10:41:54 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r21-20020a9d7515000000b006ab22bb324asm2544045otk.10.2023.05.11.10.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:41:53 -0700 (PDT)
Date:   Thu, 11 May 2023 11:41:53 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Message-ID: <645d28e112294_26011a294b2@chronos.notmuch>
In-Reply-To: <871qjn2i63.fsf@osv.gnss.ru>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:

> I'd rather think about generic interface for setting/clearing (multiple)
> bits through CI than resorting to such convenience tricks. Once that is
> in place, one will be able to say "I need these bits only", "I need to
> turn these bit(s) on", and "I need to turn these bit(s) off"
> conveniently and universally in any part of Git CI where it's needed.

It's possible to achieve both.

Imagine your ideal explicit interface. In that interface the default is no
output, so you *have* to specify all the bits, for example:

  git show --patch

Or:

  git show --raw

In this ideal interface it's clear what the user wants to do, because it's
explicit.

  git show --patch --raw --no-patch

Agreed?

My proposal achieves your ideal explicit interface, except when no format is
specified (e.g. `git show`), a default format is chosen for the user, but
that's *only* if the user hasn't specified any format.

If you explicitely specify the output format that you want, then the default is
irrelevant to you, thus you have your ideal explicit interface.

This is the best of both worlds.

Cheers.

-- 
Felipe Contreras
