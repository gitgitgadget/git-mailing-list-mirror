Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC2FC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE1B60F12
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhH3ODF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhH3ODE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:03:04 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5337FC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:02:10 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id t1-20020a4a54010000b02902638ef0f883so4586783ooa.11
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HUIBPne7H32S+fLxFcZtCKxsLM6c5cPWbgPuNzEZ//o=;
        b=dHe7/81C8FistbgRG1TQGalKg9EsSQxAeSoydk/AvmAisKi4URe7JEHTaIqsG+h+Dg
         /40EG2BbHH9Y9gDDe/XJYpV4g+BPW3blP+7TFveCX/aaCiPhQif64Wb+FE8xeVj4Sb3B
         ea8xwU7JoUD+a+Yjd3zArSD/4LiA3D33P+o7+EUzQLK16j8EgCBc5hbimfVFQ6JN0f0Q
         EKx9Cf9T1XEGBMEoYfcMGzjCr75VhcA4l1P6o11CLMUaUR8P4mj9KWH1biyxFBTI3BNO
         Plo8JTH8yEJ7p5TTnkUpqCzSnYwo6XxC4+vrlBSMmjsQ/bETs/jXjSRih/e0hElJb0sa
         NQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HUIBPne7H32S+fLxFcZtCKxsLM6c5cPWbgPuNzEZ//o=;
        b=F3DBYz9Kg1tK2MhWjrreMetJuKvl0oa1qrpSQLcPECCub0pP0TNhM00CKEI5uv0XaC
         E04/UXsQhstXHBHXvRSXjH0TQOAnpV4/SF3V31WhMwy/3Ib9CBbQJT3+3oJMwJbSjLft
         bi6qH2y9qEBGp2Il/68K49Fr5ELZSNKJwvM8/SRc7wn4pUgoQdmwtYWFNa0K0NjQL5+4
         FCkwso7FzJa0QznAdhWJpJKbCFuwl0OmlTlj7qAjlMc765UzgCYbpy8F27gIVLw1Vl6C
         NWLMmfA7PliJw8nd/obLIKc/B/7JVUvoKavHhEe8cphMa5QC9261rjMKzQSxrmUVEcqF
         9PsA==
X-Gm-Message-State: AOAM532uNkuC5eVpUKnIBnDfg1nKbRcz0iptBHAp8zEBgU9opB236Ph5
        /mxBTvjp4ytme1wlveAokVw16V1nrTM=
X-Google-Smtp-Source: ABdhPJz9IA+Idhnhto8dqyYAMPSexyQ6VAN7eJVdnH/j1IhYmhn9v7Zpj3cNnZQTSbA/Seb0XERTaw==
X-Received: by 2002:a4a:b04c:: with SMTP id g12mr10108131oon.3.1630332129227;
        Mon, 30 Aug 2021 07:02:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f479:1655:2af5:7e8e? ([2600:1700:e72:80a0:f479:1655:2af5:7e8e])
        by smtp.gmail.com with ESMTPSA id m6sm3190118otf.52.2021.08.30.07.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 07:02:08 -0700 (PDT)
Subject: Re: What's cooking in git.git (Aug 2021, #09; Sun, 29)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq35qr7mq5.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <593d6312-a190-d73b-5af6-317350b4163f@gmail.com>
Date:   Mon, 30 Aug 2021 10:02:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqq35qr7mq5.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/2021 9:19 PM, Junio C Hamano wrote:
...
> I've been a bit under the weather during the last week and wanted to
> concentrate on what to push out to 'master', so while I may have
> picked up new topics and replaced existing topics with their new
> versions, I haven't added or updated my summaries on their doneness
> to this document.  Help is appreciated.

I hope you feel better!

I haven't seen [1] get picked up yet, but I think it is really
important that it does, as it fixes a segfault in the sparse
index when certain hashset resizes occur.

[1] https://lore.kernel.org/git/pull.1017.git.1629136135286.gitgitgadget@gmail.com/

Thanks,
-Stolee
