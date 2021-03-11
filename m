Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA38C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA2F64FD6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhCKOws (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 09:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCKOwo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 09:52:44 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E129C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 06:52:44 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id t4so20880836qkp.1
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 06:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L2LpiIcVJ+2a6PWW2a1VvV/tlL7n6P2+vh3iVeCKjX0=;
        b=DdEfetmpUvwy7VhMebFcT3ULsoTex7aMwf+u6GEs2s9t44ep66CCeUI6he5a3b6oAf
         Mecx6CcvrTtR1SH17jnh4xwpNWIRQzMSjWyjigSKHUzfX6VHB2A2raVdclEQq+gf/AYi
         nTyLezjfrh66V8w4tBee/x1Djfkqd7gK8AaxnU2Sej77mH1lsa7W+SzigiZIAzCJMIl7
         ZcbeddLp/r+kZYNWkY5xyIDVZ1X6Ue3NDiGkz8j8GWmMsMEndQQJfHl9h4ZDNSVHdn28
         4Z/w1NSBgDqIlr91r468QRnRw7xtmOIvds3MmKWiXXnnq87meaosiDTLOgTFguFtIMn2
         JxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L2LpiIcVJ+2a6PWW2a1VvV/tlL7n6P2+vh3iVeCKjX0=;
        b=TNs5lt08PmOxkpu0JZwHf0QeIV74RO22JHROr2uIBwriWB54V9QJux4+xIqmx1IT7Q
         j+wHQ2dg+cLIS2eK4zdl45Z+rlVBIGZJ3tG88NEQFqAcJxQKPe1O07e+zCnUj6ECZY9t
         Y8P3Cqd2VSigzDtWnp1J/b5lW7ph2p2cyqL22vvz3DSb3Gr6CmF43HIvZvX42Fz+ENVz
         rkd24qKjFAEwXVzh1bdSr2n4xDOdshbJfOK1Iikl+W0fWuVqejfxqpREyekO56w3qmtp
         FYbOSH6hzlWwiCGdTlvZwdKe74U98gYu/D9IUw6EjByfkLmyswS5tyGLcVB6M7qshm/2
         6BuA==
X-Gm-Message-State: AOAM5330eL1ur5WRq92Y4+Zb9krEZ2YkcKHG5hRgLTCFonDAHwAc3cVv
        a2860uTVImwQdrnIOKUvLSU=
X-Google-Smtp-Source: ABdhPJxnSkc+JeHonmLM2fgkaqQlEYvm1aDc7GGbFVrGIOTF5J6quqNutxCKn9EFdsHnSFYpCmpe1Q==
X-Received: by 2002:a05:620a:6c1:: with SMTP id 1mr1923500qky.198.1615474363456;
        Thu, 11 Mar 2021 06:52:43 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:6d39:6117:2464:aeb7? ([2600:1700:e72:80a0:6d39:6117:2464:aeb7])
        by smtp.gmail.com with ESMTPSA id y1sm2067903qki.9.2021.03.11.06.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 06:52:42 -0800 (PST)
Subject: Re: [PATCH v2 03/10] merge-ort: have ll_merge() use a special
 attr_index for renormalization
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
 <386cb3230b6780817120d83457796ccf6f64c84b.1615271086.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a6f65409-29c6-a863-9804-41cba09d5732@gmail.com>
Date:   Thu, 11 Mar 2021 09:52:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <386cb3230b6780817120d83457796ccf6f64c84b.1615271086.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2021 1:24 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> ll_merge() needs an index when renormalization is requested.  Create one
> specifically for just this purpose with just the one needed entry.  This
> fixes t6418.4 and t6418.5 under GIT_TEST_MERGE_ALGORITHM=ort.

I have similar concerns here. This strategy of creating an index with
only one entry is adding some deep coupling between the ORT code and
these normalization methods. It would be a better pattern to extract
the logic that normalizes based on some attributes file without caring
where it came from.

Thanks,
-Stolee
