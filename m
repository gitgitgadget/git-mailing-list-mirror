Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B90C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 14:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3512072E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 14:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUNTBPgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgCVO7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 10:59:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34745 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgCVO7F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 10:59:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id s13so11699933ljm.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zahc6LbT3zONI95nGlVgncj73EIJnT8YIONl8slT7QY=;
        b=nUNTBPgsZ+yYnPKE9P1s+NTWjB+MOIMj5DEL2MrV1SJX5n3adAnlGW/uj1P5HZ+AK+
         N/XmPiMAgVo8pCAPBRerPzSsq17QuatAVHgcQDkLT+qf2zOedtpXxk4N9Lta6vmIsldM
         fbCR86oLgBBWa8tSA2wby+WQ/BUPs0RThOElCELa9EttUVb2f+jZDrYsDwCwX0SB97Qq
         WY7BGFTVVJDtPrIoTdfQSBcjh/94/0DBzNeyMRk64wxbBbTrgknB7NtN3d+tQPxh9iBZ
         0IXC7nfwFUuYGVW9dCiuZ6cOsGgbZuY72h44LJbXi8mOGBkDKEOLG5bpsFyiX9OglEPr
         wMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zahc6LbT3zONI95nGlVgncj73EIJnT8YIONl8slT7QY=;
        b=K8vSO0flxlnKm1PD/lhyz3mgiKOwNsS/IzDAWRY9QIZzXqcE2W3KLMRCp3biLKjBbR
         3q2F16dmuhAfRF/LmtvBsulQxthH7Qks4jXNeJpE10Mmil1DXM4ebitry26XXKbMlmSU
         DgcyVBWRKk2bJ9YhDnrBhrv2cNiRd+EqDnPg0Ub4L2Xh80NRQvWI6wdpeHAPLcnVAbUK
         5qL0WSHicByCqUIvzxpMHEnkwSREp/QzjtY57F+0REOSMWUlS40ZBjp2gS1Npvi5nvDN
         xHgzCTFI+PYTbZ7HCYntJfH/l3iueonMkH5DpuHpPJu4wP2mHYXOZfUjoOo9xg3CYJlg
         EYrw==
X-Gm-Message-State: ANhLgQ0aNeT0vLU7lxakFNdWpO22hOMwAFzhnDr4o1Kb6etD6c3yuyYa
        k8NioIbkMeOmRcZFQMh2ChM94aozM5rQ6g==
X-Google-Smtp-Source: ADFU+vs5tGXIlS9VIq1l1AYB66atY1ImVvS/nMnTwHfQXct4zikVEK8bZvkOeJoYLcmBk8L14SDCYA==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr11130232lji.247.1584889143003;
        Sun, 22 Mar 2020 07:59:03 -0700 (PDT)
Received: from [192.168.10.8] ([119.155.6.126])
        by smtp.gmail.com with ESMTPSA id r21sm2684252lfe.85.2020.03.22.07.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 07:59:02 -0700 (PDT)
To:     szeder.dev@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        sheikhhamza012@gmail.com
References: <20200322104826.GB2224@szeder.dev>
Subject: Re: [PATCH] bisect: remove root directory restriction for git bisect
From:   sheikh hamza <sheikhhamza012@gmail.com>
Message-ID: <e4cf161e-1f3a-8728-6c52-97651dc2d5fc@gmail.com>
Date:   Sun, 22 Mar 2020 19:58:53 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200322104826.GB2224@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

i apologize for empty mails, i was configuring the mailer,

by the issue i meant one of those mentioned on gigitgadget's

fork, there this was mentioned as a good entry point project

so thought of doing it as my GSoC microproject, do you think

it makes a good microproject should i continue to work on it ?

