Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA020C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 00:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC6A2065D
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 00:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvTmznc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgFNAD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 20:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFNAD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 20:03:26 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F55C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 17:03:25 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id dp10so6127803qvb.10
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 17:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cMX9AMdHxpjlG10XRVc0xiLEo8YNAcPsn5gXAtwdw94=;
        b=lvTmznc43G8WmVA0W54ttkRpy1fkKXyOealGvNSo2BMFQETSJTCW/2qqe52ozPmoE5
         ZOUMcUq/F8lZnfokkW8VcSFvZh0SdDUsMQBTmtI6Ns+I4K3o70cGZ5xUEHFI6sze89iL
         YOeI9XrlePvrgV4KW8MoBXAby1Dq2KFknwCr8FItV632Qj4hdCm3CJFErb4LCEFlf+bn
         0PiSyA4jxDvO9pzHIALrzjfi6DVREc1Uzdtp5zdCKe9KnlCtsQp9USS0mGBp8nsj40xf
         gnpHfcKolUbkTfOviCQ4QAZrruFmiZcLykNqyw0ZTEaisUeS0SoNfM4NpuwDwe/+bzz3
         boPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cMX9AMdHxpjlG10XRVc0xiLEo8YNAcPsn5gXAtwdw94=;
        b=RoDk070ZASsMtPjlD5Ukmt/4AuK2DSiSqiqN6ydhZ7RFwKIVUe/G8G8Kgk71IIRQR6
         IDprcQaOcC6cTnSy/7PHWwsCQbrIdENlk4qfbrViUd0Whi5oofLog4GGzgs/rOQZrz/i
         NT7/jD0tqqrrk9MmHovjYKbWKI67XfCAhYcD4SEBHF8JE7bj2ArmfwcryTnNAzk5bghK
         emlNsWBL8hS7/FMuWkUb5h7qdZaJMAPzEdy3zIp51O0V6m75Xfb+7I91wac74AtWJ7qp
         OULq/ssfRnmvssE+guotNdg1JHsxr9cWxb+QZ0f/WeH64udNyDPnW4CBmeyCF7x2lH/O
         mkKg==
X-Gm-Message-State: AOAM531nGBMIeYZtCttX8JmPpR+j5wbeWvWpp543gwgdaRV1rgs+b3jS
        cZM4PIboGGFIdrmQ+BlV93I=
X-Google-Smtp-Source: ABdhPJyMUP9F/vu635Shfroh7XB+7Q1at0dS/5LQT6UDirEPUqsUsPdv8d4NkdkgR2yCfn51LijB6g==
X-Received: by 2002:a05:6214:563:: with SMTP id cj3mr19050833qvb.26.1592093003675;
        Sat, 13 Jun 2020 17:03:23 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id d140sm7942494qkc.22.2020.06.13.17.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 17:03:23 -0700 (PDT)
To:     don@goodman-wilson.com
Cc:     git@vger.kernel.org, gitster@pobox.com, rpjday@crashcourse.ca,
        sandals@crustytoothpaste.net, simon@bocoup.com
References: <CAGA3LAed-QZNiMhEPBmjV2noVgLON4ciJZNsmZ5ZhTFSC2WeKg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <4429c75f-c240-64a0-f1f8-7a5fead337c3@gmail.com>
Date:   Sat, 13 Jun 2020 21:03:20 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAGA3LAed-QZNiMhEPBmjV2noVgLON4ciJZNsmZ5ZhTFSC2WeKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Could you please take your activism somewhere else? I'm kind of sick of 
entitled, rich, virtue signaling americans trying to make their problems 
everyone else's problem too.

