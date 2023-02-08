Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F3FC636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 14:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjBHOcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 09:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjBHOcE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 09:32:04 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D715EB64
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 06:32:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so1590757wmb.4
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 06:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMZXcXwuYJfRjDz08hOTqr/rBD7J99Nc46Xor4UQbAI=;
        b=OQd2GVLSCojYL0pQRbNtF0B8p/mXJefOoUsGqgj4Ky8jA6J5mKTXqOdVG0KJ/3H5xR
         GxOciOQgsiC9YQXJoLfJMfd1qXC38qJpHeilSWTIsKWAT4Gjk/8THlUflwSBOXEtCVxV
         BaEvDmvGEUAWomxLnxuY9X3CetR0CLDlOegzLPC9VJmWg3vunOTGmeodBnQ44GDlOjCU
         QVnEQiKkFO7PPKnSRi0d4ungjh0+zPkRGFQbTckWscnPvZ/5UUbwMSzEjbltjEQCPvp0
         xkVW62RWoVRPpYtD6u2+0XuLY8YrlMTUFpSeGnr4QcpuiGdeLTKY+mUVU1fgZ3Gkbnfb
         enlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMZXcXwuYJfRjDz08hOTqr/rBD7J99Nc46Xor4UQbAI=;
        b=G/pxT2wgmZy8FW9vJmUsAT0cqAy9MImuHsF/sfdPJhKC2YxlXAs4LAbDsPMUWxdHAf
         2cw5EG2879nvi+wHvNOIR/PcT3PbOLiPYkufkcalqZJlngDFxaBPb3zRcp5uhspvBLno
         dgTE3a2nHuG5bhwc93Vv451nG61qBYaJysE5MQAjqXWKHbRoYHTTaCDXRuLPvSMtq2Sk
         wXeg4ZjkIU6U/xbqk2wTM9gx8eSK/yaLJWB8IDL+AbSL9ivI8UMrghEgAn9pFQQFRD53
         TtqwChS2K5TTqH7WtHeaid5cx92PJ0glp5bw2xOJPHZ2wz2Wf0cLXlE//V+Fv/7ghcMf
         gV8A==
X-Gm-Message-State: AO0yUKW4cn4sdaK5fI3pCfjq26tncLrCl8eHzykcdEOMMMfzLmK9pdIC
        V3Lo2gso3Zro+VHd6S3qALUkbZCSOmo=
X-Google-Smtp-Source: AK7set8PCKCBHnhJmBItkKX9UTNaFjd7V8mMP2HHiPrVkRQ+J8frFNBFS9MbXxbXtV31wPuEkJARHA==
X-Received: by 2002:a05:600c:2e95:b0:3da:50b0:e96a with SMTP id p21-20020a05600c2e9500b003da50b0e96amr6727172wmn.29.1675866721857;
        Wed, 08 Feb 2023 06:32:01 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id bg2-20020a05600c3c8200b003db0bb81b6asm2427384wmb.1.2023.02.08.06.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 06:32:01 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a120ea47-722d-2bb0-9c49-294a850af6af@dunelm.org.uk>
Date:   Wed, 8 Feb 2023 14:31:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: CMakeLists.txt from contrib/buildsystems fails to build on Mac
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ilya Kantor <iliakan@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <BFC8139A-0A9A-4E84-BC0B-D6EE5F469F82@gmail.com>
 <230208.86sffgz7i1.gmgdl@evledraar.gmail.com>
In-Reply-To: <230208.86sffgz7i1.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 08/02/2023 11:57, Ævar Arnfjörð Bjarmason wrote:
> Or rather, that GFW would be fixing it up, but then I don't see why it
> should be in git.git, which as your message shows just leads to
> confusion about why this component is in git.git's tree.

I think Ilya's message shows we need to update the instructions in 
CMakeLists.txt to make it clear it is Windows only.

Best Wishes

Phillip
