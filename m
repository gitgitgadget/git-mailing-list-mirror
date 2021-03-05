Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB5AC433E9
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92AF2650AD
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhCEVx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 16:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCEVxV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 16:53:21 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D92FC06175F
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 13:53:20 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u187so2558645wmg.4
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 13:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=u4OoJ1LqG1wfvhop7QMOnKB/+wrFzZiO4W7dXvMf+qA=;
        b=djq/67RcYaKkah3DhQcRh91BT6Nxq98ZWvs2JD5o4FpBVGo3pfg5ICmjbF+S98LEoX
         sO9hI6joOjRv0ttWyfZYwXPwl9kjpv+VMlF8nWVcAmJb1mGxbGMqTCa0s/KL+kVTVWV2
         vGQHBhESV3NBDIz7NflopJRwVd89dI+HhhGKTacR8C/ZFD31XSM3OkWaHLy3jC/SRCwO
         HlCdMiEkeRafM9iqawbRUdXWCS03xxInfMgAmLUKUHBFD7BPVUByEfFtyGgsGn2Afrit
         na9eVXpfXqn0DqT0Jwc02QIbt2Id+cQiTNQqVkaJSwdEzPh0royuCk3iDJOEdrgr/ro3
         2RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=u4OoJ1LqG1wfvhop7QMOnKB/+wrFzZiO4W7dXvMf+qA=;
        b=JQLZgSk/DAqSuxt8e/M95c18t5DcniKIoEKiFjc4wVFePdKBtFzz/ZxOCumCxA41jY
         9HjmjSzFogtGMx/ID4l9OKIb2JpR3WhVUdLn/NjvGTxLk+dsxQ3Khgyn4p73+wyqLoBK
         D+lvBqJ9REctBh+GcJiHhnuCG1f8qPqlQbeHq71WckAMdG4+p3YE9r7wWB+w1OeypRuX
         kQ3mOcHgq9v2lzrvv6+CszD9Tm9CrgWRbmiXIdPFhZ0z3ok5gce2pDDesm2aR/1gTgvW
         zoJwvtGSDfYSc31ia2KxgU4QPcghRcLodKffnqswBcA4DclDwY7dvJVmqbLc32szVTTB
         Z1vQ==
X-Gm-Message-State: AOAM53028b+C1HH21u81H0IgWbCQ6LLdBToOOHIMWY7brQvJN6GvwxfL
        k/4LfrA8sDyMPVdUqhHnBnaef1tLhX4=
X-Google-Smtp-Source: ABdhPJwDSkfsZyNcOXTE2QGHL53/ZNvL8yC4yrTTOf++q9C4rtEkoP6nzyv96CAij7IcMmZq1Dnt6w==
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr10881300wml.22.1614981199025;
        Fri, 05 Mar 2021 13:53:19 -0800 (PST)
Received: from ?IPv6:2804:431:d77c:4285::536f:6e69? ([2804:431:d77c:4285::536f:6e69])
        by smtp.googlemail.com with ESMTPSA id z82sm5930343wmg.19.2021.03.05.13.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 13:53:18 -0800 (PST)
Sender: "Soni L." <fakedme@gmail.com>
Subject: Re: Cross-signing commits
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <355bb5d1-f661-4ac2-d536-d1c56ec5e408@gmail.com>
 <YEKmVWHJchUhxZmn@camp.crustytoothpaste.net>
From:   "Soni L." <fakedme+git@gmail.com>
Message-ID: <537258e7-fcf4-814c-c7c1-95c8d525f34a@gmail.com>
Date:   Fri, 5 Mar 2021 18:53:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <YEKmVWHJchUhxZmn@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2021-03-05 6:44 p.m., brian m. carlson wrote:
> On 2021-03-05 at 16:47:14, Soni L. wrote:
> > We have a somewhat unusual use-case where we need to cross-sign commits. Is
> > there any way to do this in git? As far as one can tell, attempting to
> > cross-sign a commit would cause its hash to change, and creating a signed
> > child commit would break fast-forward merges. So these are a no-go.
>
> Can you explain what you mean by "cross-signing"?  Are you proposing a
> situation where two parties sign the same commit?

Yep. See, the repos enforce signing, but they can also be forks. If 
someone wants to track upstream in one of their branches they just 
can't. Would be cool if they could just say they trust the commits by 
signing the relevant commits with their own key instead - on the 
assumption that they actually reviewed said commits.
