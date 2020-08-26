Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52273C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 12:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272782080C
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 12:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVFzL1GN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgHZM3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbgHZM3N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 08:29:13 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3A6C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 05:29:13 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id v13so1309143oiv.13
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1gNR1yA+RWAW828oaePUDwElEg7sxJ1o6XM3DxViCpU=;
        b=qVFzL1GNlLRVKUYmfB+EMRFJSYWhYidFJ30WhqH4KHo5CYd3NQcc+tlNQ5nxmoeERn
         R1bDZcIhQjmvQulSc63DKJvpvK8fQqb/ZD/6OoNt2+GYOh9/q6p6MIGZqVAOoL+SQUmT
         OPOVfG9i6o3xKNkkB4EEUlQX8Rrg6TYR/UiS021u37ztDbTpKELRS5UBRNcXjh2sTY88
         wZZ3AFkkiBu3dxrzuPFga9TW5RB9XwIg0YH7P1BXYY+NUN+VkhYZItbPhZ67LUO6XltH
         1AJKUw/xcotWNnIfzAzVlB0BjseHvSUwL80KNDMIj2yHG47PyHM58+Lc8bStV7+64suq
         s7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1gNR1yA+RWAW828oaePUDwElEg7sxJ1o6XM3DxViCpU=;
        b=funvdzwMYT1G1vAw0FgU+3xB/35KjurDNNUmtVkqtZ1+7cXHdjhQpLxFPpmXejTp2E
         AiCiosYom+110IL0ocLquuwiMkShuRUwMvx0h0yDWyZ1UTbueIZWv1uTWpR7ObvL6AMP
         EWqAUJqe7bBhwQCz4MNsaq3qPA4XRLZvbPdQzvH3a28L40KzOg52AfssMyGgi+KnOrdM
         s1BA+lCxiGKK2DYm4sckGYxWAisalh2B5gBfFQ/N56P9Zg2Lrn8NXAHogwYSQLAIKSoU
         dFufDKFohIoOIC/M+62WhMBVAQgI2QgiDKPG20pL/2aaczw1WjgFQEtyS12py5w0rn8S
         Eqyw==
X-Gm-Message-State: AOAM532djqtb+mXnnUfIkTAmxVDcWGK8EeQi7ysD2tOxPRlufndKi2I2
        tgE11MetCFvBAkbrLAd6bb4=
X-Google-Smtp-Source: ABdhPJxg20kGrBDTqIYUSJeJzx3sT9JQ/WtSu5aA11XVYOlgM5XH2qDnzV/IKrQ2O1SUuJ/bg8Yvcw==
X-Received: by 2002:a54:4f99:: with SMTP id g25mr3893616oiy.139.1598444952877;
        Wed, 26 Aug 2020 05:29:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:718c:9432:b85d:1e88? ([2600:1700:e72:80a0:718c:9432:b85d:1e88])
        by smtp.gmail.com with ESMTPSA id 33sm465631ots.12.2020.08.26.05.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 05:29:12 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] maintenance: optionally skip --auto process
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
 <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
 <5fdd8188b1d9b6efc2803b557b3ba344e184d22e.1598380805.git.gitgitgadget@gmail.com>
 <xmqqlfi2z9ht.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1e107b2e-364a-4c17-90b8-0371e8e27878@gmail.com>
Date:   Wed, 26 Aug 2020 08:29:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfi2z9ht.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2020 5:44 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Some commands run 'git maintenance run --auto --[no-]quiet' after doing
>> their normal work, as a way to keep repositories clean as they are used.
>> Currently, users who do not want this maintenance to occur would set the
>> 'gc.auto' config option to 0 to avoid the 'gc' task from running.
>> However, this does not stop the extra process invocation.
> 
> OK, that is because the configuration is checked on the other side,
> and the new check is implemented on this side before we decide to
> spawn the maintenance task.
> 
> It sounds like a change worth having without even waiting for the
> "git maintenance" to materialize ;-).

True. This one could be pulled out of Part III and placed any time
after Part I (outside of test script context conflicts). The only
reason to wait until after Part I is that the name "maintenance.auto"
implies a connection to the maintenance builtin instead of gc.

Before the maintenance builtin, it would be natural to see "gc.auto=0"
and do this same behavior, but that will not be general enough in the
future.

If you prefer, I can pull this out into a series on its own to be
tracked separately.

Thanks,
-Stolee

