Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B888C7EE43
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 22:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjFLWZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 18:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjFLWZR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 18:25:17 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A58910CE
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 15:25:16 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-650bacd6250so3882550b3a.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686608716; x=1689200716;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nrNnPEXxW4o0zbZpkF/WYncDlnBPBxLqJ4sAmlSc38=;
        b=lG4/LHXCUGAkW9XFL08LsuBbborv48iPHNHOsczWC+wYCcg3vyuePYVakcZF1ZpOzA
         Zw5xD6mV6Wylecm1x1sDaY8O01xSNes9gfTThXjowo1KaDABCJKdyL9y0lOLq6fnqyK+
         Jpan7sa4dqi2q1RKPeu/E/paqeoUG155wks4dxG2vReGmH226kGSzxdj5EZq1rrVW+Gh
         K/wkdThdGxLzVvdL+FNmh2UyUH7pW2d7HNfus9oRSDxwa5OXtPO1NdNGex+iUm7tWcSn
         9XAjUzzxitk7bPbyTBtnCpx7TWKQPYX0sM5q0vNIaQRrQS9Dajny0ttScUf9OGWK5DWZ
         7sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686608716; x=1689200716;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nrNnPEXxW4o0zbZpkF/WYncDlnBPBxLqJ4sAmlSc38=;
        b=Vu+BEjSswxsTwHada/IGU+7uCMx+cCSGTVzvGDiUo7cxZixQW9DmAMr4qHBnkBRACt
         xRyJTsoLw1IWpsAs57YOSjvQT+/dvHLf3lauJvdrVS9PCB4U3mO1QWLxCdEQTP8NRGvX
         3ADLvZhP1zeHuaVlIgACFGJ3jRLgpsLL4QPmE8Nrq9B2GuU2KYjGuvBveHdcZPd8KKKO
         v/xDv4u5PjF/7QEnRV2Sa45O7s9unU+eawMlYWi2QxZg8UKX2520Sgb0vzTYswsMoMsH
         RQa5SeOyLkuE5LD1UUdxzBFpc5czMDlfNsjKABQZPDOcqQ1xiW52OeL4I6rbZAMm1BFV
         bOPw==
X-Gm-Message-State: AC+VfDww3neiUAzabsPvFoPQCKer/ndKkZ4ga2BzalrhDtAZgEccWiqh
        VnD9dLdkDTKVD6WhhovbOdI=
X-Google-Smtp-Source: ACHHUZ5xiToHYNpcWEAJUSHE2cVw/aeYUeMvjOAiUYZezqTBYDO4XnLC8jzDrLnt+S7FC7/aOh1Elg==
X-Received: by 2002:a05:6a00:13a9:b0:653:852d:4fa8 with SMTP id t41-20020a056a0013a900b00653852d4fa8mr11758476pfg.3.1686608715937;
        Mon, 12 Jun 2023 15:25:15 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id i8-20020aa787c8000000b0062cf75a9e6bsm7370492pfo.131.2023.06.12.15.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 15:25:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v1 0/3] range-diff: treat notes like `log`
References: <cover.1685441207.git.code@khaugsbakk.name>
        <cover.1686505920.git.code@khaugsbakk.name>
Date:   Mon, 12 Jun 2023 15:25:15 -0700
In-Reply-To: <cover.1686505920.git.code@khaugsbakk.name> (Kristoffer
        Haugsbakk's message of "Sun, 11 Jun 2023 20:15:53 +0200")
Message-ID: <xmqq7cs871ys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> This is the first normal (not RFC) version of this series. The following
> cover letter is identical to the previous one up to but not including
> section “RFC and version 1”.

I have no strong opinion on the topic and did not comment on the RFC
version, either, so I am puzzled to be CC'ed, especially when the
primary author of the feature is not.

Dscho, how does this series look?

Thanks.
