Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45C5C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5808464EE0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBRUWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhBRUWX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 15:22:23 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB87BC061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 12:21:42 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id h8so3451900qkk.6
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 12:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q8RqzdvG4QRpsFNtMosM0AEi0NUgdsTQfprVWuuxWBk=;
        b=bGW6MbZEKOAcyC/IzBovbXqwyqN13i3Q7SGW9yxtkGVzv4RRs8C6jgdY/bScEpjmeN
         iXX/Ryq7fB8mLCqmREObLntGSbHEXfCnx2rY16iHI7etmGofg0iP9KS7FTzfFnawzxPo
         GCJErAGywAOaK5R/nzyiCuxUbx/uQxT6eHpzSeveV9ZJmXBCgskXLnhpzFiUWclb/6a0
         lAeevLK37OlNvcUbShR29udtnIrBl18ac3sD9cIvZ4wnbajJTg2kVt6p+vmyXZbyS8Dz
         6OQv1967skrwwqRmt6phGf1Q4ScsLSd5TRYJxe0hVd8W1KhzH1MTwaV6RgDKCc+Gsp76
         vXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q8RqzdvG4QRpsFNtMosM0AEi0NUgdsTQfprVWuuxWBk=;
        b=D1xnMejfK+NG4ohqzOQOSuhtLazOrCeAcbw3PG/fvdFnNkRf5hkdm14Mv1XWl3VnxA
         5B2V4OZ+sCHKhdGnhNSgesk29m2Z7ZYonnGw8LhVDg+Md1ZKr+GT/RLUs/0lzSXINrAG
         KtVQUu2Yj1GvgGI5zPgH8M618fE0rX/GBXwrJYCn5lCcRfXurLRtFcUV9mQLCczg69n1
         v2W4XIxVwq+7nu60MUAz0xJG6zDyz9fqd0YkX++SFuOK1998oVGmLaCDKpIlRAoNVude
         tDnDR22wfYahpDTRlyrPh9GTLYWnrhECkN+khS0TQmS/jF96QBTz9KNss8LMwg5zzK+W
         QYHw==
X-Gm-Message-State: AOAM532C6T1tBEuHQsSbsNgAn+szcKGeG4NqqK2VdzX+Q6AJagHqAckj
        SsPQnQyg+WNotqhHjhCOdbw=
X-Google-Smtp-Source: ABdhPJy3KysbhxD6lv/7g2UaQitW23nOME+tlK2tZgT6vY2PKPetg2LqMsiY4o7t5PUdRQ5zCsMtRg==
X-Received: by 2002:a37:4d4d:: with SMTP id a74mr5995632qkb.204.1613679702025;
        Thu, 18 Feb 2021 12:21:42 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id l128sm4675263qkf.68.2021.02.18.12.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 12:21:41 -0800 (PST)
Subject: Re: [PATCH 2/2] t3600: amend test 46 to check for '.gitmodules'
 modification
To:     Shourya Shukla <periperidip@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com
References: <20210218184931.83613-1-periperidip@gmail.com>
 <20210218184931.83613-3-periperidip@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <288ab1ad-d5e8-ab30-e0c2-a3e5f21d05a6@gmail.com>
Date:   Thu, 18 Feb 2021 15:21:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218184931.83613-3-periperidip@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2021-02-18 à 13:49, Shourya Shukla a écrit :
> Following commit e5a439dc71 (rm: changes in the '.gitmodules' are
> staged after using '--cached', 2021-02-18), amend test 46 of the script
> to ensure that the test also checks for '.gitmodules' modification after
> a 'git rm --cached <submodule>' i.e., the entry of the submodule in
> question is removed from the file.
> 

You can't reference your previous commit by hash, since it has not yet
made its way to Git's master branch. Usually what is done in that case is writing
"In the previous commit, we fixed *** so that *** now does ***. Change *** accordingly"
or something like this.

However, in the present case the changes to the test should be squashed into
the changes to the code, if not the tests are broken when they are run
on patch 1/2. In this project *all* commits of a topic branch should pass
the test suite before the topic is merged, not just the tip commit.

Regarding the changes themselves, they should be tweaked along with patch 1/2
to test the correct behaviour (not modifying the working tree copy of '.gitmodules'.
