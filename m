Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B3EC433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 00:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187832065D
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 00:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqHwYpL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgFNAAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 20:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFNAAq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 20:00:46 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD8FC03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 17:00:45 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id ec10so6155285qvb.5
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hDc+oO/woFvuA4/bpbhnv+04XUoGD+UpyP5PlLll2qw=;
        b=IqHwYpL0WdezszJgM2WnpF6EjWQh/vrMTQIgOX+6Ewym4rcUxqzhDJQ+VkeP5ZQ7CR
         dUBk416aQcEDaQ+Sd3cCHn5BWZJX1tymR8XfsFaoJgjVAcxbewq2oLmp+qGb2g/JVjDF
         lAtzfyxOQOl7o5riM3d428Dw9tgfCwUPlQsc/t5y2phzYXYnrgUNZqpO4hFne+PRjcR9
         LsVzVht5chyAtUxiq3VSR6vL9rmfTL1o20/RljzGXkE/0gAE14Bhg/FquX2iSzSY+Zv9
         tXtnIY7Z7qS9cGWVyPnF0/1T0o4UlpYW3DeiPf2Vs2senIgprUkyrahZVM3HQ+VdZ4wp
         n9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hDc+oO/woFvuA4/bpbhnv+04XUoGD+UpyP5PlLll2qw=;
        b=N/yLYQTjo89jHMZVc5peroEBt8opCtAoa1tQWsJsJij2lgsavfZCa6hMIqPNHcxoCB
         6VyOO2lV7TS41zSaUQFnkPox03yz5v7S1ICAtrr5T55TJSC6dKLlRMCHz6inPo8BbXoQ
         wBfSN+YQgYkOV8GkbbCMB1WPHQF4pSlqyY+/sRw0UB2PvLGvZ6FOEuueQuXEdj4Sa/ih
         H20hsmsRXbRbO+z52D+jt5LZJc5YrLFnSDePpUX+xlgfh6MqWYZeykV545m/6gbgNbwp
         Q6xCBKCyXAgAHJDW5L1KseuPVbeazXSq9tOpVpG5nrh0gViv7s2ERpcN0zI14oqk7TwT
         nNpw==
X-Gm-Message-State: AOAM533dGq39Ynq0en1wXDKA4kO+74C1ec5yuGMF3Kl3t3q457Y8Xoi4
        UX1kv5oD6T7X+pQ+QnTL27k=
X-Google-Smtp-Source: ABdhPJzr400gP/rm90U/0JgXlFRhZ6qQjEXYYR5rXilUr6ucwdsFdZw43r7PKbEj0k2DLtT/T0Qa/A==
X-Received: by 2002:a0c:f681:: with SMTP id p1mr19236468qvn.2.1592092844786;
        Sat, 13 Jun 2020 17:00:44 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id h8sm8251035qto.0.2020.06.13.17.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 17:00:44 -0700 (PDT)
To:     simon@bocoup.com
Cc:     don@goodman-wilson.com, git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net
References: <CAOAHyQzxG7Lc6+PLBtM6oe9vSoEEAmuXAaKF2VzO_phtkfGRVA@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <32b2d17c-71df-4c10-72d7-9696f1cb17a9@gmail.com>
Date:   Sat, 13 Jun 2020 21:00:41 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAOAHyQzxG7Lc6+PLBtM6oe9vSoEEAmuXAaKF2VzO_phtkfGRVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 >as far as I can tell, no evidence that "main" offends anyone.

I'm offended by "main". What now?

