Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607FDC432C3
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 22:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE92245D
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 22:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MQjPcoQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKSW5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:57:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44132 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfKSW5y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 17:57:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id e6so4312032pgi.11
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 14:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z7R2N73fbYpOqXBY252GRWewoSdJ8vz/ttFSWRKtRjU=;
        b=MQjPcoQlToTffQRkCoOC++yXrSoYGwixrsfFBguVtt929CwraSeCjslEswJvGXOmll
         HpfOMLjFV0LauFm2UslR8kyUUdvTuW4YTaRXWJFyA6KdN55nRMSuhr1/40CrYubxiZ42
         NotgJnzXszyDtMunWvZY1EsVku+E/hRbS8Dh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z7R2N73fbYpOqXBY252GRWewoSdJ8vz/ttFSWRKtRjU=;
        b=WUUwxXNIMX1yjURnGwzNaFYRV9fav56yxM4xuQzToxAwhsQA8ev8inacHCJGHuyVvO
         +ZWxzgewasW+YZSIb8mBcpj6rOIKuI02FuWBTKM9UZfPIAxEqEz2Un7sLTwXcbRPOIUz
         kAztVygjfGMPg3EFd8/GOvkhuTth8ztXng9AvFlf1CPmOQW1fU/rVfEZG5DWETPuRIMn
         cYb/FbmkmsW/oLwIyL/tFy3O4GjitsQQeLVgXRiEJrCE/o4NQPgtY5ua13UGZmT1k2Ch
         6uVch67aAt2jIi/tC22nfguauoYLt93UiXQH6iAzUi6b1tHzrNsLX9GPc8hgpro45JGW
         rPLQ==
X-Gm-Message-State: APjAAAUo9GKb2r7YPfVuQGbpe41xJNdnmP7cL6mvs1MM42AVx31iKnsx
        iEi94ihIogboBqt+nv+VmgE6WQkb2Fc=
X-Google-Smtp-Source: APXvYqzwxUicYtz2AXSJ6nJluETJBUDxH9cr1oYyvodpMnNpj0B6sBUEM/S5WLlwZgFufUw+xJpRnQ==
X-Received: by 2002:a62:447:: with SMTP id 68mr114330pfe.70.1574204271676;
        Tue, 19 Nov 2019 14:57:51 -0800 (PST)
Received: from erikchen-macbookpro.roam.corp.google.com ([2620:0:1000:2104:1dd2:cd99:9de:ece])
        by smtp.gmail.com with ESMTPSA id f24sm4455995pjp.12.2019.11.19.14.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 14:57:50 -0800 (PST)
Subject: Re: [PATCH v3 1/1] fetch: add trace2 instrumentation
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Erik Chen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
 <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
 <364c526a5d674e3f137578b24143678256601d08.1573069152.git.gitgitgadget@gmail.com>
 <xmqq5zjws12y.fsf@gitster-ct.c.googlers.com>
 <944c956e-dd9a-1a12-5cb1-0c263ee7d5bd@gmail.com>
 <xmqqsgmkzl1s.fsf@gitster-ct.c.googlers.com>
From:   Erik Chen <erikchen@chromium.org>
Message-ID: <261fae86-c909-16a5-b7b9-3ab48b5680a8@chromium.org>
Date:   Tue, 19 Nov 2019 14:57:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqsgmkzl1s.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>> In general, these sub-regions should be avoided when possible and instead
>> create regions around important sections, such as the second option Junio
>> lists above.
> 
> Thanks for a clear direction as the area expert of trace2.
I'll upload a new patch set to do that.
