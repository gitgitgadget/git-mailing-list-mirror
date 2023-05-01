Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0B5C77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 17:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjEARhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 13:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjEARhW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 13:37:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB5910C4
        for <git@vger.kernel.org>; Mon,  1 May 2023 10:37:21 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b620188aeso3245892b3a.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 10:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682962641; x=1685554641;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uI79P1GIdnlZ6kJr1gnAXqOwE2esHZY+AZU8KpyrpQ=;
        b=mue1Bnq9yWlytYXkDjm1E195yhd7FaM4H9pWmoDZEQ9c1RGKMc+qjNX4QZFZtfHPue
         MhHMSs+CiSplW6iWr5WNILrS/WZaLuJ1KbJM87GjviFTT1n0+uC045et08ySz3h44QlV
         wkMZGrhYK5DhPRGqlH6umOdEzve6xeqAQ4sxJPn3KeJYSRnxWDwTbYuRkGAXgKaZH3ER
         cvDAZe3V8KKxXsKOKF2n1w/Cpg7Vif+blZxGpXtqyxrIpLjNKYdWHaRlyp6CVX58d1WX
         xruz+plu9b+dMj8UH1ARO+10HMjD+A3zj2lKnqFx7OkBiqDClQMl01HcR/jLCjwtIapL
         jpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682962641; x=1685554641;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/uI79P1GIdnlZ6kJr1gnAXqOwE2esHZY+AZU8KpyrpQ=;
        b=lfMgZM9k6aRQ48bfwYXaLA9QZbDpvGCyJvgi26KkTbHt/whXEZa5lvdg8u+dU+b8+F
         B06favV7jUx75mM1b5K8x5F8wKznwrPgH92bBT6aGfLpiYBACkbi6dHnnXCpH5hofxTV
         M5NnOQuq73oMDM6tv/HHXACzod6lErug5RGor7/zyRVzsxXUTxvnqHd5XH96GnrLG3GB
         LGfCMEqs7ab9l4yBswErtepeA+J3Zxc5tNTQAD4a548CMUZShxXdT6E8fyMHznbacEbD
         4ZXr+1pl4qMo1ADMkLxY2GjsrKdfCRv+kkE1CDbCRPptbobzRu3szzBz0u6vSKnNKpgU
         DATg==
X-Gm-Message-State: AC+VfDxtnE+MekxME/RJdOhgGCvwpZ6cGI+FaXEmj5+IhPUzkvmkxpU+
        YXpo0QlVMDD2UHMsQNVJ+SvhF7l1qPE=
X-Google-Smtp-Source: ACHHUZ77+KVFiFweLKwZo71IqI5uwbk1iiv/MnyviE39cwBKMqvsVqAQ3FODKfh9p0pbhRU00iPErQ==
X-Received: by 2002:a05:6a00:1a89:b0:63d:a0d:6fa1 with SMTP id e9-20020a056a001a8900b0063d0a0d6fa1mr18757004pfv.21.1682962640985;
        Mon, 01 May 2023 10:37:20 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b0063d3d776910sm20199508pfj.138.2023.05.01.10.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:37:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH v2 0/1] Fix empty SHA-256 clones with v0 and v1
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
        <20230501170018.1410567-1-sandals@crustytoothpaste.net>
Date:   Mon, 01 May 2023 10:37:20 -0700
In-Reply-To: <20230501170018.1410567-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 1 May 2023 17:00:17 +0000")
Message-ID: <xmqqv8hc54xb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Changes since v1:
> * Support all requests, not just HTTP.
> * Add more tests.
> * Fix NULL pointer dereference.

Great.  Will queue.

Let's merge it down to 'next' soonish.

Thanks.
