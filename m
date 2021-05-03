Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF71DC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 16:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8616E61166
	for <git@archiver.kernel.org>; Mon,  3 May 2021 16:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhECQbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 12:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhECQbB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 12:31:01 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1742DC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 09:30:08 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id d25so5938259oij.5
        for <git@vger.kernel.org>; Mon, 03 May 2021 09:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YUqn8+1vHvUP1QH9W5KqjV1iOW23ywpSDl3vSo/VC5Y=;
        b=Wsdgby1/ru/4T1xGGW3aw/HXtAN6bQxB0KYBrbSsEQ9gYG8PIFEVXehDowTmgBKjiP
         0N0ZloRwx6zs6sjt5GIFq8+GIZhTvF40csa1kre7B7OHIeFLdSQsRErLY0JnMLRWEAaI
         2eZKIzVHndTTQANGXJihledpgFbyq7IHqnScVfgkhrnQCz9ekxBBzHEG5hVEoABECU8A
         F+HrV/A1SqrnWWRPWheUJTeZTcKmS7TXVr9XrvbZvYcSJwV5SeQ8CqZ34ZuM5Qo/Snsu
         H9jF/BFYkK6+2YwgM/vWkYgJFTsTgUtOpAz2w82pED0F4PWEMhGr8zi9R3kkZuvEoVQr
         AvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YUqn8+1vHvUP1QH9W5KqjV1iOW23ywpSDl3vSo/VC5Y=;
        b=BdFiamF9SdciLFliHU+iI8U6uUhni24RkGGqYWvdI5kM6k+J2+vCsMjcWlKPMyrRAK
         X4J4NtD+uojEcl5xme+ClAGHEbz/ALZvHt3NGnklQc2pwnrGy/rIEL5wRj2U7xuLQEVM
         dXDc/YMH+K5hp4Z/yNxNF32vKLUTCOI+AJLK4cDilaPRWLdRWobQcOYCDwosa6MzOIgu
         cGllt0ZZ0wTblFdDaFH93lelWqcP+X0KNmAxleZoG8QhysJoU9KLpbhiJncyr5o9KlW/
         Q1ZpfC7+K71E3phUfr3SQjIOnRODit6vus/wcvoKATLACI7iA9IUjcXWV9D8PvVS77fJ
         02dQ==
X-Gm-Message-State: AOAM532gwFmfO10ZHP0+9IK4+E2nMVhdfzv+XY1HmqqjKPhPsBJTS6W1
        Xkdq+yl1tvYAIAy766hcg0gnu/ZzXkv8xQ==
X-Google-Smtp-Source: ABdhPJyON11YJXs69LG+a9mlyAOSDwXtUPwDW42MhsF5T8676nEKJnNZn1o1jkEFjxihPzap6bUM7g==
X-Received: by 2002:aca:47d2:: with SMTP id u201mr1892940oia.19.1620059407171;
        Mon, 03 May 2021 09:30:07 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:85e9:158:3940:d749])
        by smtp.gmail.com with ESMTPSA id o26sm43648ood.40.2021.05.03.09.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 09:30:06 -0700 (PDT)
Subject: Re: [PATCH 2/6] fetch-pack: refactor process_acks()
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1617929278.git.jonathantanmy@google.com>
 <6a9f78df1a3513df04ac3275cd1feccfb6cf87b1.1617929278.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <15b4fb49-6254-bd6f-4c34-f04b55adced8@gmail.com>
Date:   Mon, 3 May 2021 12:30:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <6a9f78df1a3513df04ac3275cd1feccfb6cf87b1.1617929278.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/8/21 9:09 PM, Jonathan Tan wrote:
> A subsequent commit will need part, but not all, of the functionality in
> process_acks(), so move some of its functionality to its sole caller
> do_fetch_pack_v2(). As a side effect, the resulting code is also
> shorter.
>  		case FETCH_PROCESS_ACKS:
>  			/* Process ACKs/NAKs */
> -			switch (process_acks(negotiator, &reader, &common)) {

Good riddance to this nested switch!

I am unfamiliar with this code, but I believe these changes to
be correct.

Thanks,
-Stolee
