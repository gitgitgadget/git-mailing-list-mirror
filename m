Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2C6C433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9B62074B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 18:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3PI+c3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgFGSyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 14:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgFGSyv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 14:54:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6A6C061A0E
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 11:54:50 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f7so15819294ejq.6
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NF85bY7CyCyms3kGHNrlup6BUr7VPZdFE3uy+G87pf4=;
        b=u3PI+c3T1RpBG24hM98DfD/a+qnVGhMTpgxti0qX//qyQhvwt7CyLrtxfarIoO/F8y
         r7DwMBVjsQ/ZnvD/wWP7zaW91oc8V6WrzGJae1Vm5wIjuGaBXvsyQ31VxBdHZft7BLDF
         pJQWOEKDMoV3LjczuiqRvfkaZ3tpNvm4kXPuuW4O/ooZ4bHymj6mtn5IJPa8U9qdYul9
         HWiagn7RpEE+bP+pwEG2hmYtwJkBOVe4DTAVmeoAoic9/0cIgvgjWiQjFBCcTPgiHv73
         /EfmAhw5g6V7J5cT+ezkOgUXuCQMPXgf/sII4mZltOWNE3xwkWmKxnFf32GQI14/0Gvo
         kZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NF85bY7CyCyms3kGHNrlup6BUr7VPZdFE3uy+G87pf4=;
        b=tIO42Dq9TAhjmcOO8TRvo/UhsxM0RT1XZzBEpqMI5YLcnegMIJjkUAPXOD+ACwRPHN
         G/ddatZvq6x31NhCAxzQ4BE/aGBHUuGEbO8I0JjYH7R+/aKDtInE/U119oNc+zvHEQ0Z
         fEb+HdXg33lZl3b4WgPpzE6MHlbUP34w4XspU4ENbgYu/8a1VWal2By9Xg1gF6wr2Lrf
         uCCIwDhvSND+Gl/JRdsHRaRyaFBbnUBgdtXJnZG9yFQPtjeOxtTOXl8QSjIdnIrkxebB
         mBhnyvfXc0jSvviMnWCDZ0OAK3KQxO7Bpf2ClIK9Kph2y6xkITmPKFRx0iKRblFUrUdQ
         qT3g==
X-Gm-Message-State: AOAM533pgaz94p7QD+ZTR8JsI9KcVCrnIunXU6kn2vdQBp6rI3mejseJ
        opxz4fm5lXBB/1Maj8vMgX741D2r
X-Google-Smtp-Source: ABdhPJyef2DEb1WXxTiPSNJoEHPbZIXJlJ6m/poEQ4keSFr0JzuM2PzgR2K3T9iIbvBCKtwEy734Aw==
X-Received: by 2002:a17:906:4e57:: with SMTP id g23mr17499267ejw.522.1591556088971;
        Sun, 07 Jun 2020 11:54:48 -0700 (PDT)
Received: from [192.168.100.3] ([178.70.188.25])
        by smtp.gmail.com with ESMTPSA id di14sm10126536edb.77.2020.06.07.11.54.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 11:54:48 -0700 (PDT)
From:   F8ER <the.f8er@gmail.com>
Subject: Re: [PATCH] doc: fix a typo inside `--bare` section
To:     Junio C Hamano <gitster@pobox.com>
References: <pull.649.git.1591445695220.gitgitgadget@gmail.com>
 <xmqqh7vmn72l.fsf@gitster.c.googlers.com>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, the.f8er@gmail.com
Message-ID: <65cb716b-2766-e066-1d0e-21c899223060@gmail.com>
Date:   Sun, 7 Jun 2020 20:54:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqh7vmn72l.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ru
X-Antivirus: Avast (VPS 200606-0, 06/06/2020), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Junio C Hamano,

Thanks!

On 6/7/2020 7:01 PM, Junio C Hamano wrote:

> tells us that adding "environment variable" is probably the right
> thing to do,
What should I do next? I mean, how to achieve this? This is the first 
time me doing that.
> but we should not add the variable dereference '$' in
> front (and fix some that do spell $GIT_PAGER etc. to lose '$').

Should I remove it from commit, if so, how to?


Best regards,

Mark

