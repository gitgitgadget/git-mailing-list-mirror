Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D813C77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 16:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjERQBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjERQBV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 12:01:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E7DE
        for <git@vger.kernel.org>; Thu, 18 May 2023 09:01:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64388cf3263so1598135b3a.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684425680; x=1687017680;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6pNgPsv8w9cGz3rRCTdR08N6Tu5437tCkruABoSyh8=;
        b=YngKQVTDHtRjopbN6LP8pYdIrwTjqXmtmm99PfCPYYWmNMciJAKB1xNymg+4t4aqBq
         q9n8LqtAGS4IPcMRSXKZKZ0YN2ZTtMGkavpou4ExXFMVAJ0B8iuNV58G3ZSGxpb2n70s
         rDuS5DrtazFo66vr4YJeh9HeXX5H9vh5Tgr5NZGwrWKDQK5e0s8ZB8aPtIqpYrnX2Ccf
         MT7DkzX3fevvzgx3krWm3oyfhYPeBV+84dRP/xAZXxa5P/MyYQKGEk1ypcBS+IFBNA0T
         kL+WVVxXPijl1VFJSSbbSowkuAzMRP/eY1314TZJrc8iMwfd4CCG41qXudsQzLTYjcye
         2Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684425680; x=1687017680;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C6pNgPsv8w9cGz3rRCTdR08N6Tu5437tCkruABoSyh8=;
        b=K9+K18+byIRieFaZtBEh9B1R1N8yib77H3B9v4nvhRVPIHG8UmRO74RW8qgJ/B8V9A
         oMXMIJsyAiIrUyMKTNmIXr+fyzSNmDbx0j6e7shzbPTWlKuHgzfh4ITFoX4BXPnD9zZE
         9In1w9rhMtIltzsy0VLO2LSFiWOIO2C7fpxWwYF+sY0ibInGTMqCovAJ4S3pdqPeazYH
         nsCaPU0c7Ar9JM+SI/RzbBcG2NXo3lGaohxFFoSilNVrhlOHNpjsrfn/6OeIKqa0p0Ft
         mL9jdg6ficHjFItQ10dAhggYBLLMVVuchNlFpw4t7CGXor4f5kCkLYQ7OG6aTlhbR+HK
         NvJQ==
X-Gm-Message-State: AC+VfDwx6VRDvVTg/9DghMsEvSWTFYmCIZZotb73XpjugfbuCz4dwIh7
        EzYxxKJilperiIJ9mn4I6bg=
X-Google-Smtp-Source: ACHHUZ6Ffmrd0bv/DMOTQsStRwObM4As6We3meHC97mY+7YLzyg7t0GOXPWBZrUn6F+Yx6LFJ6PQCQ==
X-Received: by 2002:a05:6a00:80e:b0:649:3722:2d72 with SMTP id m14-20020a056a00080e00b0064937222d72mr4771675pfk.19.1684425680184;
        Thu, 18 May 2023 09:01:20 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j6-20020a62e906000000b0064cb0845c77sm1502578pfh.122.2023.05.18.09.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:01:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Hesse <list@eworm.de>, git@vger.kernel.org,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
References: <20230517070632.71884-1-list@eworm.de>
        <xmqqwn17q7ou.fsf@gitster.g> <ZGT6fEZFumAsZnxu@nand.local>
        <ZGT/eK6+IKlCM6Sg@nand.local> <xmqqcz2yrjbe.fsf@gitster.g>
        <xmqq8rdmrixc.fsf@gitster.g> <ZGUVvjG+xou3w8YW@nand.local>
        <xmqqy1lmq183.fsf@gitster.g> <ZGVFnzyStiscDKh3@nand.local>
Date:   Thu, 18 May 2023 09:01:19 -0700
In-Reply-To: <ZGVFnzyStiscDKh3@nand.local> (Taylor Blau's message of "Wed, 17
        May 2023 17:38:25 -0400")
Message-ID: <xmqq7ct5vdbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> My inclination is punt and simply do not to claim that we have done
>> a good due diligence to ensure with all permutations of ifdef we are
>> including necessary headers.
>
> I think that's the best course of action, too. I see that it's already
> on 'next', thanks.

Yeah, I am actuall hoping that somebody clever, with time, comes up
with a systematic way to give us better coverage, but until then, I
think it is better to honestly record where we are to future
developers.

Thanks.


