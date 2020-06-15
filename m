Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B43EC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 18:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03596206DB
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 18:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlXcT6vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgFOSSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOSSM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 14:18:12 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D35EC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 11:18:12 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id u17so13425808qtq.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8P5UYNus8f49GoYwT1vPEMtD9PqZtjLtNkD2LMvGQJI=;
        b=dlXcT6vgJJKHdLZ/R+BwdOnVUQsg3lQfkX9mOrwyYIiepBnujJv+VNnG23i+cfYlhX
         zaUrvByfSVnCTirjP9gOE1niQH9cRGo4n7eO/j6S/4FaNhjJnAwyg/LSPUQ2Amrzf0bk
         u5RLry8OaXCbk5z1Sy/Ialtkcp/xzrru0BWIMpNet6vyVHnTsIzi7qMUFdTjaWjcF3Od
         1XVsXdl+j/4HuUUVT+JFBLWVGx2WeasUNsVkhRKg3mCvhBhUs+iJQNZLUNkksw1Kxf9v
         saIeMkD0pX9ozZJcIjcpO0mYvofIDcKqaT2RkMfIx91+rEQTX7CEglHyCwkGR+BQ3jgp
         aEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8P5UYNus8f49GoYwT1vPEMtD9PqZtjLtNkD2LMvGQJI=;
        b=buf/r8Vnvo78CELMRCxd4QUpoQfTxtdWioU6ANG+zJrM8Q+YcTUuqfnaThd5zFiIkh
         X3veLB5K59g/LF+KKoeUjCabLkoIT3x9KN6gYrZhPlmSDNPazgIaFNWAHiH9uX/7e+md
         jOkTfhHcj5MI6JiPcYh7Sh+/Oy4VdgOejQvv67V6M8oJ+cTa3nA1vhe3aBw8MysFt24b
         dT63jGis6iJ9g21B/XCkOdIGVZrKsyemWgqSH3UWmAUuxnlYUUZyPX0wqCb2WbhUw68a
         k4moYmmlpL/38NZb2PCWjqbEkVcUU+Z2MdRoKyPr88iI16T35SOWN+BwjPluzlaI/ZzO
         WOEg==
X-Gm-Message-State: AOAM533cfpPCDhh9Gi4mjMAy9/+9d9qI+Kt05oRGngJxaEUD7Jz0GuPW
        2jOu3LfzcWl8EdSjAjyGtKhJ7OXWCuA=
X-Google-Smtp-Source: ABdhPJyLH0YfKCN9Sw2A8K3bcRUkxqSz9rPMrEwuMx/EU+Tnd48rkZzgzJ85xhyYRwVsknzdN033Lg==
X-Received: by 2002:aed:3b62:: with SMTP id q31mr17252093qte.293.1592245089975;
        Mon, 15 Jun 2020 11:18:09 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id p185sm10964283qkd.128.2020.06.15.11.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 11:18:09 -0700 (PDT)
To:     jrnieder@gmail.com
Cc:     Johannes.Schindelin@gmx.de, don@goodman-wilson.com,
        git@vger.kernel.org, msuchanek@suse.de, newren@gmail.com,
        philipoakley@iee.email, sandals@crustytoothpaste.net,
        sergio.a.vianna@gmail.com, simon@bocoup.com, stolee@gmail.com
References: <20200615180744.GB135968@google.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <3cef6084-e632-c9ce-c0da-a2c250c2f512@gmail.com>
Date:   Mon, 15 Jun 2020 15:18:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615180744.GB135968@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, half dozen people who are scared to be cancelled agreed with it. 
Tell me what, why don't we run a poll on popular places about tech and 
see what people think of it? It's pretty authoritarian to force the 
whole world to be affected by a change that only very few want. There's 
barely a dozen people in this conversation for a tool that is pretty 
much a global standard.

