Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8492C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 07:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF8021475
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 07:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz7/Bj41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgFQHlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHlo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 03:41:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1289C061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 00:41:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id p5so1184174wrw.9
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 00:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=OoPzNKC9YwgNiAjEK/OkOcza1C9WEpDv9fSbsvT0K5g=;
        b=kz7/Bj41RMb+p1xTODLu9RQIxilSf4vEib16vafzP2ViH3zZdULRA0lVW9J3Uz2D/G
         H0r7JvFqCdQhA76Cs0naEWvSfwCedHRyXgsoNehxn4ZZZ8AcTdE+0uwA08EbsCCZ6VJL
         lZ3Qcnm6jppKYh1mKoSkdIMF+MYP2NbhjA+CBAQZ/wyq1H0/KwcfwRw1JraxddCjORzC
         e+Qbc9T2PEVIhz1sOEbTVPiTm/Uou81xe08J6IeM8DDz3IiljONeYBO+Zp3SUupycXBw
         JP6fPf0Kt7zTtNlTNEt+dsjzfgBvhTrlmjwqGO/XMLhWt45EbJFqzf7tOl/HAt37YA62
         ubmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=OoPzNKC9YwgNiAjEK/OkOcza1C9WEpDv9fSbsvT0K5g=;
        b=Znzu2jZGcEaQ7LePD80jRYRG8tzOWjwr8Vy4qDF9/g6esfphuacvgizmGdiHmazyvs
         ZJuo5cUYOw7+rZRKVHnIbW2otEba+sCejRcIYb2kvDZlkOTMcnPDxyP+hBIt0MbGmh4m
         is6Kbh8e1GNlkf3Pq5UZPxQcq4ZQLofGXMQEtv4u3bDaPDz2HcI7ypFTe1Q5t6TK4t9E
         pmECyM6cze6f0MrVV7dkUcYSlulofd9Lomh80LVt/iQG+DI+Dyg/r0SUcCczDE7jXrh7
         wqddsbpBblhkhi58WPo3rErzhiUcfODDSL4aQzgYVHpbWsHMNJ7QE3pQ7dxt31XCsA70
         WJnQ==
X-Gm-Message-State: AOAM533uMXSOoByKOEY9quDPFh49v92AYj8MSiBqTJ+OP6uRJ2zXVqL1
        P/zXkKqbm8frPNIxUqrNjrObr6yV
X-Google-Smtp-Source: ABdhPJy30SCGIiUhTjVtK0UaBpKO910d5zNd0TZaugDTM3m8KMRgmSsfNyGIhAjaXyQdC1eDp/bZSg==
X-Received: by 2002:adf:9c12:: with SMTP id f18mr7603861wrc.105.1592379701667;
        Wed, 17 Jun 2020 00:41:41 -0700 (PDT)
Received: from [192.168.101.24] (102-182-251-152.ip.afrihost.co.za. [102.182.251.152])
        by smtp.gmail.com with ESMTPSA id s72sm7380033wme.35.2020.06.17.00.41.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 00:41:41 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   Noel Grandin <noelgrandin@gmail.com>
Subject: filtering on git fetch?
Message-ID: <f6c1377f-6945-b04f-07cf-887c4b7c9f76@gmail.com>
Date:   Wed, 17 Jun 2020 09:41:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

Setup

(*) I'm fetching across a transatlantic link (RTT in the 300ms range on a good day)
(*) I'm fetching from a gerrit server

$ GIT_PACKET_TRACE=true git fetch

shows tons and tons of

09:39:43.355675 pkt-line.c:80           packet:        fetch< 3a7ad7ee5d7daa0c93a80fbb32a677597d81ac75 
refs/changes/00/9000/3
09:39:43.355684 pkt-line.c:80           packet:        fetch< 6cacf1db5311f6b250ebaa12c71419a8ff9b747e 
refs/changes/00/9000/meta
09:39:43.355693 pkt-line.c:80           packet:        fetch< 849a43434a5ede9ce9b70da14231f34edb2593fb 
refs/changes/00/90100/1

type stuff before it starts fetching the updates to master that I am interested in.

Is there any way to tell the remote git server that I'm only interested in a subset of stuff?

Thanks, Noel Grandin
