Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDC1C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 00:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469542078A
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 00:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceUvWw6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgFNAFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 20:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFNAFj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 20:05:39 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2ECC03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 17:05:37 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id y9so6146312qvs.4
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 17:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yCyA631x1ghO29res3h0Ph6EZyNoUPPfnJsUtrJjZx8=;
        b=ceUvWw6q8mbp/aAv15EDbiNoj7u9VCPkIMTlO3avRzhzpeGZ4lvxV3sLNFb04lzcE1
         b1q4I539MGlKeROI+KI+X8hl4MUJjGDGLLukg5f4jF3MP5Db5M/ccYtWTpLyNv5IzUex
         fh9tUoamrPVk6owwS5pZkTfN/VLv0XSfBjivDMtPBO8vdZWqBAXIN0wUjK8TnHTY4T9u
         4ceqJ8HJovqsw6iytkUZFeiROKiL01aWddje897PuHTyVi5WpI9NhGmS8IAzyaIwYX9N
         gBV6CGGZupmp4Kv8zABRdDtEefw3rW3Gt2XP7UOyWH6PPRNFTV566is34SKzVV1HRQ42
         DzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yCyA631x1ghO29res3h0Ph6EZyNoUPPfnJsUtrJjZx8=;
        b=eeAWe0uQcqcWwBLcAWJM6TlW6Vd2NiYE7nwBHERBGpeyFZrBtlCSQriRZf8tuF2Ydh
         6i8a8anXFH6uZeTbDBPWNavfF3MklV8e9zuuWmMskxMX5iQJwhoV3J7J1bAnuuOtkXrU
         i3mXzi4CtWm48VpzuNpPK/E25I4jIssB1rTanjIQ4oYcLkvgOI5HSe9/BLI9V+JB8vxD
         M7rjAIyU8zyrhriLPnNU5N2QGCWPzYTI9TgdYCAWF05/VvpUamXwJMjZJOLdsaw9VbSt
         +caIKln+TG3L8u0eluL2F8OJ6iS+B554AcJttJpWj78lOt8GOJBXl/TtMXnRDGa0S7aJ
         0Qig==
X-Gm-Message-State: AOAM531A1XGeSMyyXUV/7WZyZQ6YNPYPEvnyx1uVSLM+1VZ4OOPRUYii
        7ZOAEc1NQtKHZPiyvufaq9xr5wrZCKk=
X-Google-Smtp-Source: ABdhPJzgdEsXVhDPcKMYMGIY0ICvZ6oF7pFsGqK7WuZzoCp4YLcuvu9UFKzYlniK3fu4iTSMLEx3jw==
X-Received: by 2002:a05:6214:a72:: with SMTP id ef18mr19465929qvb.239.1592093136724;
        Sat, 13 Jun 2020 17:05:36 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id y70sm7985911qkb.16.2020.06.13.17.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 17:05:36 -0700 (PDT)
To:     don@goodman-wilson.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, simon@bocoup.com
References: <CAGA3LAcDpQQhcmaQG3+s6XNnth54KmNC+padAXXYsc5C33p7kA@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <fcad8e8f-e853-d754-e3f7-644a5c717f84@gmail.com>
Date:   Sat, 13 Jun 2020 21:05:33 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAGA3LAcDpQQhcmaQG3+s6XNnth54KmNC+padAXXYsc5C33p7kA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No one here has to explain why something not racist is racist. The 
problem are the perpetually offended that see racism in literally 
everywhere. Specially when there's virtue signaling points in the table.

