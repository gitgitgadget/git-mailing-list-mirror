Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBEAC4363C
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 18:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940822068D
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 18:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLl1xBFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgJDSxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 14:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJDSxj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 14:53:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DA6C0613CE
        for <git@vger.kernel.org>; Sun,  4 Oct 2020 11:53:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dn5so7052223edb.10
        for <git@vger.kernel.org>; Sun, 04 Oct 2020 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fDSLVRG3GNB/YDoBTOTql6vV8yvvAmuTFEajY+cuYzg=;
        b=lLl1xBFZXvRaheWQGNVz45iVLPkOtA2fsQPY1eIwX3beaWLa7egA72lbJLfqucR7g8
         OD9+8tnGNIuRjYWH7A3UNPoqGU/JNMhAPDperuFiMBTVPCxCUl7jPFS636T+QeyPy3oH
         A2C8IQaOCXZgA7Ddpxkw2Sst/6MmOiik5xM8cqDuN0H6npNCg+16WOiciL6fPh9SULHB
         0TKVjbOi5F3ZHSbAmzq6mlhygELatOrUf/kCgQCKZTDw6NR+Lrl/pNkoYyzpUaDvQLVu
         GSaKDpU8BOp8rhiqmUh2QgGEpaX3vwPGNeXTSxTdqWsKwhqSLuHUrBAHkpTU8AvLV8s3
         6Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fDSLVRG3GNB/YDoBTOTql6vV8yvvAmuTFEajY+cuYzg=;
        b=OoQ6/V2UD0cQek61H9xzL7V+YCyaTa71CWBxR+0hBLCg3vrbgcjphjrcnlDh2Zc48e
         aqEemkWGfCxls8y4q1rfZqUZ75ix5iHR64f9Wg6+ri4+fV6OuwIDtzw4boHL9ee7L8tC
         tA4MQJ+t/1r2MPhr+hKGlLGwHH9qR2bhrD7WSyByKqGjiIMhBhfopbt9as7m5WW3yCDE
         Dv8mkmOIt/RoJY0m7QEnjbueN8kfzCwKHGTjyfB7YVpCSPABkWARvFeHrqhknky+j+aC
         z7mCME0zg/8rvYnDFJQygmaoA36PO03tiM25iSjt1Okxep6QHixlS+q53hxU10KYoeI1
         Hz1A==
X-Gm-Message-State: AOAM531KkGxOtZT+QCC5DljUOpRdEnfm/UpdycHvRflEnHT4HiUP8wVE
        or+r1Eji6ddWsS/FUMJnuXqtHwYqs2o=
X-Google-Smtp-Source: ABdhPJwxDqEa52YgCDaMi9NWupWUanWlpJkHco1G279mn53SRhbU+0zqbivgLOpObGbJ5yCweW7MuA==
X-Received: by 2002:aa7:c7d7:: with SMTP id o23mr13294918eds.44.1601837617160;
        Sun, 04 Oct 2020 11:53:37 -0700 (PDT)
Received: from [192.168.1.98] ([94.31.83.233])
        by smtp.gmail.com with ESMTPSA id g20sm6220837ejx.12.2020.10.04.11.53.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:53:36 -0700 (PDT)
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Jonathan_M=c3=bcller?= <jonathanmueller.dev@gmail.com>
Subject: git add --intent-to-add and git stash
Message-ID: <b16f61b9-7f0f-38ab-7200-58ad5e659321@gmail.com>
Date:   Sun, 4 Oct 2020 20:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

when I try to `git stash` a file I have previously added using `git add 
--intent-to-add`, I get an `error: Entry 'X' not uptodate. Cannot 
merge.` error. I have to manually remove the file from the index, stash, 
and add it again after I've popped the stash.

Can `git stash` be taught to handle such files automatically?

Thanks,
Jonathan
