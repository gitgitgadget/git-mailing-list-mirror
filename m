Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA62BC80D57
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2D22481C
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAXX4jTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfLMTlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:41:03 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33884 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfLMTlD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:41:03 -0500
Received: by mail-qk1-f193.google.com with SMTP id d202so193623qkb.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 11:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A1xGF3VgH+HosoDUdVfJBeXKW549I3UaQ8ItdvQLQvM=;
        b=HAXX4jTRjv1TJw9tAHV+pD3KOUeL/oswZqvi4s/AvIUU2XIOCcIye/3FZir8kZ5B0U
         5TcYR4OucVnMCvSarhO1bGWsw3PIKsmtw7E8uL1/7EZbgII2DGlhV9ZEan323/WfT/Jn
         Q7PvD47v0l2PXPRt3szfqA75FTb8vmpvBrImy1szjVpL5qhhLtOzjBBswEoEySeQjEFH
         Nlol8rAJEaEECznYVL+QXp2zxSUmbq+eKJjqwsoUYUyFUi+rMedyCjtk16PwXtGhXuyk
         iA8XChTscb4+Nk3bdTj6jzuZtr8vMu0M4PnMA1i/43OZhtQaUKwMBtkPYNQY37nQRlHY
         bIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A1xGF3VgH+HosoDUdVfJBeXKW549I3UaQ8ItdvQLQvM=;
        b=VAbDj71jA58Yr481Hv6YUj7rvh0c+YN1Pk8UpYD2DiXKrEXU8SwDJeHZibKR6zddoZ
         9jXXdXFuWjdyMQAmCO4o5w8YrJpcf/GqmA84c5bnPR6XvXXALPJu9PJfE1qjcvzKrg4+
         vdpf4TtWnlZDPHDR3fpQEC+0HwqBx8tLrfjPGcQhAkZHpQA2HOIrso8vuOrcuMFWcwMn
         noSUGEB6WP/57Rx/XgNHpSMjDj637R9yPCgZqt4oPRcg1gwiVAcul28Edj3ALa2n2e/v
         ZpYhdlFdJhrRSAbPq/vIWDiNfhMm+VGOS5M6idA63SwMafGFKQTOYKxN2lizVjoDfz/k
         DypQ==
X-Gm-Message-State: APjAAAVJbw84Rl4YJyGslWEnBTe2ME2oNHORJZ8IasDfvpBejLYX4tJp
        1yLtcEfvwEWAf0wedoAJSKk=
X-Google-Smtp-Source: APXvYqwE2+9RZMON8Fj3KkdDvUEkT7h0U6ufVOW31vHi77hQQ5jvjvpqdwB8g+1hktMa/MMAhmL6UQ==
X-Received: by 2002:a05:620a:136e:: with SMTP id d14mr14822120qkl.342.1576266062282;
        Fri, 13 Dec 2019 11:41:02 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:1414:e94c:6df7:afb8? ([2001:4898:a800:1012:c547:e94c:6df7:afb8])
        by smtp.gmail.com with ESMTPSA id q25sm3159746qkq.88.2019.12.13.11.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 11:41:01 -0800 (PST)
Subject: Re: [PATCH 1/1] sparse-checkout: respect core.ignoreCase in cone mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
 <23705845ce73992bf7ab645d28febebe0a698d49.1575920580.git.gitgitgadget@gmail.com>
 <7aeb1589-cc08-654f-1bc0-d48fec1c0729@gmail.com>
 <xmqqwob0jbba.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d1b11424-db8b-e13c-e896-923d74b3d531@gmail.com>
Date:   Fri, 13 Dec 2019 14:40:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqqwob0jbba.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13/2019 2:05 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> If you have a plan for that branch and the merge status of those
>> commits, then I'm happy to re-target my PR against 'next' or
>> an equivalent branch.
> 
> This change does not make much sense without the cone-mode topic,
> no?

I'm saying it should go on top, as a new branch that depends on
ds/sparse-cone. Sorry for not making that clear.

Thanks,
-Stolee

