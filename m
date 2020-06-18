Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6BCC433E1
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 01:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF392073E
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 01:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8HQYhow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbgFRBqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgFRBqx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 21:46:53 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396E5C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 18:46:53 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x202so3616778oix.11
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 18:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FzpiZMod8vj5WElgD0l7Sg9U1c99HKbBMTEaXrtJztc=;
        b=J8HQYhowFsFRrFt2ixfUxH6wjJ6SNGEAn13PiqVS8yIrgbY4LhnXTWzQ0a8kw+UY/7
         3dO2P2q1JiK2uWIJUelOAEWUpQcqrZ4sYw8isdJ9RAmGZcZoX7nA5EtewKOqOl4gQXPr
         wLiQ0Uibs57yOrSeMpUt1Z6Xnqbe65rlPhy5jKMjyYcAYz//Ujg3CBzov6xkQauNoujI
         YFAQiWrKwHCKpFlF3O0a0JjM8X23DiGCRWLvdbBRlrIBJo34ctEIuhf1NbXEOZAC9FUK
         Uzfs+fTbCzOeuYs+h+5eg1cJ/jYoSLhECK2ezu361POWhbuVfAWdaWYufxBveaRNLe9g
         P5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FzpiZMod8vj5WElgD0l7Sg9U1c99HKbBMTEaXrtJztc=;
        b=ILSIocpJjE5wbpGAGYps+rPpFYYGemeH/AETOEQzpDA3WCwpsBB59hrwtpSEPH1zFi
         J2rsRynWbi5j5SswvJRg8vAJ7W9Zzm2+zgG+c8BX7n8nZ9l7OvjwwkJ6ADDna7/TD8RM
         N/x/4WNZO2ut2Qufv2OQtG8ffLIRDDugTH19og6unoCf5I+ekZLm9JVD7OpJMK9YPfVO
         0gR5m538sPMOOKEPTnh0cnN6tK8QIOkTbUMADlyUADQNSlJ04MeeW6kxJC46jsiVmsrA
         1SIJhjcT3BpYHsUOOLCA9Hc5XzhVIAlYdMi+PJdb/UY2PgjQLqKI32WiazFp4kHwko3+
         0fWA==
X-Gm-Message-State: AOAM531DzPwWHzq8HRcsGj66VMh/GRbaYy5HfoS6NyNqKYpc/t6fkUa+
        gGnqMUJVjQzp3wem0GZPws8=
X-Google-Smtp-Source: ABdhPJwa6llMBb+nA1RIiF8hQHNYtcfjxpEjhCDBKG05zk/+OvnaR66YiVv7CKzflBpRIOp2c0QKjw==
X-Received: by 2002:a05:6808:b14:: with SMTP id s20mr1283073oij.155.1592444812596;
        Wed, 17 Jun 2020 18:46:52 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u125sm344866oif.57.2020.06.17.18.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 18:46:52 -0700 (PDT)
Subject: Re: [PATCH 0/8] More commit-graph/Bloom filter improvements
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <xmqqimfps81d.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c2b40d09-ca17-6b0e-c7da-722d92a2a669@gmail.com>
Date:   Wed, 17 Jun 2020 21:46:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqimfps81d.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/17/2020 5:21 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This builds on sg/commit-graph-cleanups,...
> 
> How ready is that topic, do you think?  I'd rather not to see too
> many patches piled on top of what is not even in 'next', but I do
> not remember it reviewed seriously (I did take a look or two at it
> myself before queuing the series, but that does not quite count).

That topic was my attempt to apply the "easy and obvious" changes
from Szeder's proof-of-concept. In some sense, you could consider
them authored by Szeder and reviewed by me. But also, I did need to
tweak some things, so some review from others would be helpful.

> Will queue to extend the topic for now.

I'll refrain from pushing any more in this direction until more
review comes along. I found myself with a need to do something
productive and familiar, so I started doing commit-graph
performance stuff.

Thanks,
-Stolee
