Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE11EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 15:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjF3PkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 11:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjF3Pjw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 11:39:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862613C10
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 08:39:46 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b698371937so32985771fa.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688139585; x=1690731585;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qfCJmSAAx46HkutPp134xHAvOoJOVXZFJ1anVCmfOY=;
        b=U3RUMJmFUfNT68esJ3yA0JXc6YweuzbvnfG9GfXLhROMk4JKCYkw9XrUrWGMVSyN3r
         iZtSEZhsSWzUqdXAiVr8nA6WQZNaNhnsLYWCQUD1T/kwaytMJxJclcxAbiX5RGBfJeJQ
         WDrug1FzOWMjDKcz4CDqWHvz2y4oYCP6IP+DkcVLDxeP/o387SPshhGQM9GIK2Bov6B3
         vLA3WxB4GBJIhAJJJ38vlO2vYDdnvfD1yHq8guhDEl/yFzwQw8Nr1OCST3fnTd/jmSW3
         KTWov9u2FHrq6nNau2TpayTl4c+3eX4QdC04mqVq6Rw7ayCrX/uTyuMC71l//xJIRtY7
         Cg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139585; x=1690731585;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qfCJmSAAx46HkutPp134xHAvOoJOVXZFJ1anVCmfOY=;
        b=HpaTE/OU4yOY0k5DswKlBGp4dW+VslcdAC2zX6UT8VCRTCENOSuq2Gtc9Gf3VDF1R6
         KYT8XgB3rp7lSDZr6zvs1Iu6xCs/CgrW1EaWD3nOt/gTFXsyTEnotV1cs6TOnn/6vOtj
         DszeEafXRDBCnLcqgFz9QJd+HNlcFPmaDHj0/2V4yUAwtTQm9PkuhT9ROYwhMuLz4Jf5
         q9+3dsJF8EU3yBgfMF1Un4Y6u6VTfdIwhalqw5uDSUUMTpTEvnFniJZgZZx5EfcSOyMq
         CZ9B3BbOOHChY81QPmBfTBFaaMQnJuDT73mI+0y+okCPw0yslPktmhay3nse8mZEPAGx
         gZFQ==
X-Gm-Message-State: ABy/qLY0sVi5AgTw1YuoNO8PBDuRXlkGA2KoVoLpFZs9bpPwcBPkqQ7Y
        vRXEJg0EMa/70Mz2FEXv3hXf/tRjSNrHjfFesK0=
X-Google-Smtp-Source: APBJJlE6CcD52lSUWF8gBrNhu51hLSl5OzJrNwQfmPY+uxshLYbRByONZcRxJ50lMfOzCScepqN6dbKvXUzRdpP2dlo=
X-Received: by 2002:a2e:9616:0:b0:2b6:a0c2:edaa with SMTP id
 v22-20020a2e9616000000b002b6a0c2edaamr2540697ljh.32.1688139584420; Fri, 30
 Jun 2023 08:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <CADE8Naq5W3Bn=gwV7W-xMvYOMMRO=ZY9Ly6im4Rb_qFjMWTbTg@mail.gmail.com>
 <CAJoAoZ=OEfsgkqsag926tH4GEuafX26A09SGZ1vR1uLh2W_4TA@mail.gmail.com>
 <CAJoAoZnVAe3kvUdPZmanbKffG7cx3Tc-==H4+FH=L5qQP2smEg@mail.gmail.com>
 <CADE8Naonm+bW_jVvJKmnfZWQyX=0-QVSHxpSaHs1qo+5DsCiPQ@mail.gmail.com>
 <CAJoAoZ=X9hwZZ9eN2X=g04k2E6=wZsY1WEKFydMreNJKM3Mzng@mail.gmail.com> <CADE8NaqSn7DvvBHzLhGdWwZtwK+sxoKnVWo_G26P30p_WnVXJg@mail.gmail.com>
In-Reply-To: <CADE8NaqSn7DvvBHzLhGdWwZtwK+sxoKnVWo_G26P30p_WnVXJg@mail.gmail.com>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Fri, 30 Jun 2023 21:09:32 +0530
Message-ID: <CADE8NapQK2ouy4YDQA+3NNkUn_EegkSBQCtDfcSCVGmZvVufXg@mail.gmail.com>
Subject: Re: Documentation/MyFirstObjectWalk: add #include "trace.h" to use trace_printf()
To:     Emily Shaffer <nasamuffin@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!
I pulled down walken.c from https://github.com/nasamuffin/git/tree/revwalk
and was able to fix the broken code. I also fixed
Documentation/MyFirstObjectWalk.txt
and have accordingly pushed all the changes to my fork of git:

https://github.com/vinayakdsci/git/tree/revwalk-fixed

I had to remove init_walken_defaults() as I could not trace the
function init_grep_defaults()
which I think has been removed since you wrote the tutorial.
I also didn't find a mention of init_grep_defaults() in the tutorial,
so maybe that is alright.
Also, struct list_objects_filter_options is included inside of
rev_info, so I don't think it requires initialisation
any more.

It would be great if you are able to use this branch to rewrite your own!

Thanks a lot!
Vinayak
