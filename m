Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C805C4BA0E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1ED20714
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne2UfqOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBZKiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:38:51 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:35815 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgBZKiu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:38:50 -0500
Received: by mail-wr1-f49.google.com with SMTP id w12so2357896wrt.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t36DQM6LXKhGvQWirm2cuCsmdcjKyJzHKPWXJF8ZYvM=;
        b=Ne2UfqOdEp0bgdTRs8+h6HW6yfl7SSSlb0fKSpmvJm0d0wInaevmpa6Sk6BlErNz73
         jP7NvcYEvwUm4qV5M3oWcLMAcwC4j06AIxBlnOPOyUiLbOZluXKDbOmF0HIFXroLVjyn
         IFLFXqmP+vecfJhK8e/lk+JvoZsQpQ/JatuFlb0Jmj9mgC0ewJL8v4qzytL5eICHXUJN
         O0DGVUAw/NfLHJi5deXcuH298IWZD/EBwqM4qFNOkKH1hVqOgHF1L53N8gUnWcXWuVa5
         AHhfqAYMmHXWMjKfnXdgrMJ8X0+WgnqalZc0zplHHtLnDVUUD1R4QeJb6rV8116ce00X
         SFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t36DQM6LXKhGvQWirm2cuCsmdcjKyJzHKPWXJF8ZYvM=;
        b=fEhtPDSR6tDzkpwBCJhH6hMvpW0NXeYUK1fFHKRLY/n/VnCouGmsIlyWItd+ymx9TD
         5AyrX9gcfCYKrHgAq5UIBOO/sKpOGll/Wrt0VAp6DMJVsNEvtK7pq0ZtOzaydErtGKEV
         h4NsnV9djwjp5mG9amZyHQGfX4oDQ+PgSwpdF4/bPpfuNIeMZptKsbXJlSnDuHGwLXND
         obtVxac6GEM8t3GDnWlKQf2bDXKpCmFp8LdlMEMSm7uk7//WzcTTw3nluDrO87S8VGLT
         n6imT2D3vEQjnz67bNKkwaiuXu8sGArBL9bsTXSw1bPk52YNbpyWQ7cd6TjLbt9qoFXZ
         gF9g==
X-Gm-Message-State: APjAAAXtE3CoOXSQ/xg2v5xtruILS985GZM8VmKmAW99XUB9WwYd6ZXS
        CBRA5m3Dk5buOWt6SxBeYh0Vp1Yz
X-Google-Smtp-Source: APXvYqwB4zy6JgIP7DWOq1ywOpZoiQjTOOkNUrLpLUlAYsNLB03C9QykCY08KzEc3+z5aXsZhmniqw==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr5090826wrx.210.1582713528460;
        Wed, 26 Feb 2020 02:38:48 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-296-184.w86-199.abo.wanadoo.fr. [86.199.79.184])
        by smtp.gmail.com with ESMTPSA id r3sm2646988wrn.34.2020.02.26.02.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:38:47 -0800 (PST)
Subject: Re: What's cooking in git.git (Feb 2020, #05; Tue, 25)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqo8tml1lv.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <fa83b4d6-4db4-bae2-e07b-a67cee501fa2@gmail.com>
Date:   Wed, 26 Feb 2020 11:38:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8tml1lv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 25/02/2020 à 23:54, Junio C Hamano a écrit :
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>     http://git-blame.blogspot.com/p/git-public-repositories.html
> 

Sorry to insist, but I did not see
<20200121193226.24297-1-alban.gruin@gmail.com> making it into your
tree... did it fell through the cracks?

Alban

