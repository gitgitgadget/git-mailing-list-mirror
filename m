Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC46C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 06:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F4361158
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 06:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhIHGCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhIHGCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 02:02:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E65C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 23:01:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u1so626177plq.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 23:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zpF1XuzZbtIlLT/6HYICubI5OKCLj46Z///A0foCBCY=;
        b=HfQXBAugN4GG+L2NdJxoh1qEn5fxyCOYK38eIPt1v9HJHnaZ+L9Zu5YbQbA1Qbu0uJ
         fWgx39Xpe6FeSFoOTQuLvGMrbCq3XYm/ewBgl59nXOjjG3I2/LTag+ygsYmXY1qH6MW+
         Ip5i48nm6oG4OLfEN1z9ePBjW/wVTFb2muuebQhatdjlDN7iXZvzgsbVbrWqLNXU9g2L
         hZJR7w6VR8phw0hHhbF6XyoRoXcBqf3WpwHbdxkFVTMBW3JclqqzhrUQ7V8cTXi/1x4i
         taa7FO+9e7H3f6+vT5JRTKcyXnmk0+6BK3gxcP1Vx4kiDEbzEz+eg7NTzN5i4irAJe68
         LiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zpF1XuzZbtIlLT/6HYICubI5OKCLj46Z///A0foCBCY=;
        b=ugvGK7PgbZ0GtCE1O2+4welisIaOBLetbE9POvIEP3IoCMw5+3qtE+LveXc3ty4Ooi
         S4w9/eXpMxYgJ+srXMG7r+FJ501EbBsX4WBYGXtFIJtGnlTYmQEAHZNmJSCVSOUj+ZsK
         GN/dLiZneWJMTysfDY1nay0JJfPJi/NPcBpiFwrw76DdhoAljA1AoWH0uqaW6eNs/olE
         +mm9sLFYGFqPtAHM4H7EHlhgPmEYhycXg2lsXIwI+qBIaGiBb78ja8BzYLMjaZ6I4kvW
         UHrxfOwAykJDtuWTn7IwzfecDxt55Gg3TzDQ5erCdkjFSod/mMYZyykv8E2S+kEk2EZq
         wiBQ==
X-Gm-Message-State: AOAM530HnOWTyVrg2urYhj7gKitrsEVehpQzBeetevPKaixpjcylvarT
        X67YSa2qSje2dZ64vIeo7q8jFI1F+2o9ZQ==
X-Google-Smtp-Source: ABdhPJxgVn2OQBihdjALa765Y1ektbcvHtjUuFUlvYQlnrSDmf3wqMO8uxqP2Fzg4zRRK2pj+3yo3w==
X-Received: by 2002:a17:90b:1e08:: with SMTP id pg8mr2383706pjb.3.1631080863606;
        Tue, 07 Sep 2021 23:01:03 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id v4sm959430pff.11.2021.09.07.23.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 23:01:03 -0700 (PDT)
Subject: Re: [PATCH 0/2] Add cmd_gud and detect libiconv path for Mac OS
To:     Colin Curtis <colinpcurtis@gmail.com>, git@vger.kernel.org
References: <20210908051340.13332-1-colinpcurtis826@ucla.edu>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <a1ba4d11-222a-92a1-257d-522dc4e0d8e0@gmail.com>
Date:   Wed, 8 Sep 2021 13:01:01 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908051340.13332-1-colinpcurtis826@ucla.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09/21 12.13, Colin Curtis wrote:
> From: Colin Curtis <colinpcurtis@gmail.com>
> 
> The gud command opens the Pro Git book webpage in the default
> web browser.  The reason to add this command is due to the
> play on words when saying 'git gud', which sounds like 'get good'.
> Hence this command when invoked will open up the Pro Git
> webpage to allow the user to 'get good' at git.
> 
> We also fix a bug in the Makefile when running on Mac OS, namely
> the libiconv path when using a brew install for the library.  Previously
> the developer would have to manually change the path to the library when
> developing on Mac OS.
> 

Two distinct topics in one patch series. Why don't you create separate 
patch series for each topic?

For `git gud`, I think there's no point on adding such easter egg, since 
users can simply access git-scm.com with their browser, without needing 
specialized command just to invoke it.

-- 
An old man doll... just what I always wanted! - Clara
